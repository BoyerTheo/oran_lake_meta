library('ggplot2')
library('tidyr')
library('forcats')
library('tidyverse')

################# Comparaison phylum bactérien #########################
###########  Kraken 
####### Echantillon H 
df_EHD<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes','Planctomycetes','Tenericutes',
                             'Cyanobacteria','Verrucomicrobia','Deinococcus-Thermus','Autres'),
                   echantillon_H=c(80.75,7.741,4.539,3.168,1.812,0.6288,0.4245,0.2401,0.1172,0.5794)
)

df_EHD$phylum<- fct_relevel(df_EHD$phylum,c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes','Planctomycetes','Tenericutes',
                                            'Cyanobacteria','Verrucomicrobia','Deinococcus-Thermus','Autres'))
######## Echantillon S


df_ESD<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes','Planctomycetes',
                             'Cyanobacteria','Deinococcus-Thermus','Chloroflexi','Chlorobi','Autres'),
                   echantillon_S=c(60.87,14.37,13.07,4.826,2.893,0.9045,0.6474,0.4006,0.2666,1.7519)
)

df_ESD$phylum<- fct_relevel(df_ESD$phylum,c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes','Planctomycetes',
                                            'Cyanobacteria','Deinococcus-Thermus','Chloroflexi','Chlorobi','Autres'))


###########  SQM
####### Echantillon H 
df_BPH<-data.frame(
  phylum=c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Verrucomicrobia','Firmicutes',
           'Planctomycetes','Ignavibacteriae','Tenericutes','Spirochaetes','Autres'),
  echantillon_H=c(65.74,18.72,7.22,2.36,1.51,1.50,0.91,0.54,0.41,1.09))

df_BPH$phylum<- fct_relevel(df_BPH$phylum, c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Verrucomicrobia','Firmicutes',
                                             'Planctomycetes','Ignavibacteriae','Tenericutes','Spirochaetes','Autres'))

######## Echantillon S

df_BPS<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Chloroflexi',
                             'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Autres'),
                   echantillon_S=c(42.35, 26.98, 17.19, 3.56, 2.61, 2.49, 1.79, 1.48, 0.80, 0.76))

df_BPS$phylum<- fct_relevel(df_BPS$phylum,c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Chloroflexi',
                                            'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Autres'))


df_phyla <- data.frame(phylum=c('Proteobacteria','Bacteroidetes','Actinobacteria','Unclassified Bacteria','Chloroflexi','Cyanobacteria','Tenericutes',
                                'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Ignavibacteriae','Chlorobi','Autres','Verrucomicrobia'),
                       krak_h=c(80.75,7.741,4.539,0,0,0.4245,0.6288,3.168,1.812,0,0.1172,0,0,0,0.5794,0.2401),
                       krak_s=c(60.87,14.37,13.07,0,0.4006,0,0.9045,4.826,2.893,0,0.6474,0,0,0.2666,1.7519,0),
                       sqm_h=c(65.74,18.72,0,7.22,0,0,0.54,1.51,1.50,0,0,0.41,0.91,0,1.09,2.36),
                       sqm_s=c(42.35,26.98,0,17.19,3.56,0,0,2.61,2.49,1.79,1.48,0.80,0,0,0.76,0),
                       hex_color=c('#004586','#ffd320','#ff420e','#579d1c','#7e0021','#314004','#ff950e','#c20d0d','#4b1f6f','#83caff','#800080','#ffff00','#bfbdff','#a36439','#aecf00','#54b09c')
                                      #1         2        3           4         5         6       7           8         9       10        11        12        13        14        15        16
                       )

conditions <- c(rep("Kraken_H",16),rep("SqueezeMeta_H",16),rep("Kraken_S",16),rep("SqueezeMeta_S",16))
phylum <- rep(c('Proteobacteria','Bacteroidetes','Actinobacteria','Unclassified Bacteria','Chloroflexi','Cyanobacteria','Tenericutes',
                    'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Ignavibacteriae','Chlorobi','Autres','Verrucomicrobia'),4)
