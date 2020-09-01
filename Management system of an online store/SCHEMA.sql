/* CREAREA TABELELOR*/
CREATE TABLE DEPARTAMENT_AVA
( cod_departament NUMBER(4) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL,
  telefon VARCHAR2(10) DEFAULT '0700000000',
  descriere VARCHAR2(50)
);
 
CREATE TABLE ANGAJAT_AVA
( cnp NUMBER(13) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL,
  prenume VARCHAR2(20),
  adresa_email CHAR(15) UNIQUE,
  data_nasterii DATE,
  data_angajarii DATE default SYSDATE, 
  salariu NUMBER(8,2) NOT NULL,
  cod_departament NUMBER(4) REFERENCES DEPARTAMENT_AVA(cod_departament)
);

CREATE TABLE CLIENT_AVA
( cod_client NUMBER(10) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL,
  prenume VARCHAR2(20),
  adresa_email CHAR(15) UNIQUE,
  telefon VARCHAR2(10) DEFAULT '0700000000',
  adresa VARCHAR2(50)
);

CREATE TABLE CURIER_AVA
( id_curier NUMBER(10) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL,
  telefon VARCHAR2(10) DEFAULT '0700000000',
  descriere VARCHAR2(50)
);


CREATE TABLE COMANDA_AVA 
( cod_comanda NUMBER(10) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL, 
  descriere VARCHAR2(50),
  cod_client NUMBER(10) REFERENCES CLIENT_AVA(cod_client),
  cnp_angajat NUMBER(13) REFERENCES ANGAJAT_AVA(cnp),
  id_curier NUMBER(10) REFERENCES CURIER_AVA(id_curier)
);

CREATE TABLE FURNIZOR_AVA
( cod_furnizor NUMBER(10) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL,
  adresa_email CHAR(50) UNIQUE,
  adresa VARCHAR(50)
);

CREATE TABLE PRODUS_AVA
( cod_produs NUMBER(10) PRIMARY KEY,
  nume VARCHAR2(20) NOT NULL, 
  descriere VARCHAR2(200),
  pret NUMBER(8,2) default 0,
  cantitate NUMBER(5),
  cod_furnizor NUMBER(10) REFERENCES FURNIZOR_AVA(cod_furnizor),
  categorie VARCHAR2(100)
);
  
CREATE TABLE EVIDENTA_AVA
( cod_evidenta NUMBER(10) PRIMARY KEY, 
  cantitate NUMBER(10),
  data_comanda DATE default SYSDATE, 
  cod_comanda NUMBER(10) REFERENCES COMANDA_AVA(cod_comanda),
  cod_produs NUMBER(10) REFERENCES PRODUS_AVA(cod_produs)
);

/* ADAUGAREA INREGISTRARILOR */

/* DEPARTAMENT */
SELECT *
FROM DEPARTAMENT_AVA;

INSERT INTO DEPARTAMENT_AVA
VALUES (1, 'Resurse umane', '0712234456', NULL);

INSERT INTO DEPARTAMENT_AVA
VALUES (2, 'Comenzi', '0763456789', NULL);

INSERT INTO DEPARTAMENT_AVA
VALUES (3, 'Vanzari', '0214567898', NULL);

INSERT INTO DEPARTAMENT_AVA
VALUES (4, 'IT', '0722456789', NULL);

INSERT INTO DEPARTAMENT_AVA
VALUES (5, 'Contabilitate', '0744567321', NULL);

/* ANGAJAT */
SELECT *
FROM ANGAJAT_AVA;

INSERT INTO ANGAJAT_AVA
VALUES(6200609016703, 'Antonescu', 'Ion', 'antonescuion@yahoo.com', '15-MAY-1969', '8-APR-2004', 1500, 1);

INSERT INTO ANGAJAT_AVA
VALUES(6200613017271, 'Alecu', 'Elena', 'alecuelena@yahoo.com', '10-JUN-1980', '8-FEB-2017', 2500, 2);

INSERT INTO ANGAJAT_AVA
VALUES(6200613017747, 'Pascu', 'Ioana', 'pascuioana@yahoo.com', '20-SEP-1994', '20-APR-2018', 3100, 2);

INSERT INTO ANGAJAT_AVA
VALUES(6200613018909, 'Ignat', 'Ioana', 'ignatioana@yahoo.com', '15-APR-1989', '17-JAN-2006', 3000, 2);

INSERT INTO ANGAJAT_AVA
VALUES(6200613016931, 'Andrei', 'Aurel', 'andreiaurel@yahoo.com', '19-AUG-1977', '18-APR-2010', 2000, 1);

INSERT INTO ANGAJAT_AVA
VALUES(6200613018087, 'Rusel', 'Cosmina', 'ruselcosmina@yahoo.com', '18-MAY-1970', '10-APR-2000', 4500, 5);

