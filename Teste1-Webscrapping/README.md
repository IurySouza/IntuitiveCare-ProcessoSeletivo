# Teste 1 - Webscrapping
O teste consiste em realizar webscrapping para realizar o download de diversos arquivos.

## Dependências
- Python 3.8.10
- Scrapy 2.7.0 (ATENÇÃO: é necessário NÃO instalar uma versão superior do Scrapy. Caso já exista uma versão instalada, 
                    use o comando: $ pip install -Iv scrapy==2.7.0)

## Funcionamento
A partir da biblioteca Scrapy, é feito o crawling conseguindo-se assim os nomes e links de download dos arquivos desejados. Tais dados são salvos em um JSON, que é então lido e transformado em um array de dicionários Python. A partir disso, é realizado o acesso aos links de download, e os arquivos são salvos em uma pasta temporária. Finalmente, os arquivos relevantes são comprimidos em formato zip e os arquivos temporários (JSON e arquivos baixados) são deletados.