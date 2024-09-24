library(tidyverse); library(sf)

# Carregamento das bases de dados
load("data/tables/tabelas_dados.rda")
load("data/geo/zonas_rms_pol_crs4674.rda")
load("data/geo/zonas_rms_pts_crs4674.rda")

# Armazenando as bases de dados em objetos para processamento
viagens <- tabelas_dados[[6]]
pol_zon <- zonas_rms_pol_crs4674
pts_zon <- zonas_rms_pts_crs4674

# Produzindo dados de fluxos de viagens 
## Obtendo coordenadas x,y dos centroides das zonas
pts_zon <- cbind(pts_zon,st_coordinates(pts_zon))

## Tabela com fluxos OD
flux <- viagens %>% 
  group_by(Z_O,Z_D) %>% 
  summarize(n = sum(FATOR_EXP, na.rm = T)) %>% 
  ## Adicionando as coordenadas das zonas de origem
  left_join(pts_zon %>% st_drop_geometry() %>% select(Name,X,Y),
            by = join_by(Z_O == Name)) %>% 
  rename('O_X' = 'X', 'O_Y' = 'Y') %>% 
  ## Adicionando as coordenadas das zonas de destino
  left_join(pts_zon %>% st_drop_geometry() %>% select(Name,X,Y),
            by = join_by(Z_D == Name)) %>% 
  rename('D_X' = 'X', 'D_Y' = 'Y')

# Mapa de fluxos OD (somente acima de 2000 viagens)
ggplot() +
  geom_sf(data = pol_zon, fill = "#353941", color = "white", linewidth = 0.05) +
  geom_curve(data = flux %>% filter(!is.na(Z_O) & !is.na(Z_D) &
                                      Z_O != Z_D & n >= 2000),
             aes(x = O_X, y = O_Y,
                 xend = D_X, yend = D_Y,
                 linewidth = n),
             arrow = arrow(length = unit(0.01, "npc"), type = 'closed'),
             color = '#E8772D', alpha = 0.8) +
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

ggsave('vignettes/fluxos_acima2000.jpg', dpi = 300)

