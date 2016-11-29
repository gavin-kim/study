/*
Create the first script which prompts for the name of a salesman and finds out how many cars he/she has sold. 
Use an IF or CASE statement to display three different messages based on the outcome. 
If the result is greater than 1, display something like "JACK SPRATT has sold 27 cars", 
if the result is zero display something like "JOHN JOHNSON has sold no cars", and 
if the result is one display something like "SAM SLICKER has sold only one car".
Hint: As you know the salesman name is kept in the saleinv. 
Remember that all salesman names are written in uppercase as they are a foreign key to employee table.
*/

SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT p_salesman PROMPT 'Enter the name of a salesman: '

DECLARE
  v_salesman saleInv.salesman%TYPE;
  v_count NUMBER(10);
  v_result VARCHAR2(255);
BEGIN
  SELECT emp.empName, COUNT(*)
    INTO v_salesman, v_count
    FROM saleInv sale
   INNER JOIN employee emp 
           ON sale.salesman = emp.empName   
   WHERE UPPER(emp.empName) = UPPER('&p_salesman')
   GROUP BY emp.empName; 
   
   IF (v_count > 1) THEN
     v_result := v_count || ' cars';
   ELSIF (v_count = 1) THEN
     v_result := 'onle one car';
   ELSE
     v_result := 'no cars';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE(TRIM(v_salesman) || ' has sold ' || v_result);
   
END;
/

/*
Create a second script to input a servinv # and print the service information coresponding to that servinv.
Hint: Use one of methods described in this module to declare the variables and assign values to them using 
an SQL statement. Then, concatenate those values for easy printing.
*/

SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT p_servInv PROMPT 'Enter service invoice #: '

DECLARE
  v_servInv servInv%ROWTYPE;
BEGIN
  SELECT *
    INTO v_servInv
    FROM servInv
   WHERE UPPER(servInv.servInv) = UPPER('&p_servInv');
   
   DBMS_OUTPUT.PUT_LINE(
     'Service #:     ' || v_servInv.servInv || CHR(10) || 
     'Service Date:  ' || v_servInv.serDate || CHR(10) ||
     'Customer Name: ' || v_servInv.cName || CHR(10) ||
     'Serial:        ' || v_servInv.serial || CHR(10) ||
     'Parts Cost:    ' || v_servInv.partsCost || CHR(10) ||
     'Labor Cost:    ' || v_servInv.laborCost || CHR(10) ||
     'Tax:           ' || v_servInv.tax || CHR(10) ||
     'Total Cost:    ' || v_servInv.totalCost || CHR(10));
    
END;
/
 select * from servinv;



/*
Create a third script for changing customer names in the database. The script will prompt the user for the existing customer name, 
then prompts again for the new name and successfully changes that customer's name in the database.
Hint: Remember that customer table is connected through foreign key constraints with four tables: car, saleinv, servinv and prospect. 
Therefore all those tables need to be also updated when you change the value of the primary key in the car table.
*/

ACCEPT p_oldName PROMPT 'Enter existing customer name: '
ACCEPT p_newName PROMPT 'Enter a new customer name: '

DECLARE 

BEGIN
  INSERT INTO customer
  SELECT '&p_newName', cStreet, cCity, cProv, cPostal, chPhone, cbPhone
    FROM customer
   WHERE UPPER(cname) = UPPER('&p_oldName'); 
          
  UPDATE car
     SET cname = '&p_newName'
   WHERE UPPER(cname) = UPPER('&p_oldName');
   
  UPDATE saleInv
     SET cname = '&p_newName'
   WHERE UPPER(cname) = UPPER('&p_oldName');
   
   
  UPDATE servInv
     SET cname = '&p_newName'
   WHERE UPPER(cname) = UPPER('&p_oldName');
   
   
  UPDATE prospect
     SET cname = '&p_newName'
   WHERE UPPER(cname) = UPPER('&p_oldName');
   
   
  DELETE FROM customer
   WHERE UPPER(cname) = UPPER('&p_oldName');
END;
/

