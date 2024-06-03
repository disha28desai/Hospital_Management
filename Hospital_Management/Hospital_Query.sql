#SQL QUERIES

#1. Retrieve the names and positions of nurses who are registered. 

SELECT name, position 
FROM Nurse 
WHERE registered = 'Yes';


#2. Write a query in SQL to obtain the fullname of the patients whose gender is male.

SELECT CONCAT(NAME,' ',SURNAME) AS Patients_Fullname,GENDER
FROM PATIENT
WHERE GENDER = 'MALE';

#3. Retrieve the names and genders of patients born after 1990.

SELECT name, Gender 
FROM Patient 
WHERE YEAR(birthdate) > 1990;


#4. Write a query in SQL to find the name of the nurse who are Team Leader or not registered.

SELECT NAME,POSITION,REGISTERED
FROM NURSE
WHERE Position = 'Team Leader' OR REGISTERED = "NO";

#5. Write a query to obtain the avg cost of all the medical procedures.

SELECT AVG(COST) as Average_cost
FROM PROCEDURES;

#6 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.

SELECT NAME as Procedure_Name,COST as Procedure_Cost 
FROM PROCEDURES
WHERE NOT COST < 2000;

#7. Write a query to update the name of the patient to Robert Fernandez having patientid as 5.

UPDATE PATIENT
SET NAME = 'Robert',SURNAME = 'Fernandez'
WHERE PATIENT_ID = 5;

SELECT * FROM PATIENT;

#8. Retrieve the names of patients who have hypertension.

SELECT p.name
FROM Patient p
INNER JOIN Patient_Diagnosis pd ON p.patient_id = pd.Patient_ID
WHERE pd.Diagnosis = 'Hypertension';


#9. Second maximum cost of medical procedure

SELECT NAME,MAX(COST) as Procedure_cost
FROM PROCEDURES 
GROUP BY name
ORDER BY Procedure_cost DESC
LIMIT 1,1;

#Like Operator

#10. Write a query in SQL to obtain the name of the patients starting with letter A.

SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'A%';

#11. Find patients who have been diagnosed with the same disease more than once.

SELECT DISTINCT p.patient_id, p.name, p.surname, pd.Diagnosis
FROM patient p
INNER JOIN patient_diagnosis pd ON p.patient_id = pd.Patient_ID
GROUP BY p.patient_id, pd.Diagnosis
HAVING COUNT(pd.Diagnosis) > 1;


#12. Write a query in SQL to obtain the name of the patients whose name start with letter J and ends with Z.


#13. Find the department where the average age of patients is the highest.

SELECT d.dept_name, AVG(YEAR(CURRENT_DATE) - YEAR(p.birthdate)) AS avg_age
FROM department d
LEFT JOIN physician phy ON d.department_id = phy.departmentid
LEFT JOIN patient p ON phy.employeeid = p.primary_check
GROUP BY d.dept_name
ORDER BY avg_age DESC
LIMIT 1;



#14.  Write a query in SQL to obtain the name of the physicians who are the head of each department

select p.name as Doctor_name,d.dept_name
from physician p
inner join department d
on p.employeeid = d.head;


#15. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement

select CONCAT(p.name,' ',p.SURNAME) as PATIENT_NAME,ph.NAME as PHY_WHO_DID_PRI_TREATMENT
FROM PATIENT p
LEFT JOIN PHYSICIAN ph
ON p.PRIMARY_CHECK = ph.EMPLOYEEID;


#16. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.

select p.name as physician_name,d.dept_name as department_name
from physician p
inner join affiliated_with aw
on p.employeeid = aw.physicianid
inner join department d
on aw.departmentid = d.department_id
where primaryaffiliation='t';


#17. Find the nurse with the most patients assigned.

SELECT n.name, COUNT(p.patient_id) AS total_assigned_patients
FROM nurse n
LEFT JOIN physician phy ON n.nurse_id = phy.nurse_id
LEFT JOIN patient p ON phy.employeeid = p.primary_check
GROUP BY n.name
ORDER BY total_assigned_patients DESC
LIMIT 1;


#18. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.

SELECT PH.EMPLOYEEID,PH.NAME AS Physician_Name,PH.POSITION AS Designation,P.PATIENT_ID,CONCAT(P.NAME,' ',P.SURNAME) AS Patient_treated,P.GENDER,PD.DIAGNOSIS,PD.PRESCRIPTION
FROM PATIENT_DIAGNOSIS pd
LEFT JOIN Physician ph
ON pd.Physician_id = ph.employeeid
LEFT JOIN PATIENT P
ON P.PATIENT_ID = PD.PATIENT_ID;

#SUBQUERY

#19. Write a query in SQL to obtain the maximum cost of the medical procedure.

SELECT NAME,COST FROM PROCEDURES
WHERE COST IN (SELECT MAX(COST) FROM PROCEDURES);

#20. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.

SELECT * FROM Patient
WHERE patient_id IN (SELECT Patient_ID FROM PATIENT_DIAGNOSIS WHERE Diagnosis = 'Chronic Pain');

#21. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.

SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost > (SELECT AVG(cost) FROM procedures);

#22. Write a query in SQL to obtain the procedure name and cost whose cost is less than the avg cost of all the procedure.

SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost < (SELECT AVG(cost) FROM procedures);

#23. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.

SELECT * 
FROM Physician 
WHERE position IN (SELECT position FROM Physician
                   WHERE position
                   LIKE '%Senior%' OR position LIKE '%Head Chief%'
                   );


#24.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 

SELECT * 
FROM Physician 
WHERE employeeid IN (SELECT physicianid 
                     FROM affiliated_with 
                     WHERE primaryaffiliation = 'f'
                     );

#25. Find the total number of patients per department.

  
SELECT d.dept_name, COUNT(p.patient_id) AS total_patients
FROM department d
LEFT JOIN physician phy ON d.department_id = phy.departmentid
LEFT JOIN patient p ON phy.employeeid = p.primary_check
GROUP BY d.dept_name;


#26. Find the top 5 physicians with the highest number of patients.

SELECT phy.name, COUNT(pd.Patient_ID) AS total_patients
FROM physician phy
LEFT JOIN patient_diagnosis pd ON phy.employeeid = pd.Physician_id
GROUP BY phy.name
ORDER BY total_patients DESC
LIMIT 5;


#27. Find the average cost of procedures performed by each department.

SELECT d.dept_name, AVG(pr.cost) AS average_cost
FROM department d
LEFT JOIN physician phy ON d.department_id = phy.departmentid
LEFT JOIN patient_diagnosis pd ON phy.employeeid = pd.Physician_id
LEFT JOIN procedures pr ON pd.Diagnosis = pr.name
GROUP BY d.dept_name;