INSERT INTO ANGAJAT_AVA
VALUES(6200613016374, 'Hamdan', 'Tudor', 'hamdantudor@yahoo.com', '20-FEB-1977', '8-APR-2018', 3000, 4);

INSERT INTO ANGAJAT_AVA
VALUES(6200613018466, 'Tenea', 'Irina', 'teneairina@yahoo.com', '19-MAY-1996', '28-APR-2015', 5000, 4);

INSERT INTO ANGAJAT_AVA
VALUES(6200613018167, 'Musetel', 'Daniela', 'museteldana@yahoo.com', '20-DEC-1998', '28-APR-2017', 4500, 4);

INSERT INTO ANGAJAT_AVA
VALUES(6200608016911, 'Stanca', 'Florin', 'stancaf@yahoo.com', '22-DEC-1996', '28-APR-2017', 2500, 2);

/* CLIENT */
SELECT *
FROM CLIENT_AVA;

INSERT INTO CLIENT_AVA
VALUES(101, 'Fleseriu', 'Dorel', 'dorel@yahoo.com', '0722345678', 'str. Iasomiei, Bucuresti');

INSERT INTO CLIENT_AVA
VALUES(103, 'Alexandrescu', 'Alin', 'alinalexandrescu@yahoo.com', '0765456789', 'str. Stadionului, Bolintin-Vale');

INSERT INTO CLIENT_AVA
VALUES(104, 'Gheorghe', 'Isabelle', 'isabelle@gmail.com', '0729876542', 'str. Apolodor, Bacau');

INSERT INTO CLIENT_AVA
VALUES(105, 'Olteanu', 'Ana', 'olteanuana@yahoo.com', '0763592987', 'str. Lacustei, Bucuresti');

INSERT INTO CLIENT_AVA
VALUES(112, 'Filip', 'Ioana', 'ioanafilip@yahoo.com', '0727897890', 'str. Belsugului, Chiajna');

INSERT INTO CLIENT_AVA
VALUES(100, 'Faur', 'Mariana', 'fmariana@yahoo.com', '0765487985', 'str. Ion Creanga, Bucuresti');

INSERT INTO CLIENT_AVA
VALUES(102, 'Chira', 'Corina', 'chiracorina@yahoo.com', '0726985458', 'str. Joita, Ramnicu Valcea');

INSERT INTO CLIENT_AVA
VALUES(114, 'Vacaru', 'Alexandra', 'alexandravacaru@yahoo.com', '0763593975', 'str. Fericirii, Bucuresti');

/* CURIER */

SELECT *
FROM CURIER_AVA;

INSERT INTO CURIER_AVA
VALUES(200, 'AVANGARD CURIER SRL', '0741090797', 'Oras: Tulcea; pagina de internet:www.24curier.ro');

INSERT INTO CURIER_AVA
VALUES(202, 'BOOKURIER SRL', '0314253254', 'Oras: Bucutresti, sector 2');

INSERT INTO CURIER_AVA
VALUES(201, 'AZTEC CURIER SRL', '0723456789', 'Oras: Ramnicu Valcea');

INSERT INTO CURIER_AVA
VALUES(203, 'DANMANO TRANS SRL', '0741090890', 'Oras: Bacau; pagina de internet:www.danmano.ro');

INSERT INTO CURIER_AVA
VALUES(204, 'EDFIL TEAM SRL', '0743091797', 'Oras: Bucuresti; sector 3');

INSERT INTO CURIER_AVA
VALUES(205, 'DHL ROMANIA SRL', '0741890797', 'Oras: Bucuresti; pagina de internet:www.dhl.ro');

INSERT INTO CURIER_AVA
VALUES(206, 'TNT ROMANIA SRL', '0743090997', 'Oras: Bucuresti, sector 1');

INSERT INTO CURIER_AVA
VALUES(207, 'ON TIME CURIER SRL', '0722090797', 'Oras: Brasov');

/* COMANDA */
SELECT *
FROM COMANDA_AVA;

INSERT INTO COMANDA_AVA
VALUES(14523, 'Pijama', NULL, 102, '6200613017271', 206);

INSERT INTO COMANDA_AVA
VALUES(9012, 'Tricou', NULL, 105, '6200613017271', 200);

INSERT INTO COMANDA_AVA
VALUES(8352, 'Pantaloni', NULL, 112, '6200613017747', 200);

INSERT INTO COMANDA_AVA
VALUES(6671, 'Rochie', NULL, 100, '6200613018909', 204);

INSERT INTO COMANDA_AVA
VALUES(1343, 'Tricou', NULL, 104, '6200613017747', 205);

