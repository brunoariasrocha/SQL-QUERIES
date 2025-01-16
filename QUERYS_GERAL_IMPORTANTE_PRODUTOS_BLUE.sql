select distinct 
	cod_produto, dsc_produto, und_produto, nom_marca,
	cod_grupo, dsc_grupo, 
	cod_subgrupo, dsc_subgrupo,
	PESO_LIQ, PESO_BRUTO, CONTROLA_LOTE, NCM
from [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
	where cod_grupo = 009
	and cod_produto>'50500' 
order by cod_produto asc

------------------------------------------------------------------------------------------------------------
WITH RankedProducts AS (
	SELECT DISTINCT
		cod_produto, cod_produto_ant,
		dsc_produto, controla_lote, status_produto, cod_marca, 
		und_produto, cod_grupo, NCM, 
		dsc_grupo, cod_subgrupo, 
		dsc_subgrupo, PESO_BRUTO, PESO_LIQ, CONTROLE_PRODUTO,
		ROW_NUMBER() OVER (PARTITION BY cod_produto ORDER BY status_produto ASC) AS RowNum
FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
WHERE cod_filial = 1
	AND (
		cod_produto>50000
	)
)
SELECT *
FROM RankedProducts
WHERE RowNum = 1
  --AND cod_grupo = 004
ORDER BY cod_produto ASC;

------------------------------------------------------------------------------------------------------------

SELECT DISTINCT top 10* FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
WHERE cod_filial = 1 
  AND cod_grupo = 004 
  AND (LTRIM(RTRIM(TIPO_EMBALAGEM)) = '' OR TIPO_EMBALAGEM IS NULL)
ORDER BY cod_produto ASC;
--fator_conversao>1 
--cod_produto>'50503'

------------------------------------------------------------------------------------------------------------
SELECT DISTINCT 
       COALESCE(SB1.B1_COD, TBL.cod_produto) AS CODIGO, 
       SB1.B1_DESC AS DESC_SB1, 
       TBL.DSC_PRODUTO AS DESC_SPX
FROM [1_RAW].[SB1_PROTHEUS] SB1
FULL OUTER JOIN [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL] TBL
ON SB1.B1_COD = TBL.cod_produto
WHERE (SB1.B1_COD IS NULL OR TBL.cod_produto IS NULL)
ORDER BY CODIGO ASC; -- TRAZ OS PRODUTOS QUE ESTÃO SEM CORRESPONDÊNCIA DE CÓDIGO ENTRE PROTHEUS E BLUE

------------------------------------------------------------------------------------------------------------

WITH RankedProducts AS (
	SELECT DISTINCT
		cod_produto, cod_produto_ant,
		dsc_produto, controla_lote, status_produto, cod_marca, 
		und_produto, cod_grupo, NCM, 
		dsc_grupo, cod_subgrupo, 
		dsc_subgrupo, PESO_BRUTO, PESO_LIQ, CONTROLE_PRODUTO,
		ROW_NUMBER() OVER (PARTITION BY cod_produto ORDER BY status_produto ASC) AS RowNum
FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
WHERE cod_filial = 1
	AND (
		cod_produto=50328
		or cod_produto = 50507
		or cod_produto = 50508
		or cod_produto = 50509
		or cod_produto = 50510
	)
)
SELECT *
FROM RankedProducts
WHERE RowNum = 1
  --AND cod_grupo = 004
ORDER BY cod_produto ASC;



WITH RankedProducts AS (
	SELECT DISTINCT
		cod_produto, cod_produto_ant,
		dsc_produto, cod_grupo,
		dsc_grupo, cod_subgrupo, 
		dsc_subgrupo,
		ROW_NUMBER() OVER (PARTITION BY cod_produto ORDER BY status_produto ASC) AS RowNum
FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
WHERE cod_filial = 1
)
SELECT *
FROM RankedProducts
WHERE RowNum = 1
ORDER BY cod_produto ASC;
