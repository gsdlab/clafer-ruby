CREATE TABLE "users" ("id" INTEGER PRIMARY KEY, 
	"first_name"      varchar(255), 
	"last_name" varchar(255));

CREATE TABLE "problems" ("id" INTEGER PRIMARY KEY,
	"user_id"  integer,
	"desc" varchar(255));

INSERT INTO "users" ("first_name", "last_name") VALUES ("zalias", "agurkas");
INSERT INTO "users" ("first_name", "last_name") VALUES ("zalias", "kopustas");
INSERT INTO "users" ("first_name", "last_name") VALUES ("zalias", "ridikas");
INSERT INTO "users" ("first_name", "last_name") VALUES ("zalias", "svogunas");

INSERT INTO "problems" ("user_id", "desc") VALUES ("1", "kaka");