INSERT INTO COMANDA_AVA
VALUES(4562, 'Pulover', NULL, 112, '6200613017747', 202);

INSERT INTO COMANDA_AVA
VALUES(8754, 'Ghiozdan', NULL, 102, '6200613017271', 206);

INSERT INTO COMANDA_AVA
VALUES(9013, 'Pijama', NULL, 114, '6200613018909', 201);

INSERT INTO COMANDA_AVA
VALUES(8677, 'Curea', NULL, 101, '6200613018909', 206);

INSERT INTO COMANDA_AVA
VALUES(9017, 'Rochie', NULL, 103, '6200613017271', 201);

INSERT INTO COMANDA_AVA
VALUES(9019, 'Bluza', NULL, 114, '6200613017271', 201);


/* FURNIZOR */
SELECT *
FROM FURNIZOR_AVA;

INSERT INTO FURNIZOR_AVA
VALUES(1004, 'Angro Zenda', 'angrozenda@gmail.com', 'Cluj Napoca');

INSERT INTO FURNIZOR_AVA
VALUES(1006, 'VERISSIMO', 'verissimo@gmail.com', 'Bucuresti');

INSERT INTO FURNIZOR_AVA
VALUES(1007, 'Belcor Fashion', 'belcorfashion@gmail.com', 'Suceava');

INSERT INTO FURNIZOR_AVA
VALUES(1008, 'Stil Strehaia SRL', 'stilstrehaia@yahoo.com', 'Strehaia');

INSERT INTO FURNIZOR_AVA
VALUES(1009, 'Bobo Moda', 'bobomoda@gmail.com', 'Giurgiu');

INSERT INTO FURNIZOR_AVA
VALUES(1001, 'About You', 'aboutyou@gmail.com', 'Bucuresti');

INSERT INTO FURNIZOR_AVA
VALUES(1002, 'Mega Stock', 'eu@depozitoutlet.ro', 'Cluj Napoca');

INSERT INTO FURNIZOR_AVA
VALUES(1003, 'Raspberry Store', 'raspberrystore@gmail.com', 'Bucuresti');

INSERT INTO FURNIZOR_AVA
VALUES(1005, 'Ellen Design ', 'ellendesign@gmail.com', 'Bucuresti');

/* PRODUSE */
SELECT *
FROM PRODUS_AVA;

