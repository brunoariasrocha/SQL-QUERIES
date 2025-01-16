SELECT
    LTRIM(RTRIM(SB1.B1_COD)) AS B1_COD, 
    LTRIM(RTRIM(SB1.B1_DESC)) AS B1_DESC, 
    LTRIM(RTRIM(SB1.B1_MSBLQL)) AS B1_MSBLQL,
    LTRIM(RTRIM(SB1.B1_UM)) AS B1_UM, 
    LTRIM(RTRIM(SB1.B1_XNOMMAR)) AS B1_XNOMMAR, 
    LTRIM(RTRIM(SB1.B1_PROC)) AS B1_PROC, 
    LTRIM(RTRIM(SA2.A2_NOME)) AS NOME_FORNECEDOR,  -- Nome do fornecedor
    LTRIM(RTRIM(SB1.B1_XCAT1)) AS B1_XCAT1,
    LTRIM(RTRIM(ZZ3.ZZ3_DESCR)) AS DESCRICAO_CATEGORIA,  -- Descri��o da categoria
    LTRIM(RTRIM(SB1.B1_XCAT2)) AS B1_XCAT2,
    LTRIM(RTRIM(ZZ4.ZZ4_DESCR)) AS DESCRICAO_SUBGRUPO1,  -- Descri��o do Subgrupo 1
    LTRIM(RTRIM(SB1.B1_XGRP1)) AS B1_XGRP1,
    LTRIM(RTRIM(ZZ1.ZZ1_DESCR)) AS DESCRICAO_SUBGRUPO2,  -- Descri��o do Subgrupo 2
    LTRIM(RTRIM(SB1.B1_XGRP2)) AS B1_XGRP2,
    LTRIM(RTRIM(ZZ2.ZZ2_DESCR)) AS DESCRICAO_SUBGRUPO3,  -- Descri��o do Subgrupo 3
    LTRIM(RTRIM(SB1.B1_DESBSE3)) AS B1_DESBSE3, 
    LTRIM(RTRIM(SB1.B1_XIDPATR)) AS B1_XIDPATR, 
    LTRIM(RTRIM(SB1.B1_PESO)) AS B1_PESO, 
    LTRIM(RTRIM(SB1.B1_POSIPI)) AS B1_POSIPI, 
    LTRIM(RTRIM(SB1.B1_XCULQBR)) AS B1_XCULQBR, 
    LTRIM(RTRIM(SB1.B1_XNOMUNI)) AS B1_XNOMUNI, 
    ISNULL(CONVERT(VARCHAR(5000), LTRIM(RTRIM(SB1.B1_XPRATIV))), '') AS B1_XPRATIV,  -- Convers�o do campo B1_XPRATIV
    LTRIM(RTRIM(SB1.B1_XCONCET)) AS B1_XCONCET, 
    LTRIM(RTRIM(SB1.B1_XCODANT)) AS B1_XCODANT, 
    LTRIM(RTRIM(SB1.B1_XAPRES)) AS B1_XAPRES,  
    LTRIM(RTRIM(SB1.B1_IDSAN01)) AS B1_IDSAN01,
    LTRIM(RTRIM(SB1.B1_XIDSAN0)) AS B1_XIDSAN0, 
    LTRIM(RTRIM(SB1.B1_XIDSAN3)) AS B1_XIDSAN3
FROM [1_RAW].[SB1_PROTHEUS] SB1
LEFT JOIN 
    [1_RAW].[SA2_PROTHEUS] SA2 
    ON SB1.B1_PROC = SA2.A2_COD  
    AND SB1.B1_LOJPROC = SA2.A2_LOJA
LEFT JOIN 
    [1_RAW].[ZZ3_PROTHEUS] ZZ3 
    ON LTRIM(RTRIM(SB1.B1_XCAT1)) = LTRIM(RTRIM(ZZ3.ZZ3_COD))
LEFT JOIN 
    [1_RAW].[ZZ4_PROTHEUS] ZZ4 
    ON LTRIM(RTRIM(SB1.B1_XCAT1)) = LTRIM(RTRIM(ZZ4.ZZ4_CAT1))  
    AND LTRIM(RTRIM(SB1.B1_XCAT2)) = LTRIM(RTRIM(ZZ4.ZZ4_COD))
LEFT JOIN 
    [1_RAW].[ZZ1_PROTHEUS] ZZ1 
    ON LTRIM(RTRIM(SB1.B1_XCAT1)) = LTRIM(RTRIM(ZZ1.ZZ1_CAT1))  
    AND LTRIM(RTRIM(SB1.B1_XCAT2)) = LTRIM(RTRIM(ZZ1.ZZ1_CAT2)) 
    AND LTRIM(RTRIM(SB1.B1_XGRP1)) = LTRIM(RTRIM(ZZ1.ZZ1_COD))
LEFT JOIN 
    [1_RAW].[ZZ2_PROTHEUS] ZZ2 
    ON LTRIM(RTRIM(SB1.B1_XCAT1)) = LTRIM(RTRIM(ZZ2.ZZ2_CAT1))  
    AND LTRIM(RTRIM(SB1.B1_XCAT2)) = LTRIM(RTRIM(ZZ2.ZZ2_CAT2)) 
    AND LTRIM(RTRIM(SB1.B1_XGRP1)) = LTRIM(RTRIM(ZZ2.ZZ2_GRP)) 
    AND LTRIM(RTRIM(SB1.B1_XGRP2)) = LTRIM(RTRIM(ZZ2.ZZ2_COD))
WHERE 
   LTRIM(RTRIM(SB1.B1_COD)) > '50830'
   -- AND LTRIM(RTRIM(SB1.B1_MSBLQL)) = '2'
ORDER BY 
    LTRIM(RTRIM(SB1.B1_COD)) ASC;
