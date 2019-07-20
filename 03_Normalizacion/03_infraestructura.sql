/******************************************** infraestructura ********************************************/

--HIDROELECTICAS

SELECT 
	CAST(institucio AS VARCHAR(50)) as institucion,
	CAST(leyenda AS VARCHAR(50)) as estado,
	CAST(nombre AS VARCHAR(50)) as nombre,
	ST_Transform(geom, 4326) as geom
INTO tablaaux
FROM hidroelectricas;

UPDATE tablaaux SET geom = ST_Force2D(geom);
SELECT UpdateGeometrySRID('tablaaux', 'geom', '4326');
ALTER TABLE tablaaux ALTER COLUMN geom  TYPE geometry(MULTIPOINT, 4326) USING ST_Multi(geom);

INSERT INTO "hidroelectrica" ("institucion", "estado" ,"nombre" , geom )
SELECT   "institucion", "estado" ,"nombre" , geom
FROM "tablaaux";
DROP TABLE "tablaaux";

--PETROLEO

ALTER TABLE "petroleo" ADD COLUMN "IdPetroleo" SERIAL;
ALTER TABLE "petroleo" ADD COLUMN "institucion" VARCHAR(50);
ALTER TABLE "petroleo" ADD COLUMN "fecha" DATE;
ALTER TABLE "petroleo" ADD COLUMN "estado" VARCHAR(50);

UPDATE "petroleo" pu
SET geom = ST_Transform(geom, 4326),
	"estado" = leyenda,
	"institucion" = cia,
	"fecha" = (SELECT TO_DATE(f.fechat, 'YYYY')
	FROM (SELECT substring(fecha_atua from '....$') as Fechat , "IdPetroleo"  
	FROM petroleo) AS f
	WHERE pu."IdPetroleo" = f."IdPetroleo" );

	
SELECT UpdateGeometrySRID('petroleo', 'geom', '4326');


ALTER TABLE "petroleo" DROP COLUMN pais;
ALTER TABLE "petroleo" DROP COLUMN cia;
ALTER TABLE "petroleo" DROP COLUMN fuente;
ALTER TABLE "petroleo" DROP COLUMN institucio;
ALTER TABLE "petroleo" DROP COLUMN fecha_atu;
ALTER TABLE "petroleo" DROP COLUMN area_sig_h;
ALTER TABLE "petroleo" DROP COLUMN leyenda;
ALTER TABLE "petroleo" DROP COLUMN shape_leng;
ALTER TABLE "petroleo" DROP COLUMN shape_area;
ALTER TABLE "petroleo" DROP COLUMN limraisg;
ALTER TABLE "petroleo" DROP COLUMN cod_ah;
ALTER TABLE "petroleo" DROP COLUMN cod_zh;
ALTER TABLE "petroleo" DROP COLUMN cod_szh;
ALTER TABLE "petroleo" DROP COLUMN nom_ah;
ALTER TABLE "petroleo" DROP COLUMN nom_zh;
ALTER TABLE "petroleo" DROP COLUMN nom_szh;
ALTER TABLE "petroleo" DROP COLUMN objectid_1;
ALTER TABLE "petroleo" DROP COLUMN ruleid;
ALTER TABLE "petroleo" DROP COLUMN shape_ar_1;
ALTER TABLE "petroleo" DROP COLUMN shape_le_1;
ALTER TABLE "petroleo" DROP COLUMN fecha_atua;
	


--MINERIA ILEGAL

ALTER TABLE "mineria" ADD COLUMN "IdMineria" SERIAL;
ALTER TABLE "mineria" ADD COLUMN "institucion" VARCHAR(50);
ALTER TABLE "mineria" ADD COLUMN "fecha" DATE;
ALTER TABLE "mineria" ADD COLUMN "metodoExplotacion" VARCHAR(50);
ALTER TABLE "mineria" ADD COLUMN "sustancia" VARCHAR(50);


SELECT UpdateGeometrySRID('mineria', 'geom', '4326');

UPDATE "mineria" 
SET geom = ST_Transform(geom, 4326),
	"institucion" = instituici,
	"sustancia" = substancia,
	"metodoExplotacion"= metodoexpl;


ALTER TABLE "mineria" DROP COLUMN cod_ah;
ALTER TABLE "mineria" DROP COLUMN cod_ah;
ALTER TABLE "mineria" DROP COLUMN cod_ah;
ALTER TABLE "mineria" DROP COLUMN cod_zh;
ALTER TABLE "mineria" DROP COLUMN cod_szh;
ALTER TABLE "mineria" DROP COLUMN nom_ah;
ALTER TABLE "mineria" DROP COLUMN nom_zh;
ALTER TABLE "mineria" DROP COLUMN nom_szh;
ALTER TABLE "mineria" DROP COLUMN objectid_1;
ALTER TABLE "mineria" DROP COLUMN ruleid;
ALTER TABLE "mineria" DROP COLUMN shape_ar_1;
ALTER TABLE "mineria" DROP COLUMN shape_le_1;
ALTER TABLE "mineria" DROP COLUMN objectid;
ALTER TABLE "mineria" DROP COLUMN limraisg;
ALTER TABLE "mineria" DROP COLUMN shape_leng;
ALTER TABLE "mineria" DROP COLUMN leyendagar;
ALTER TABLE "mineria" DROP COLUMN fuenteinfo;
ALTER TABLE "mineria" DROP COLUMN fecha_situ;
ALTER TABLE "mineria" DROP COLUMN ator;
ALTER TABLE "mineria" DROP COLUMN descripci;
ALTER TABLE "mineria" DROP COLUMN metodoexpl;
ALTER TABLE "mineria" DROP COLUMN substancia;
ALTER TABLE "mineria" DROP COLUMN instituici;





