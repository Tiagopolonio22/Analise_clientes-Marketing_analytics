# Análise de Clientes — Marketing Analytics

**Autor:** Tiago Polónio
**Dashboard interativo:** https://datastudio.google.com/s/u9tLr9zObM0

## Contexto e Objetivo

Este projeto analisa um dataset de 2240 clientes (Customer Personality Analysis, Kaggle), com o objetivo de identificar que perfis de cliente geram mais valor, em que mercados a empresa tem melhor desempenho, e que recomendações de negócio daí decorrem.

Perguntas de negócio exploradas:
- Que nível de educação está associado a maior gasto?
- Como se distribuem os clientes por faixa etária?
- Que países geram mais receita, e onde as campanhas têm melhor aceitação?

## Metodologia

1. **SQL (SQLite)** — exploração inicial, deteção e remoção de valores inválidos (outliers de ano de nascimento, categorias de estado civil inconsistentes), cálculo de métricas agregadas.
2. **Excel** — exploração interativa com Tabelas Dinâmicas e Gráficos, para validar padrões antes de os levar ao dashboard.
3. **Looker Studio** — dashboard interativo e partilhável, com filtros por país e faixa etária.

Após a limpeza de dados, a base de análise ficou com **2230 clientes** (99,6% do total original).

## Principais Insights

### 1. O gasto aumenta com o nível de educação, de forma quase consistente

Clientes com **PhD** apresentam o maior gasto médio, seguidos de perto por **Mestrado** e **Licenciatura** (com uma pequena inversão entre estes dois níveis), e clientes com educação **Básica** gastam claramente menos — a diferença entre o topo (PhD) e a base (Básico) é muito acentuada. O padrão sugere uma relação direta entre nível de educação e disposição para gastar, com a exceção pontual entre Licenciatura e Mestrado.

### 2. A base de clientes é maioritariamente adulta, com pouca representação jovem

**72%** dos clientes pertencem à faixa "Adulto", **25,3%** são "Sénior", e apenas **2,7%** são "Jovem Adulto". A marca tem uma base claramente envelhecida, com presença residual entre consumidores mais jovens.

### 3. Espanha lidera com folga em volume de negócio

Com **1094 clientes** e um gasto total de **660.367€**, a Espanha representa quase metade do gasto total da base (1.351.045€), confirmando-se como o mercado mais relevante em volume.

### 4. Os mercados com maior volume também têm taxas de aceitação de campanhas acima da média

Entre os países com amostra robusta (mais de 100 clientes), **Espanha (16,09%)** e **Arábia Saudita (15,48%)** têm taxa de aceitação de campanhas acima da média geral (14,84%), o que reforça — por dois ângulos distintos (volume e propensão a responder) — que são os mercados prioritários atuais.

### 5. Um resultado que exige cautela: México

O México regista a maior taxa de aceitação observada (66,7%), mas esta assenta numa amostra de apenas **3 clientes** — demasiado pequena para ser estatisticamente fiável. Qualquer alteração nesse resultado (1 cliente a mais ou a menos) muda drasticamente a percentagem. **Não deve ser usado para justificar decisões de investimento** sem antes recolher uma amostra maior deste mercado.

## Recomendações de Negócio

- **Priorizar comunicação de produtos/ofertas premium** a clientes com educação superior (Mestrado/PhD), dado o seu gasto médio superior.
- **Reforçar investimento em Espanha e Arábia Saudita**, os únicos mercados que combinam volume relevante com taxa de aceitação acima da média.
- **Explorar o segmento Sénior com mais profundidade** — representa um quarto da base e pode ter necessidades distintas dos Adultos, atualmente dominantes.
- **México: recolher mais dados antes de qualquer decisão** — o resultado atual é promissor mas não é estatisticamente robusto.

## Limitações dos Dados

- Excluídos 3 registos com ano de nascimento inválido (anterior a 1930) e 7 registos com valores inconsistentes em estado civil (0,4% da base).
- A coluna `Income` tinha 24 valores em falta (~1%), ignorados automaticamente nos cálculos de média.
- Os resultados por país têm fiabilidade muito variável consoante a dimensão da amostra (de 3 a 1094 clientes) — comparações diretas entre países pequenos e grandes devem ser lidas com cautela.

## Dashboard

Explora os dados de forma interativa, com filtros por país e faixa etária: https://datastudio.google.com/s/u9tLr9zObM0
