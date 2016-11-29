/*
 * File   : Yoonkwan_Kim_A1.sql
 * Name   : Yoonkwan Kim
 * Problem: Creating tables
 */

DROP SEQUENCE saleInv_seq;
DROP SEQUENCE servInv_seq;
DROP TABLE invOption;
DROP TABLE saleInv;
DROP TABLE servWork;
DROP TABLE servInv;
DROP TABLE baseOption;
DROP TABLE car;
DROP TABLE prospect;
DROP TABLE options;
DROP TABLE customer;
DROP TABLE employee;


CREATE TABLE employee (
  empName       CHAR(20),
  startDate     DATE 
                CONSTRAINT startDate_nn NOT NULL,
  manager       CHAR(20) 
                CONSTRAINT employee_manager_ref REFERENCES employee(empName),
  commissionRate NUMBER(2, 0),
  title         CHAR(26),
  
  CONSTRAINT employee_pk PRIMARY KEY (empName)
);


CREATE TABLE customer (
  cName   CHAR(20),
  cStreet CHAR(20) 
          CONSTRAINT customer_cStreet_nn NOT NULL,
  cCity   CHAR(20) 
          CONSTRAINT customer_cCity_nn NOT NULL,
  cProv   CHAR(20) 
          CONSTRAINT customer_cProv_nn NOT NULL,
  cPostal CHAR(10),
  cHphone CHAR(13),
  cBphone CHAR(13),
  
  CONSTRAINT customer_pk PRIMARY KEY (cName) 
);


CREATE TABLE options (
  oCode CHAR(4),
  oDesc CHAR(30),
  oList NUMBER(7, 2),
  oCost NUMBER(7, 2),
  
  CONSTRAINT options_pk PRIMARY KEY (oCode)
);


CREATE TABLE prospect (
  cName CHAR(20)
        CONSTRAINT prospect_cName_nn NOT NULL,
  make  CHAR(10)
        CONSTRAINT prospect_make_nn  NOT NULL
        CONSTRAINT prospect_make_check 
             CHECK (make IN ('ACURA', 'MERCEDES', 'LAND ROVER', 'JAGUAR')),
  model CHAR(8),
  cYear CHAR(4),
  color CHAR(12),
  trim  CHAR(16),
  oCode CHAR(4)
        CONSTRAINT prospect_oCode_nn NOT NULL,
        
  CONSTRAINT prospect_cmmccto_uk 
      UNIQUE (cName, make, model, cYear, color, trim, oCode),
  CONSTRAINT prospect_fk_customer FOREIGN KEY (cName) REFERENCES customer(cName),
  CONSTRAINT prospect_fk_options  FOREIGN KEY (oCode) REFERENCES options(oCode)
);


CREATE TABLE car (
  serial      CHAR(8),
  cName       CHAR(20),
  make        CHAR(10) 
              CONSTRAINT car_make_nn NOT NULL,
  model       CHAR(8) 
              CONSTRAINT car_model_nn NOT NULL,
  cYear       CHAR(4) 
              CONSTRAINT car_cYear_nn NOT NULL,
  color       CHAR(12) 
              CONSTRAINT car_color_nn NOT NULL,
  trim        CHAR(16) 
              CONSTRAINT car_trim_nn NOT NULL,
  engineType  CHAR(10) 
              CONSTRAINT car_engineType NOT NULL,
  purchInv    CHAR(6),
  purchDate   DATE,
  purchFrom   CHAR(12),
  purchCost   NUMBER(9, 2),
  freightCost NUMBER(9, 2),
  totalCost   NUMBER(9, 2),
  listPrice   NUMBER(9, 2),
  
  CONSTRAINT car_pk          PRIMARY KEY (serial),
  CONSTRAINT car_fk_customer FOREIGN KEY (cName) REFERENCES customer(cName)
);

CREATE TABLE baseOption (
  serial CHAR(8),
  oCode CHAR(4),
  
  CONSTRAINT baseOption_pk         PRIMARY KEY (serial, oCode),
  CONSTRAINT baseOption_fk_car     FOREIGN KEY (serial) REFERENCES car(serial),
  CONSTRAINT baseOption_fk_options FOREIGN KEY (oCode)  REFERENCES options(oCode)
);

