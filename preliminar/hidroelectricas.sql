SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE "hidroelectricas" (gid serial,
"empresa" varchar(50),
"tipo" varchar(10),
"pais" varchar(20),
"fonte" varchar(75),
"nombre" varchar(50),
"institucio" varchar(15),
"leyenda" varchar(30),
"pot_mw" numeric,
"estagio" varchar(20),
"limraisg" varchar(1),
"cod_ah" numeric,
"cod_szh" numeric,
"cod_zh" numeric,
"nom_ah" varchar(254),
"nom_szh" varchar(254),
"nom_zh" varchar(254),
"objectid_1" numeric,
"ruleid" numeric,
"shape_area" numeric,
"shape_leng" numeric);
ALTER TABLE "hidroelectricas" ADD PRIMARY KEY (gid);
SELECT AddGeometryColumn('','hidroelectricas','geom','4674','MULTIPOINT',2);
INSERT INTO "hidroelectricas" ("empresa","tipo","pais","fonte","nombre","institucio","leyenda","pot_mw","estagio","limraisg","cod_ah","cod_szh","cod_zh","nom_ah","nom_szh","nom_zh","objectid_1","ruleid","shape_area","shape_leng",geom) VALUES (NULL,'PCH','Colombia',NULL,'Microcentral HidroelÃ©trica MitÃº','GAIA','en construciÃ³n','0.00000000000','ConstruÃ§Ã£o','s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'010400002042120000010000000101000000D05F1E4EDA9351C000917C11AC4BF43F');
COMMIT;
ANALYZE "hidroelectricas";
