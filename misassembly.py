#!/usr/bin/env python3

import numpy as np
import pandas as pd


def cutoff(data,cutoff):
    #Cette fonction permet d'obtenir les ID des contigs ne passant pas les critères de qualité
    fail_contigs=[]
    i = 0
    taille_totale=0
    taille_max=0
    taille_min=data.iloc[1,1]
    for x in range(1,len(data)):
        #nombre de pb concidéré en trop grande couverture + trop faible couverture / taille contig
        erreur=data.iloc[x,4]+data.iloc[x,6]
        ratio=erreur/data.iloc[x,1]

        if ratio > cutoff and int(erreur) > 150 :
            taille_totale=taille_totale+data.iloc[x,1]
            i=i+1
            fail_contigs.append(data.iloc[x,0])

            if taille_max < data.iloc[x,1]:
                taille_max = data.iloc[x,1]
            if taille_min > data.iloc[x,1]:
                taille_min = data.iloc[x,1]
    taille_moy=taille_totale/i
    phrase="pour un ratio d'anomalie supérieur à {}% de la taille du contig, il y a {} contigs en défauts\nTaille moyenne : {} pb\nTaille max : {} pb\nTaille min : {} pb"\
    .format(cutoff*100,len(fail_contigs),round(taille_moy),round(taille_max),round(taille_min))
    print(phrase)
    #return l'id des id fails
    return fail_contigs

def bench_cutoff(data,list_cut):
    #permet d'effectuer une comparaison de différents cutoff
    results = []
    for y in list_cut :
        fail_contigs = cutoff(data,y)
        results.append(fail_contigs)
    #retourne une liste contenant la liste des ids défaut pour chaque ratio
    return results

def big_contig_def(data,cutoff):
    lst_contig = []
    for x in range(1,len(data)):
        #nombre de pb concidéré en trop grande couverture + trop faible couverture / taille contig
        erreur=data.iloc[x,4]+data.iloc[x,6]
        contig_len=data.iloc[x,1]
        ratio=erreur/contig_len
        if ratio > cutoff and int(erreur) > 150 and contig_len > 1000 :
            lst_contig.append(data.iloc[x,:])
    return lst_contig

contig_to_check = big_contig_def(data_tsv,0.15)
#for contigs in contig_to_check:

def dico_frag(data_bed,data_tsv,cutoff):
    dico_frag={}
    contig_to_check = big_contig_def(data_tsv,cutoff)
    fichier = open("contigs_to_check.bed","w")
    for contigs in contig_to_check :
        for x in range(0,len(data_bed)):
            if contigs[0] == data_bed.iloc[x,0] :
            #But : afficher pour chaque contigs suspects le start / le end et la taille du fragment pour chacun de ces intervalles
                taille_frag=data_bed.iloc[x,2]-data_bed.iloc[x,1]
                tuple=(data_bed.iloc[x,1],data_bed.iloc[x,2],taille_frag,contigs[1])
                fichier.write(str(data_bed.iloc[x,0])+"\t"+str(data_bed.iloc[x,1])+"\t"+str(data_bed.iloc[x,2])+"\t"+str(data_bed.iloc[x,3])+"\t"+str(data_bed.iloc[x,4])+"\t"+str(data_bed.iloc[x,5])+"\t"+str(data_bed.iloc[x,6])+"\t"+str(data_bed.iloc[x,7])+"\t"+str(data_bed.iloc[x,8])+"\n")
                if contigs[0] in dico_frag :
                    dico_frag[contigs[0]].append(tuple)
                else :
                    dico_frag[contigs[0]]=[tuple]
    fichier.close()
    return dico_frag

def fasta_for_blast(fasta):
    #Cette fonction permet de créer un dictionnaire contenant l'iD associé à la séquence 
    dic_fasta={}
    fichier = open(fasta,"r")
    flag=""
    for element in fichier :
        if ">" in element :
            id = element.split(" ")
            dic_fasta[id[0]]=""
            flag=str(id[0])
        else :
            dic_fasta[flag]+=element
    return dic_fasta
