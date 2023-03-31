DROP TABLE IF EXISTS "phones_to_orders";
DROP TABLE IF EXISTS "phones";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "users";

CREATE TABLE "users"(
  "id" serial PRIMARY KEY,
  "firstName" VARCHAR(64) NOT NULL CHECK ("firstName" != ''),
  "lastName" VARCHAR(64) NOT NULL CHECK ("lastName" != ''),
  "email" VARCHAR(256) NOT NULL CHECK ("email" != '') UNIQUE,
  "isMale" BOOLEAN NOT NULL,
  "birthday" DATE NOT NULL CHECK ("birthday" < current_date),
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "height" NUMERIC(3,2) NOT NULL CHECK ("height">1.0 AND "height"<2.5)
);

CREATE TABLE "phones"(
  "id" serial PRIMARY KEY,
  "brand" VARCHAR(64) NOT NULL CHECK ("brand" != ''),
  "model" VARCHAR(64) NOT NULL CHECK ("model" != ''),
  "price" DECIMAL(10,2) NOT NULL CHECK ("price">0 ),
  "quantity" INT NOT NULL CHECK ("quantity" >=0 ) DEFAULT 0,
  "description" text,
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "unique_phone" UNIQUE("brand", "model")
);

CREATE TABLE "orders"(
  "id" serial PRIMARY KEY,
  "userId" INT REFERENCES "users"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "phones_to_orders"(
  "phoneId" INT REFERENCES "phones"("id"),
  "orderId" INT REFERENCES "orders"("id"),
  "quantity" INT NOT NULL CHECK ("quantity" >0 ) DEFAULT 1,
  PRIMARY KEY ("phoneId", "orderId")
);