values <- c(Kraken_H=c(80.75,7.741,4.539,0,0,0.4245,0.6288,3.168,1.812,0,0.1172,0,0,0,0.5794,0.2401),
            SqueezeMeta_H=c(65.74,18.72,0,7.22,0,0,0.54,1.51,1.50,0,0,0.41,0.91,0,1.09,2.36),
            Kraken_S=c(60.87,14.37,13.07,0,0.4006,0,0.9045,4.826,2.893,0,0.6474,0,0,0.2666,1.7519,0),
            SqueezeMeta_S=c(42.35,26.98,0,17.19,3.56,0,0,2.61,2.49,1.79,1.48,0.80,0,0,0.76,0))


data <-data.frame(conditions,phylum,values)


#data$values<- fct_relevel(data$values,c("krak_h","krak_h","krak_h","krak_h","krak_h","krak_h","krak_h","krak_h","krak_h","krak_h",
                                        #"sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h","sqm_h",
                                        #"krak_s","krak_s","krak_s","krak_s","krak_s","krak_s","krak_s","krak_s","krak_s","krak_s",
                                        #"sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s","sqm_s"))

colorset= c("Proteobacteria"="#004586","Bacteroidetes"="#ffd320","Actinobacteria"="#ff420e","Unclassified Bacteria"="#a36439","Chloroflexi"="#7e0021",
            "Cyanobacteria"="#ff09f8","Tenericutes"="#ff950e","Firmicutes"="#c20d0d","Planctomycetes"="#83caff","Balneolaeota"="#aecf00","Deinococcus-Thermus"="#800080",
            "Spirochaetes"="#579d1c","Ignavibacteriae"="#314004","Chlorobi"="#00ff23","Autres"="#4b1f6f","Verrucomicrobia"="#54b09c")


ggplot(data, aes(fill=phylum, y=values, x=conditions)) + 
  
  geom_bar(position="fill", stat="identity", width=0.5)+
  scale_x_discrete(limits=c('Kraken_H','SqueezeMeta_H','Kraken_S','SqueezeMeta_S'))+
  #scale_fill_manual(values=c('#004586','#aecf00','#ff420e','#bfbdff','#7e0021','#314004','#ff950e','#0d96fc','#579d1c','#83caff','#ffff00','#800080','#ffd320','#4b1f6f','#a36439','#c20d0d','#54b09c'))+
  scale_fill_manual(values=colorset) +
  labs(title="Comparaison des differents phyla bactériens en fonction des logiciels\net des échantillons H et S", fill="Phyla", x="Conditions", y="Pourcentages")+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0, size=20),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18),
        axis.text.x = element_text(size=12, color='black'),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15))

################# Phylum Eukaryote ##############

conditions <- c(rep("Kraken_H",20),rep("SqueezeMeta_H",20),rep("Kraken_S",20),rep("SqueezeMeta_S",20))
phylum <- rep(c('Unclassified Eukaryota','Ciliophora','Ascomycota','Streptophyta','Bigyra (no phylum in NCBI)','Chordata','Bacillariophyta',
                'Oomycota (no phylum in NCBI)','Arthropoda','Rotifera','Chlorophyta','Microsporidia','Nematoda',
                'Cnidaria','Annelida','Platyhelminthes','Basidiomycota','Apicomplexa','Mollusca','Autres'),4)
values <- c(Kraken_H=c(0,1.344,4.523,12.46,0,48.19,0,0,25.38,0,0,0,0.9201,0,0,1.096,1.074,0,1.517,3.4959),
            SqueezeMeta_H=c(38.03,35.44,0,4.66,3.72,3.43,2.19,1.79,1.65,1.25,0,0,0,0,0,0,0,0,0,7.83),
            Kraken_S=c(0,0,4.049,12.52,0,48.55,0,0,27.4,0,0,0,0.889,0,0,1.133,1.101,0.4924,1.465,2.4),
            SqueezeMeta_S=c(25.69,0,0,2.48,0,4.45,0,0,51.99,0,4.98,3.32,1.47,1.40,0.78,0,0,0,0,3.45))

data <-data.frame(conditions,phylum,values)

