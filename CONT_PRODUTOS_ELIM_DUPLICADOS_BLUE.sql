WITH ProdutosUnicos AS (
    SELECT 
        cod_produto,
        dsc_grupo, 
        dsc_subgrupo,
		dsc_produto,
        ROW_NUMBER() OVER (PARTITION BY cod_produto ORDER BY cod_produto) AS row_num
    FROM [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
    WHERE cod_produto > 50000
      AND cod_grupo = 009
      AND cod_subgrupo = 044
)
SELECT dsc_produto, cod_produto, dsc_grupo, dsc_subgrupo
FROM ProdutosUnicos
WHERE row_num = 1
ORDER BY cod_produto asc
--ORDER BY dsc_produto asc
