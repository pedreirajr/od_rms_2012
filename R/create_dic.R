library(readxl); library(dplyr)

# Lê as tabelas existentes
path <- "data_raw/Banco de Dados OD Domiciliar rev 2.xlsx"
tabs <- readxl::excel_sheets(path)

# (1) Organização dos campos ---------------------------------------------------

# Lê a aba 'descrição dos campos'
campos <- read_excel(path, sheet = "descrição dos campos", col_names = F)

# Identifica as linhas que contém os títulos dos blocos
blocos_indices <- which(grepl("^BLOCO", campos$...1))

# Extrai os nomes dos blocos
nomes_blocos <- campos$...1[blocos_indices]

# Cria uma lista para armazenar os dataframes de cada bloco
lista_blocos <- list()

# Loop para separar cada bloco em um dataframe
for (i in seq_along(blocos_indices)) {
  # Índice inicial e final de cada bloco
  inicio <- blocos_indices[i] + 1
  fim <- ifelse(i < length(blocos_indices), blocos_indices[i + 1] - 1, nrow(campos))
  
  # Extrair os dados do bloco e limpar as linhas vazias
  bloco <- campos[inicio:fim, ] %>%
    filter(!is.na(...1))
  
  colnames(bloco) <- c("campo", "descricao")
  
  # Adiciona o dataframe à lista com o nome do bloco
  lista_blocos[[nomes_blocos[i]]] <- bloco
}

#
# (2) Organização dos códigos dos campos ---------------------------------------
path <- "data_raw/Banco de Dados OD Domiciliar rev 2.xlsx"
tabs <- readxl::excel_sheets(path)

# Lê descrição dos campos de cada arquivo
# Lê a aba 'descrição dos campos'
cods <- read_excel(path, sheet = "códigos", col_names = F)

# Identifica as linhas que contém os títulos dos blocos
blocos_indices <- which(grepl("^BLOCO", cods$...1))

# Extrai os nomes dos blocos
nomes_blocos <- cods$...1[blocos_indices]

# Cria uma lista para armazenar os blocos e suas variáveis
lista_cods <- list()

# Loop para separar cada bloco
for (i in seq_along(blocos_indices)) {
  # Índice inicial e final de cada bloco
  inicio_bloco <- blocos_indices[i] + 1
  fim_bloco <- ifelse(i < length(blocos_indices), blocos_indices[i + 1] - 1, nrow(cods))
  
  # Extrai o bloco
  bloco <- cods[inicio_bloco:fim_bloco, ] %>%
    filter(!is.na(...1))
  
  # Identifica as variáveis e seus dados associados
  variaveis_indices <- which(!is.na(bloco$...1) & is.na(bloco$...2))
  nomes_variaveis <- bloco$...1[variaveis_indices]
  
  # Cria uma lista para armazenar as variáveis deste bloco
  lista_variaveis <- list()
  
  # Loop para cada variável dentro do bloco
  for (j in seq_along(variaveis_indices)) {
    # Índice inicial e final de cada variável
    inicio_var <- variaveis_indices[j] + 1
    fim_var <- ifelse(j < length(variaveis_indices), variaveis_indices[j + 1] - 1, nrow(bloco))
    
    # Extrai a tabela de códigos e descrições para cada variável
    variavel <- bloco[inicio_var:fim_var, ] %>%
      filter(!is.na(...1), !is.na(...2)) %>%
      rename(codigo = ...1, descricao = ...2)
    
    # Adiciona a tabela de códigos e descrições à lista de variáveis deste bloco
    lista_variaveis[[nomes_variaveis[j]]] <- variavel
  }
  
  # Adiciona a lista de variáveis ao bloco correspondente na lista aninhada
  lista_cods[[nomes_blocos[i]]] <- lista_variaveis
}

# Exibe a estrutura da lista aninhada
str(lista_cods)

# (3) Salvando as listas com os campos e códigos para dicionário -------------
output_dir_dics <- "data/dics"
if (!dir.exists(output_dir_dics)) {
  dir.create(output_dir_dics, recursive = T) 
}

save(lista_blocos, file = 'data/dics/descricao_campos.rda')
save(lista_cods, file = 'data/dics/descricao_codigos.rda')

