#!/usr/bin/env python3

import pandas as pd

def remove_contigs(file_in, file_out, summary_out):
    #cette fonction permet d'obtenir un csv des contigs ne passant pas les critères de qualités
    data=pd.read_csv(file_in, sep="\t")
    subdata=data[["#rname","numreads","coverage","endpos","meandepth"]]
    del data

    liste_to_remove=[]

    file_rm=open(file_out,"w")
    for x in range(0,len(subdata)):
        #if subdata.iloc[x,1]<5 and subdata.iloc[x,2]<50 :
        if subdata.iloc[x,2]< 90 or subdata.iloc[x,4] < 1: #subdata.iloc[x,4] < 1 or subdata.iloc[x,1] < 5 : #
            liste_to_remove.append(subdata.iloc[x,3])
            ligne=subdata.iloc[x,0]+"\n"
            file_rm.write(ligne)
    file_rm.close()
    del subdata

    nb_seq=len(liste_to_remove)
    max_len=max(liste_to_remove)
    a=0
    for x in liste_to_remove:
        if int(x) > 500:
            a=a+1
    sup500=a
    inf500=nb_seq-a

    d = {'nb_seq':[nb_seq],'max_len':[max_len],'contigs_sup500':[sup500],'contigs_inf500':[inf500]}
    df=pd.DataFrame(data=d)
    df.to_csv(summary_out, index_label=False)

file_in_1_5="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/mapping_1_5_coverage.tsv"
file_out_1_5="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/file_rm_1_5_cov"
summary_out="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/summary_out_1_5_cov"

file_in_6_12="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/mapping_6_12_coverage.tsv"
file_out_6_12="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/file_rm_6_12_cov"
summary_out_6_12="/home/thboyer/Documents/Stage/Oran_metagenomic_data/bwa_coverage/summary_out_6_12_cov"

#remove_contigs(file_in_6_12,file_out_6_12,summary_out_6_12)
#remove_contigs(file_in_1_5,file_out_1_5,summary_out)
