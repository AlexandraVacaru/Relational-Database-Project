/* 1. Sa se afiseze numele, prenumele, salariul si adresa de e-mail pentru toti angajatii al caror salariu este mai mare de
2000 si care lucreaza in departamentul Comenzi.*/

SELECT a.nume, a.prenume, a.salariu, a.adresa_email
FROM ANGAJAT_AVA a
JOIN DEPARTAMENT_AVA d ON (d.cod_departament = a.cod_departament)
WHERE a.salariu > 2000 AND LOWER(d.nume) LIKE 'comenzi';

/* 2. Sa se afiseze numele categoriei, numele si pretul produsului care se afla in categoria dama si pentru care pretul nu este egal cu 39, 59, 100.*/

SELECT p.categorie, p.nume, p.pret
FROM PRODUS_AVA p
WHERE LOWER(p.categorie) LIKE '%dama%' AND p.pret NOT IN (30,50,100);

/* 3. Sa se afiseze detalii despre comenzile care au fost preluate in luna para.*/

SELECT c.cod_comanda, c.nume, e.data_comanda
FROM EVIDENTA_AVA e
JOIN COMANDA_AVA c ON (e.cod_comanda = c.cod_comanda)
WHERE MOD(EXTRACT(MONTH FROM e.data_comanda),2) = 0;

/*4.Sa se determine codul, numele si prenumele angajatilor al caror salariu este mai mare decat 3000 sau este egal cu salariul 
maxim pentru departamentul respectiv. */

SELECT cnp, nume, prenume, salariu, cod_departament
FROM ANGAJAT_AVA
WHERE (cod_departament, salariu) IN ( SELECT cod_departament, salariu
                                      FROM ANGAJAT_AVA
                                      WHERE salariu > 3000
                                      UNION 
                                      SELECT cod_departament, MAX(salariu)
                                      FROM ANGAJAT_AVA
                                      GROUP BY cod_departament);
                                      
/* 5. Sa se afiseze numele si data angajarii pentru salariatii care au fost angajati dupa angajatul cu numele Ignat.*/
SELECT nume, prenume, data_angajarii
FROM ANGAJAT_AVA
WHERE data_angajarii > ( SELECT data_angajarii
                         FROM ANGAJAT_AVA
                         WHERE LOWER(nume) LIKE 'ignat');
                         
/* 6. Sa se afiseze numele si salariul pentru toti colegii din acelasi departament cu angajatul cu numele Ignat 
(se va exclude Ignat).*/
SELECT nume, prenume, salariu, cod_departament
FROM ANGAJAT_AVA
WHERE cod_departament IN ( SELECT cod_departament
                           FROM ANGAJAT_AVA
                           WHERE LOWER(nume) LIKE 'ignat')
AND LOWER(nume) <> 'ignat';

/* 7.  Sa se afiseze codul, numele, suma totala a comenzii pentru comanda cu cel mai mare pret. */
SELECT DISTINCT c.cod_comanda, c.nume, p.pret * e.cantitate "Suma comanda"
FROM COMANDA_AVA c
JOIN EVIDENTA_AVA e ON (e.cod_comanda = c.cod_comanda)
JOIN PRODUS_AVA p ON (p.cod_produs = e.cod_produs)
WHERE p.pret * e.cantitate = ( SELECT MAX( p1.pret * e1.cantitate)
                               FROM EVIDENTA_AVA e1
                               JOIN PRODUS_AVA p1 ON (e1.cod_produs = p1.cod_produs));
                               
/* 8.Sa se afiseze codul, numele si numarul produselor pentru comenzile care contin mai mult de un produs.*/

SELECT c.cod_comanda, c.nume, COUNT(p.cod_produs) * e.cantitate "Numar produse"
FROM COMANDA_AVA c
JOIN EVIDENTA_AVA e ON (e.cod_comanda = c.cod_comanda)
JOIN PRODUS_AVA p ON (p.cod_produs = e.cod_produs)
GROUP BY c.cod_comanda,c.nume, e.cantitate
HAVING COUNT(p.cod_produs) * e.cantitate > 1;

