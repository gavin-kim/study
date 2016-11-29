/*
  File   : Yoonkwan_Kim_Assignment3.sql
  Name   : Yoonkwan Kim
  Problem: SELECT query
 */


/*
  1. How many vehicles were sold with full insurance coverage
     (fire, collision, liability, property)? (2marks)
*/
SELECT count(*)
  FROM s6.saleInv sale
 WHERE sale.fire = 'Y'
   AND sale.collision = 'Y'
   AND sale.liability = 'Y'
   AND sale.property = 'Y';

/*
  2. Show all customer information for people that are interested in buying
     a car with a sun roof. Arrange the result in descending name order.
     The result must not have duplicates.
     (There are three different sun roofs available; see options - 4 marks).
*/
SELECT DISTINCT cust.*
  FROM s6.customer cust
 INNER JOIN s6.prospect pros
         ON cust.cName = pros.cName
 INNER JOIN s6.options opt
         ON pros.oCode = opt.oCode
 WHERE UPPER(opt.oCode) = 'S22'
    OR UPPER(opt.oCode) = 'S23'
    OR UPPER(opt.oCode) = 'S54'
    OR UPPER(opt.oCode) = 'S88'
 ORDER BY cust.cName DESC;

/*
  3. List the names and home phone numbers of customers who purchased
     (not who own) ACURA RSX and who live in Brampton (5 marks).
*/
SELECT cust.cName, cust.chPhone
  FROM s6.customer cust
 INNER JOIN s6.saleInv sale
         ON cust.cName = sInv.cName
 INNER JOIN s6.car car
         ON sale.serial = car.serial
 WHERE UPPER(car.make) = 'ACURA'
   AND UPPER(car.model) = 'RSX'
   AND UPPER(cust.cCity) = 'BRAMPTON';


/*
  4. What is the average cost of service visits of 2013 Acura make cars?
     Round the result to 2 decimal places (4 marks).
*/
SELECT ROUND(AVG(serv.totalCost), 2) AS "Average cost of 2013 Acura"
  FROM s6.servInv serv
 INNER JOIN s6.car car
         ON serv.serial = car.serial
 WHERE UPPER(car.make) = 'ACURA'
   AND TO_CHAR(serv.serDATE, 'YYYY') = '2013';

/*
  5. Write the most effective query that produces the list with names and
     phone numbers of all customers who have purchased (not who owns) a car
     from us but have never come in for servicing. (No duplicates - 4 marks).
*/
SELECT cust.cName, cust.CHPHONE,
  FROM s6.customer cust
 INNER JOIN s6.saleInv sale
         ON cust.cName = sale.cName
  LEFT JOIN s6.servInv serv
         ON cust.cName = serv.cName
 WHERE serv.cName IS NULL;

/*
  6. Show the customer name, the amount spent, the make and model of the car
     of the person who has spent the most amount of money during one single
     service visit. (3 marks)
*/
SELECT cust.cName, serv.totalCost, car.make, car.model
  FROM s6.servInv serv
 INNER JOIN s6.customer cust
         ON serv.cName = cust.cName
 INNER JOIN s6.car
         ON serv.serial = car.serial
 WHERE serv.totalCost = (SELECT MAX(totalCost)
                           FROM s6.servInv);

/*
  7. Print in a formatted mailing label, the name, full address, car make and
     model of the person(s) who purchased the least expensive car from us.
     (5 marks)
*/
SELECT TRIM(cust.cName) || CHR(10) ||
       TRIM(cust.cStreet) || CHR(10) ||
       TRIM(cust.cCity) || ', ' ||
       TRIM(cust.cProv) || ' ' ||
       TRIM(cust.cPostal) || CHR(10) ||
       TRIM(car.make) || ', ' || TRIM(car.model)
    AS "Mailing Label"
  FROM s6.customer cust
 INNER JOIN s6.saleInv sale
         ON cust.cName = sale.cName
 INNER JOIN s6.car
         ON sale.serial = car.serial
 WHERE sale.totalPrice = (SELECT MIN(totalPrice)
                            FROM s6.saleInv);
