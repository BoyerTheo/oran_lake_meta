#!/usr/bin/env python3

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import time
from os import listdir

path_file_report="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/report_kraken2"
path_file_output="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/output_kraken2"
path_file_fasta="/media/thboyer/WD_BLACK/oran_lake_meta/contigs.fasta"
path_doc_bact ="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/bacteria_seq.fasta"
path_doc_euka="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/eukaryota_seq.fasta"
path_doc_viru="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/viruses_seq.fasta"
path_doc_arch="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/archaea_seq.fasta"
path_confidence="/home/thboyer/Documents/Stage/Oran_metagenomic_data/kraken2/confidence/"

#data.to_csv(path_output,sep="\t",header=head)


def multiplot(path_file):
    global_lst=[]
    for file in listdir(path_file) :
        global_lst.append((plot_hits(path_confidence+file),file))
    fig=plt.figure()
    i=1
    for graph in global_lst :
        ax=fig.add_subplot(3,2,i)
        ax.hist(graph[0],bins=50,log=True)
        ax.set(title=f"Répartition des contigs classifiés en fonction de leurs tailles pour un indice de {graph[1][0:-4]}", xlabel="taille contigs en pb", ylabel="nombre de contigs en log")
        i=i+1
    plt.show()

def plot_hits(data_file):
    data=pd.read_table(data_file,sep="\t",header=None)
    lst_contigs_out=[]
    for x in range(0,len(data)):
        if (data.iloc[x,0]=="C"):
            lst_contigs_out.append(data.iloc[x,3])
    return lst_contigs_out

def plot_nohits(data_file):
    data=pd.read_table(data_file,sep="\t",header=None)
    lst_contigs_out=[]
    for x in range(0,len(data)):
        if (data.iloc[x,0]=="U"):
            lst_contigs_out.append(data.iloc[x,3])
    return lst_contigs_out

multiplot(path_confidence)

def contigs_taxa(report_file):
    """
    cette fonction permet de trouver les id NCBI détectés dans l'échantillon
    """
    data=pd.read_table(report_file,sep="\t",header=None)
    dico_seq = {}
    lst_regne = ["Bacteria","Eukaryota","Viruses","Archaea"]
    ite = "None"
    for x in range(0,len(data)):
        if data.iloc[x,5].lstrip(" ") in lst_regne:
            ite=data.iloc[x,5].lstrip(" ")
            dico_seq[data.iloc[x,4]]=ite
        elif ite=="None":
            continue
        else :
            dico_seq[data.iloc[x,4]]=ite
    return dico_seq

def find_contigs(report_file,output_file):
    """
    cette fonction permet de trouver le nom des contigs en fonction du règne (bactérie, eucaryote...)
    """
    data=pd.read_table(output_file,sep="\t",header=None)
    data=data.drop(data.columns[4], axis=1)
    print("Extraction des taxons =================> START")
    dico_seq=contigs_taxa(report_file)
    print("Extraction des taxons =================> DONE")
    print("Finding and sorting contigs =================> START")
    dico_contigs={}
    mark=0
    no_ref=[]
    tps1 = time.process_time()
    for x in range(0,len(data)):
        if data.iloc[x,0]=="C":
            if data.iloc[x,2] in dico_seq:#si dans notre dictionnaire des taxons on retrouve le même taxons
                # alors on crée une clef avec le nom du contig et son taxon en valeur
                dico_contigs[data.iloc[x,1]]=dico_seq[data.iloc[x,2]]
                mark=mark+1
            else :
                no_ref.append(data.iloc[x,1])
        if mark in [100000,500000,1000000,2000000,3000000,4000000,5000000,6000000,7000000]:
            print(f"{mark} sequences traitées en {time.process_time()-tps1} secondes")
    print("Finding and sorting contigs =================> DONE")
    print(len(no_ref))
    return dico_contigs

