\c relatorio_operadoras

WITH aux_datas AS (
    SELECT
        data
    FROM despesas
    GROUP BY data
    ORDER BY data DESC
),
aux_despesas AS (
    SELECT
        reg_ans,
        descricao,
        SUM(vl_saldo_final) AS saldo
    FROM despesas
    WHERE
            vl_saldo_final IS NOT NULL
        AND data IN (SELECT data FROM aux_datas LIMIT 4)
        AND descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSIST_NCIA A SA_DE MEDICO HOSPITALAR '
    GROUP BY
        reg_ans,
        descricao
    ORDER BY saldo DESC
    LIMIT 10
)

SELECT
    razao_social,
    saldo
FROM operadoras
    JOIN aux_despesas ON aux_despesas.reg_ans=operadoras.registro_ans
ORDER BY saldo DESC;