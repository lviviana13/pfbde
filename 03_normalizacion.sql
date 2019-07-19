/* ******************************************* zonaGeografica ******************************************* */

/** SUBZONAS HIDROGRAFICAS **/
--realizar tabla auxiliar para los datos de subzona hidrografica
SELECT CAST(nom_szh AS VARCHAR(50)), CAST(cod_szh as INTEGER), geom 
	INTO tablaaux_szh
	FROM zona_hidrica;
--Agregar columna a tabla auxiliar
ALTER TABLE "tablaaux_szh" ADD COLUMN "FkTipoCod" INTEGER; 
--Ingresar código de subzona hidrica
UPDATE "tablaaux_szh" set "FkTipoCod"=2; 


INSERT INTO "zonaGeografica" ("NomZG", "CodZG", "FkTipoCod", geom )
SELECT  "nom_szh", "cod_szh", "FkTipoCod", geom 
FROM "tablaaux_szh";

DROP TABLE "tablaaux_szh";


/** ZONAS HIDROGRAFICAS **/

SELECT
	 CAST(zhg.nom_zh AS VARCHAR(50)),
	 CAST(zhg.cod_zh  as INTEGER),
	ST_UNION(zhg.geom) as geom
INTO tablaaux_zh
FROM zona_hidrica zhg
GROUP BY zhg.nom_zh, zhg.cod_zh;

ALTER TABLE tablaaux_zh ALTER COLUMN geom TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

--Agregar columna a tabla auxiliar
ALTER TABLE "tablaaux_zh" ADD COLUMN "FkTipoCod" INTEGER;
--Ingresar código de subzona hidrica
UPDATE "tablaaux_zh" set "FkTipoCod"=1; 

INSERT INTO "zonaGeografica" ("NomZG", "CodZG", "FkTipoCod", geom )
SELECT  "nom_zh", "cod_zh", "FkTipoCod", geom 
FROM "tablaaux_zh";

DROP TABLE "tablaaux_zh";
DROP TABLE zona_hidrica;

/** DEPARTAMENTOS **/
SELECT CAST(nmg AS VARCHAR(50)), CAST(cod_dane as INTEGER), geom 
	INTO tablaaux
	FROM departamentos;
--Agregar columna a tabla auxiliar
ALTER TABLE "tablaaux" ADD COLUMN "FkTipoCod" INTEGER; 
--Ingresar código que indica que es un departamentp
UPDATE "tablaaux" set "FkTipoCod"=3; 


INSERT INTO "zonaGeografica" ("NomZG", "CodZG", "FkTipoCod", geom )
SELECT  "nmg", "cod_dane", "FkTipoCod", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "departamentos";

/** ZONIFICACION RESOLUCION 1277 DE 2014 **/

SELECT 
	CAST(tipo_zona AS VARCHAR(50)), 
	ST_UNION(ST_Transform(z.geom, 4326)) as geom
	INTO tablaaux
	FROM zonificacion2014 z
	WHERE z.tipo_zona='A' or z.tipo_zona='B'
	GROUP BY z.tipo_zona;

--Agregar columna a tabla auxiliar e ingresar codigo de tipoCod
ALTER TABLE "tablaaux" ADD COLUMN "FkTipoCod" INTEGER; 
UPDATE "tablaaux" set "FkTipoCod"=4; 

--Agregar columna a tabla auxiliar e ingresar codigo de tipoCod
ALTER TABLE "tablaaux" ADD COLUMN "CodZG" INTEGER; 
UPDATE "tablaaux" SET "CodZG"=1 where tipo_zona='A'; 
UPDATE "tablaaux" SET "CodZG"=2 where tipo_zona='B';


INSERT INTO "zonaGeografica" ("NomZG", "CodZG", "FkTipoCod", geom )
SELECT  "tipo_zona", "CodZG", "FkTipoCod", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "zonificacion2014";


﻿/* ******************************************* cambioCobertura ******************************************* */


/** Cambio de cobertura 2012 2013 **/

SELECT 
	cb.dn,
	ST_UNION(ST_Transform(cb.geom, 4326)) as geom
	INTO tablaaux
	FROM cb1213 cb
	WHERE cb.dn=63
	GROUP BY cb.dn;

--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2012'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/1/2013';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "cb1213";

/** Cambio de cobertura 2013 2014 **/

SELECT 
	cb.dn,
	ST_UNION(ST_Transform(cb.geom, 4326)) as geom
	INTO tablaaux
	FROM cb1314 cb
	WHERE cb.dn=63
	GROUP BY cb.dn;

--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2013'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/1/2014';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "cb1314";

/** Cambio de cobertura 2014 2015 **/

