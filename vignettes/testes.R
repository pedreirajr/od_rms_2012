library(sf); library(tidyverse)

# Carrega as bases de dados
load("data/tables/tabelas_dados.rda")
load("data/geo/zonas_rms_pol_crs4674.rda")
load("data/geo/subzonas_rms_pol_crs4674.rda")

# Armazena base de dados de viagens e arquivos de polígonos das zonas e subzonas
# em 3 objetos para processamento
viagens <- tabelas_dados[[6]]
pol_zon <- zonas_rms_pol_crs4674
pol_subzon <- subzonas_rms_pol_crs4674

# Confere quantidade de zonas únicas na base de viagens que existem no arquivo
# de polígonos
zonas_unicas <- union(unique(viagens$Z_O),unique(viagens$Z_O))
length(zonas_unicas) # 251
sum(zonas_unicas %in% pol_zon$Name) # 217 zonas presentes no arquivo de polígonos

# Confere quantidade de subzonas únicas na base de viagens que existem no arquivo
# de polígonos
subzonas_unicas <- union(unique(viagens$ZONAsub_O),unique(viagens$ZONAsub_D))
length(subzonas_unicas) # 842
sum(subzonas_unicas %in% pol_subzon$Name) # 802 subzonas presentes no arquivo de polígonos
