library('ggplot2')
library('tidyr')
library('forcats')
library('tidyverse')

df<-data.frame(
  echantillon_H=c(71.64,27.89,0.29,0.18),
  echantillon_S=c(60.47,31.25,8.04,0.24),
  domaine=c('Bacteria','Eukaryota','Archaea','Viruses')
)

df2<-tidyr::pivot_longer(df, cols=c('echantillon_H','echantillon_S'), names_to='variable',
                                 values_to="pourcentage")

bp<-ggplot(df2, aes(x=domaine, y=pourcentage, fill=variable))+
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


######## PHYLUM BACTERIEN H #######################    


df_EHD<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes',
                'Planctomycetes','Tenericutes','Cyanobacteria','Verrucomicrobia',
                'Deinococcus-Thermus','Autres'),
                echantillon_H=c(80.75,7.741,4.539,3.168,1.812,0.6288,0.4245,
                                0.2401,0.1172,0.5794)
)

df_EHD$phylum<- fct_relevel(df_EHD$phylum,c('Proteobacteria','Bacteroidetes','Actinobacteria','Firmicutes',
                                              'Planctomycetes','Tenericutes','Cyanobacteria','Verrucomicrobia',
                                              'Deinococcus-Thermus','Autres'))

pie1<-ggplot(df_EHD,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                            #'Proteob','Bactero','Actinob','Firmicu','Plancto','Teneric','Cyanoba','Verruco','Deinocc','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#ff420e','#579d1c','#7e0021','#83caff','#314004','#800080','#ff950e','#aecf00'))+
  labs(title="Abondance relative des bactéries \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie1

######## PHYLUM BACTERIEN S #######################    

df_ESD<-data.frame(phylum= c('Proteobacteria','Bacteroidetes','Actinobacteria'
                              ,'Firmicutes','Planctomycetes',
                              'Cyanobacteria','Deinococcus-Thermus',
                              'Chloroflexi','Chlorobi','Autres'),
                   echantillon_S=c(60.87,14.37,13.07,4.826,2.893,0.9045,0.6474,0.4006,0.2666,1.7519)
)

df_ESD$phylum<- fct_relevel(df_ESD$phylum,c('Proteobacteria','Bacteroidetes','Actinobacteria'
                                              ,'Firmicutes','Planctomycetes',
                                              'Cyanobacteria','Deinococcus-Thermus',
                                              'Chloroflexi','Chlorobi','Autres'))
                                              

pie2<-ggplot(df_ESD,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                              #'Prote','Bactero','Actino','Firmicu','Planctom','Cyanoba','Deinocc','Chlorof','Chlorobi','Autres'
  scale_fill_manual(values=c('#004586','#ffd320','#ff420e','#579d1c','#7e0021','#314004','#ff950e','#c20d0d','#4b1f6f','#aecf00'))+
  labs(title="Abondance relative des bactéries \nen fonction du phylum pour l'échantillon S", fill="Phylum")+ 
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie2

######## PHYLUM EUCARYOTE H #######################    

df_EHP<-data.frame(phylum=c('Chordata','Arthropoda','Streptophyta','Ascomycota',
                   'Mollusca','Ciliophora','Platyhelminthes','Basidiomycota','Nematoda','Autres'),
                   echantillon_H=c(48.19,25.38,12.46,4.523,1.517,1.344,1.096,1.074,0.9201,3.4959))
                   
df_EHP$phylum<- fct_relevel(df_EHP$phylum,c('Chordata','Arthropoda','Streptophyta','Ascomycota',
                                            'Mollusca','Ciliophora','Platyhelminthes','Basidiomycota','Nematoda','Autres'))

pie3<-ggplot(df_EHP,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                              #'Chorda','Arthro','Strepto','Ascomy','Mollusca','Cilioph','Platyhe','Basidio','Nematoda','Autres'
  scale_fill_manual(values=c('#004586','#ff420e','#ffd320','#579d1c','#7e0021','#4b1f6f','#314004','#ff950e','#c20d0d','#aecf00'))+
  labs(title="Abondance relative des eucaryotes \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie3

######## PHYLUM EUCARYOTE S #######################         

df_ESP<-data.frame(phylum=c('Chordata','Arthropoda','Streptophyta','Ascomycota',
                            'Mollusca','Platyhelminthes','Basidiomycota','Nematoda','Apicomplexa','Autres'),
                   echantillon_S=c(48.55,27.4,12.52,4.049,1.465,1.133,1.101,0.889,0.4924,2.4
                   ))

df_ESP$phylum<- fct_relevel(df_ESP$phylum,c('Chordata','Arthropoda','Streptophyta','Ascomycota',
                                            'Mollusca','Platyhelminthes','Basidiomycota','Nematoda','Apicomplexa','Autres'))

pie4<-ggplot(df_ESP,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                            #'Chordata','Arthro','Strepto','Ascomyc','Mollusca','Platyh','Basidio','Nematoda','Apicom','Autres'
  scale_fill_manual(values=c('#004586','#ff420e','#ffd320','#579d1c','#7e0021','#314004','#ff950e','#c20d0d','#8b02c7','#aecf00'))+
  labs(title="Abondance relative des eucaryotes \nen fonction du phylum pour l'échantillon S", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie4       

######## PHYLUM ARCHEA H #######################    

df_AHP<-data.frame(phylum=c('Euryarchaeota','Crenarchaeota','Thaumarchaeota','Candidatus Thermoplasmatota',
                            'Autres'),
                   echantillon_H=c(87.05,5.987,4.528,1.814,0.621
                   ))

df_AHP$phylum<- fct_relevel(df_AHP$phylum,c('Euryarchaeota','Crenarchaeota','Thaumarchaeota','Candidatus Thermoplasmatota',
                                            'Autres'))

pie5<-ggplot(df_AHP,aes(x="",y=echantillon_H,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                              #Euryar','Crenarc','Thaumar','Can Ther','Autres'
  scale_fill_manual(values=c('#004586','#ff420e','#ffd320','#579d1c','#aecf00'))+
  labs(title="Abondance relative des archées \nen fonction du phylum pour l'échantillon H", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie5       


######## PHYLUM ARCHEA S #######################   

df_ASP<-data.frame(phylum=c('Euryarchaeota','Autres'),
                   echantillon_S=c(99.18,0.82
                   ))

df_ASP$phylum<- fct_relevel(df_ASP$phylum,c('Euryarchaeota','Autres'))

pie6<-ggplot(df_ASP,aes(x="",y=echantillon_S,fill=phylum))+
  geom_bar(stat="identity")+
  coord_polar("y",start=0)+
                               #Euryar','Autres'
  scale_fill_manual(values=c('#004586','#aecf00'))+
  labs(title="Abondance relative des archées \nen fonction du phylum pour l'échantillon S", fill="Phylum")+
  theme_void()+
  theme(plot.title = element_text(hjust = 0, size=25),
        legend.text = element_text(size = 20),
        legend.title = element_text(size=20))
pie6       
