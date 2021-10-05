#!/usr/bin/env python3
import pandas as pd

path_file="/media/thboyer/WD_BLACK/oran_lake_meta/bacteria_seq.fasta"
fichier2=open("NODE_1_length_1134719_cov_36.214557.fasta","w")
size=0
with open(path_file) as fichier :
    my_contig = ">NODE_1_length_1134719_cov_36.214557"
    for ligne in fichier :
        if ligne[0]==">":
            my_contig = ligne
        if ">NODE_1_length_1134719_cov_36.214557" in my_contig :
            size=size+len(ligne)
            if size<1000000 :
                fichier2.write(ligne)

    fichier2.close()
