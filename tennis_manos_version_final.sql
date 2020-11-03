DROP TABLE IF EXISTS Tournoua CASCADE;
DROP TABLE IF EXISTS Paiktis CASCADE ;
DROP TABLE IF EXISTS Apotelesma CASCADE ;
DROP TABLE IF EXISTS Kritis CASCADE ;

CREATE TABLE Tournoua(
	Id SERIAL,
	Eponimia VARCHAR(30),
	Xora VARCHAR(30),
	EtosIdrisis INT,
	EtosDiejagwgeisTournoua INT,
	PRIMARY KEY (Id)
);

CREATE TABLE Paiktis(
	Id SERIAL,
	Onomateponimo VARCHAR(30),
	Ilikia INT,
	EtosNikisTournoua INT,
	PRIMARY KEY (Id)
);

CREATE TABLE Apotelesma(
	Id INT,
	Onomateponimo VARCHAR(30),
	SetItimenou int,
	FOREIGN KEY (Id) references Paiktis(Id),
	PRIMARY KEY (Id)
);

CREATE TABLE Kritis(
	Onomateponimo VARCHAR(30),
	Empeiria VARCHAR (300),
	PRIMARY KEY (Onomateponimo)
);

-- Tournoua
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1984);
insert into Tournoua values(DEFAULT, 'Australian Open','Australia',1980,1996);
insert into Tournoua values(DEFAULT, 'US Open','HPA',1988,2000);
insert into Tournoua values(DEFAULT, 'Wimbledon','Agglia',1981,2010);
insert into Tournoua values(DEFAULT, 'Tsardampospito','Ellada', 2015, 2015);
-- ++
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1985);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1986);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1987);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1988);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1989);
-- ++
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1994);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1995);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1996);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1997);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1998);
-- ++
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1974);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1975);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1976);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1977);
insert into Tournoua values(DEFAULT, 'Roland Garros', 'Gallia', 1978, 1978);

-- Paiktis
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1984);
insert into Paiktis values (DEFAULT, 'Rafael Nadal',33,1994);
insert into Paiktis values (DEFAULT, 'Novak Djokovic',31,2000);
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,2010);
insert into Paiktis values (DEFAULT, 'Patrwklos Tsardampas',35,2015);
insert into Paiktis values (DEFAULT, 'Roger Federer Jr',2,2019);
-- ++
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1984);
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1985);
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1986);
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1987);
insert into Paiktis values (DEFAULT, 'Roger Federer',38,1988);
-- ++
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,1994);
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,1995);
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,1996);
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,1997);
insert into Paiktis values (DEFAULT, 'Stefanos Tsitsipas',27,1998);
-- ++
insert into Paiktis values (DEFAULT, 'Rafael Nadal',27,1974);
insert into Paiktis values (DEFAULT, 'Rafael Nadal',27,1975);
insert into Paiktis values (DEFAULT, 'Rafael Nadal',27,1976);
insert into Paiktis values (DEFAULT, 'Rafael Nadal',27,1977);
insert into Paiktis values (DEFAULT, 'Rafael Nadal',27,1978);

-- Apotelesmata
insert into Apotelesma values(1, 'Roger Federer',5);
insert into Apotelesma values(2, 'Rafael Nadal',2);
insert into Apotelesma values(3, 'Novak Djokovic',1);
insert into Apotelesma values(4, 'Stefanos Tsitsipas',0);
insert into Apotelesma values(5, 'Patrwklos Tsardampas',1);
-- ++
insert into Apotelesma values(7, 'Roger Federer',5);
insert into Apotelesma values(8, 'Roger Federer',5);
insert into Apotelesma values(9, 'Roger Federer',5);
insert into Apotelesma values(10, 'Roger Federer',5);
insert into Apotelesma values(11, 'Roger Federer',5);
-- ++
insert into Apotelesma values(12, 'Stefanos Tsitsipas',5);
insert into Apotelesma values(13, 'Stefanos Tsitsipas',5);
insert into Apotelesma values(14, 'Stefanos Tsitsipas',5);
insert into Apotelesma values(15, 'Stefanos Tsitsipas',5);
insert into Apotelesma values(16, 'Stefanos Tsitsipas',5);
-- ++
insert into Apotelesma values(17, 'Rafael Nadal',5);
insert into Apotelesma values(18, 'Rafael Nadal',5);
insert into Apotelesma values(19, 'Rafael Nadal',5);
insert into Apotelesma values(20, 'Rafael Nadal',5);
insert into Apotelesma values(21, 'Rafael Nadal',5);


