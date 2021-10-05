if (!require(tidyverse)) { install.packages("tidyverse") }

#Spécifier le dossier contenant les différents fichiers
setwd("/shared/ifbstor1/home/thboyer")
#Spécifier le nom du fichier contenant le génome
data<-readLines("Phatr-genome.fa")
parse_fasta <- function(fasta,chrom,start,end,nom_fichier_sortie) {
  sequence<-""
  current_chrom='chr_1'
  for(x in 1:length(fasta)){
    if(grepl('chr', fasta[x])){
      current_chrom <-fasta[x]
    }
    if(grepl(chrom, current_chrom)){
      sequence<-str_c(sequence,fasta[x], seq="", collapse="")
    }
  }
  start<-start+nchar(chrom)
  end<-end+nchar(chrom)
  final_sequence<-substr(sequence,start,end)
  writeLines(final_sequence,con=nom_fichier_sortie)
  return(final_sequence)
}

#Pour cette fonction il faut juste mettre 
#data : le fichier du génome au format fasta/fa/fas, 
#chrom : le nom du chromosome avec des "" autour et ">" devant (ex: ">chr_15"), 
#start : le début de la sequence à chercher,
#end : la fin de la sequence à chercher,
#nom_fichier_sortie : le nom du fichier de sortie et des "" autour

sequence_to_return<-parse_fasta(data,">chr_5",135756,136577,"hsp70_chr5.txt")