/* 9. Sa se afiseze codul departamentului cu media salariului cea mai mare */
SELECT cod_departament
FROM ANGAJAT_AVA
GROUP BY cod_departament
HAVING AVG(salariu) = ( SELECT MAX(AVG(salariu))
                        FROM ANGAJAT_AVA
                        GROUP BY cod_departament);
                        
/* 10.Sa se afiseze denumirea produselor si numele furnizorului pentru produsele cu pretul cuprins intre 100 si 300 de lei.*/
SELECT p.nume "Denumire produs", f.nume "Nume furnizor", p.pret "Pretul produsului"
FROM PRODUS_AVA p
JOIN FURNIZOR_AVA f ON (f.cod_furnizor = p.cod_furnizor)
WHERE p.pret BETWEEN 100 AND 300;

/* 11. Sa se afiseze codul, numele si codul comenzii produselor care sunt cel putin in 
aceeasi comanda ca produsul cu codul 1664.*/
SELECT DISTINCT p.cod_produs, p.nume, e.cod_comanda
FROM PRODUS_AVA p
JOIN EVIDENTA_AVA e ON (p.cod_produs = e.cod_produs)
WHERE NOT EXISTS ( SELECT 1
                   FROM PRODUS_AVA p1
                   JOIN EVIDENTA_AVA e1 ON (e1.cod_produs = p1.cod_produs)
                   WHERE p1.cod_produs = 1664
                   AND NOT EXISTS ( SELECT 1
                                    FROM EVIDENTA_AVA e2
                                    WHERE e2.cod_produs = p.cod_produs AND e2.cod_comanda = e1.cod_comanda));

/* 12. Sa se listeze informatii despre curierii ale caror comenzi au fost date in primele 6 luni ale anului 2019. */

SELECT cr.id_curier, cr.nume
FROM CURIER_AVA cr
JOIN COMANDA_AVA c ON (c.id_curier = cr.id_curier)
JOIN EVIDENTA_AVA e ON (e.cod_comanda = c.cod_comanda)
WHERE EXTRACT(YEAR FROM e.data_comanda) = 2019 AND EXTRACT(MONTH FROM e.data_comanda) BETWEEN 1 AND 6;

/* 13. Sa se realizeze un script prin care sa se afiseze numele, departamentul si data angajarii salariatilor care au inceput 
lucrul intre doua date calendaristice introduse de la tastatura.*/

ACCEPT p_data1 PROMPT 'Data de inceput'
ACCEPT p_data2 PROMPT 'Data de sfarsit'
SELECT a.nume || ' ' || a.prenume || ' ' || d.nume || ' ' || a.data_angajarii "Detalii angajati"
FROM ANGAJAT_AVA a
JOIN DEPARTAMENT_AVA d ON (a.cod_departament = d.cod_departament)
WHERE a.data_angajarii BETWEEN TO_DATE('&p_data1', 'MM/DD/YY') AND TO_DATE('&p_data2', 'MM/DD/YY');

/* 14.  Sa se afiseze codul si valoarea stocului fiecarui furnizor, care are cel putin 3 produse pe stoc. */

SELECT SUM(p.pret * p.cantitate) "Valoare stoc", p.cod_furnizor
FROM FURNIZOR_AVA f
JOIN PRODUS_AVA p ON (p.cod_furnizor = f.cod_furnizor)
WHERE (SELECT COUNT(cod_produs) FROM PRODUS_AVA p1 WHERE p1.cod_furnizor = f.cod_furnizor) >= 2
GROUP BY p.cod_furnizor;

/* 15. Sa se afiseze numele, codul departamentului, salariul si o coloana care sa arate salariul dupa marire. Pentru 
departamentul Vanzari are loc o marire de 10%, pentru departamentul Resurse umane  15%,iar pentru departamentul Comenzi 20%. */