-- Αναζητήστε όλα τα τουρνουά που ιδρύθηκαν μετά το 2000.

CREATE MATERIALIZED VIEW TwoThousandTournaments AS
SELECT Tournoua.Eponimia, Tournoua.EtosIdrisis
FROM Tournoua
WHERE Tournoua.EtosIdrisis > 2000;


-- Αναζητήστε όλους τους ενήλικους παίκτες του τουρνουά. 

CREATE MATERIALIZED VIEW AdultPlayers AS
SELECT DISTINCT Paiktis.Onomateponimo, Paiktis.Ilikia
FROM Paiktis
WHERE Paiktis.Ilikia >= 18;


-- Βρείτε τα αποτελέσματα του τουρνουά που κέρδισε ο ‘Roger Federer’.

CREATE MATERIALIZED VIEW RogerWinner AS
SELECT *
FROM Apotelesma
WHERE Apotelesma.Onomateponimo = 'Roger Federer';


--  Βρείτε όλους τους παίκτες που έχουν πάνω από 5 νίκες στο ‘Roland Garros’. 

CREATE MATERIALIZED VIEW OverFiveWins AS
SELECT Apotelesma.Onomateponimo, Tournoua.Eponimia, Paiktis.EtosNikisTournoua
FROM Apotelesma, Tournoua, Paiktis
GROUP BY Apotelesma.Onomateponimo, Tournoua.Eponimia, Paiktis.EtosNikisTournoua, Tournoua.EtosDiejagwgeisTournoua, Paiktis.Onomateponimo
HAVING COUNT(Apotelesma.Onomateponimo) >= 5 
AND Tournoua.Eponimia = 'Roland Garros'
AND Tournoua.EtosDiejagwgeisTournoua = Paiktis.EtosNikisTournoua
AND Paiktis.Onomateponimo = Apotelesma.Onomateponimo;


-- Αναζητήστε τους παίκτες που το όνομά τους αρχίζει από ‘R’. 

CREATE MATERIALIZED VIEW Rnames AS
SELECT DISTINCT Paiktis.Onomateponimo
FROM Paiktis
WHERE LEFT(Paiktis.Onomateponimo, 1) = 'R';


-- Βρείτε τα τουρνουά που διεξάγονται στη Γαλλία

CREATE MATERIALIZED VIEW FrTournaments AS
SELECT DISTINCT Tournoua.Eponimia
FROM Tournoua
WHERE Tournoua.Xora = 'Gallia';


-- Ερώτημα 2

insert into Kritis  values('Giorgos Tsaparas','exei summetasxei se 10 tounroua');
insert into Kritis  values('Takis Χatzimixas','exei summetasxei se 10 tounroua');

-- ALTER TABLE Paiktis ALTER COLUMN Onomateponimo TYPE VARCHAR(40);
-- ALTER TABLE Kritis DROP COLUMN empeiria;
-- ALTER TABLE Kritis ADD hlikia int;

insert into Kritis  values('tsapas',38);


-- Ερώτημα 4

INSERT INTO Tournoua (Eponimia)
SELECT Eponimia
FROM generate_series(1, 10000) AS x (Eponimia);

INSERT INTO Paiktis (Onomateponimo)
SELECT Onomateponimo
FROM generate_series(1, 10000) AS x (Onomateponimo);

INSERT INTO Kritis (Onomateponimo)
SELECT Onomateponimo
FROM generate_series(1, 10000) AS x (Onomateponimo);

-- Without materialized views: 143msec
-- With materialized views: 172msec
-- Παρατηρούμε ότι με τα materialized views απαιτείται περισσότερος χρόνος επεξεργασίας των πινάκων.
