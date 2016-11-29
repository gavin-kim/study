/*
 * File   : Yoonkwan_Kim_Assignment2.sql
 * Name   : Yoonkwan Kim
 * Problem: Insert data
 * Date   : Sep 27 2016
 */

INSERT INTO s6.customer 
VALUES ('Kim', '284 Nottingham Dr.', 'Oakville', 'ON', 'L6H4H9', '(639)571-4688', 
        '(639)571-4688');

INSERT INTO s6.customer
VALUES ('Oliver', '1323 Homer St.', 'Vancouver', 'BC', 'G3G6R1', '(778)929-6391',
        '(778)929-6391');
        
INSERT INTO s6.car
VALUES ('J13BXES0', 'Kim', 'JAGUAR', 'XE R', '2013', 'Black', 'Brown', 
        '3.0L V6', null, null, null, null, null, null, null);
        
INSERT INTO s6.car
VALUES ('M14WAMG0', 'Oliver','MERCEDES', 'AMG S65', '2014', 'White', 'White', 
        'V12', null, null, null, null, null, null, null);
        
INSERT INTO s6.car
VALUES ('A14WAMG0', null, 'ACURA', 'MDX', '2015', 'Black', 'Black', 
        '3.6L V6', null, TO_DATE('14-09-09', 'YY-MM-DD'), 'ACURA', 
        25000.00, 0.00, 25000.00, 30000.00);

INSERT INTO s6.baseOption
VALUES ('A14WAMG0', 'CD2');

INSERT INTO s6.baseOption
VALUES ('A14WAMG0', 'ED3');

INSERT INTO s6.saleInv
VALUES ('I' || TO_CHAR(s6.saleInv_seq.NEXTVAL, 'FM00000'), 'Kim', 'ADAM ADAMS', 
        TO_DATE('15-12-12', 'YY-MM-DD'), 'A14WAMG0', 30000.00, 3000.00, 
        27000.00, 27000.00 * 0.13, 150.00, 27000.00 * 0.1, 'J13BXES0', 15000.00, 
        'Y', 'Y', 'Y', 'Y');

UPDATE s6.car
   SET cName = 'KIM'
 WHERE serial = 'A14WAMG0';

UPDATE s6.car
   SET cName = null,
       purchInv = 'P12345',
       purchDate = TO_DATE('15-12-12', 'YY-MM-DD'),
       purchFrom = 'Kim',
       freightCost = 0.00,
       totalCost = 15000.00,
       listPrice = 15000.00 * 1.1
 WHERE serial = 'J13BXES0';
 
INSERT INTO s6.invOption
VALUES ('I' || TO_CHAR(s6.saleInv_seq.CURRVAL, 'FM00000'), 'S88', 490.99);

INSERT INTO s6.invOption
VALUES ('I' || TO_CHAR(s6.saleInv_seq.CURRVAL, 'FM00000'), 'SD1', 488.00);

INSERT INTO s6.prospect
VALUES ('Kim', 'MERCEDES', 'SL', '2016', 'Silver', null, 'S88');

INSERT INTO s6.prospect
VALUES ('Oliver', 'MERCEDES', 'S-Class', '2016', 'Black', null, 'S88');

INSERT INTO s6.servInv
VALUES (TO_CHAR(s6.servInv_seq.NEXTVAL, 'FM0000'), TO_DATE('15-09-09', 'YY-MM-DD'),
        'Oliver', 'M14WAMG0', 5000.00, 1000.00, 6000.00 * 0.13, 6000 * 1.13); 

INSERT INTO s6.servWork
VALUES (TO_CHAR(s6.servInv_seq.CURRVAL, 'FM0000'), 'Repaired wheels');
      
INSERT INTO s6.servInv
VALUES (TO_CHAR(s6.servInv_seq.NEXTVAL, 'FM0000'), TO_DATE('15-12-12', 'YY-MM-DD'),
        'Oliver', 'M14WAMG0', 4200.00, 500.00, 4700.00 * 0.13, 4700 * 1.13); 
        
INSERT INTO s6.servWork
VALUES (TO_CHAR(s6.servInv_seq.CURRVAL, 'FM0000'), 'Repaired a sound system');
        
COMMIT;