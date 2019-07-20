
﻿/* ******************************************* DDL ******************************************* */


﻿﻿CREATE TABLE "TipoCod" (
  "IdTipoCod" INTEGER NOT NULL,
  "NomTipoCod" VARCHAR(50) NOT NULL,
  CONSTRAINT "TipoCod_Pk" PRIMARY KEY ("IdTipoCod")     
);


CREATE TABLE "zonaGeografica"
(
  "IdZonaGeografica" SERIAL NOT NULL,
  "NomZG" VARCHAR(50) NOT NULL, 
  "CodZG" INTEGER NOT NULL,
  "FkTipoCod" INTEGER NOT NULL,
  CONSTRAINT "zonaGeografica_Pk" PRIMARY KEY ("CodZG", "FkTipoCod"),
  CONSTRAINT "zonaGeografica_TipoCod" FOREIGN KEY ("FkTipoCod") REFERENCES "TipoCod" ("IdTipoCod")
);

SELECT AddGeometryColumn('', 'zonaGeografica', 'geom', '4326', 'MULTIPOLYGON', 2);


﻿﻿CREATE TABLE "TipoCambioCobertura"
(
  "IdCodCambioCobertura" INTEGER NOT NULL,
  "NomCambioCobertura" VARCHAR(50) NOT NULL,
  CONSTRAINT "TipoCambioCobertura_Pk" PRIMARY KEY ("IdCodCambioCobertura")     
);


CREATE TABLE "cambioCobertura"
(
  "IdCambioCobertura" SERIAL NOT NULL,
  "FKCodCambioCobertura"  INTEGER NOT NULL,
  "tiempoInicio" DATE NOT NULL,
  "tiempoFin" DATE NOT NULL,
  CONSTRAINT "cambioCobertura_Pk" PRIMARY KEY ("IdCambioCobertura"),
  CONSTRAINT "cambioCobertura_TipoCambioCobertura" FOREIGN KEY ("FKCodCambioCobertura") REFERENCES "TipoCambioCobertura" ("IdCodCambioCobertura")
);

SELECT AddGeometryColumn('', 'cambioCobertura', 'geom', '4326', 'MULTIPOLYGON', 2);


﻿﻿CREATE TABLE "TipoCobertura"
(
  "IdCodCobertura" INTEGER NOT NULL,
  "NomCobertura" VARCHAR(50) NOT NULL,
  CONSTRAINT "TipoCobertura_Pk" PRIMARY KEY ("IdCodCobertura")     
);


CREATE TABLE "cobertura"
(
  "IdCobertura" SERIAL NOT NULL,
  "FKCodCobertura"  INTEGER NOT NULL,
  "fecha" DATE NOT NULL,
  CONSTRAINT "cobertura_Pk" PRIMARY KEY ("IdCobertura"),
  CONSTRAINT "cobertura_TipoCobertura" FOREIGN KEY ("FKCodCobertura") REFERENCES "TipoCobertura" ("IdCodCobertura")
);

SELECT AddGeometryColumn('', 'cobertura', 'geom', '4326', 'MULTIPOLYGON', 2);


CREATE TABLE "intervencion"
(
  "IdIntervencion" SERIAL NOT NULL,
  "gradoInter"  VARCHAR(50) NOT NULL,
  "fecha" DATE NOT NULL,
  CONSTRAINT "intervencion_Pk" PRIMARY KEY ("IdIntervencion")
);

SELECT AddGeometryColumn('', 'intervencion', 'geom', '4326', 'MULTIPOLYGON', 2);


CREATE TABLE "hidroelectrica"
(
  "IdHidroelectrica" SERIAL NOT NULL,
  "estado"  VARCHAR(50),
  "nombre"  VARCHAR(50) NOT NULL,
  "institucion"  VARCHAR(50) NOT NULL,
  "fecha" DATE,
  CONSTRAINT "hidroelectrica_Pk" PRIMARY KEY ("IdHidroelectrica")
);

SELECT AddGeometryColumn('', 'hidroelectrica', 'geom', '4326', 'MULTIPOINT', 2);










