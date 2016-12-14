/*
  File   : f.sql
  Name   : Yoonkwan Kim
  Problem: Show a sale invoice
*/


SET SERVEROUTPUT ON;

ACCEPT p_saleInv PROMPT 'Enter Sale invoice ID: '

DECLARE

  CURSOR cur_saleInv IS
  SELECT sInv.saleInv, sInv.saleDate,
         cust.cName, cust.cStreet, cust.cCity, cust.cProv, cust.cPostal, 
         cust.cHphone, sInv.salesMan,
         car.serial, car.make, car.model, car.cYear, car.color,
         sInv.fire, sInv.liability, sInv.collision, sInv.property,
         sInv.totalPrice, sInv.tradeAllow, sInv.discount, sInv.net, sInv.Tax, 
         (sInv.net + sInv.tax) AS "PAYABLE"
   FROM saleInv sInv
  INNER JOIN customer cust 
          ON sInv.cName = cust.cName
  INNER JOIN car car   
          ON sInv.serial = car.serial
  WHERE UPPER(TRIM(sInv.saleInv)) = UPPER(TRIM('&p_saleInv'));

  CURSOR cur_options IS
  SELECT iOpt.oCode, opt.oDesc, iOpt.salePrice
    FROM saleInv sInv
   INNER JOIN invOption iOpt
           ON sInv.saleInv = iOpt.saleInv
   INNER JOIN options opt
           ON iOpt.oCode = opt.oCode
   WHERE UPPER(TRIM(sInv.saleInv)) = UPPER(TRIM('&p_saleInv'));
   
  CURSOR cur_trade_in IS
  SELECT car.serial, car.make, car.model, car.cYear, sInv.tradeAllow
    FROM saleInv sInv
   INNER JOIN car car
           ON sInv.tradeserial = car.serial
   WHERE UPPER(TRIM(sInv.saleInv)) = UPPER(TRIM('&p_saleInv'));

BEGIN  

  FOR sInv IN cur_saleInv
  LOOP
  
    DBMS_OUTPUT.PUT_LINE(
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('SALES INVOICE', 45) || CHR(10) || LPAD(' ', 80, '-') || CHR(10) ||
      RPAD('Invoice No: ' || sInv.saleInv, 40) || 
      RPAD('Date: ' || sInv.saleDate, 40) || CHR(10) || CHR(10) ||
      RPAD('SOLD TO: ', 10) || LPAD('NAME: ', 10) || sInv.cName || CHR(10) ||
      LPAD('Address: ', 20) || sInv.cStreet || CHR(10) ||
      LPAD('City: ', 20) || sInv.cCity || CHR(10) ||
      LPAD('State: ', 20) || sInv.cProv || CHR(10) ||
      LPAD('Postal: ', 20) || sInv.cPostal || CHR(10) ||
      LPAD('Phone: ', 20) || sInv.chPhone || CHR(10) ||
      LPAD('Salesman: ', 20) || sInv.salesman || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) ||
      RPAD('Serial', 15) || RPAD('Make', 15) || RPAD('Model', 15) || 
      RPAD('Year', 15) || RPAD('Color', 15) || CHR(10) ||
      RPAD(sInv.serial, 15) || RPAD(sInv.make, 15) || RPAD(sInv.model, 15) ||
      RPAD(sInv.cYear, 15) || RPAD(sInv.color, 15) || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('Insurance Coverage Includes', 50) || CHR(10) || CHR(10) ||
      LPAD('Fire and Theft ', 20) || 
      RPAD('[' || sInv.fire || ']', 20) ||
      RPAD('Liability      ', 20) || 
      RPAD('[' || sInv.liability || ']', 20) || CHR(10) ||
      LPAD('Collision      ', 20) || 
      RPAD('[' || sInv.collision || ']', 20) ||
      RPAD('Property Damage', 20) || 
      RPAD('[' || sInv.property || ']', 20) || CHR(10) ||
      LPAD(' ', 80, '-') || CHR(10) || 
      LPAD('Options', 42) || CHR(10) || CHR(10) ||
      RPAD('Code', 25) || RPAD('Description', 30) || RPAD('Price', 25)
    );
    
    FOR opt IN cur_options LOOP
      DBMS_OUTPUT.PUT_LINE(
        RPAD(opt.oCode, 25) || RPAD(opt.oDesc, 30) || RPAD(opt.salePrice, 25)
      );
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( 
      LPAD(' ', 80, '-') || CHR(10) || LPAD('Trade-In', 43) || 
      CHR(10) || CHR(10) ||
      RPAD('Serial', 15) || RPAD('Make', 15) || RPAD('Model', 15) || 
      RPAD('Year', 15) || RPAD('Color', 15)
    );
    
    FOR trade IN cur_trade_in LOOP
      DBMS_OUTPUT.PUT_LINE(
        RPAD(trade.serial, 15) || RPAD(trade.make, 15) || 
        RPAD(trade.model, 15) || RPAD(trade.cYear, 15) || 
        RPAD(trade.tradeAllow, 15)
      );
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(
      LPAD(' ', 80, '-') || CHR(10) ||
      LPAD('Total Price: ', 25) || sInv.totalPrice || CHR(10) ||
      LPAD('Trade-In Allowance: ', 25) || sInv.tradeAllow || CHR(10) ||
      LPAD('Discount: ', 25) || sInv.discount || CHR(10) ||
      LPAD('Net: ', 25) || sInv.net || CHR(10) ||
      LPAD('Taxes: ', 25) || sInv.tax || CHR(10) ||
      LPAD('Total Payable: ', 25) || sInv.payable || CHR(10) ||
      LPAD(' ', 80, '-')
    );
    
  END LOOP;
END;
/
EXIT;
