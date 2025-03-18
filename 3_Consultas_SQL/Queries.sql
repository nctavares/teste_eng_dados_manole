-------------------------------------------------------------------------------------------------------
------------- 1. Qual o total de vendas por cliente e categoria de produto no último mês? -------------
-------------------------------------------------------------------------------------------------------

SELECT
    c.nome_cliente AS cliente,
    p.categoria AS categoria_produto,
    SUM(fv.valor_total) AS total_vendas
FROM
    fato_vendas fv
    JOIN dim_cliente c ON fv.id_cliente = c.id_cliente
    JOIN dim_produto p ON fv.id_produto = p.id_produto
    JOIN dim_tempo t ON fv.id_tempo = t.id_tempo
WHERE
    t.data >= DATEADD(MONTH, -1, GETDATE())
GROUP BY
    c.nome_cliente, p.categoria
ORDER BY
    total_vendas DESC;

-----------------------------------------------------------------------------------
------------ 2. Quais os 5 produtos mais vendidos nos últimos 3 meses? ------------
-----------------------------------------------------------------------------------

SELECT TOP 5
    p.nome_produto AS produto,
    SUM(fv.quantidade) AS total_vendido
FROM
    fato_vendas fv
    JOIN dim_produto p ON fv.id_produto = p.id_produto
    JOIN dim_tempo t ON fv.id_tempo = t.id_tempo
WHERE
    t.data >= DATEADD(MONTH, -3, GETDATE()) 
GROUP BY
    p.nome_produto
ORDER BY
    total_vendido DESC;

--------------------------------------------------------------------------------
----------- 3. Qual o tempo médio entre compras de um mesmo cliente? -----------
--------------------------------------------------------------------------------

WITH compras_cliente AS (
    SELECT
        fv.id_cliente,
        t.data,
        LAG(t.data) OVER (PARTITION BY fv.id_cliente ORDER BY t.data) AS data_compra_anterior
    FROM
        fato_vendas fv
        JOIN dim_tempo t ON fv.id_tempo = t.id_tempo
)
SELECT
    c.nome_cliente AS cliente,
    AVG(DATEDIFF(DAY, data_compra_anterior, data)) AS tempo_medio_dias
FROM
    compras_cliente cc
    JOIN dim_cliente c ON cc.id_cliente = c.id_cliente
WHERE
    data_compra_anterior IS NOT NULL  
GROUP BY
    c.nome_cliente
ORDER BY
    tempo_medio_dias;