colorset= c('Ascomycota'="#004586",'Ciliophora'="#ffd320",'Unclassified Eukaryota'="#a36439",'Streptophyta'="#ff420e",'Bigyra (no phylum in NCBI)'="#7e0021",
            'Chordata'="#ff09f8",'Bacillariophyta'="#ff950e",'Oomycota (no phylum in NCBI)'="#c20d0d",'Arthropoda'="#83caff",'Rotifera'="#aecf00",'Chlorophyta'="#800080",
            'Microsporidia'="#579d1c",'Nematoda'="#314004",'Cnidaria'="#00ff23",'Annelida'="#54b09c",'Platyhelminthes'="#6f00ff",
            'Basidiomycota'="#ded2ca" ,'Apicomplexa'="#524e39" ,'Mollusca'= "#9e9c9b",'Autres'="#4b1f6f")


ggplot(data, aes(fill=phylum, y=values, x=conditions)) + 
  geom_bar(position="fill", stat="identity", width=0.5)+
  scale_x_discrete(limits=c('Kraken_H','SqueezeMeta_H','Kraken_S','SqueezeMeta_S'))+
  #scale_fill_manual(values=c('#004586','#aecf00','#ff420e','#bfbdff','#7e0021','#314004','#ff950e','#0d96fc','#579d1c','#83caff','#ffff00','#800080','#ffd320','#4b1f6f','#a36439','#c20d0d','#54b09c'))+
  scale_fill_manual(values=colorset) +
  labs(title="Comparaison des differents phyla eucaryotes en fonction\n des logiciels et des échantillons H et S", fill="Phyla", x="Conditions", y="Pourcentages")+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0, size=20),
        legend.text = element_text(size=17),
        legend.title = element_text(size=17),
        axis.text.x = element_text(size=12, color='black'),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15))


################# Phylum Archéen ##############

conditions <- c(rep("Kraken_H",11),rep("SqueezeMeta_H",11),rep("Kraken_S",11),rep("SqueezeMeta_S",11))
phylum <- rep(c('Euryarchaeota','Crenarchaeota','Thaumarchaeota','Candidatus Thermoplasmatota','Autres',
                'Unclassified Archaea', 'Nanoarchaeota', 'Candidatus Woesearchaeota','Candidatus Bathyarchaeota',
                'Candidatus Lokiarchaeota','Candidatus Thorarchaeota'),4)
values <- c(Kraken_H=c(87.050,5.987,4.528,1.814,0.621,0,0,0,0,0,0),
            SqueezeMeta_H=c(84.45,0,0.98,0,1.09,8.91,2.43,1.24,0.89,0,0),
            Kraken_S=c(99.18,0,0,0,0.82,0,0,0,0,0,0),
            SqueezeMeta_S=c(93.07,0,0,0,0.28,4.27,0,0.86,0,0.53,0.50))

data <-data.frame(conditions,phylum,values)

colorset= c('Euryarchaeota'="#004586",'Crenarchaeota'="#ffd320",'Unclassified Archaea'="#a36439",'Thaumarchaeota'="#ff420e",'Candidatus Thermoplasmatota'="#7e0021",
            'Nanoarchaeota'="#ff09f8",'Candidatus Woesearchaeota'="#ff950e",'Candidatus Bathyarchaeota'="#c20d0d",'Candidatus Lokiarchaeota'="#83caff",
            'Candidatus Thorarchaeota'="#aecf00",'Autres'="#4b1f6f")


ggplot(data, aes(fill=phylum, y=values, x=conditions)) + 
  geom_bar(position="fill", stat="identity", width=0.5)+
  scale_x_discrete(limits=c('Kraken_H','SqueezeMeta_H','Kraken_S','SqueezeMeta_S'))+
  #scale_fill_manual(values=c('#004586','#aecf00','#ff420e','#bfbdff','#7e0021','#314004','#ff950e','#0d96fc','#579d1c','#83caff','#ffff00','#800080','#ffd320','#4b1f6f','#a36439','#c20d0d','#54b09c'))+
  scale_fill_manual(values=colorset) +
  labs(title="Comparaison des differents phyla archéens en fonction\n des logiciels et des échantillons H et S", fill="Phyla", x="Conditions", y="Pourcentages")+
  theme_minimal()+
  theme(plot.title = element_text(hjust=0, size=20),
        legend.text = element_text(size=17),
        legend.title = element_text(size=17),
        axis.text.x = element_text(size=12, color='black'),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=15))
