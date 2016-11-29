/*
Question 1: Cursor Script
*/
SET SERVEROUTPUT ON;
ACCEPT p_make PROMPT 'Enter a car make: '
ACCEPT p_model PROMPT 'Enter a car model: '
ACCEPT p_year PROMPT 'Enter a car year: '

DECLARE
  CURSOR cust_cur IS
    SELECT cust.*
      FROM car
     INNER JOIN customer cust
             ON car.cName = cust.cName
     WHERE UPPER(car.make) = UPPER('&p_make') 
       AND UPPER(car.model) = UPPER('&p_model')
       AND UPPER(car.cYear) = UPPER('&p_year');


BEGIN
   DBMS_OUTPUT.PUT_LINE(
     '&p_make' || ' ' || '&p_model' || CHR(10) ||
     '&p_year' || CHR(10) || CHR(10)
   );

   FOR v_cust IN cust_cur LOOP
     DBMS_OUTPUT.PUT_LINE(
       v_cust.cName || CHR(10) ||
       v_cust.cStreet || CHR(10) ||
       TRIM(v_cust.cCity) || ' ' ||
       TRIM(v_cust.cProv) || ' ' ||
       v_cust.cPostal || CHR(10) || CHR(10)
     );
   END LOOP;
END;
/

/*
Question 2: Exception Script
*/
SET SERVEROUTPUT ON;
ACCEPT p_make PROMPT 'Enter a car make: '
ACCEPT p_model PROMPT 'Enter a car model: '

DECLARE
  ex_nocars EXCEPTION;
  ex_onecar EXCEPTION;
  v_msg VARCHAR2(255);

  CURSOR sale_cur IS
    SELECT car.make, car.model, COUNT(*) numOfCars, AVG(sale.net) avgPrice
      FROM car
     INNER JOIN saleInv sale
             ON car.serial = sale.serial
     WHERE UPPER(car.make) = UPPER('&p_make') 
       AND UPPER(car.model) = UPPER('&p_model')
     GROUP BY car.make, car.model;       
BEGIN
  FOR v_row IN sale_cur LOOP
    CASE v_row.numOfCars 
      WHEN 0 THEN
        v_msg := 'No cars are sold.';
        RAISE ex_nocars;
      WHEN 1 THEN
        v_msg := v_row.avgPrice;
        RAISE ex_onecar;
      ELSE
        DBMS_OUTPUT.PUT_LINE(
          v_row.make || ' ' ||
          v_row.model || ' ' ||
          v_row.numOfCars || ' ' ||
          v_row.avgPrice
        );
    END CASE;
  END LOOP;
EXCEPTION
  WHEN ex_nocars THEN
    DBMS_OUTPUT.PUT_LINE(v_msg);
  WHEN ex_onecar THEN
    DBMS_OUTPUT.PUT_LINE(v_msg);  
END;
/