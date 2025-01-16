select distinct cod_produto_ant, cod_produto, dsc_produto, cod_grupo, dsc_grupo, cod_subgrupo, dsc_subgrupo from [3_CUR].[TBL_DIM_PRODUTOS_ORIG_CDL]
where cod_filial=1
order by cod_produto asc

--ESSA QUERY TRAZ APENAS ALGUNS CAMPOS