dico_test={'NODE_1490_length_35962_cov_28.596289':'Eukaryota','NODE_687947_length_1069_cov_1.124204':'Eukaryota','NODE_6449967_length_129_cov_9.000000': 'Bacteria', 'NODE_6449969_length_129_cov_9.000000': 'Bacteria', 'NODE_6449973_length_129_cov_9.000000': 'Bacteria', 'NODE_6449976_length_129_cov_9.000000': 'Bacteria', 'NODE_6449977_length_129_cov_9.000000': 'Bacteria', 'NODE_6449979_length_129_cov_9.000000': 'Bacteria', 'NODE_6449980_length_129_cov_9.000000': 'Bacteria', 'NODE_6449982_length_129_cov_9.000000': 'Bacteria', 'NODE_6449985_length_129_cov_9.000000': 'Bacteria', 'NODE_6449988_length_129_cov_8.500000': 'Bacteria', 'NODE_6449989_length_129_cov_8.500000': 'Bacteria', 'NODE_6449990_length_129_cov_8.500000': 'Eukaryota', 'NODE_6449991_length_129_cov_8.500000': 'Bacteria', 'NODE_6449993_length_129_cov_8.500000': 'Bacteria', 'NODE_6449998_length_129_cov_8.000000': 'Bacteria', 'NODE_6449999_length_129_cov_8.000000': 'Bacteria', 'NODE_6450001_length_129_cov_8.000000': 'Viruses', 'NODE_6450004_length_129_cov_8.000000': 'Bacteria', 'NODE_6450006_length_129_cov_8.000000': 'Bacteria', 'NODE_6450012_length_129_cov_8.000000': 'Bacteria', 'NODE_6450016_length_129_cov_8.000000': 'Bacteria', 'NODE_6450018_length_129_cov_8.000000': 'Bacteria', 'NODE_6450019_length_129_cov_8.000000': 'Bacteria', 'NODE_6450023_length_129_cov_8.000000': 'Bacteria', 'NODE_6450024_length_129_cov_8.000000': 'Bacteria', 'NODE_6450025_length_129_cov_8.000000': 'Bacteria', 'NODE_6450026_length_129_cov_8.000000': 'Bacteria', 'NODE_6450039_length_129_cov_7.500000': 'Bacteria', 'NODE_6450040_length_129_cov_7.500000': 'Bacteria', 'NODE_6450042_length_129_cov_7.000000': 'Bacteria', 'NODE_6450049_length_129_cov_7.000000': 'Bacteria', 'NODE_6450050_length_129_cov_7.000000': 'Bacteria', 'NODE_6450052_length_129_cov_7.000000': 'Bacteria', 'NODE_6450058_length_129_cov_7.000000': 'Bacteria', 'NODE_6450061_length_129_cov_7.000000': 'Viruses', 'NODE_6450064_length_129_cov_7.000000': 'Archaea', 'NODE_6450067_length_129_cov_7.000000': 'Bacteria', 'NODE_6450068_length_129_cov_7.000000': 'Bacteria', 'NODE_6450070_length_129_cov_7.000000': 'Bacteria', 'NODE_6450074_length_129_cov_7.000000': 'Bacteria', 'NODE_6450076_length_129_cov_7.000000': 'Bacteria', 'NODE_6450079_length_129_cov_6.500000': 'Bacteria', 'NODE_6450084_length_129_cov_6.500000': 'Bacteria', 'NODE_6450089_length_129_cov_6.500000': 'Bacteria', 'NODE_6450090_length_129_cov_6.500000': 'Bacteria', 'NODE_6450093_length_129_cov_6.500000': 'Bacteria', 'NODE_6450095_length_129_cov_6.500000': 'Bacteria', 'NODE_6450096_length_129_cov_6.500000': 'Eukaryota', 'NODE_6450100_length_129_cov_6.000000': 'Eukaryota', 'NODE_6450102_length_129_cov_6.000000': 'Bacteria', 'NODE_6450105_length_129_cov_6.000000': 'Bacteria', 'NODE_6450106_length_129_cov_6.000000': 'Eukaryota', 'NODE_6450108_length_129_cov_6.000000': 'Bacteria', 'NODE_6450113_length_129_cov_6.000000': 'Bacteria', 'NODE_6450115_length_129_cov_6.000000': 'Bacteria', 'NODE_6450116_length_129_cov_6.000000': 'Bacteria', 'NODE_6450119_length_129_cov_6.000000': 'Bacteria', 'NODE_6450121_length_129_cov_6.000000': 'Bacteria', 'NODE_6450122_length_129_cov_6.000000': 'Bacteria', 'NODE_6450125_length_129_cov_6.000000': 'Bacteria', 'NODE_6450136_length_129_cov_6.000000': 'Bacteria', 'NODE_6450138_length_129_cov_5.500000': 'Archaea', 'NODE_6450139_length_129_cov_5.500000': 'Bacteria', 'NODE_6450140_length_129_cov_5.500000': 'Bacteria', 'NODE_6450141_length_129_cov_5.500000': 'Bacteria', 'NODE_6450142_length_129_cov_5.500000': 'Bacteria', 'NODE_6450143_length_129_cov_5.500000': 'Bacteria', 'NODE_6450144_length_129_cov_5.500000': 'Bacteria', 'NODE_6450145_length_129_cov_5.500000': 'Bacteria', 'NODE_6450153_length_129_cov_5.000000': 'Bacteria', 'NODE_6450154_length_129_cov_5.000000': 'Bacteria', 'NODE_6450156_length_129_cov_5.000000': 'Bacteria', 'NODE_6450158_length_129_cov_5.000000': 'Bacteria', 'NODE_6450160_length_129_cov_5.000000': 'Bacteria', 'NODE_6450163_length_129_cov_5.000000': 'Bacteria', 'NODE_6450166_length_129_cov_5.000000': 'Bacteria', 'NODE_6450170_length_129_cov_5.000000': 'Eukaryota', 'NODE_6450171_length_129_cov_5.000000': 'Bacteria', 'NODE_6450173_length_129_cov_5.000000': 'Bacteria', 'NODE_6450174_length_129_cov_5.000000': 'Bacteria', 'NODE_6450175_length_129_cov_5.000000': 'Bacteria', 'NODE_6450177_length_129_cov_5.000000': 'Bacteria', 'NODE_6450181_length_129_cov_5.000000': 'Bacteria', 'NODE_6450182_length_129_cov_5.000000': 'Bacteria', 'NODE_6450185_length_129_cov_5.000000': 'Bacteria', 'NODE_6450188_length_129_cov_5.000000': 'Bacteria', 'NODE_6450189_length_129_cov_5.000000': 'Bacteria', 'NODE_6450192_length_129_cov_5.000000': 'Bacteria', 'NODE_6450193_length_129_cov_5.000000': 'Archaea', 'NODE_6450194_length_129_cov_5.000000': 'Bacteria', 'NODE_6450197_length_129_cov_5.000000': 'Bacteria', 'NODE_6450199_length_129_cov_5.000000': 'Bacteria', 'NODE_6450201_length_129_cov_4.500000': 'Bacteria', 'NODE_6450202_length_129_cov_4.500000': 'Eukaryota', 'NODE_6450214_length_129_cov_4.500000': 'Bacteria', 'NODE_6450217_length_129_cov_4.500000': 'Bacteria', 'NODE_6450219_length_129_cov_4.500000': 'Bacteria', 'NODE_6450227_length_129_cov_4.500000': 'Bacteria', 'NODE_6450228_length_129_cov_4.500000': 'Archaea', 'NODE_6450233_length_129_cov_4.500000': 'Bacteria', 'NODE_6450235_length_129_cov_4.500000': 'Bacteria', 'NODE_6450236_length_129_cov_4.500000': 'Bacteria', 'NODE_6450237_length_129_cov_4.500000': 'Bacteria', 'NODE_6450238_length_129_cov_4.000000': 'Bacteria', 'NODE_6450240_length_129_cov_4.000000': 'Bacteria', 'NODE_6450242_length_129_cov_4.000000': 'Bacteria', 'NODE_6450243_length_129_cov_4.000000': 'Bacteria', 'NODE_6450244_length_129_cov_4.000000': 'Bacteria'}

