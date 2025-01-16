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
  AND cod_grupo = 004
  AND cod_subgrupo = 025
ORDER BY cod_produto ASC;