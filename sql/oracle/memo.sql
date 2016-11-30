
/* Server prints output */
SET SERVEROUTPUT ON;    

/* Declare a global variable */
VARIABLE g_var VARCHAR2(1000) 

/* Print the global variable */ 
PRINT g_var                  

/* Cursor and Loop */
DECLARE
    CURSOR var_cur IS         
    SELECT ……                 
BEGIN
    OPEN var_cur;         
        LOOP             
            FETCH var_cur INTO col1, col2;
            EXIT WHEN var_cur%NOTFOUND;
        END LOOP;
    CLOSE var_cur;       
END;
/

/* Cursor variable conditaions */
v_value%FOUND     : true, a row exists
v_value%NOTFOUND; : true, no more row
v_value%ISOPEN;   : always return false for implicit cursors
v_value%ROWCOUNT; : number of row

/* For Loop */
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

/* Case */
CASE var
    WHEN ‘value1’ THEN 
        Do something;
    WHEN ‘value2’ THEN
        Do something;
    ELSE
        Do something else;
END CASE;


/* Make Exception and Catch */
DECLARE
    exp_toomany EXCEPTION;
BEGIN
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

/* Exception Code and Messge */
SQLCODE          : it has an error code. It starts from 0 and when an error occurs it gets error code
SQLERRM(SQLCODE) : show error message 

/* Declare and Initialize custom exception */
ex_noname EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_noname, -1311(error_code));  initialize personal exception;

/* Create Procedure */
CREATE OR REPLACE PROCEDURE procedure1 (
    param_id VARCHAR2 := ‘0’,
    param_name VARCHAR2
    param_value1 IN      /* can be a value     */
    param_value2 OUT     /* must be a variable */ 
    param_value3 IN OUT  /* must be a variable	*/
)
AS
BEGIN
    DMBS_OUTPUT.PUT_LINE(pl_id || ‘ ‘ || pl_name);
END;
/

/* Call Procedure */
CALL procedure1(‘myId’, pl_name => ‘kim’);

/* Create Function */
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
  RETURN v_total; /* return value */
END;
/
