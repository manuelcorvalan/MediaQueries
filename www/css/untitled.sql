SELECT MONTOO 
  FROM RLIQUIDACION SUB_LIQUIDA 
 WHERE SUB_LIQUIDA.CODIGO = @CODIGO 
   AND SUB_LIQUIDA.AMES   = @AMES
   AND SUB_LIQUIDA.COHADE = @COHADE;

SELECT RES.KTDL + RES.KTDS
  FROM RESUMEN RES
 WHERE RES.CODIGO         = @CODIGO
   AND RES.AMES           = @AMES


SELECT AFPCOT.MONTO + (ISAPRE.MONTOA * 0.07) +  SEGCET.MONTO
  FROM 
 (SELECT MONTO, CODIGO, AMES
    FROM RLIQUIDACION SUB_LIQUIDA 
   WHERE SUB_LIQUIDA.CODIGO = @CODIGO 
     AND SUB_LIQUIDA.AMES   = @AMES
     AND SUB_LIQUIDA.COHADE = ''AFPCOT'') AFPCOT
,(SELECT MONTO, CODIGO, AMES
    FROM RLIQUIDACION SUB_LIQUIDA 
   WHERE SUB_LIQUIDA.CODIGO = @CODIGO 
     AND SUB_LIQUIDA.AMES   = @AMES
     AND SUB_LIQUIDA.COHADE = ''ISAPRE'') ISAPRE
,(SELECT MONTO, CODIGO, AMES
    FROM RLIQUIDACION SUB_LIQUIDA 
   WHERE SUB_LIQUIDA.CODIGO = @CODIGO 
     AND SUB_LIQUIDA.AMES   = @AMES
     AND SUB_LIQUIDA.COHADE = ''SEGCET'') SEGCET
  WHERE AFPCOT.CODIGO = ISAPRE.CODIGO
    AND ISAPRE.CODIGO = SEGCET.CODIGO
    AND AFPCOT.AMES   = ISAPRE.AMES
    AND ISAPRE.AMES   = SEGCET.AMES