def taxon_to_fasta(path_to_fasta,dico):#(report_file,output_file):
    """
    Cette fonction permet de générer 4 fichiers fasta et d'y inserer les différentes séquences correspondantes
    """
    b = 0
    e = 0
    v = 0
    a = 0
    file_b=open(path_doc_bact,"w")
    file_e=open(path_doc_euka,"w")
    file_v=open(path_doc_viru,"w")
    file_a=open(path_doc_arch,"w")
    current=""
    with open(path_to_fasta) as txt:
        print("writting =================> START")
        for ligne in txt :
            if ligne[1:-1] in dico :
                if dico[ligne[1:-1]] == "Bacteria" :
                    current="Bacteria"
                    b=b+1
                elif dico[ligne[1:-1]] == "Eukaryota" :
                    current="Eukaryota"
                    e=e+1
                elif dico[ligne[1:-1]] == "Viruses" :
                    current="Viruses"
                    v=v+1
                elif dico[ligne[1:-1]] == "Archaea" :
                    current="Archaea"
                    a=a+1

            if current == "Bacteria" :
                file_b.write(ligne)
            elif current == "Eukaryota":
                file_e.write(ligne)
            elif current == "Viruses":
                file_v.write(ligne)
            elif current == "Archaea":
                file_a.write(ligne)

        print("writting =================> DONE")
        print(f"Bacteria : {b} sequences\nEukaryota : {e} sequences\nArchaea : {a} sequences\nViruses : {v} sequences")
        file_b.close()
        file_e.close()
        file_v.close()
        file_a.close()
    return txt