SELECT 
	cb.dn,
	ST_UNION(ST_Transform(cb.geom, 4326)) as geom
	INTO tablaaux
	FROM cb1415 cb
	WHERE cb.dn=63
	GROUP BY cb.dn;

--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2014'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/1/2015';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "cb1415";

/** Cambio de cobertura 2015 2016 **/

SELECT 
	cb.dn,
	ST_UNION(ST_Transform(cb.geom, 4326)) as geom
	INTO tablaaux
	FROM cb1516 cb
	WHERE cb.dn=63
	GROUP BY cb.dn;

--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2015'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/1/2016';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "cb1516";


/** Cambio de cobertura 2016 2017 **/

SELECT 
	cb.dn,
	ST_UNION(ST_Transform(cb.geom, 4326)) as geom
	INTO tablaaux
	FROM cb1617 cb
	WHERE cb.dn=63
	GROUP BY cb.dn;

--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2016'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/1/2017';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "cb1617";

/** Alertas tempranas 2013 I**/

SELECT 
	ST_UNION(ST_Transform(a.geom, 4326)) as geom
	INTO tablaaux
	FROM at2013i a;
	
--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/1/2013'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/06/2013';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "at2013i";

/** Alertas tempranas 2013 ii**/

SELECT 
	ST_UNION(ST_Transform(a.geom, 4326)) as geom
	INTO tablaaux
	FROM at2013ii a;
	
--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/06/2013'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/12/2013';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "at2013ii";

/** Alertas tempranas 2014 i**/

SELECT 
	ST_UNION(ST_Transform(a.geom, 4326)) as geom
	INTO tablaaux
	FROM at2014 a;
	
--Agregar columna a tabla auxiliar e ingresar codigo para deforestacion
ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER; 
UPDATE "tablaaux" set  "FKCodCambioCobertura" =1; 

--Agregar fecha de inicio y fin
 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/01/2014'; 
UPDATE "tablaaux" SET "tiempoFin"= '1/06/2014';


INSERT INTO "cambioCobertura" ("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT  "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom 
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "at2014";


/** QUEMAS **/


SELECT
    ST_UNION(ST_Transform(a.geom, 4326)) as geom
    INTO tablaaux
    FROM quemas a;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);


ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCambioCobertura"  INTEGER;
UPDATE "tablaaux" set  "FKCodCambioCobertura" =2;

 ALTER TABLE "tablaaux" ADD COLUMN  "tiempoInicio" DATE;
 ALTER TABLE "tablaaux" ADD COLUMN "tiempoFin" DATE;
UPDATE "tablaaux" SET "tiempoInicio"= '1/01/2000';
UPDATE"tablaaux" SET "tiempoFin"= '31/12/2017';


INSERT INTO"cambioCobertura" 
("FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom )
SELECT   "FKCodCambioCobertura", "tiempoInicio", "tiempoFin", geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "quemas";


﻿/* ******************************************* cobertura ******************************************* */


/** BOSQUE NO BOSQUE 2012**/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2012 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2012'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2012";


/** BOSQUE NO BOSQUE 2013**/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2013 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2013'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2013";



/** BOSQUE NO BOSQUE 2014 **/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2014 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2014'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2014";


/** BOSQUE NO BOSQUE 2015 **/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2015 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2015'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2015";

/** BOSQUE NO BOSQUE 2016 **/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2016 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2016'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2016";

/** BOSQUE NO BOSQUE 2017 **/

SELECT 
	c.dn,
	ST_UNION(ST_Transform(c.geom, 4326)) as geom
INTO tablaaux
FROM bnb2017 c
WHERE c.dn=127 OR c.dn=254
GROUP BY c.dn;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "FKCodCobertura"  INTEGER; 
UPDATE "tablaaux" SET "FKCodCobertura"=1 where dn=127; 
UPDATE "tablaaux" SET "FKCodCobertura"=2 where dn=254;


ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2017'; 


INSERT INTO "cobertura" ("FKCodCobertura" ,"fecha" , geom )
SELECT   "FKCodCobertura"  , "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "bnb2017";

﻿/* ******************************************* intervencion ******************************************* */


/** INTERVENCION ANTROPICA 2014 **/

SELECT 
	CAST(rango AS VARCHAR(50)),
	ST_UNION(ST_Transform(geom, 4326)) as geom
INTO tablaaux
FROM ei2014 
GROUP BY rango;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom 
TYPE geometry(MultiPolygon, 4326) USING ST_Multi(geom);

ALTER TABLE "tablaaux" ADD COLUMN  "fecha" DATE;
UPDATE "tablaaux" SET "fecha"= '31/12/2014'; 


INSERT INTO "intervencion" ("gradoInter" ,"fecha" , geom )
SELECT   "rango", "fecha" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";
DROP TABLE "ei2014";




