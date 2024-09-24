# Dados da Pesquisa Origem e Destino da Região Metropolitana de Salvador (2012)

Este repositório disponibiliza dados tabulares e geográficos oriundos da Pesquisa de Mobilidade da Região Metropolitana de Salvador de 2012.

Os dados originais foram obtidos através do download do [arquivo compactado](http://sit.infraestrutura.ba.gov.br/docs/download/publicacoes/suplog/Pesquisa_OD.rar) em formato .rar e disponibilizado pela Secretaria de Infraesturtura do Governo do Estado da Bahia. Este arquivo possui \~1,5GB de dados com múltiplas pastas e arquivos sobre a pesquisa realizada em 2012. Quando descompactado atinge \~7 GB.

Os 3 arquivos para processamento foram extraídos dos seguintes diretórios do arquivo compactado:

-   **Dados tabulares**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados- rev.2/Banco de Dados OD Domiciliar rev 2

-   **Dados geográficos**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados dos Produtos consolidados/Arquivos_kmz_do_zoneamento

O primeiro contém a pasta de trabalho do Excel "Banco de Dados OD Domiciliar rev 2.xlsx" que possui planilhas com dados dos questionários aplicados nas entrevistas domiciliares e descrições dos campos e dos códigos utilizados em cada tabela. Esta pasta de trabalho é formada por 6 planilhas com tabelas de respostas ("Banco Domicílios", "Banco Moradores", "Banco Atividades", "Banco de Viagens", "Banco Segurança" e "Banco de Viagens (matriz link)") e 2 planihas contendo descritivo dos campos destas tabelas ("descrição dos campos") e a codificação utilizadas em alguns campos ("códigos").

O segundo consiste em arquivos .kmz "Zonas OD Salvador.kmz" e "Subzonas OD Salvador.kmz" com as camadas de pontos e polígonos das zonas e subzonas. Todos estes arquivos foram salvos no diretório `data_raw` deste repositório.

Após processamento no R (ver diretório `R` deste repositório com os códigos), os arquivos finais foram salvos na pasta `data`, contendo a descrição dos campos e códigos para elaboração dos dicionários (em `data/dics`), os arquivos geográficos de zonas e subzonas de tráfego (`data/geo`) e as tabelas com as respostas aos questionários da entrevista domiciliar (`data/tables`). Em todos os casos, os arquivos foram salvos no formato .rda para R.

Para o dicionário foram salvas duas listas (`descricao_campos.rda` e `descricao_codigos.rda`). No primeiro caso, há uma lista unidimensional de tamanho 6, contendo 6 tibbles com os nomes dos campos (colunas) e suas respectivas descrições para asbases de dados existentes. No segundo caso, o arquivo é uma lista com duas dimensões, onde a primeira dimensão indica a bases de dados escolhida e a segunda à variável que se quer entender a codificação. Por exemplo, o comando descricao_codigos[[1]][[2]] retornará um tibble relativo à explicação dos códigos da variável "Condição de Moradia" da base de dados "Banco Domicílios".
