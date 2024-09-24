library(readxl); library(dplyr); library(hms)

# Lendo as tabelas existentes
path <- "data_raw/Banco de Dados OD Domiciliar rev 2.xlsx"
tabs <- readxl::excel_sheets(path)

# Obtém vetor de texto contendo somente nomes das abas do excel que se referem
# às tabelas de dados da pesquisa
tabs_dados <- tabs[which(grepl("^Banco", tabs))]

# Cria a pasta para as tabelas
output_dir_tables <- "data/tables"
if (!dir.exists(output_dir_tables)) {
  dir.create(output_dir_tables, recursive = T) 
}

# Lê as tabelas e as salva em .rda:
tabelas_dados <- list()

for (i in seq_along(tabs_dados)){
  
  # Lê cada tabela de dados
  tabelas_dados[[i]] <- readxl::read_excel(path, sheet = tabs_dados[i])
  
  # Correção dos valores de horas
  ## Obs.: por algum motivo, as funções para ler planilhas do R (seja do readxl 
  ## ou do openxls) convertem parte dos valores de colunas contendo valores de
  ## horas em fração e mantém o restante no formato HH:MM:SS (apesar de tudo
  ## ser texto, no fim das contas). As colunas são HORA_O e HORA_D presentes 
  ## 2 das planilhas.
  ## Esta foi a única solução que consegui dar para resolver o problema:
  if('HORA_O' %in% colnames(tabelas_dados[[i]]) |
     'HORA_D' %in% colnames(tabelas_dados[[i]])){
    tabelas_dados[[i]] <- tabelas_dados[[i]] %>% 
      mutate(HORA_O = ifelse(grepl("\\.", HORA_O),
                             format(as.POSIXct(as.numeric(HORA_O) * 86400, 
                                               origin = "1970-01-01", tz = "UTC"),
                                    "%H:%M:%S"),
                             HORA_O),
             HORA_D = ifelse(grepl("\\.", HORA_D),
                             format(as.POSIXct(as.numeric(HORA_D) * 86400, 
                                               origin = "1970-01-01", tz = "UTC"), 
                                    "%H:%M:%S"),
                             HORA_D))
  }
  # Elimina 3 colunas adicionais adicionadas artificialmente por causa da 
  # configuração da planilha do excel para a tabela "Banco de Viagens 
  # (matriz link)"
  if(i == 6){
    tabelas_dados[[i]] <- tabelas_dados[[i]] %>% select(-c(...27,...28,...29))
  }
}

# Salva a lista de tabelas no diretório data/tables:
save(tabelas_dados, file = 'data/tables/tabelas_dados.rda')