#dico_cont=find_contigs(path_file_report,path_file_output)
#taxon_to_fasta(path_file_fasta,dico_cont)
"""
for a in dico_test:
    print(a)
"""
"""
dico_cont=find_contigs(path_file_report,path_file_output)
print(len(dico_cont))
"""




'NODE_5252225_length_306_cov_0.251397', 'NODE_5252235_length_306_cov_0.251397', 'NODE_5252263_length_306_cov_0.251397', 'NODE_5252292_length_306_cov_0.251397', 'NODE_5252359_length_306_cov_0.245810', 'NODE_5252411_length_306_cov_0.245810', 'NODE_5252422_length_306_cov_0.240223', 'NODE_5252438_length_306_cov_0.240223', 'NODE_5252466_length_306_cov_0.240223', 'NODE_5252517_length_306_cov_0.240223', 'NODE_5252532_length_306_cov_0.234637', 'NODE_5252562_length_306_cov_0.234637', 'NODE_5252588_length_306_cov_0.234637', 'NODE_5252628_length_306_cov_0.234637', 'NODE_5252675_length_306_cov_0.229050', 'NODE_5252688_length_306_cov_0.229050', 'NODE_5252705_length_306_cov_0.229050', 'NODE_5252711_length_306_cov_0.229050', 'NODE_5252725_length_306_cov_0.229050', 'NODE_5252760_length_306_cov_0.229050', 'NODE_5252777_length_306_cov_0.223464', 'NODE_5252786_length_306_cov_0.223464', 'NODE_5252811_length_306_cov_0.223464', 'NODE_5252855_length_306_cov_0.223464', 'NODE_5252907_length_306_cov_0.217877', 'NODE_5252927_length_306_cov_0.217877', 'NODE_5252945_length_306_cov_0.217877', 'NODE_5252948_length_306_cov_0.217877', 'NODE_5252966_length_306_cov_0.217877', 'NODE_5253029_length_306_cov_0.212291', 'NODE_5253034_length_306_cov_0.212291', 'NODE_5253037_length_306_cov_0.212291', 'NODE_5253058_length_306_cov_0.212291', 'NODE_5253061_length_306_cov_0.212291', 'NODE_5253078_length_306_cov_0.212291', 'NODE_5253081_length_306_cov_0.212291', 'NODE_5253082_length_306_cov_0.212291', 'NODE_5253091_length_306_cov_0.212291', 'NODE_5253112_length_306_cov_0.206704', 'NODE_5253134_length_306_cov_0.206704', 'NODE_5253154_length_306_cov_0.206704', 'NODE_5253156_length_306_cov_0.206704', 'NODE_5253159_length_306_cov_0.206704', 'NODE_5253168_length_306_cov_0.206704', 'NODE_5253179_length_306_cov_0.206704', 'NODE_5253200_length_306_cov_0.201117', 'NODE_5253210_length_306_cov_0.201117', 'NODE_5253247_length_306_cov_0.201117', 'NODE_5253263_length_306_cov_0.201117', 'NODE_5253293_length_306_cov_0.195531', 'NODE_5253352_length_306_cov_0.195531', 'NODE_5253398_length_306_cov_0.189944', 'NODE_5253414_length_306_cov_0.189944', 'NODE_5253437_length_306_cov_0.189944', 'NODE_5253464_length_306_cov_0.184358', 'NODE_5253467_length_306_cov_0.184358', 'NODE_5253509_length_306_cov_0.184358', 'NODE_5253518_length_306_cov_0.184358', 'NODE_5253520_length_306_cov_0.184358', 'NODE_5253522_length_306_cov_0.184358', 'NODE_5253531_length_306_cov_0.184358', 'NODE_5253560_length_306_cov_0.178771', 'NODE_5253585_length_306_cov_0.178771', 'NODE_5253597_length_306_cov_0.178771', 'NODE_5253603_length_306_cov_0.178771', 'NODE_5253604_length_306_cov_0.178771', 'NODE_5253652_length_306_cov_0.173184', 'NODE_5253703_length_306_cov_0.167598', 'NODE_5253762_length_306_cov_0.167598', 'NODE_5253822_length_306_cov_0.162011', 'NODE_5253841_length_306_cov_0.162011', 'NODE_5253871_length_306_cov_0.156425', 'NODE_5253882_length_306_cov_0.156425', 'NODE_5253895_length_306_cov_0.156425', 'NODE_5253896_length_306_cov_0.156425', 'NODE_5253938_length_306_cov_0.150838', 'NODE_5253947_length_306_cov_0.150838', 'NODE_5253961_length_306_cov_0.150838', 'NODE_5254001_length_306_cov_0.150838', 'NODE_5254003_length_306_cov_0.150838', 'NODE_5254031_length_306_cov_0.145251', 'NODE_5254040_length_306_cov_0.145251', 'NODE_5254046_length_306_cov_0.145251', 'NODE_5254082_length_306_cov_0.139665', 'NODE_5254125_length_306_cov_0.139665', 'NODE_5254141_length_306_cov_0.134078', 'NODE_5254176_length_306_cov_0.134078', 'NODE_5254188_length_306_cov_0.134078', 'NODE_5254202_length_306_cov_0.134078', 'NODE_5254216_length_306_cov_0.128492', 'NODE_5254226_length_306_cov_0.128492', 'NODE_5254273_length_306_cov_0.128492', 'NODE_5254294_length_306_cov_0.128492', 'NODE_5254306_length_306_cov_0.128492', 'NODE_5254317_length_306_cov_0.128492', 'NODE_5254338_length_306_cov_0.128492', 'NODE_5254409_length_306_cov_0.128492', 'NODE_5254450_length_306_cov_0.128492', 'NODE_5254451_length_306_cov_0.128492', 'NODE_5254452_length_306_cov_0.128492', 'NODE_5254455_length_306_cov_0.128492', 'NODE_5254521_length_306_cov_0.128492', 'NODE_5254537_length_306_cov_0.128492', 'NODE_5254543_length_306_cov_0.128492', 'NODE_5254614_length_306_cov_0.128492', 'NODE_5254616_length_306_cov_0.128492', 'NODE_5254631_length_306_cov_0.128492', 'NODE_5254692_length_306_cov_0.128492', 'NODE_5254707_length_306_cov_0.128492', 'NODE_5254746_length_306_cov_0.128492', 'NODE_5254777_length_306_cov_0.128492', 'NODE_5254858_length_306_cov_0.117318', 'NODE_5254860_length_306_cov_0.117318', 'NODE_5254889_length_306_cov_0.111732', 'NODE_5254900_length_306_cov_0.111732', 'NODE_5254923_length_306_cov_0.100559', 'NODE_5254933_length_306_cov_0.100559', 'NODE_5254934_length_306_cov_0.100559', 'NODE_5254971_length_306_cov_0.089385', 'NODE_5254979_length_306_cov_0.083799', 'NODE_5254985_length_306_cov_0.083799', 'NODE_5254987_length_306_cov_0.083799', 'NODE_5255004_length_306_cov_0.078212', 'NODE_5255013_length_306_cov_0.072626', 'NODE_5255048_length_306_cov_0.067039', 'NODE_5255050_length_306_cov_0.067039', 'NODE_5255068_length_306_cov_0.061453', 'NODE_5255079_length_306_cov_0.055866', 'NODE_5255100_length_306_cov_0.044693', 'NODE_5255163_length_306_cov_0.005587', 'NODE_5255210_length_306_cov_0.000000', 'NODE_5255215_length_305_cov_40.314607', 'NODE_5255230_length_305_cov_20.528090', 'NODE_5255263_length_305_cov_9.640449', 'NODE_5255271_length_305_cov_8.752809', 'NODE_5255287_length_305_cov_7.280899', 'NODE_5255289_length_305_cov_6.994382', 'NODE_5255342_length_305_cov_4.584270', 'NODE_5255393_length_305_cov_3.780899', 'NODE_5255438_length_305_cov_3.370787', 'NODE_5255460_length_305_cov_3.252809', 'NODE_5255487_length_305_cov_3.112360', 'NODE_5255500_length_305_cov_3.044944', 'NODE_5255576_length_305_cov_2.612360', 'NODE_5255638_length_305_cov_2.415730', 'NODE_5255649_length_305_cov_2.387640'
