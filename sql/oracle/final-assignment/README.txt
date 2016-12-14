The files in this directory provide a the items on the DBAS32100 final assignment.
The directory contains 6 scripts and 3 functions. 
To execute the program the user must be in the same directory where the scrips reside, 
or provide the appropriate path to the main shell script called menu:

Currently This program supports 6 options (a ~ f).

<Menu options>
----------------------------------------------------------------------
SPECIALTY IMPORTS VEHICLE SALES

Select one of the following options:
 a: Enter a new Customer
 b: Lookup a Customer
 c: Enter a new Vehicle Inventory Record
 d: Lookup a Vehicle Inventory Record
 e: Enter a new Sales Invoice
 f: Lookup a Sales Invoice
 g: Enter a new Service Work Order    (NOT SUPPORTED)
 h: Lookup a Service Work Order       (NOT SUPPORTED)  
 i: Enter a new Prospect              (NOT SUPPORTED) 
 j: Look up a Prospective Customer    (NOT SUPPORTED)
 k: Lookup All Prospective Customers  (NOT SUPPORTED)
 l: Delete a Prospect                 (NOT SUPPORTED)  
 x: Exit this program                 
 Enter your option here:



Example A. 

Create a new Customer.
When the user create a new record, required fields must be entered.

Customer Name (Required): yoonkwan
Street (Required): oakville
City (Required): oakville
Province (Required): ontario
Postal: l6h4h9
Home Phone: 123-123-1234
Mobile Phone: 123-123-2222

Customer Name: 'YOONKWAN' created.

PL/SQL procedure successfully completed.



Eample B. 

Get information of the Customer by customer's name
Look for a customer and show information of the customer.
User name will be changed to upper cases.

Enter your option here: b

You are logged in as s6_130 S6_130

Enter a customer name: rodrigo lima

-------------------------------------------------------------------------------
                          CUSTOMER INFOMATION

Name:    RODRIGO LIMA
Address: 123 FAKE STREET
City:    MISSISSAUGA
State:   ON
Postal:  L5L 5L5
Phone:   (905)828-2828
-------------------------------------------------------------------------------

PL/SQL procedure successfully completed.

Press any key to continue .....



Example C. 

Create a new Vehicle Inventory Record. All required fields must be entered.
Because it's for the inventory record, the user can not enter a customer for the new vehicle.

Enter your option here: c

You are logged in as s6_130 S6_130

Function created.

Car Serial (Required): ABCD42
Make (Required): HYUNDAI
Model (Required): Sonata
Year (Required): 2010
Color (Required): Black
Trim (Required): White
Engine (Required): V6
Purchase Invoice:
Purchase Date (YYYY-MM-DD):
Purchase From:
Purchase Cost:
Freight Cost:
Total Cost:
List Price: 20000

Car Serial: 'ABCD42' created.

PL/SQL procedure successfully completed.



Example D. 

Get Information of the Vehicle Inventory Record


Enter Car Serial: M15BMCL0

-------------------------------------------------------------------------------
                          VEHICLE INVENTORY RECORD
-------------------------------------------------------------------------------
Serial No.          Make                Model               Year
M15BMCL0            MERCEDES            MCLASS              2015
-------------------------------------------------------------------------------
Exterior Color      Trim                Purchased From      Purch Invoice No.
BLACK               BLACK               YOU                 101010
-------------------------------------------------------------------------------
Purchase Date                 Purchse Cost             List Base Price
01-JAN-08                     30000                    43550
-------------------------------------------------------------------------------
                 Optional Equpment and Accessories -
Factory

Code                Description                             List Price
U20                 BLACK UPHOLSTRY                         106.48
-------------------------------------------------------------------------------



Example E. 

Create a new Sales Invoice. All required fields must be entered
and all reference fields (customer name, salesman, car serial) must exists. 

Enter the Id (Required): ABCGGG
Enter the customer name (Required): JUAN TOMASINO
Enter the sales man:
Enter the sales date 'yyyy-mm-dd' (Required): 2000-10-10
Enter the car serial (Required): A12SMDX0
Enter the amount of discount: 200
Enter the the net: 50
Enter the the tax: 1200
Enter the license fee: 50
Enter the commission: 100
Enter the trade serial:
Enter the trade allow:
Fire (Y/N): y
Liability (Y/N): y
Collision (Y/N): n
Property Damage (Y/N): n

Sale Invoice ID: 'ABCGGG' created.

PL/SQL procedure successfully completed.



Example F. 

Get information of the Sales Invoice

Enter Sale invoice ID: I00300

-------------------------------------------------------------------------------
                                SALES INVOICE
-------------------------------------------------------------------------------
Invoice No: I00300                      Date: 16-JUL-28

SOLD TO:      NAME: ALEX HICKS
           Address: 123 Fake St
              City: Burlington
             State: ON
            Postal: L7F4G5
             Phone: (905)522-5555
          Salesman: DEVON WOODCOMB
-------------------------------------------------------------------------------
Serial         Make           Model          Year           Color
A09WMDX5       ACURA          MDX            2015           White
-------------------------------------------------------------------------------
                       Insurance Coverage Includes

     Fire and Theft [Y]                 Liability           [Y]

     Collision      [Y]                 Property Damage     [Y]
-------------------------------------------------------------------------------
                                   Options

Code                     Description                   Price
CD2                      CD PLAYER                     230
ED3                      ELECTRONIC INSTRUMENTS        750
-------------------------------------------------------------------------------
                                   Trade-In

Serial         Make           Model          Year           Color
A09BRSX5       ACURA          RSX            2015           5000
-------------------------------------------------------------------------------
            Total Price: 35000
     Trade-In Allowance: 5000
               Discount: 0
                    Net: 35000
                  Taxes: 4550
          Total Payable: 39550
-------------------------------------------------------------------------------

PL/SQL procedure successfully completed.


