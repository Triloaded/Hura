delete  from interns_wsp_analysis where generateddate like '%2020%';
insert into interns_wsp_analysis(department, occupation, ma, fa, mw, fw, mc, fc, mi, fi, grtotal,
						da, dc, dw, di, dgtotal,
						youth, midage, senior, agtotal)
SELECT department as department, occupation as occupation,
 COUNT(MA) AS MA,
 COUNT(FA) AS FA,
 COUNT(MW) AS MW,
 COUNT(FW) AS FW,
 COUNT(MC) AS MC,
 COUNT(FC) AS FC,
 COUNT(MI) AS MI,
 COUNT(FI) AS FI,
 SUM(ISNULL(MA, 0) + ISNULL(FA, 0) + ISNULL(MW, 0) + ISNULL(FW, 0) + ISNULL(MC, 0) + ISNULL(FC, 0) + ISNULL(MI, 0) + ISNULL(FI, 0)) AS GRTOTAL,
 COUNT(DA) AS DA,
 COUNT(DC) AS DC,
 COUNT(DW) AS DW,
 COUNT(DI) AS DI,
 SUM(ISNULL(DA, 0) + ISNULL(DC, 0) + ISNULL(DW, 0) + ISNULL(DI, 0)) AS DGTOTAL,
 COUNT(Youth) AS Youth,
 COUNT(Midage) AS Midage,
 COUNT(senior) AS senior,
 SUM(ISNULL(Youth, 0) + ISNULL(Midage, 0) + ISNULL(senior, 0)) AS AGTOTAL
FROM (
	select department, occupation,
	CASE WHEN gender='M' AND race='A' THEN 1 END  MA, 
	CASE WHEN gender='F' AND race='A' THEN 1 END  FA,
	CASE WHEN gender='M' AND race='W' THEN 1 END  MW,
	CASE WHEN gender='F' AND race='W' THEN 1 END  FW,
	CASE WHEN gender='M' AND race='C' THEN 1 END  MC,
	CASE WHEN gender='F' AND race='C' THEN 1 END  FC,
	CASE WHEN gender='M' AND race='I' THEN 1 END  MI,
	CASE WHEN gender='F' AND race='I' THEN 1 END  FI,
	CASE WHEN disability_status=1 AND race='A' THEN 1 END  DA,
	CASE WHEN disability_status=1 AND race='C' THEN 1 END  DC,
	CASE WHEN disability_status=1 AND race='W' THEN 1 END  DW,
	CASE WHEN disability_status=1 AND race='I' THEN 1 END  DI,
	CASE WHEN age <= 35 THEN 1 END  Youth,  
	CASE WHEN age > 35 AND age <= 55  THEN 1 END  Midage,
	CASE WHEN age > 55 THEN 1 END  senior
	
	FROM intern_data	
	)
	
	intern_data GROUP BY ROLLUP(department,  occupation) ORDER BY department, occupation asc;