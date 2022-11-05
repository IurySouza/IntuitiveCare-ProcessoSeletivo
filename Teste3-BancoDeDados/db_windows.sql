SELECT 'CREATE DATABASE relatorio_operadoras;'
  WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'relatorio_operadoras')\gexec
\c relatorio_operadoras

CREATE TEMP TABLE temp_despesas(full_line TEXT);
CREATE TEMP TABLE temp_operadores(full_line TEXT);

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

\copy temp_despesas FROM '.\Data\1T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM '.\Data\2T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM '.\Data\3T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_despesas FROM '.\Data\4T2021.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'UTF8');

\copy temp_despesas FROM '.\Data\1T2022.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'UTF8');

\copy temp_despesas FROM '.\Data\2T2022.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

\copy temp_operadores FROM '.\Data\Relatorio_cadop.csv' WITH (format 'csv', header 'true', delimiter E'\b', encoding 'ISO-8859-1');

DELETE FROM temp_operadores WHERE ctid IN (
    SELECT ctid
    FROM temp_operadores
    LIMIT 2
);

WITH temp(a) AS  (
 SELECT string_to_array(full_line, ';') FROM temp_operadores
)
INSERT INTO operadoras
  SELECT
    a[ 1]::integer,
    a[ 2]::text,
    a[ 3]::text,
    a[ 4]::text,
    a[ 5]::text,
    a[ 6]::text,
    a[ 7]::text,
    a[ 8]::text,
    a[ 9]::text,
    a[10]::text,
    a[11]::text,
    a[12]::text,
    a[13]::text,
    a[14]::text,
    a[15]::text,
    a[16]::text,
    a[17]::text,
    a[18]::text,
    a[19]::date
  FROM temp;

WITH temp(a) AS  (
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

