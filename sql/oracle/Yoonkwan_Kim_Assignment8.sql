/*
  File   : Yoonkwan_Kim_Assignment8.sql
  Name   : Yoonkwan Kim
  Problem: Collections and Triggers
*/
 
/*
  A.
  Write a stored procedure which accepts a customer name as a parameter and 
  "returns" the number of cars the customer has bought and total amount of money 
  he/she has spent.
*/

CREATE OR REPLACE PROCEDURE proc_cars_spent (
  in_firstChar IN CHAR,
  in_lastChar IN CHAR
)
IS 
  CURSOR cur_cust IS
  SELECT cName, COUNT(*) AS "NUMOFCARS", SUM(totalPrice) AS "TOTALSPENT"
    FROM saleInv 
   GROUP BY cName; 
BEGIN
  DBMS_OUTPUT.PUT_LINE('Customer    ' || CHR(9) || 'NumOfCars' || CHR(9) || 'TotalAmount');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
  FOR cust IN cur_cust 
  LOOP
    IF REGEXP_LIKE(cust.cName, '^[' || in_firstChar || '-' || in_lastChar || ']{1}', 'i') THEN
      DBMS_OUTPUT.PUT_LINE(cust.cName || CHR(9) || cust.numOfCars || CHR(9) || cust.totalSpent);
    END IF;
  END LOOP;
END;
/

/* 
  A. Test Script 
*/
SET SERVEROUTPUT ON;
ACCEPT p_firstChar PROMPT 'Enter the first letter: '
ACCEPT p_lastChar PROMPT 'Enter the last letter: '

DECLARE
  v_firstChar CHAR := '&p_firstChar';
  v_lastChar CHAR := '&p_lastChar';
  exp_invalidInput EXCEPTION; 
BEGIN
  IF REGEXP_LIKE (v_firstChar, '^[a-z]{1}$', 'i') AND
     REGEXP_LIKE (v_lastChar, '^[a-z]{1}$', 'i') THEN
     
    proc_cars_spent('A', 'D');
  ELSE
    RAISE exp_invalidInput;
  END IF;
EXCEPTION
  WHEN exp_invalidInput THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Input. Please input only one letter.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
END;
/


/*
  B.
  Prepare a function to return the total number of options on a car given 
  the serial number of the car. Include both base options and invoice options.
*/

CREATE OR REPLACE FUNCTION func_num_options (
  in_serial IN VARCHAR2
)
RETURN NUMBER
IS
  v_numOptions NUMBER := 0;
  v_temp NUMBER := 0;
BEGIN
  SELECT COUNT(*)
    INTO v_temp
    FROM baseOption
   WHERE UPPER(serial) = UPPER(in_serial);
  
  v_numOptions := v_numOptions + v_temp;
  v_temp := 0;
   
  SELECT COUNT(*)
    INTO v_temp
    FROM saleInv sInv
   INNER JOIN InvOption iOpt 
           ON sInv.saleInv = iOpt.saleInv
   WHERE UPPER(sInv.serial) = UPPER(in_serial);
  
  RETURN v_numOptions + v_temp;
END;
/

/*
  B. Test Script
*/
SET SERVEROUTPUT ON;
ACCEPT p_serial PROMPT 'Enter a serial code: '

DECLARE 
  exp_invalidInput EXCEPTION;
  v_serial car.serial%TYPE := '&p_serial';
  v_make car.make%TYPE;
  v_model car.model%TYPE;
BEGIN
  if REGEXP_LIKE (v_serial, '^[a-z0-9]{8}', 'i') THEN
    SELECT make, model
      INTO v_make, v_model
      FROM car
     WHERE UPPER(serial) = UPPER(v_serial); 
    
    DBMS_OUTPUT.PUT_LINE(
      'Serial#: ' || v_serial || CHR(10) ||
      'Make: ' || v_make || CHR(10) ||
      'Model: ' || v_model || CHR(10) ||
      'Num of Options: ' || func_num_options(v_serial)
    );        
  ELSE
    RAISE exp_invalidInput;
  END IF;
EXCEPTION
  WHEN exp_invalidInput THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Input. Serial code should be 8 letters and numbers');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
END;
/

/*
  C.
  Write a trigger for the car table which:
  will convert the following to UPPER case during an INSERT or UPDATE:
  serial, make, model, color will write all data changes to a log file
  Be sure to test it by trying all three operations. Your triggers and 
  tests should work off of your own personal tables and not the s6 tables. 
  You do not have the right permissions to s6 schema.
*/

CREATE OR REPLACE TRIGGER car_before_insert_update
BEFORE INSERT OR UPDATE OF serial, make, model, color ON car
FOR EACH ROW
BEGIN
  :NEW.serial := UPPER(:NEW.serial);
  :NEW.make := UPPER(:NEW.make);
  :NEW.model := UPPER(:NEW.model);
  :NEW.color := UPPER(:NEW.color);
  
  IF INSERTING THEN
    INSERT INTO carLog
    VALUES (user, 'INSERT', SYSDATE, :NEW.serial);
  ELSIF UPDATING THEN
    INSERT INTO carLog
    VALUES (user, 'UPDATE', SYSDATE, :NEW.serial);
  END IF;

END;
/

