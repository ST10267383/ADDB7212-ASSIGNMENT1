ALTER SESSION SET container=xepdb1;

CREATE USER John IDENTIFIED BY Johnch2024; --Question 3
CREATE USER Hannah IDENTIFIED BY Hannahch2024;

GRANT SELECT ANY TABLE TO John;
GRANT INSERT ANY TABLE TO Hannah;

SELECT --Question 4
    d.FIRST_NAME || ', ' || d.SURNAME AS DRIVER,
    d.DRIVER_CODE AS CODE,
    v.VIN_NUMBER,
    v.MILEAGE
FROM 
    Driver d
JOIN 
    driver_Deliveries dd ON d.DRIVER_ID = dd.DRIVER_ID
JOIN 
    Vehicle v ON dd.VIN_NUMBER = v.VIN_NUMBER
WHERE 
    v.MILEAGE < 80000;

SELECT  --Question 5
    s.STAFF_ID,
    s.FIRST_NAME,
    s.SURNAME,
    COUNT(d.DELIVERY_ITEM) AS DELIVERIES_PROCESSED
FROM 
    Staff s
JOIN 
    Delivery_Items d ON s.STAFF_ID = d.STAFF_ID
GROUP BY 
    s.STAFF_ID, s.FIRST_NAME, s.SURNAME
ORDER BY 
    DELIVERIES_PROCESSED ASC
FETCH FIRST 1 ROWS ONLY;

CREATE VIEW Staff_Delivery_Count AS /*Question 5.3.1 This will create the view, with the appropriate logic below*/
SELECT 
    s.STAFF_ID,
    s.FIRST_NAME,
    s.SURNAME,
    COUNT(d.DELIVERY_ITEM) AS DELIVERIES_PROCESSED
FROM 
    Staff s
JOIN 
    Delivery_Items d ON s.STAFF_ID = d.STAFF_ID
GROUP BY 
    s.STAFF_ID, s.FIRST_NAME, s.SURNAME
ORDER BY 
    DELIVERIES_PROCESSED ASC;
    
    
SELECT * FROM Staff_Delivery_Count /*This is the line we use to call the view which contains all the logic we previously encased*/
FETCH FIRST 1 ROWS ONLY;/*this will allow us to only see the employee with the most deliveries processed.*/


DECLARE --Question 6
    
    CURSOR staff_cursor IS
        SELECT FIRST_NAME, SURNAME
        FROM Staff;
    
    v_first_name Staff.FIRST_NAME%TYPE;
    v_surname Staff.SURNAME%TYPE;
BEGIN
    
    OPEN staff_cursor;
      
    LOOP
        
        FETCH staff_cursor INTO v_first_name, v_surname;
        
        EXIT WHEN staff_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_surname);
    END LOOP;
    
    CLOSE staff_cursor;
END;