SELECT a.nume || ' '|| a.prenume "Nume angajat", d.cod_departament "Codul departamentului", a.salariu "Salariu vechi", 
       DECODE(d.nume, 'Vanzari', TO_CHAR(a.salariu * 1.1) , 'Resurse umane', TO_CHAR(a.salariu * 1.15) , 'Comenzi', 
              TO_CHAR(a.salariu * 1.2), 'Fara marire') "Salariu nou"
FROM ANGAJAT_AVA a
JOIN DEPARTAMENT_AVA d ON (a.cod_departament = d.cod_departament);


/* 16. Sa se afiseze codul, numele si data comenzilor care au fost date in aceeasi luna in care cele
mai multe comenzi au fost date.*/

SELECT c.cod_comanda, c.nume, e.data_comanda
FROM COMANDA_AVA c
JOIN EVIDENTA_AVA e ON (e.cod_comanda = c.cod_comanda)
WHERE TO_CHAR(e.data_comanda, 'mm') = ( SELECT TO_CHAR(data_comanda, 'mm')
                                        FROM EVIDENTA_AVA
                                        GROUP BY TO_CHAR(data_comanda, 'mm')
                                        HAVING COUNT(cod_comanda) = ( SELECT MAX(COUNT(cod_comanda))
                                                                      FROM EVIDENTA_AVA
                                                                      GROUP BY TO_CHAR(data_comanda, 'mm')));

/* 17. Sa se afiseze numele, salariul, codul departamentului, salariul mediu si numarul de angajati din departamentul 
respectiv. */

SELECT d.nume, d.cod_departament, salariu_mediu, numar_angajati
FROM DEPARTAMENT_AVA d
JOIN ( SELECT cod_departament, ROUND(AVG(salariu)) salariu_mediu, COUNT(cnp) numar_angajati
       FROM angajat_ava 
       GROUP BY cod_departament) aux
       ON(d.cod_departament = aux.cod_departament);
       
/* 18. Pentru fiecare comanda, sa se afiseze numele acesteia, dar si numele si pretul celui mai ieftin produs din cadrul 
comenzii, ordonat dupa pret. */

SELECT c.nume "Nume comanda", p.nume "Nume produs", p.pret "Pret produs"
FROM COMANDA_AVA c 
JOIN EVIDENTA_AVA e ON (c.cod_comanda = e.cod_comanda)
JOIN PRODUS_AVA p ON (p.cod_produs = e.cod_produs)
WHERE (c.nume, p.pret) IN (SELECT c1.nume, MIN(p1.pret) minim
                            FROM COMANDA_AVA c1 
                            JOIN EVIDENTA_AVA e1 ON (c1.cod_comanda = e1.cod_comanda)
                            JOIN PRODUS_AVA p1 ON (p1.cod_produs = e1.cod_produs)
                            GROUP BY c1.nume)
ORDER BY 3;

/* 19. Sa se afiseze numele departamentelor si numele salariatilor care lucreaza in ele. Se vor afisa si departamentele 
care nu au salariati. (folosim RIGHT OUTER JOIN) */

SELECT a.nume "Nume angajat", d.nume "Nume departament"
FROM ANGAJAT_AVA a
RIGHT OUTER JOIN DEPARTAMENT_AVA d ON (d.cod_departament = a.cod_departament)
ORDER BY 1;

/* 20. Sa se afiseze codurile departamentelor al caror nume contine sirul 'en' sau in care lucreaza angajati 
al caror nume incepe cu 'A' */

SELECT cod_departament
FROM DEPARTAMENT_AVA 
WHERE UPPER(nume) LIKE '%EN%'
UNION
SELECT cod_departament
FROM ANGAJAT_AVA
WHERE UPPER(nume) LIKE 'A%';

       