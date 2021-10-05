library('ggplot2')
library('tidyr')
library('forcats')
library('tidyverse')

##### PlOT GENERAL ######
arc_1_5<-390452
bac_1_5<-293333016
euk_1_5<-12168373
vir_1_5<-179392
no_cds_1_5<-768981
unclass_1_5<-43022378
unmap_1_5<- 40391314
total_1_5<- bac_1_5+euk_1_5+arc_1_5+vir_1_5
arc_6_12<-12815649
bac_6_12<-147459034
euk_6_12<-2560622
vir_6_12<-369610
no_cds_6_12<-22405033
unclass_6_12<-57699894
unmap_6_12<-140640
total_6_12<-arc_6_12+bac_6_12+vir_6_12+euk_6_12


df_sqm<-data.frame(
  echantillon_H=c(bac_1_5/total_1_5*100, euk_1_5/total_1_5*100, arc_1_5/total_1_5*100, vir_1_5/total_1_5*100),
  echantillon_S=c(bac_6_12/total_6_12*100, euk_6_12/total_6_12*100, arc_6_12/total_6_12*100, vir_6_12/total_6_12*100),
  domaine=c("Bacteria", "Eukaryota", "Archaea","Viruses")
)
df_sqm$echantillon_H<-round(df_sqm$echantillon_H,2)
df_sqm$echantillon_S<-round(df_sqm$echantillon_S,2)

df_sqm

df_sqm_2<-tidyr::pivot_longer(df_sqm, cols=c('echantillon_H','echantillon_S'), names_to='variable',
                         values_to="pourcentage")

bp<-ggplot(df_sqm_2, aes(x=domaine, y=pourcentage, fill=variable))+
  geom_bar(stat="identity", position='dodge')+
  scale_x_discrete(limits=c("Bacteria", "Eukaryota", "Archaea","Viruses"))+
  geom_text(aes(label=pourcentage),vjust=-0.3, color="black",size=3.5,
            position=position_dodge(0.9))+
  scale_fill_brewer(palette='Paired')+
  labs(title= "Abondance relative des différents domaines de micro-organismes pour les échantllons H et S",
       x="Domaines", y="Abondance relative",fill ="Echantillons")+
  theme(axis.title = element_text(vjust=-1),plot.title = element_text(hjust = 0.5))+
  theme_minimal()
bp

##### SAMPLE H BACTERIE PHYLUM #############

df_BPH<-data.frame(
  phylum=c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Verrucomicrobia','Firmicutes',
           'Planctomycetes','Ignavibacteriae','Tenericutes','Spirochaetes','Autres'),
  echantillon_H=c(65.74,18.72,7.22,2.36,1.51,1.50,0.91,0.54,0.41,1.09))

df_BPH$phylum<- fct_relevel(df_BPH$phylum, c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Verrucomicrobia','Firmicutes',
                                             'Planctomycetes','Ignavibacteriae','Tenericutes','Spirochaetes','Autres'))

pie1<-ggplot(df_BPH,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                            #'Proteob','Bactero','Unclass','Verruco','Firmicu','Plancto','Ignavib','Teneric','Spiroch','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#ff420e','#579d1c','#7e0021','#83caff','#314004','#800080','#ff950e','#aecf00'))+
  labs(title="Abondance relative des bactéries \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie1

##### SAMPLE S BACTERIE PHYLUM #############

df_BPS<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Chloroflexi',
                             'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Autres'),
                   echantillon_S=c(42.35, 26.98, 17.19, 3.56, 2.61, 2.49, 1.79, 1.48, 0.80, 0.76))

df_BPS$phylum<- fct_relevel(df_BPS$phylum,c('Proteobacteria','Bacteroidetes','Unclassified Bacteria','Chloroflexi',
                                            'Firmicutes','Planctomycetes','Balneolaeota','Deinococcus-Thermus','Spirochaetes','Autres'))


