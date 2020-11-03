Drop table if exists katastima, proion, emporos, agorazoun, exoun CASCADE;

CREATE TABLE katastima(
	id_katastimatos serial NOT NULL,
	onoma_katastimatos VARCHAR (50) NOT NULL,
	dieuthinsi VARCHAR (50) NOT NULL,
	onoma_dieuthinti VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_katastimatos)
);

CREATE TABLE proion(
	onoma_proiontos VARCHAR (50) NOT NULL,
	eteria VARCHAR (50) NOT NULL,
	poli VARCHAR (50) NOT NULL,
	PRIMARY KEY (onoma_proiontos)
);

CREATE TABLE emporos(
	id_emporou serial NOT NULL,
	onoma_emporou VARCHAR (50) NOT NULL,
	poli VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_emporou)
);

CREATE TABLE agorazoun(
	id_emporou serial NOT NULL,
	id_katastimatos serial NOT NULL,
	timi decimal NOT NULL,
	FOREIGN KEY (id_emporou) REFERENCES emporos(id_emporou),
	FOREIGN KEY (id_katastimatos) REFERENCES katastima(id_katastimatos),
	PRIMARY KEY (id_emporou, id_katastimatos)
);

CREATE TABLE exoun(
	id_emporou serial NOT NULL,
	onoma_proiontos VARCHAR (50) NOT NULL,
	FOREIGN KEY (id_emporou) REFERENCES emporos(id_emporou),
	FOREIGN KEY (onoma_proiontos) REFERENCES proion(onoma_proiontos),
	PRIMARY KEY (id_emporou, onoma_proiontos)
);


INSERT INTO katastima VALUES (DEFAULT, 'Papadopoulos SA', 'Thiveon 27', 'Kostas Papadopoulos');
INSERT INTO katastima VALUES (DEFAULT, 'Ntaxtirntis ABEE', 'Antheon 2184', 'Makarios Ntaxtirntis');
INSERT INTO katastima VALUES (DEFAULT, 'Froutemporiki', '15o xiliometro Athinon Lamias', 'Nikitas Vartholomeos');
INSERT INTO katastima VALUES (DEFAULT, 'Sardela AE', 'Thiveon 27', 'Kostas Papadopoulos');

INSERT INTO proion VALUES ('Laxanaki', 'Mpananex', 'Rethimno');
INSERT INTO proion VALUES ('Tiramisou', 'Erikos', 'Rethimno');
INSERT INTO proion VALUES ('Pitsa', 'Al Patchino', 'Ptolemaida');
INSERT INTO proion VALUES ('Tortigies', 'El Sabor', 'Ptolemaida');

INSERT INTO emporos VALUES (DEFAULT, 'Giorgos Piperakis', 'Rethimno');
INSERT INTO emporos VALUES (DEFAULT, 'Giorgos Kourasis', 'Ptolemaida');
INSERT INTO emporos VALUES (DEFAULT, 'Dimokritos Paleologos', 'Mikines');
INSERT INTO emporos VALUES (DEFAULT, 'Kostas Papadopoulos', 'Tost');

INSERT INTO agorazoun VALUES (1, 3, 5.5);
INSERT INTO agorazoun VALUES (2, 1, 8.9);
INSERT INTO agorazoun VALUES (3, 1, 1.4);
INSERT INTO agorazoun VALUES (4, 4, 1.4);

INSERT INTO exoun VALUES (3, 'Tiramisou');
INSERT INTO exoun VALUES (2, 'Laxanaki');
INSERT INTO exoun VALUES (1, 'Pitsa');
INSERT INTO exoun VALUES (1, 'Tortigies');

-- Τα καταστήματα που αγοράζουν από τον έμπορο Γιώργος Πιπεράκη:

create view katastimataEmporos as 
select katastima.onoma_katastimatos, emporos.onoma_emporou
from katastima, emporos, agorazoun
where agorazoun.id_emporou = 1 
and katastima.id_katastimatos = agorazoun.id_katastimatos 
and emporos.id_emporou = agorazoun.id_emporou; 

create MATERIALIZED view katastimataEmporosM as 
select katastima.onoma_katastimatos, emporos.onoma_emporou
from katastima, emporos, agorazoun
where agorazoun.id_emporou = 1 
and katastima.id_katastimatos = agorazoun.id_katastimatos 
and emporos.id_emporou = agorazoun.id_emporou;

