/*
  File   : c.sql
  Name   : Yoonkwan Kim
  Problem: Create a new vehicle inventory record
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION func_create_car (
  in_serial VARCHAR2,
  in_cname VARCHAR2,
  in_make VARCHAR2,
  in_model VARCHAR2,
  in_cyear VARCHAR2,
  in_color VARCHAR2,
  in_trim VARCHAR2,
  in_enginetype VARCHAR2,
  in_purchinv VARCHAR2,
  in_purchdate DATE,
  in_purchfrom VARCHAR2,
  in_purchcost NUMBER,
  in_freightcost NUMBER,
  in_totalcost NUMBER,
  in_listprice NUMBER
)
RETURN VARCHAR2
IS
  ex_null EXCEPTION;
BEGIN
  
  IF (in_serial IS NULL) OR (in_make IS NULL) OR (in_model IS NULL) OR 
     (in_cYear IS NULL) OR (in_color IS NULL) OR (in_trim IS NULL) OR 
     (in_engineType IS NULL) THEN 
    RAISE ex_null;
  ELSE 
    INSERT INTO car
    VALUES (UPPER(in_serial), UPPER(in_cname), UPPER(in_make), UPPER(in_model), 
            UPPER(in_cyear), UPPER(in_color), UPPER(in_trim), 
            UPPER(in_enginetype), UPPER(in_purchinv), 
            TO_DATE(in_purchdate, 'yyyy-mm-dd'), UPPER(in_purchfrom), 
            NVL(in_purchcost, 0), NVL(in_freightcost, 0),
            NVL(in_totalcost, 0), NVL(in_listprice, 0)
    );
    COMMIT;                    
    RETURN 'Car Serial: ''' || UPPER(in_serial) || ''' created.';    
  END IF;     
  
EXCEPTION
  WHEN ex_null THEN
    RETURN 'Required Fields can not be Null';
  WHEN OTHERS THEN
    RETURN 'Exception occured: ' || SQLERRM(SQLCODE);
END;
/

ACCEPT p_serial PROMPT 'Car Serial (Required): '
ACCEPT p_make PROMPT 'Make (Required): '
ACCEPT p_model PROMPT 'Model (Required): '
ACCEPT p_cyear PROMPT 'Year (Required): '
ACCEPT p_color PROMPT 'Color (Required): '
ACCEPT p_trim PROMPT 'Trim (Required): '
ACCEPT p_enginetype PROMPT 'Engine (Required): '
ACCEPT p_purchInv PROMPT 'Purchase Invoice: '
ACCEPT p_purchDate PROMPT 'Purchase Date (YYYY-MM-DD): '
ACCEPT p_purchFrom PROMPT 'Purchase From: '
ACCEPT p_purchcost PROMPT 'Purchase Cost: '
ACCEPT p_freightcost PROMPT 'Freight Cost: '
ACCEPT p_totalcost PROMPT 'Total Cost: '
ACCEPT p_listprice PROMPT 'List Price: '

DECLARE
  v_result VARCHAR2(255) := 'Failed';
BEGIN
  v_result := func_create_car(
    '&p_serial', NULL, '&p_make', '&p_model', '&p_cyear', '&p_color', 
    '&p_trim', '&p_enginetype', '&p_purchInv', '&p_purchDate', '&p_purchFrom',
    '&p_purchCost', '&p_freightcost', '&p_totalCost', '&p_listPrice'
    );
  
  DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXIT;
