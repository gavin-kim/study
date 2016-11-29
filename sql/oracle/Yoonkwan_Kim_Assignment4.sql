/*
  File   : Yoonkwan_Kim_Assignment4.sql
  Name   : Yoonkwan Kim
  Problem: SELECT query
*/

/*
1. Print the total amount, the average dollar value of service visits and
   the number of those visits for Acara, Mercedes and Jaguar car makes
   that are sold between January 2016 and September 2016 inclusive (5 marks).
*/
SELECT car.make, SUM(serv.totalCost), ROUND(AVG(serv.totalCost), 2),
       COUNT(*) AS "Number of visits"
  FROM s6.car car
 INNER JOIN s6.servInv serv
         ON car.serial = serv.serial
 WHERE TO_CHAR(serv.serDate, 'YYYY') = '2016'
   AND TO_CHAR(serv.serDate, 'MM') >= 1
   AND TO_CHAR(serv.serDate, 'MM') <= 9
 GROUP BY car.make
HAVING UPPER(car.make) IN ('ACURA', 'MERCEDES', 'JAGUAR');

/*
2. Print a list of available sales persons names who have sold more than 20 cars.
   Display the number of cars they have sold. (4 marks)
*/
SELECT emp.empName, count(*) AS "Number of cars"
  FROM s6.employee emp
 INNER JOIN s6.saleInv sale
         ON emp.empName = sale.salesMan
 GROUP BY emp.empName
HAVING count(*) > 20;

/*
3. List the names of all customers who purchased cars with some type of radio.
   (Description has 'RADIO' in it) (6 marks).
    Note: Keep in mind that ‘RADIO’ can be a baseoption or an optional option
   (invoption), therefore you need to use UNION to bring rows from the two
   different selections.
*/
SELECT sale.cName
  FROM s6.saleInv sale
 INNER JOIN s6.baseOption baseOptR
         ON sale.serial = baseOptR.serial
 INNER JOIN s6.options baseOpt
         ON baseOptR.oCode = baseOpt.oCode
 WHERE UPPER(baseOpt.oDesc) LIKE '%RADIO%'

UNION

SELECT sale.cName
  FROM s6.saleInv sale
 INNER JOIN s6.invOption invOptR
         ON sale.saleInv = invOptR.saleInv
 INNER JOIN s6.options invOpt
         ON invOptR.oCode = invOpt.oCode
 WHERE UPPER(invOpt.oDesc) LIKE '%RADIO%';



/*
4. List serial, make, model of all 2016 cars that are not sold.
   Add (ocode, odesc, olist) if they have options (6 marks).
    This query does not need the invoption table because we are looking for
   new unsold cars that cannot have extra invoice options.
   Remember, cars are not sold if they have a null in car.cname.
    The options table must also be joined. Be sure to also to use OUTER JOIN-s
   on the tables field so that if there is a car with no baseoption records
   it will be shown although the values for the options will be null.
*/
SELECT car.serial, car.make, car.model, opt.oCode, opt.oDesc, opt.oList
  FROM s6.car car
  LEFT JOIN s6.baseOption baseOpt
         ON car.serial = baseOpt.serial
  LEFT JOIN s6.options opt
         ON baseOpt.oCode = opt.oCode
 WHERE car.cName IS NULL
   AND car.cYear = '2016';


/*
5. Who are the customers living in Oakville who have spent $10000 or
   more on services? Include the sum of the totalcost-s in the select.
   Display the results in descending order of the total amount spent (6 marks).
    A car may have been serviced multiple times so be sure to group
   by the appropriate fields.
*/
SELECT serv.cName, cust.cCity, SUM(serv.totalCost)
  FROM s6.servInv serv
 INNER JOIN s6.customer cust
         ON serv.cName = cust.cName
 WHERE UPPER(cust.cCity) = 'OAKVILLE'
 GROUP BY serv.cName, cust.cCity
HAVING SUM(serv.totalCost) > 10000
 ORDER BY SUM(serv.totalCost) DESC;


/*
6. List the name, address and home phone of customers interested in any cars
   that are available for sale in the lot (unsold). Match on make, model,
   year and color. Include the matching criteria in the output (5 marks).
    Those interested in cars are listed in the prospect table. Here you join
   tables based on criteria that are not part of the keys, i.e. non-key fields.
   Join criteria do not have to be primary keys but simply a common field
   between the two tables.
*/
SELECT DISTINCT cust.cName, cust.cStreet, cust.cCity, cust.cProv, cust.cPostal,
       cust.chPhone
  FROM s6.customer cust
 INNER JOIN s6.prospect pros
         ON cust.cName = pros.cName
 INNER JOIN s6.car car
         ON pros.make = car.make
        AND pros.model = car.model
        AND pros.cYear = car.cYear
        AND pros.color = car.color
 WHERE car.cName IS NULL;

