library(sf); library(tidyverse)

# Cria pasta para arquivos kml originais
output_dir_geo_unzip <- "data_raw/geo_unzip"
if (!dir.exists(output_dir_geo_unzip)) {
  dir.create(output_dir_geo_unzip, recursive = T) 
}

# Descompacta os KMZ de zonas e subzonas:
unzip("data_raw/Zonas OD Salvador.kmz", 
      exdir = "data_raw/geo_unzip/zonas")
unzip("data_raw/Subzonas OD Salvador.kmz", 
      exdir = "data_raw/geo_unzip/subzonas")

# Renomeia o arquivo de zonas e subzonas:
name_file_zonas <- list.files("data_raw/geo_unzip/zonas", full.names = TRUE)
file.rename(name_file_zonas, "data_raw/geo_unzip/zonas/zonas_rms_original.kml")

name_file_subzonas <- list.files("data_raw/geo_unzip/subzonas", full.names = TRUE)
file.rename(name_file_subzonas, "data_raw/geo_unzip/subzonas/subzonas_rms_original.kml")

# Lê as camadas que existem no arquivo
zonas_rms_layers <- st_layers(paste0(output_dir_geo_unzip,
                                     '/zonas/zonas_rms_original.kml'))
subzonas_rms_layers <- st_layers(paste0(output_dir_geo_unzip,
                                        '/subzonas/subzonas_rms_original.kml'))

# Lê arquivos por camada
zonas_rms_pts <- st_read(paste0(output_dir_geo_unzip,
                                '/zonas/zonas_rms_original.kml'),
                         layer = zonas_rms_layers$name[1])
zonas_rms_pol <- st_read(paste0(output_dir_geo_unzip,
                                '/zonas/zonas_rms_original.kml'),
                         layer = zonas_rms_layers$name[2])

subzonas_rms_pts <- st_read(paste0(output_dir_geo_unzip,
                                   '/subzonas/subzonas_rms_original.kml'),
                            layer = subzonas_rms_layers$name[1])
subzonas_rms_pol <- st_read(paste0(output_dir_geo_unzip,
                                   '/subzonas/subzonas_rms_original.kml'),
                            layer = subzonas_rms_layers$name[2])

# Converte CRS para SIRGAS2000 (4674)
zonas_rms_pts_crs4674 <- st_transform(zonas_rms_pts, crs = 4674)
zonas_rms_pol_crs4674 <- st_transform(zonas_rms_pol, crs = 4674)
subzonas_rms_pts_crs4674 <- st_transform(subzonas_rms_pts, crs = 4674)
subzonas_rms_pol_crs4674 <- st_transform(subzonas_rms_pol, crs = 4674)

# Edita os nomes das ZONAS para 3 dígitos com zero à esquerda para join futuro
# com as bases de dados tabulares
zonas_rms_pts_crs4674 <- zonas_rms_pts_crs4674 %>% 
  mutate(Name = ifelse(nchar(Name) == 1, paste0("00",Name),
                       ifelse(nchar(Name) == 2, paste0("0",Name), Name))) 

zonas_rms_pol_crs4674 <- zonas_rms_pol_crs4674 %>% 
  mutate(Name = ifelse(nchar(Name) == 1, paste0("00",Name),
                       ifelse(nchar(Name) == 2, paste0("0",Name), Name))) 

# Edita os nomes das SUBZONAS, substituindo "-" por "." para join futuro
# com as bases de dados tabulares
subzonas_rms_pts_crs4674 <- subzonas_rms_pts_crs4674 %>% 
  mutate(Name = gsub("- ?", ".", Name))

subzonas_rms_pol_crs4674 <- subzonas_rms_pol_crs4674 %>% 
  mutate(Name = gsub("- ?", ".", Name))


# Cria subpasta de destino para os arquivos finais em CRS4674
output_dir_geo <- "data/geo"
if (!dir.exists(output_dir_geo)) {
  dir.create(output_dir_geo, recursive = T) 
}

# Salva o novo arquivo com o CRS transformado
save(zonas_rms_pts_crs4674, 
     file = paste0(output_dir_geo,'/zonas_rms_pts_crs4674.rda'))
save(zonas_rms_pol_crs4674, 
     file = paste0(output_dir_geo,'/zonas_rms_pol_crs4674.rda'))
save(subzonas_rms_pts_crs4674, 
     file = paste0(output_dir_geo,'/subzonas_rms_pts_crs4674.rda'))
save(subzonas_rms_pol_crs4674, 
     file = paste0(output_dir_geo,'/subzonas_rms_pol_crs4674.rda'))

# Teste
# ggplot() +
#   geom_sf(data = zonas_rms_pol_crs4674) +
#   geom_sf(data = zonas_rms_pts_crs4674)
# 
# ggplot() +
#   geom_sf(data = subzonas_rms_pol_crs4674) +
#   geom_sf(data = subzonas_rms_pts_crs4674)
