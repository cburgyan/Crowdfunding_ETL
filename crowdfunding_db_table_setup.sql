--Create table schema
CREATE TABLE "campaign" (
    "cd_id" INT PRIMARY KEY  NOT NULL,
    "contact_id" INT   NOT NULL,
    "company_name" VARCHAR(50)   NOT NULL,
    "description" VARCHAR(225)   NOT NULL,
    "goal" NUMERIC(10,2)   NOT NULL,
    "pledged" NUMERIC(10,2)   NOT NULL,
    "outcome" VARCHAR(50)   NOT NULL,
    "backers_count" INT   NOT NULL,
    "country" VARCHAR(50)   NOT NULL,
    "currency" VARCHAR(50)   NOT NULL,
    "launched_date" DATE   NOT NULL,
    "end_date" DATE   NOT NULL,
    "category_id" VARCHAR(50)   NOT NULL,
    "subcategory_id" VARCHAR(50)   NOT NULL,
    );

CREATE TABLE "category" (
    "category_id" VARCHAR(50) PRIMARY KEY  NOT NULL,
    "category" VARCHAR(50)   NOT NULL,
);

CREATE TABLE "contacts" (
    "contact_id" INT PRIMARY KEY  NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "email" VARCHAR(50)   NOT NULL,
);

CREATE TABLE "subcategory" (
    "subcategory_id" VARCHAR(50) PRIMAR KEY NOT NULL,
    "subcategory" VARCHAR(50)   NOT NULL,
);

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_contract_id" FOREIGN KEY("contract_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");