CREATE TABLE servInv (
  servInv   CHAR(5),
  servDate  DATE 
            CONSTRAINT servInv_servDate_nn NOT NULL,
  cName     CHAR(20) 
            CONSTRAINT servInv_cName_nn NOT NULL,
  serial    CHAR(8) 
            CONSTRAINT servInv_serial_nn NOT NULL,
  partsCost NUMBER(7, 2),
  laborCost NUMBER(7, 2),
  tax       NUMBER(7, 2),
  totalCost NUMBER(7, 2),
  
  CONSTRAINT servInv_pk          PRIMARY KEY (servInv),
  CONSTRAINT servInv_fk_customer FOREIGN KEY (cName)  REFERENCES customer(cName),
  CONSTRAINT servInv_fk_car      FOREIGN KEY (serial) REFERENCES car(serial)
);

CREATE TABLE servWork (
  servInv CHAR(5),
  workDesc CHAR(80),
  CONSTRAINT servWork_pk         PRIMARY KEY (servInv, workDesc),
  CONSTRAINT servWork_fk_servInv FOREIGN KEY (servInv) REFERENCES servInv(servInv)
);

CREATE TABLE saleInv (
  saleInv     CHAR(6),
  cName       CHAR(20)
              CONSTRAINT saleInv_cName_nn      NOT NULL,
  salesMan    CHAR(20)
              CONSTRAINT saleInv_salesMan_nn   NOT NULL,
  saleDate    DATE
              CONSTRAINT saleInv_saleDate_nn   NOT NULL
              CONSTRAINT saleInv_saleDate_chk  
                   CHECK (saleDate > TO_DATE('01-JAN-1990', 'DD-MON-YYYY')),
  serial      CHAR(8)
              CONSTRAINT saleInv_serial_nn     NOT NULL,
  totalPrice  NUMBER(9, 2),
  discount    NUMBER(8, 2),
  net         NUMBER(9, 2),
  tax         NUMBER(8, 2),
  licFee      NUMBER(6, 2),
  commission  NUMBER(8, 2),
  tradeSerial CHAR(8),
  tradeAllow  NUMBER(9, 2),
  fire        CHAR(1)
              CONSTRAINT saleInv_fire_chk      CHECK (fire      IN ('Y', 'N')),
  collision   CHAR(1)
              CONSTRAINT saleInv_collision_chk CHECK (collision IN ('Y', 'N')),
  liability   CHAR(1)
              CONSTRAINT saleInv_liability_chk CHECK (liability IN ('Y', 'N')),
  property    CHAR(1)
              CONSTRAINT saleInv_property_chk  CHECK (property  IN ('Y', 'N')),
    
  CONSTRAINT saleInv_pk          PRIMARY KEY (saleInv),
  CONSTRAINT saleInv_fk_customer FOREIGN KEY (cName)    REFERENCES customer(cName),
  CONSTRAINT saleInv_fk_employee FOREIGN KEY (salesMan) REFERENCES employee(empName),
  CONSTRAINT saleInv_fk_car      FOREIGN KEY (serial)   REFERENCES car(serial)
);

CREATE TABLE invOption (
  saleInv   CHAR(6) 
            CONSTRAINT invOption_saleInv_nn   NOT NULL,
  oCode     CHAR(4) 
            CONSTRAINT invOption_oCode_nn     NOT NULL,
  salePrice NUMBER(7, 2) 
            CONSTRAINT invOption_salePrice_nn NOT NULL,
            
  CONSTRAINT invOption_so_uk      UNIQUE      (saleInv, oCode),
  CONSTRAINT invOption_fk_saleInv FOREIGN KEY (saleInv) REFERENCES saleInv(saleInv),
  CONSTRAINT invOption_fk_options FOREIGN KEY (oCode)   REFERENCES options(oCode)
);

CREATE SEQUENCE saleInv_seq
  START WITH 1
  INCREMENT BY 1
  ORDER;

CREATE SEQUENCE servInv_seq
  START WITH 1
  INCREMENT BY 1
  ORDER;
