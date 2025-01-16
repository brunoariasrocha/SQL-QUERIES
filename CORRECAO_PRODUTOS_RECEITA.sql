SELECT
	cod_empresa, und_empresa, cod_produto, 
	dsc_produto, und_produto, 
	cod_grupo, dsc_grupo, 
	cod_subgrupo1, dsc_subgrupo1, 
	qtd_disp
	FROM [1_RAW].[TBL_ESTOQUE_CDL]
		WHERE 
			cod_grupo=004
			and qtd_disp>0
order by cod_produto asc

WITH ProdutosUnicos AS (
    SELECT 
        cod_produto,
        TIPO_EMBALAGEM,
        DESC_EMBALAGEM,
        FATOR_CONVERSAO,
        UND_CONVERSAO,
		PESO_BRUTO, PESO_LIQ,
        ROW_NUMBER() OVER (PARTITION BY cod_produto ORDER BY cod_produto) AS rn
    FROM 
        [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
)
SELECT
    estoque.cod_empresa, 
    estoque.und_empresa, 
    estoque.cod_produto, 
    estoque.dsc_produto, 
    estoque.und_produto, 
    estoque.cod_grupo, 
    estoque.dsc_grupo, 
    estoque.cod_subgrupo1, 
    estoque.dsc_subgrupo1, 
    estoque.qtd_disp,
    produtos.TIPO_EMBALAGEM,
    produtos.DESC_EMBALAGEM,
    produtos.FATOR_CONVERSAO,
    produtos.UND_CONVERSAO,
	produtos.PESO_BRUTO,
	produtos.PESO_LIQ
FROM 
    [1_RAW].[TBL_ESTOQUE_CDL] AS estoque
LEFT JOIN 
    ProdutosUnicos AS produtos
ON 
    estoque.cod_produto = produtos.cod_produto
WHERE 
    estoque.cod_grupo = 004
    AND estoque.qtd_disp > 0
ORDER BY 
    estoque.cod_produto ASC;

--AND produtos.rn = 1  -- Seleciona apenas a primeira linha para cada cod_produto