/*
  File   : b.sql
  Name   : Yoonkwan Kim
  Problem: Show customer information
*/

SET SERVEROUTPUT ON;

ACCEPT p_cName PROMPT 'Enter a customer name: '

DECLARE
  CURSOR cur_cust IS
  SELECT *
    FROM customer cust
   WHERE UPPER(TRIM(cust.cName)) = UPPER(TRIM('&p_cName'));
BEGIN
  
  FOR cust IN cur_cust LOOP
    DBMS_OUTPUT.PUT_LINE(
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('CUSTOMER INFOMATION', 45) || CHR(10) || CHR(10) ||
      'Name:    ' || cust.cNAME || CHR(10) ||
      'Address: ' || cust.CSTREET || CHR(10) ||
      'City:    ' || cust.CCITY || CHR(10) ||
      'State:   ' || cust.CPROV || CHR(10) || 
      'Postal:  ' || cust.CPOSTAL || CHR(10) ||
      'Phone:   ' || cust.CHPHONE || CHR(10) ||
      LPAD(' ', 80, '-')
    );
  END LOOP;
 
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(
      'Customer Name: ''' || '&p_cName' || ''' doesn''t exist.'
    );
END;
/
EXIT;