INSERT INTO PRODUS_AVA
VALUES(19, 'Pijama Dama Elif', 'Pijama dama alcatuita din doua piese : maiou si pantalon scurt.Prezinta imprimeu modern.
        Este o pijama lejera, material de calitate superioara.100% bumbac', 29, 1009, 30, 'Pijamale Dama');
 
INSERT INTO PRODUS_AVA
VALUES(831,'Curea Dama Masiva', 'Curea dama foarte trendy din piele ecologica. Model deosebit, care se poate accesoriza cu usurinta.Lugimea este de 100 cm.',
       30, 1009, 15, 'Curele Dama');

INSERT INTO PRODUS_AVA
VALUES(631, 'Blue Denim Jeans', 'Caracteristici Produs: inchidere cu fermoar, cu buzunare', 129, 1003, 20, 'Pantaloni Dama');

INSERT INTO PRODUS_AVA
VALUES(328, 'Rochie Bleumarin', 'Caracteristici produs: decolteu In V, inchidere cu nasturi' , 89, 1005, 10, 'Rochii');

INSERT INTO PRODUS_AVA
VALUES(123, 'TOMMY HILFIGER Rucsac', 'Rucsac TOMMY HILFIGER pe albastru închis / ro?u / alb', 335, 1001, 30, 'Genti');

INSERT INTO PRODUS_AVA
VALUES(333, 'Pulover Dama SmoothCollar Mov','Pulover dama tricotat: culoarea magenta, puloverul este pe gat', 37, 1004, 3, 'Pulovere Dama');

INSERT INTO PRODUS_AVA
VALUES(162, 'Tricou W NSW AIR TOP SS BF','O culoare per pachet, Print Logo, Tiv drept, Tiv/muchie tighelit?', 130, 1001, 15, 'Tricouri Barbati');

INSERT INTO PRODUS_AVA
VALUES(508,'Pantaloni Dama Viorella', 'Pantalon fashion din material calitativ si elastic. Pantalonii au talia inalta si se inchide cu fermoar pe o parte. Acest tip de pantalon avantajeaza orice tip de silueta',
        50, 1006, 40, 'Pantaloni');
        
INSERT INTO PRODUS_AVA
VALUES(309, 'Rochie cu dungi Dorothy Perkins', 'Caracteristici Produs: cordon in talie', 89, 1007, 10, 'Rochii');

INSERT INTO PRODUS_AVA
VALUES(129, 'Saboti Benassi Just Do It', 'Talp? de acoperire c?ptu?it?, O culoare per pachet', 103, 1008, 10, 'Incaltaminte dama');

INSERT INTO PRODUS_AVA
VALUES(262, 'Espadrile Dama Cu Imprimeu Abstract Imaginary Mov', 'Espadrile dama colectia Zenda. La exterior: material textil, la interior: material textil, talpa: material sintetic, cu striatii fine', 
       55, 1002, 4, 'Incaltaminte dama');
       
INSERT INTO PRODUS_AVA
VALUES(7182, 'Jacheta Ella', 'Jacheta  material plin cu insertii de sclipici si elastic. Jacheta ofera un look pe care toata lumea il va remarca, datorita modelului glamour dat de perforatiile inedite.', 
       80, 1006, 16, 'Jachete');
       
INSERT INTO PRODUS_AVA
VALUES(819, 'Salopeta denim DOROTHY PERKINS', 'Compozitie; 100% bumbac, Caracteristici produs: cordon in talie', 99, 1001, 17, 
        'Salopete dama');

INSERT INTO PRODUS_AVA
VALUES(175, 'Camasa babydoll Ellos', 'Compozitie:65% bumbac,33% poliamida,2% elastan, Caracteristici Produs: inchidere cu nasturi', 
        50, 1007, 20, 'Bluze dama');

INSERT INTO PRODUS_AVA
VALUES(1773, 'Fusta Midi Plisata Dorothy Perkins', 'Caracteristici produs: fusta plisata, imprimeu floral', 69, 1001, 30, 'Fuste');

INSERT INTO PRODUS_AVA
VALUES(1664, 'Pantaloni RIVER ISLAND', 'Compozitie: 100% poliester, Caracteristici Produs: inchidere cu fermoar lateral',
        149, 1003, 18, 'Pantaloni dama');

INSERT INTO PRODUS_AVA
VALUES(10034, 'Camasa Dama Ella', 'Camasa dama din tesatura plina si subtire , cu broderie aplicata . 
    Camasa are maneca lunga bufanta , aceasta se inchide cu nasturi. Camasa poate fi asortata cu usurinta .', 60, 1008, 20, 'Bluze dama');

INSERT INTO PRODUS_AVA
VALUES(869, 'Pantaloni Scurti Barbatesti Leaf Style', 'Pantaloni barbatesti colectia Zenda. Sunt croiti drept, au buzunare clasice in fata si la spate si se incheie in fata cu fermoar si nasture. Lungime aprox. 54cm', 90, 1004, 30, 'Pantaloni barbati');

INSERT INTO PRODUS_AVA
VALUES(1989, 'Tricou PANTHER', 'Tricou Magdeburg - Los Angeles pe negru / alb', 300, 1002, 20, 'Tricouri barbati');

/* EVIDENTA */

SELECT *
FROM EVIDENTA_AVA;

INSERT INTO EVIDENTA_AVA
VALUES(453, 1, '18-MAY-2019', 14523, 19);

INSERT INTO EVIDENTA_AVA 
VALUES(2345, 2, '20-JUN-2020', 9012, 1989);

INSERT INTO EVIDENTA_AVA
VALUES(990, 1, SYSDATE, 6671, 328); 

INSERT INTO EVIDENTA_AVA
VALUES(1234, 1, '17-MAY-2019', 1343, 162);

INSERT INTO EVIDENTA_AVA
VALUES(189, 2, SYSDATE, 4562, 333);

INSERT INTO EVIDENTA_AVA
VALUES(783, 1, '18-APR-2020', 8754, 123);

INSERT INTO EVIDENTA_AVA
VALUES(920, 1, SYSDATE, 9013, 19);

INSERT INTO EVIDENTA_AVA
VALUES(6738, 2, '8-FEB-2020', 9017, 328);

INSERT INTO EVIDENTA_AVA
VALUES (354, 1, SYSDATE, 8677, 831);

INSERT INTO EVIDENTA_AVA
VALUES(9012, 1, SYSDATE, 8352, 869);

INSERT INTO EVIDENTA_AVA
VALUES(9013, 2, '20-JUN-2020', 9012, 1989);

INSERT INTO EVIDENTA_AVA
VALUES(90112, 1, '20-JUN-2020', 9012, 162);

INSERT INTO EVIDENTA_AVA
VALUES(9014, 3, SYSDATE, 8352, 1664);

INSERT INTO EVIDENTA_AVA
VALUES(9016, 1, SYSDATE, 8352, 508);

INSERT INTO EVIDENTA_AVA
VALUES(9017, 1, '17-DEC-2019', 9019, 10034);

INSERT INTO EVIDENTA_AVA
VALUES(9018, 1, '17-DEC-2019', 9019, 175);


