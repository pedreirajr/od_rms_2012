# Dados da Pesquisa Origem e Destino da Região Metropolitana de Salvador (2012)

Este repositório disponibiliza dados tabulares e geográficos oriundos da Pesqusia de Mobilidade da Região Metropolitana de Salvador de 2012.

Os dados originais foram obtidos através do download do [arquivo compactado](http://sit.infraestrutura.ba.gov.br/docs/download/publicacoes/suplog/Pesquisa_OD.rar) em formato .rar e disponibilizado pela Secretaria de Infraesturtura do Governo do Estado da Bahia. Este arquivo possui \~1,5GB de dados com múlitplas pastas e arquivos sobre a pesquisa realizada em 2012. Quando descompactado atinge \~7 GB.

Os 3 arquivos extraídos para processamento foram obtidos a partir dos seguintes diretórios do arquivo compactado:

-   **Dados tabulares**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados- rev.2/Banco de Dados OD Domiciliar rev 2

-   **Dados geográficos**:

Pesquisa OD/PESQUISA O-D NA RMS/Banco de dados dos Produtos consolidados/Arquivos_kmz_do_zoneamento

O primeiro contém a pasta de trabalho do Excel "Banco de Dados OD Domiciliar rev 2.xlsx" que possui planilhas com as tabelas oriundas das respostas dos questionários aplicados nas entrevistas domiciliares e descrições dos campos e dos códigos utilizados em cada tabela. O segundo consiste em arquivos .kmz com as camadas de pontos e polígonos das zonas e subzonas. Todos estes arquivos foram salvos no diretório data_raw deste repositório.

Após processamento no R (ver diretório R deste repositório com os códigos), os arquivos finais foram salvos na pasta data, contendo a descrição dos campos e códigos para elaboração dos dicionários (em data/dics), os arquivos geográficos de zonas e subzonas de tráfego (data/geo) e as tabelas com as respostas aos questionários da entrevista domiciliar (data/tables).
