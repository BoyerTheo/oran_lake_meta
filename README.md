# oran_lake_meta

L'ensemble des scripts retrouvés dans ce répertoire permettent de traiter, uniformiser et trier les données issues du séquençage shotgun métagénomique du lac Dayat Morsli d'Oran :

* misassembly.py : permet de détecter et d'éliminer les potentielles chimères formées lors de l'assemblage, cette fonction permet d'éliminer les contigs ayant une trop grosse variation de profondeur au sein de leur séquence

* kraken_abundance.py : permet de refaire une abondance relative en prenant en compte la profondeur des contigs, sinon l'abondance relative est fausse car elle se base uniquement sur le nombre de contig classé à un taxon.

* graph_kraken.py : permet d'obtenir un certain nombre de graphique à partir du rapport généré par Kraken2 via l'utilisation de matplotlib

* remove_zero_cov.py : permet de faire le trie dans les contigs assemblés via metaSpades en fonction de leur couverture et de leur profondeur. Sont ainsi éliminés les contigs présentant un fort risque d'être des artéfacts (0 de couverture / profondeur trop faible).

Liste des commandes :

Le dossier "scripts" répertorie toutes les commandes utilisées pour lancer les différents logiciels sur le core cluster de l'IFB 
