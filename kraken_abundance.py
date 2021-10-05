#!/usr/bin/env python3

import pandas as pd
import numpy as np
import itertools
import time

def lcp_style(report_indent):
    # Fonction permettant de réduire le temps de calcul en précalculant les distances entre identation
    rpt=report_indent
    lst_diff=[]
    for x in range(0,len(rpt)):
        count=1
        ite=1
        if rpt.iloc[x,6] != 0 :
            while rpt.iloc[x-ite,6] != rpt.iloc[x,6]-2 :
                count+=1
                ite+=1
            lst_diff.append(count)
        elif rpt.iloc[x,6] == 0 :
            lst_diff.append(0)
    lst_diff=pd.Series(lst_diff)
    return lst_diff


def report_indent(report):
    # On ajoute l'indentation au rapport à la dernière colonne du report_kraken2_1_5_condensed
    report=pd.read_csv(report, sep="\t",header=None)
    report.columns=["pourcentage","frag_clade","frag_taxon","rank_code","ncbi_id","scientific_name"]
    indent_file = get_indent(report)
    indent_file = pd.DataFrame(indent_file)
    #On renome la première colonne
    indent_file=indent_file.rename(columns={0:'indent'})
    #On concatène les deux tableaux
    report=pd.concat([report,indent_file],axis=1)
    lcp = lcp_style(report)
    lcp = pd.DataFrame(lcp)
    lcp=lcp.rename(columns={0:'lcp'})
    report=pd.concat([report,lcp],axis=1)
    #On enregistre
    report.to_csv(report_file,sep='\t',index=False)

def mapping_output(mapping,output):
    output=pd.read_csv(output, sep="\t", header=None)
    output.columns=["C/U","contig_id","ncbi_id","sequence_lenght","kmer_LCA"]
    print(output)
    mapping=pd.read_csv(mapping,sep="\t")
    #Le fameux mapout --> Concatenation du mapping file et du output file
    mapout=pd.concat([mapping,output["ncbi_id"]],axis=1,join="inner")
    #On fait en sorte que meandepth ne soit pas un float
    mapout['meandepth']=mapout['meandepth'].round(0).astype(int)
    print(mapout)
    mapout.to_csv(mapout_file,sep='\t',index=False)

def get_indent(report):
    #Fonction permettant d'obtenir le nombre d'indentations pour chaque taxon
    indent=[]
    for a in report['scientific_name']:
        count_blank=0
        for y in itertools.takewhile(lambda x : x == " ",a): #Récupération du nombre d'indentation
            count_blank+=1
        indent.append(count_blank)
        indentS=pd.Series(indent)
    return indentS

def climbing_indent(ncbi_id,report):
    #Fonction permettant de retracer la taxonomie
    name_row={}
    tps1 = time.process_time()
    print("START ==============================> indent ")
    for x in range(0,len(report)):
        if report.iloc[x,4] in ncbi_id:
            name_row[report.iloc[x,4]]= [x] #création de la clef avec l'id NCBI et ajout de l'index (normalement unique car on reset si il existe déjà)
            repere=report.iloc[x,6]
            ite=report.iloc[x,7]
            cur=x-ite
            while repere > 0 :
                if report.iloc[cur,6] == repere-2 : #Verification que l'indentation correspond au rang supérieur
                    name_row[report.iloc[x,4]].append(cur) #Ajout de l'index
                    repere = report.iloc[cur,6] #Ajustement du repère à l'indentation correspondante
                    cur=cur-report.iloc[cur,7]
                if repere == 0 :
                    name_row[report.iloc[x,4]].append(0)
        if x in [100,1000,10000,50000,100000,500000,1000000,2000000,3000000,4000000,5000000,6000000,7000000]:
            print(f"{x} sequences traitées en {time.process_time()-tps1} secondes")
    print("STOP==============================> indent ")
    print(f"{time.process_time()-tps1} secondes")
    return name_row

def finding_contigs(mapout,report):
    mark=0
    print(report)
    lst_ncbi=mapout["ncbi_id"].tolist()
    dico_ncbi=climbing_indent(lst_ncbi,report)
    tps1 = time.process_time()
    print("START ==============================> Ajout profondeur ")
    for x in range(0,len(mapout)):
        mark+=1
        if mapout.iloc[x,9] in dico_ncbi :
            #la 1er coordonnée contenue dans le dico est recherchée dans le tableau report_file, on lui ajoute la profondeur uniquement sur le taxon
            a=dico_ncbi[mapout.iloc[x,9]][0]
            report.iloc[a,2]+= mapout.iloc[x,6]-1
            for element in dico_ncbi[mapout.iloc[x,9]]:
                #on propage la profondeur à l'ensemble du clade pour le reste de l'id
                report.iloc[element,1]+= mapout.iloc[x,6]-1
        if mark in [10000,100000,500000,1000000,2000000,3000000,4000000,5000000,6000000,7000000]:
            print(f"{mark} sequences traitées en {time.process_time()-tps1} secondes")
    print("STOP==============================> Ajout profondeur ")
    print(f"{time.process_time()-tps1} secondes")
    print(report)
    report.to_csv(abundance_100000,sep='\t',index=False)
    return report

def fix_percentage(report):
    total=report.iloc[1,1]+report.iloc[0,1]
    for x in range(0,len(report)):
        report.iloc[x,0]=(report.iloc[x,1]/total)*100
    report['pourcentage']=report['pourcentage'].round(2)
    del report['indent']
    del report['lcp']
    print(report)
    return report
