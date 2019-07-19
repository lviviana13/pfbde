
﻿/* ******************************************* DDL ******************************************* */

﻿﻿CREATE TABLE "TipoCod"
(
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