-- Τα καταστήματα στα οποία είτε έχουν διευθυντή τον 
-- Κώστα Παπαδόπουλο είτε αγοράζουν από κάποιο έμπορο με αυτό το όνομα:

create view katastimataDieuthintisEmporos as
select  katastima.onoma_katastimatos,katastima.id_katastimatos,katastima.onoma_dieuthinti,emporos.onoma_emporou
from katastima, agorazoun, emporos
where katastima.id_katastimatos = agorazoun.id_katastimatos
and emporos.id_emporou = agorazoun.id_emporou
and emporos.onoma_emporou = 'Kostas Papadopoulos'
or katastima.onoma_dieuthinti = 'Kostas Papadopoulos'
and katastima.id_katastimatos = agorazoun.id_katastimatos 
and emporos.id_emporou = agorazoun.id_emporou;

create MATERIALIZED view katastimataDieuthintisEmporosM as
select  katastima.onoma_katastimatos,katastima.id_katastimatos,katastima.onoma_dieuthinti,emporos.onoma_emporou
from katastima, agorazoun, emporos
where katastima.id_katastimatos = agorazoun.id_katastimatos
and emporos.id_emporou = agorazoun.id_emporou
and emporos.onoma_emporou = 'Kostas Papadopoulos'
or katastima.onoma_dieuthinti = 'Kostas Papadopoulos'
and katastima.id_katastimatos = agorazoun.id_katastimatos 
and emporos.id_emporou = agorazoun.id_emporou;

-- Τους εμπόρους οι οποίοι έχουν όλα τα προϊόντα τα 
-- οποία παράγονται στο Ρέθυμνο :

create view emporosProion as
select emporos.onoma_emporou,proion.poli
from proion,exoun,emporos
where proion.poli = 'Rethimno' and exoun.id_emporou = emporos.id_emporou and proion.onoma_proiontos = exoun.onoma_proiontos ;

create MATERIALIZED view emporosProionM as
select emporos.onoma_emporou,proion.poli
from proion,exoun,emporos
where proion.poli = 'Rethimno' and exoun.id_emporou = emporos.id_emporou and proion.onoma_proiontos = exoun.onoma_proiontos ;


-- Τα καταστήματα τα οποία έχουν διευθυντή τον 
--Κώστα Παπαδόπουλο και δεν αγοράζουν
--από κάποιο έμπορο με το όνομα Γιώργος Κουράσης:
create view katastimaDieuthintisNotEmporos as
select katastima.onoma_katastimatos,katastima.id_katastimatos,emporos.onoma_emporou,katastima.onoma_dieuthinti
from katastima,agorazoun,emporos
where katastima.onoma_dieuthinti = 'Kostas Papadopoulos' and 
emporos.onoma_emporou != 'Giorgos Kourasis' and katastima.id_katastimatos = agorazoun.id_katastimatos and emporos.id_emporou = agorazoun.id_emporou ;

create MATERIALIZED view katastimaDieuthintisNotEmporosM as
select katastima.onoma_katastimatos,katastima.id_katastimatos,emporos.onoma_emporou,katastima.onoma_dieuthinti
from katastima,agorazoun,emporos
where katastima.onoma_dieuthinti = 'Kostas Papadopoulos' and 
emporos.onoma_emporou != 'Giorgos Kourasis' and katastima.id_katastimatos = agorazoun.id_katastimatos and emporos.id_emporou = agorazoun.id_emporou ;

--Τα ονόματα Όλων των εμπόρων και δίπλα τα ονόματα των προϊόντων που
--έχουν και τα οποία παράγονται στην Πτολεμαίδα (αν υπάρχουν αλλιώς 
--τα αντίστοιχα πεδία θα είναικενά):

create MATERIALIZED view proionPtolemaidaM as
select emporos.onoma_emporou,proion.onoma_proiontos,proion.poli
from proion,emporos,exoun
where proion.poli = 'Ptolemaida' 
and exoun.onoma_proiontos = proion.onoma_proiontos 
and exoun.id_emporou = emporos.id_emporou;

create view proionPtolemaida as
select emporos.onoma_emporou,proion.onoma_proiontos,proion.poli
from proion,emporos,exoun
where proion.poli = 'Ptolemaida' 
and exoun.onoma_proiontos = proion.onoma_proiontos 
and exoun.id_emporou = emporos.id_emporou;