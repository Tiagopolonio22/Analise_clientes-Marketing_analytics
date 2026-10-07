-- ============================================================
-- ANÁLISE DE CLIENTES — MARKETING ANALYTICS
-- Autor: Tiago Polónio
-- Dataset: Customer Personality Analysis (Kaggle)
-- Motor: SQLite
-- ============================================================
-- Queries principais do projeto, organizadas por etapa:
-- exploração -> qualidade dos dados -> limpeza -> análise.
-- ============================================================


-- ----------------------------------------------------------
-- 1. EXPLORAÇÃO INICIAL
-- ----------------------------------------------------------

SELECT * FROM marketing_data LIMIT 10;

PRAGMA table_info(marketing_data);

SELECT COUNT(DISTINCT id) FROM marketing_data;


-- ----------------------------------------------------------
-- 2. QUALIDADE DOS DADOS
-- ----------------------------------------------------------

-- Income: valores em falta
SELECT COUNT(*) FROM marketing_data WHERE Income IS NULL;
-- 24 clientes (~1%). Ignorados automaticamente por AVG/SUM, sem
-- necessidade de tratamento adicional.

-- Marital_Status: deteção de categorias inválidas
SELECT Marital_Status, COUNT(*)
FROM marketing_data
GROUP BY Marital_Status
ORDER BY COUNT(*) DESC;
-- "Alone", "YOLO" e "Absurd": 7 clientes (0,3%). Erros de preenchimento.

-- Year_Birth: deteção de outliers
SELECT MIN(Year_Birth), MAX(Year_Birth) FROM marketing_data;

SELECT COUNT(*) FROM marketing_data WHERE Year_Birth < 1930;
-- 3 clientes com idade implausível.


-- ----------------------------------------------------------
-- 3. VIEW — base de análise
-- ----------------------------------------------------------
-- Exclui os 10 registos identificados na secção anterior e
-- adiciona duas colunas derivadas: Faixa_Etaria e Gasto_total.
-- A tabela original (marketing_data) permanece inalterada.

DROP VIEW IF EXISTS dados_limpos;

CREATE VIEW dados_limpos AS
SELECT *,
    CASE
        WHEN Year_Birth >= 1990 THEN 'Jovem Adulto'
        WHEN Year_Birth >= 1960 THEN 'Adulto'
        ELSE 'Sénior'
    END AS Faixa_Etaria,
    (MntWines + MntFruits + MntMeatProducts + MntFishProducts
     + MntSweetProducts + MntGoldProds) AS Gasto_total
FROM marketing_data
WHERE Year_Birth >= 1930
  AND Marital_Status NOT IN ('Alone', 'YOLO', 'Absurd');

SELECT COUNT(*) FROM dados_limpos;
-- 2230 (2240 - 10).


-- ----------------------------------------------------------
-- 4. Gasto por nível de educação
-- ----------------------------------------------------------

SELECT Education, AVG(Gasto_total) AS gasto_medio, COUNT(*) AS num_clientes
FROM dados_limpos
GROUP BY Education
ORDER BY gasto_medio DESC;
-- PhD: gasto médio mais alto. Básico: gasto médio mais baixo.


-- ----------------------------------------------------------
-- 5. Distribuição por faixa etária
-- ----------------------------------------------------------

SELECT Faixa_Etaria,
    COUNT(*) AS num_clientes,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dados_limpos), 1) AS percentagem
FROM dados_limpos
GROUP BY Faixa_Etaria
ORDER BY num_clientes DESC;
-- Adulto: 72% da base. Jovem Adulto: 2,7%.


-- ----------------------------------------------------------
-- 6. Gasto e aceitação de campanhas por país
-- ----------------------------------------------------------

SELECT Country,
    SUM(Gasto_total) AS gasto_total,
    COUNT(*) AS num_clientes,
    ROUND(AVG(Response) * 100, 2) AS taxa_aceitacao_pct
FROM dados_limpos
GROUP BY Country
ORDER BY gasto_total DESC;
-- Espanha: maior volume (1094 clientes, 660.367€) e taxa de aceitação
-- acima da média (16,09%). Arábia Saudita também acima da média (15,48%).
-- México: taxa mais alta (66,7%), mas amostra de apenas 3 clientes —
-- resultado não estatisticamente robusto.


-- ----------------------------------------------------------
-- 7. Taxa de aceitação geral
-- ----------------------------------------------------------

SELECT
    COUNT(*) AS total_clientes,
    SUM(Response) AS aceitaram_campanha,
    ROUND(AVG(Response) * 100, 2) AS taxa_aceitacao_pct
FROM dados_limpos;
-- 14,84%.
