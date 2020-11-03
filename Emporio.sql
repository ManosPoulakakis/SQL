DROP TABLE IF EXISTS katastima, proion, emporos, agorazoun, exoun CASCADE;
DROP TYPE IF EXISTS address, merch, manager, company;

-- Types:

CREATE TYPE address AS (
	Odos VARCHAR (50),
	Arithmos INT
);

CREATE TYPE merch AS (
	Onoma VARCHAR (50),
	Epitheto VARCHAR (50)
);

CREATE TYPE manager AS (
	Onoma VARCHAR (50),
	Epitheto VARCHAR (50)
);

CREATE TYPE company AS ENUM ('Froutemporiki', 'Sardela AE', 'Papadopoulos SA');

-- Tables:

CREATE TABLE katastima(
	id_katastimatos serial NOT NULL,
	onoma_katastimatos VARCHAR (50),
	dieuthinsi address,
	onoma_dieuthinti manager,
	PRIMARY KEY (id_katastimatos)
);

CREATE TABLE proion(
	onoma_proiontos VARCHAR (50) NOT NULL,
	eteria company,
	poli VARCHAR (50),
	PRIMARY KEY (onoma_proiontos)
);

CREATE TABLE emporos(
	id_emporou serial NOT NULL,
	onoma_emporou merch,
	poli text[],
	PRIMARY KEY (id_emporou)
);

CREATE TABLE agorazoun(
	id_emporou SERIAL NOT NULL,
	id_katastimatos SERIAL NOT NULL,
	timi DECIMAL,
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

-- Data insertion:

INSERT INTO katastima VALUES (DEFAULT, 'Sardelomanabiko', ROW('Deligianni', 12), ROW('Giorgos', 'Nikou'));
INSERT INTO katastima VALUES (DEFAULT, 'O Geros Tou moria', ROW('Karamanli', 192), ROW('Theodoros', 'Kwlokotronhs'));
INSERT INTO katastima VALUES (DEFAULT, 'Ta 2 Pa', ROW('Thiveon', 45), ROW('Kostas', 'Papadopoulos'));
INSERT INTO katastima VALUES (DEFAULT, 'Kotsos and Sons', ROW('Bofor', 11), ROW('Kostas', 'Papadopoulos'));

INSERT INTO proion VALUES ('Laxanaki', 'Sardela AE', 'Rethimno');
INSERT INTO proion VALUES ('Tiramisou', 'Papadopoulos SA', 'Rethimno');
INSERT INTO proion VALUES ('Pitsa', 'Papadopoulos SA', 'Ptolemaida');
INSERT INTO proion VALUES ('Fraoules', 'Froutemporiki', 'Ptolemaida');

INSERT INTO emporos VALUES (DEFAULT, ROW('Kostas', 'Papadopoulos'), ARRAY['Peiraias', 'Perama']);
INSERT INTO emporos VALUES (DEFAULT, ROW('Giorgos', 'Kourasis'), ARRAY['Ptolemaida', 'Kozani']);
INSERT INTO emporos VALUES (DEFAULT, ROW('Giorgos', 'Piperakis'), ARRAY['Rethimno', 'Irakleio']);
INSERT INTO emporos VALUES (DEFAULT, ROW('Nikos' , 'Korompos'), ARRAY['Santorini', 'Mykonos']);

-- VVV emporos, katastima, timi VVV

INSERT INTO agorazoun VALUES (1, 3, 5);
INSERT INTO agorazoun VALUES (4, 4, 5);
INSERT INTO agorazoun VALUES (3, 1, 5);
INSERT INTO agorazoun VALUES (2, 1, 5);

INSERT INTO exoun VALUES (1, 'Laxanaki');
INSERT INTO exoun VALUES (2, 'Tiramisou');
INSERT INTO exoun VALUES (3, 'Pitsa');
INSERT INTO exoun VALUES (1, 'Fraoules');

-- 1. Τα καταστήματα που αγοράζουν από τον έμπορο Γιώργος Πιπεράκη

SELECT katastima.onoma_katastimatos, emporos.onoma_emporou
FROM katastima, emporos, agorazoun
WHERE agorazoun.id_emporou = 1 
AND katastima.id_katastimatos = agorazoun.id_katastimatos 
AND emporos.id_emporou = agorazoun.id_emporou; 

-- 2. Τα καταστήματα στα οποία είτε έχουν διευθυντή τον Κώστα Παπαδόπουλο είτε αγοράζουν από κάποιο έμπορο με αυτό το όνομα

SELECT  katastima.onoma_katastimatos,katastima.id_katastimatos,katastima.onoma_dieuthinti,emporos.onoma_emporou
FROM katastima, agorazoun, emporos
WHERE katastima.id_katastimatos = agorazoun.id_katastimatos
AND emporos.id_emporou = agorazoun.id_emporou
AND (emporos.onoma_emporou).Onoma = 'Kostas' AND (emporos.onoma_emporou).Epitheto = 'Papadopoulos'
OR (katastima.onoma_dieuthinti).Onoma = 'Kostas' AND (katastima.onoma_dieuthinti).Epitheto = 'Papadopoulos'
AND katastima.id_katastimatos = agorazoun.id_katastimatos 
AND emporos.id_emporou = agorazoun.id_emporou;


-- 3. Τους εμπόρους οι οποίοι έχουν όλα τα προϊόντα τα οποία παράγονται στο Ρέθυμνο

SELECT emporos.onoma_emporou,proion.poli
FROM proion,exoun,emporos
WHERE proion.poli = 'Rethimno' 
AND exoun.id_emporou = emporos.id_emporou 
AND proion.onoma_proiontos = exoun.onoma_proiontos;

-- 4. Τα καταστήματα τα οποία έχουν διευθυντή τον Κώστα Παπαδόπουλο και δεν αγοράζουν από κάποιο έμπορο με το όνομα Γιώργος Κουράσης:

SELECT katastima.onoma_katastimatos,katastima.id_katastimatos,emporos.onoma_emporou,katastima.onoma_dieuthinti
FROM katastima,agorazoun,emporos
WHERE (katastima.onoma_dieuthinti).Onoma = 'Kostas' AND (katastima.onoma_dieuthinti).Epitheto = 'Papadopoulos' 
AND (emporos.onoma_emporou).Onoma != 'Giorgos' AND (emporos.onoma_emporou).Epitheto != 'Kourasis' 
AND katastima.id_katastimatos = agorazoun.id_katastimatos 
AND emporos.id_emporou = agorazoun.id_emporou ;

-- 5. Τα ονόματα Όλων των εμπόρων και δίπλα τα ονόματα των προϊόντων που έχουν και τα οποία παράγονται στην Πτολεμαίδα (αν υπάρχουν αλλιώς τα αντίστοιχα πεδία θα είναι κενά)

SELECT emporos.onoma_emporou,proion.onoma_proiontos,proion.poli
FROM proion,emporos,exoun
WHERE proion.poli = 'Ptolemaida' 
AND exoun.onoma_proiontos = proion.onoma_proiontos 
AND exoun.id_emporou = emporos.id_emporou;
