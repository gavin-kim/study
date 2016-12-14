/*
  File   : a.sql
  Name   : Yoonkwan Kim
  Problem: Create a new customer
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION func_create_customer (
  in_cName VARCHAR2,
  in_cStreet VARCHAR2,
  in_cCity VARCHAR2,
  in_cProv VARCHAR2,
  in_cPostal VARCHAR2,
  in_chPhone VARCHAR2,
  in_cbPhone VARCHAR2
)
RETURN VARCHAR2
IS
  ex_null EXCEPTION;
BEGIN
  
  IF (in_cname IS NOT NULL) AND (in_cstreet IS NOT NULL) AND
     (in_ccity IS NOT NULL) AND (in_cprov IS NOT NULL) THEN 
      
    INSERT INTO customer
    VALUES (UPPER(in_cName), UPPER(in_cStreet), UPPER(in_cCity), 
            UPPER(in_cProv), UPPER(in_cPostal), in_chPhone, in_cbPhone);
    COMMIT;                    
    RETURN 'Customer Name: ''' || UPPER(in_cName) || ''' created.';
  
  ELSE 
    RAISE ex_null;    
  END IF;     
  
EXCEPTION
  WHEN ex_null THEN
    RETURN 'Required Fields can not be Null';
  WHEN OTHERS THEN
    RETURN 'Exception occured: ' || SQLERRM(SQLCODE);
END;
/

ACCEPT p_cName PROMPT 'Customer Name (Required): '
ACCEPT p_cStreet PROMPT 'Street (Required): '
ACCEPT p_cCity PROMPT 'City (Required): '
ACCEPT p_cProv PROMPT 'Province (Required): '
ACCEPT p_cPostal PROMPT 'Postal: '
ACCEPT p_chPhone PROMPT 'Home Phone: '
ACCEPT p_cbPhone PROMPT 'Mobile Phone: '

DECLARE
  v_result VARCHAR2(255) := 'Failed';
BEGIN
  v_result := func_create_customer('&p_cName', '&p_cStreet', '&p_cCity',
              '&p_cProv', '&p_cPostal', '&p_chPhone', '&p_cbPhone');
  
  DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXIT;

