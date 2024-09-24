# Dados da Pesquisa Origem e Destino da Região Metropolitana de Salvador (2012)

Este repositório disponibiliza dados tabulares e geográficos oriundos da Pesquisa de Mobilidade da Região Metropolitana de Salvador de 2012.

Os dados originais foram obtidos através do download do [arquivo compactado](http://sit.infraestrutura.ba.gov.br/docs/download/publicacoes/suplog/Pesquisa_OD.rar) em formato .rar disponibilizado pela Secretaria de Infraesturtura do Governo do Estado da Bahia. Este arquivo possui \~1,5GB de dados com múltiplas pastas e arquivos sobre a pesquisa realizada em 2012. Quando descompactado, atinge \~7 GB.

Os 3 arquivos para processamento foram extraídos dos seguintes diretórios do arquivo compactado:

-   **Dados tabulares**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados- rev.2/Banco de Dados OD Domiciliar rev 2

-   **Dados geográficos**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados dos Produtos consolidados/Arquivos_kmz_do_zoneamento

O primeiro diretório contém a pasta de trabalho do Excel "Banco de Dados OD Domiciliar rev 2.xlsx". Esta pasta de trabalho é formada por 6 planilhas com tabelas de respostas dos questionários ("Banco Domicílios", "Banco Moradores", "Banco Atividades", "Banco de Viagens", "Banco Segurança" e "Banco de Viagens (matriz link)"), 1 planiha contendo o descritivo dos campos destas tabelas ("descrição dos campos") e 1 planilha contendo a codificação utilizada em alguns destes campos ("códigos").

O segundo diretório contém os arquivos geográficos compactados "Zonas OD Salvador.kmz" e "Subzonas OD Salvador.kmz" com as camadas de pontos e polígonos das zonas e subzonas. Todos estes arquivos foram salvos no diretório `data_raw` deste repositório.

Após processamento no R (ver diretório `R` deste repositório com os códigos), os arquivos finais foram salvos na pasta `data`, contendo a descrição dos campos e códigos para elaboração dos dicionários (em `data/dics`), os arquivos geográficos de zonas e subzonas de tráfego (`data/geo`) e as tabelas com as respostas aos questionários da entrevista domiciliar (`data/tables`). Em todos os casos, os arquivos foram salvos no formato .rda para R.

Para o dicionário foram salvas dois arquivos (`descricao_campos.rda` e `descricao_codigos.rda`). No primeiro, há uma lista unidimensional de tamanho 6, contendo 6 tibbles com os nomes dos campos (colunas) e suas respectivas descrições para as bases de dados mencionadas anteriormente. O segundo arquivo contém uma lista bidimensional, onde a primeira dimensão referencia a base de dados escolhida e a segunda dimensão indica a variável que se quer entender a codificação. Por exemplo, a chamada `descricao_codigos[[1]][[2]]` retornará um tibble relativo à explicação dos códigos da variável "Condição de Moradia" da base de dados "Banco Domicílios". O resultado é o seguinte tibble:

+------------+--------------+
| codigo     | descricao    |
+============+==============+
| 1          | ```          |
|            | próprio      |
|            | ```          |
+------------+--------------+
| 2          | ```          |
|            | alugado      |
|            | ```          |
+------------+--------------+
| 3          | ```          |
|            | cedido       |
|            | ```          |
+------------+--------------+
| 4          | ```          |
|            | invadido     |
|            | ```          |
+------------+--------------+
