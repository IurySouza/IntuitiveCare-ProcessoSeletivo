SELECT 'CREATE DATABASE relatorio_operadoras'
  WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'relatorio_operadoras')\gexec
\c relatorio_operadoras

CREATE TEMP TABLE temp_despesas(full_line TEXT);

CREATE TABLE IF NOT EXISTS despesas(
    data DATE,
    reg_ans INTEGER,
    cd_conta_contabil INTEGER,
    descricao TEXT,
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2) 
);

CREATE TABLE IF NOT EXISTS operadoras(
    registro_ans INTEGER,
    cnpj TEXT,
    razao_social TEXT,
    nome_fantasia TEXT,
    modalidade TEXT,
    logradouro TEXT,
    numero TEXT,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT,
    uf TEXT,
    cep TEXT,
    ddd TEXT,
    telefone TEXT,
    fax TEXT,
    endereco_eletronico TEXT,
    representante TEXT,
    cargo_representante TEXT,
    data_registro_ans DATE
);

\copy temp_despesas FROM './Data/1T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM './Data/2T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM './Data/3T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM './Data/4T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM './Data/1T2022.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM './Data/2T2022.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy operadoras(registro_ans,cnpj,razao_social,nome_fantasia,modalidade,logradouro,numero,complemento,bairro,cidade,uf,cep,ddd,telefone,fax,endereco_eletronico,representante,cargo_representante,data_registro_ans) FROM PROGRAM 'tail -n +4 ./Data/Relatorio_cadop.csv' WITH (format 'csv', header 'true', delimiter ';', encoding 'ISO-8859-1');

WITH temp(a) AS (
 SELECT string_to_array(full_line, ';') FROM temp_despesas
)
INSERT INTO despesas
  SELECT
    a[1]::date,
    a[2]::integer,
    a[3]::integer,
    a[4]::text,
    regexp_replace(a[5], ',', '.')::decimal(15,2),
    regexp_replace(a[6], ',', '.')::decimal(15,2)
  FROM temp;