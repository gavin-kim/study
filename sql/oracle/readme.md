# PL SQL for Oracle

SET SERVEROUTPUT ON;    // server prints output


VARIABLE g_var VARCHAR2(1000) // Declare a global variable
PRINT g_var                   // Print the global variable 


DECLARE
    CURSOR var_cur IS    >// Declare cursor variable
    SELECT ……            // store select result
BEGIN
    OPEN var_cur;        // open cursor 
        LOOP             // loop
            FETCH var_cur INTO col1, col2;
            EXIT WHEN var_cur%NOTFOUND;
        END LOOP;
    CLOSE var_cur;       // close cursor
END;
/

v_value%FOUND     : true, a row exists
v_value%NOTFOUND; : true, no more row
v_value%ISOPEN;   : always return false for implicit cursors
v_value%ROWCOUNT; : number of row


BEGIN 
    FOR v_row IN var_cur LOOP     // use for loop
        DBMS_OUTPUT.PUT_LINE(v_row.col1 || ‘, ‘ || v_row.col2);
    END LOOP;
END;
/

/* If statement */

IF (expression) THEN
ELSIF (expression) THEN
ELSE
END IF

CASE var
    WHEN ‘value1’ THEN 
        Do something;
    WHEN ‘value2’ THEN
        Do something;
    ELSE
        Do something else;
END CASE;

DECLARE
    exp_toomany EXCEPTION;
BEGIN
    …
    …
   RAISE exp_toomany;  throw a exception named “exp_toomany”
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        Do something;
    WHEN exp_toomany THEN
        Do something;
    WHEN OTHERS THEN
        ROLLBACK WORK;
END;
/

SQLCODE          : it has an error code. It starts from 0 and when an error occurs it gets error code
SQLERRM(SQLCODE) : show error message 

ex_noname EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_noname, -1311(error_code));  initialize personal exception;

CREATE OR REPLACE PROCEDURE procedure1 (
    param_id VARCHAR2 := ‘0’,
    param_name VARCHAR2
    param_value1 IN     // can be a value
    param_value2 OUT    // must be a variable  
    param_value3 IN OUT // must be a variable	
)
AS
BEGIN
    DMBS_OUTPUT.PUT_LINE(pl_id || ‘ ‘ || pl_name);
END;
/
CALL procedure1(‘myId’, pl_name => ‘kim’);

CREATE OR REPLACE FUNCTION getTotalDiscounts(
  param_date IN VARCHAR2
)
RETURN NUMBER
AS
  v_total NUMBER;
BEGIN
  SELECT SUM(discount)
    INTO v_total
    FROM saleInv
   WHERE saleDate > param_date; 
  RETURN v_total;
END;
/