pie2<-ggplot(df_BPS,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                              #'Proteo','Bacter','Unclas', 'Chlorof', 'Firmicu' 'Plancto','Balne', 'Deinoc','Spirocha','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#ff420e','#669472','#7e0021','#83caff','#4b1f6f','#c20d0d','#ff950e','#aecf00'))+
  labs(title="Abondance relative des bactéries \nen fonction du phylum pour l'échantillon S", fill="Phylum")+ 
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie2

#### SAMPLE H EUCARYOTES PHYLUM #####


df_EPH<-data.frame(phylum=c('Unclassified Eukaryota','Ciliophora','Streptophyta','Bigyra (no phylum in NCBI)','Chordata','Bacillariophyta',
                            'Oomycota (no phylum in NCBI)','Arthropoda','Rotifera','Autres'),
                   echantillon_H=c(38.03, 35.44, 4.66, 3.72, 3.43, 2.19, 1.79, 1.65, 1.25, 7.83))

df_EPH$phylum<- fct_relevel(df_EPH$phylum,c('Unclassified Eukaryota','Ciliophora','Streptophyta','Bigyra (no phylum in NCBI)','Chordata','Bacillariophyta',
                                            'Oomycota (no phylum in NCBI)','Arthropoda','Rotifera','Autres'))

pie3<-ggplot(df_EPH,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                            #'Unclass','Ciliopho','Strept','Bigyra','Chordata','Bacillar','Oomycota','Arthro','Rotifer','Autres'
  scale_fill_manual(values=c('#004586','#ff420e','#ffd320','#579d1c','#7e0021','#4b1f6f','#314004','#ff950e','#c20d0d','#aecf00'))+
  labs(title="Abondance relative des eucaryotes \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie3


#### SAMPLE S EUCARYOTES PHYLUM #####


df_EPS<-data.frame(phylum=c('Arthropoda', 'Unclassified Eukaryota','Chlorophyta','Chordata', 'Microsporidia', 
                            'Streptophyta','Nematoda', 'Cnidaria', 'Annelida', 'Autres'),
                   echantillon_S=c(51.99, 25.69, 4.98,4.45,3.32,2.48,1.47,1.40,0.78,3.45
                   ))

df_EPS$phylum<- fct_relevel(df_EPS$phylum,c('Arthropoda', 'Unclassified Eukaryota','Chlorophyta','Chordata', 'Microsporidia', 
                                            'Streptophyta','Nematoda', 'Cnidaria', 'Annelida', 'Autres'))

pie4<-ggplot(df_EPS,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                              #'Arthr, 'Unclass','Chloroph','Chorda', 'Micros','Strepto','Nematod', 'Cnida', 'Annelida','Autres')
  scale_fill_manual(values=c('#ff950e','#004586','#ed4937','#7e0021','#4f89d1','#ffd320','#ed2bd3','#ffff00','#8b02c7','#aecf00'))+
  labs(title="Abondance relative des eucaryotes \nen fonction du phylum pour l'échantillon S", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie4       

#### SAMPLE H ARCHAEA PHYLUM #####

df_APH<-data.frame(phylum=c('Euryarchaeota', 'Unclassified Archaea', 'Nanoarchaeota', 'Candidatus Woesearchaeota',  'Thaumarchaeota',
                           'Candidatus Bathyarchaeota', 'Autres'
),
                   echantillon_H=c(84.45, 8.91, 2.43, 1.24, 0.98, 0.89, 1.09
                   ))

df_APH$phylum<- fct_relevel(df_APH$phylum,c('Euryarchaeota', 'Unclassified Archaea', 'Nanoarchaeota','Candidatus Woesearchaeota',  'Thaumarchaeota',
                                            'Candidatus Bathyarchaeota', 'Autres'))

pie5<-ggplot(df_APH,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                             #'Euryar','Unclass', 'Nanoar','Cand Woe','Thauma',' Cand Bath','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#ff420e','#579d1c','#7e0021','#83caff','#aecf00'))+
  labs(title="Abondance relative des archées \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie5       


#### SAMPLE S ARCHAEA PHYLUM #####

df_APS<-data.frame(phylum=c('Euryarchaeota','Unclassified Archaea','Candidatus Woesearchaeota','Candidatus Lokiarchaeota',
                            'Candidatus Thorarchaeota','Autres'),
                   echantillon_S=c(93.07,4.27,0.86,0.53,0.50,0.28))

df_APS$phylum<- fct_relevel(df_APS$phylum,c('Euryarchaeota','Unclassified Archaea','Candidatus Woesearchaeota','Candidatus Lokiarchaeota',
                                            'Candidatus Thorarchaeota','Autres'))

pie6<-ggplot(df_APS,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                             #'Euryar','Unclas','Cand Woe','Cand Loki','Cand Tho','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#8b02c7','#ff950e', '#314004','#aecf00'))+
  labs(title="Abondance relative des archées \nen fonction du phylum pour l'échantillon S", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie6       

