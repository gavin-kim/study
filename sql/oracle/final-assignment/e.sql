/*
  File   : e.sql
  Name   : Yoonkwan Kim
  Problem: Create a new sale invoice
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION func_create_sale_inv (
  in_saleInv IN VARCHAR2,
  in_cName IN VARCHAR2,
  in_salesman IN VARCHAR2,
  in_saleDate IN VARCHAR2,
  in_serial IN VARCHAR2,
  in_discount IN NUMBER,
  in_net IN NUMBER,
  in_tax IN NUMBER,
  in_licfee IN NUMBER,
  in_commission IN NUMBER,
  in_tradeserial IN VARCHAR2,
  in_tradeallow IN NUMBER,
  in_fire IN VARCHAR2,
  in_collision IN VARCHAR2,
  in_liability IN VARCHAR2,
  in_property IN VARCHAR2
)
RETURN VARCHAR2
IS
  ex_null EXCEPTION;
BEGIN
  
  IF (in_saleInv IS NOT NULL) AND (in_cName IS NOT NULL) AND
     (in_saledate IS NOT NULL) AND (in_serial IS NOT NULL) THEN 
      
    INSERT INTO saleInv
    VALUES (UPPER(in_saleInv), UPPER(in_cName), UPPER(in_salesman), 
            TO_DATE(in_saleDate, 'YYYY-MM-DD'), UPPER(in_serial), 
            NVL(in_net + in_tax, 0), NVL(in_discount, 0), NVL(in_net, 0), 
            NVL(in_tax, 0), NVL(in_licfee, 0), NVL(in_commission, 0),
            UPPER(in_tradeSerial), NVL(in_tradeAllow, 0), 
            NVL(UPPER(in_fire), 'N'), NVL(UPPER(in_collision), 'N'), 
            NVL(UPPER(in_liability), 'N'), NVL(UPPER(in_property), 'N'));
    COMMIT;        
            
    RETURN 'Sale Invoice ID: ''' || UPPER(in_saleInv) || ''' created.';
  
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

ACCEPT p_saleinv PROMPT 'Enter the Id (Required): '
ACCEPT p_cname PROMPT 'Enter the customer name (Required): '
ACCEPT p_salesman PROMPT 'Enter the sales man: '
ACCEPT p_saledate PROMPT 'Enter the sales date ''yyyy-mm-dd'' (Required): '
ACCEPT p_serial PROMPT 'Enter the car serial (Required): '
ACCEPT p_discount PROMPT 'Enter the amount of discount: '
ACCEPT p_net PROMPT 'Enter the the net: '
ACCEPT p_tax PROMPT 'Enter the the tax: '
ACCEPT p_licfee PROMPT 'Enter the license fee: '
ACCEPT p_commission PROMPT 'Enter the commission: '
ACCEPT p_tradeserial PROMPT 'Enter the trade serial: '
ACCEPT p_tradeallow PROMPT 'Enter the trade allow: '
ACCEPT p_fire PROMPT 'Fire (Y/N): '
ACCEPT p_collision PROMPT 'Liability (Y/N): '
ACCEPT p_liability PROMPT 'Collision (Y/N): '
ACCEPT p_property PROMPT 'Property Damage (Y/N): '

DECLARE
  v_result VARCHAR2(255);
BEGIN
  v_result := func_create_sale_inv('&p_saleinv', '&p_cname', '&p_salesman',
    '&p_saledate', '&p_serial', '&p_discount', '&p_net', '&p_tax', '&p_licfee',
    '&p_commission', '&p_tradeserial', '&p_tradeallow', '&p_fire', 
    '&p_collision', '&p_liability', '&p_property');
  
  DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXIT;
