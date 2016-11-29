/*
  File   : Yoonkwan_Kim_Assignment5.sql
  Name   : Yoonkwan Kim
  Problem: Create VIEW and SELECT query
*/

/*
Create a VIEW which includes the customer name and city, the car make and model,
the service invoice number and date along with the total value of each invoice
*/
CREATE OR REPLACE VIEW servInv_total AS

SELECT cust.cName, cust.cCity, car.make, car.model,
       serv.servInv, serv.serDate, SUM(serv.totalCost) AS "total"
  FROM s6.servInv serv
 INNER JOIN s6.customer cust
         ON serv.cName = cust.cName
 INNER JOIN s6.car car
         ON serv.serial = car.serial
 GROUP BY cust.cName, cust.cCity,car.make, car.model,
          serv.servInv, serv.serDate;

/*
 0. Show the name, service date and the amount spent on each service visit
    by the customer named John Doe
 */
SELECT cName, serDate, "total"
  FROM servInv_total
 WHERE UPPER(cName) = 'JOHN DOE';

/*
 1. How many customers from each different city do we have in the database?
 */
SELECT UPPER(cCity), COUNT(*)
  FROM servInv_total
 GROUP BY UPPER(cCity);

/*
 2. Show the total amount of money the customer John Doe has spent for services.
 */
SELECT cName, SUM("total")
  FROM servInv_total
 WHERE UPPER(cName) = 'JOHN DOE'
 GROUP BY cName;


/*
 3. Show the car make and model, the service invoice number, date and
    totalcost of each service visit of all customers from Burlington.
 */
SELECT make, model, servInv, serDate, "total"
  FROM servInv_total
 WHERE UPPER(cCity) = 'BURLINGTON';

/*
 4. How much is the total spending of the customers from Brampton?
 */
SELECT UPPER(cCity), SUM("total")
  FROM servInv_total
 WHERE UPPER(cCity) = 'BRAMPTON'
 GROUP BY UPPER(cCity);



/*
 5. What is the average of the amount spent by customers from Mississauga?
 */
SELECT cName, ROUND(AVG("total"), 2)
  FROM servInv_total
 WHERE UPPER(cCity) = 'MISSISSAUGA'
 GROUP BY cName;

/*
 6. How many customers from Toronto have brought their car for service?
 */
SELECT UPPER(cCity), COUNT(*)
  FROM servInv_total
 WHERE UPPER(cCity) = 'TORONTO'
 GROUP BY UPPER(cCity);

/*
 7. How many customers have spent more than $5000 on service?
 */
SELECT COUNT(*)
  FROM servInv_total
 WHERE "total" > 5000;

/*
 8. What is the average amount spent for the services of JAGUAR cars
 */
SELECT ROUND(AVG("total"), 2)
  FROM servInv_total
 WHERE UPPER(make) = 'JAGUAR';

/*
 9. Show the total amount of spending on services for different car makes
 */
SELECT make, SUM("total")
  FROM servInv_total
 GROUP BY make;

