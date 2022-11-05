# Teste 3 - Banco de Dados
O teste consiste na criação de um Banco de Dados a partir de informações presentes em CSV's, posteriormente realizando queries análiticas sobre os dados.

## Dependências
- Postgresql

## Funcionamento
Foram desenvolvidos dois scripts para criar o banco de dados:
- db_unix.sql: Funciona em sistemas unix como linux e macOS;
- db_windows.sql: Funciona nas plataformas windows

Essa diferença se deve ao comando "tail", que está presente em sistemas unix mas não no windows. Esse comando permite ignorar as N primeiras linhas do CSV, passo necessário para a transformação do "relatório cadop", além da diferença em caminhos de diretório entre os sistemas ('\' para Windows, e '/' para Unix).
Foram criadas duas tabelas: despesas, que contém os dados baixados do site do governo, e operadoras, com as informações do CSV disponibilizado. Utilizando o comando \copy, foi feita a conversão dos CSV's para o banco de dados.

## Queries Analíticas
Segundo a especificação do exercício, foram criados dois arquivos para realizar consultas no banco:
- query_trimestre.sql: vê as 10 operadoras com mais gastos na categoria 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSIST_NCIA A SA_DE MEDICO HOSPITALAR' no último trimestre;
- query_ano.sql: realiza a mesma consulta, porém considerando o último ano.

Primeiramente, obtêm-se as datas em ordem decrescente, a data mais recente são usadas para determinar o período do trimestre, enquanto as últimas 4 datas são utilizadas para determinar o período do ano.
Com base nesse período, é feito uma somatório do saldo de cada operadora naquela categoria específica, e então é feita uma junção das duas tabelas com base no registro ans da operadora, para poder mostrar todas as 10 operadores, ordenadas por saldo.