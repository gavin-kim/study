/*
  File   : d.sql
  Name   : Yoonkwan Kim
  Problem: Show a vehicle information
*/

SET SERVEROUTPUT ON;

ACCEPT p_serial PROMPT 'Enter Car Serial: '

DECLARE

  CURSOR cur_car IS
  SELECT *
   FROM car
  WHERE UPPER(TRIM(serial)) = UPPER(TRIM('&p_serial'));

  CURSOR cur_bOption IS
  SELECT opt.oCode, opt.oDesc, opt.oList
    FROM car car
   INNER JOIN baseOption bOpt
           ON car.serial = bOpt.serial
   INNER JOIN options opt
           ON bOpt.oCode = opt.oCode
   WHERE UPPER(TRIM(car.serial)) = UPPER(TRIM('&p_serial'));
   
BEGIN  

  FOR car IN cur_car
  LOOP
  
    DBMS_OUTPUT.PUT_LINE(
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('VEHICLE INVENTORY RECORD', 50) || CHR(10) || 
      LPAD(' ', 80, '-') || CHR(10) ||
      RPAD('Serial No.', 20) || RPAD('Make', 20) || 
      RPAD('Model', 20) || RPAD('Year', 20) || CHR(10) ||
      RPAD(car.serial, 20) || RPAD(car.make, 20) || 
      RPAD(car.model, 20) || RPAD(car.cYear, 20) || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) ||
      RPAD('Exterior Color', 20) || RPAD('Trim', 20) || 
      RPAD('Purchased From', 20) || RPAD('Purch Invoice No.', 20) || CHR(10) ||
      RPAD(car.color, 20) || RPAD(car.trim, 20) || 
      RPAD(car.purchFrom, 20) || RPAD(car.purchInv, 20) || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) ||
      RPAD('Purchase Date', 30) || RPAD('Purchse Cost', 25) || 
      RPAD('List Base Price', 25) || CHR(10) ||
      RPAD(car.purchDate, 30) || RPAD(car.purchCost, 25) || 
      RPAD(car.listPrice, 25) || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('Optional Equpment and Accessories - Factory', 60) || 
      CHR(10) || CHR(10) ||
      RPAD('Code', 20) || RPAD('Description', 40) || RPAD('List Price', 20) 
    );
    
    FOR opt IN cur_bOption LOOP
      DBMS_OUTPUT.PUT_LINE(
        RPAD(opt.oCode, 20) || RPAD(opt.oDesc, 40) || RPAD(opt.oList, 20)
      );
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(LPAD(' ', 80, '-'));

  END LOOP;
END;
/

EXIT;
