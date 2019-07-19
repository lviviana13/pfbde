/*DDL para proyecto Deforestación en el Amazonas*/
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
  CONSTRAINT "zonaGeografica_TipoCod" FOREIGN KEY ("FkTipoCod") REFERENCES "TipoCod" ("IdFacultad")
);

﻿/* ******************************************* zonaGeografica ******************************************* */

INSERT INTO "TipoCod" ("IdTipoCod", "NomTipoCod") VALUES (1, 'zona hidrografica_IDEAM');
INSERT INTO "TipoCod" ("IdTipoCod", "NomTipoCod") VALUES (2, 'subzona hidrografica_IDEAM');
INSERT INTO "TipoCod" ("IdTipoCod", "NomTipoCod") VALUES (3, 'departamento_DANE');

