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
select
	sbz.bz_filial as filial,
	sbz.bz_cod as codigo,
	sbz.bz_localiz as endereco,
	sb1.b1_desc as descricao,
	sb1.b1_xcat1 as categoria,
	sb1.b1_xcat2 as subgrupo1
from [1_raw].[sbz_protheus] sbz
left join
	[1_raw].[sb1_protheus] sb1
	on sbz.bz_cod = sb1.b1_cod
where sb1.b1_xcat1 = '02' 
	and sb1.b1_xcat2 = '09'
	and sbz.bz_localiz = 'S'
order by b1_cod
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
------------------------------------------------------------------------------------------------------------
SELECT TOP 10
	fil.nom_fantasia AS nome_filial,
    --prod.cnpj_empresa AS cnpj,
    prod.cod_produto AS codigo_produto,
    prod.cod_produto_ant AS codigo_produto_protheus,
    prod.cod_grupo AS codigo_grupo,
    prod.cod_subgrupo AS codigo_subgrupo,
    prod.cod_barra AS codigo_barras
    --fil.cnpj AS cnpj2,    
FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL] AS prod
LEFT JOIN [3_CUR].[DIM_FILIAIS] AS fil
    ON prod.cnpj_empresa = fil.cnpj;
