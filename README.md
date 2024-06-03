Here's a brief summary of each table in the HOSPITAL_MANAGMENT_SYSTEM database that I created to manage data of hospital:

Physician:

Contains information about physicians working in the hospital.
Fields: employeeid (primary key), name, position.
Affiliated_with:

Represents the affiliation of physicians with different departments.
Fields: physicianid (foreign key referencing Physician), departmentid (foreign key referencing Department), primaryaffiliation.
Department:

Stores details about different departments in the hospital.
Fields: department_id (primary key), dept_name, head (foreign key referencing Physician).
Nurse:

Contains information about nurses working in the hospital.
Fields: nurse_id, name, position, registered.
Patient:

Stores information about patients admitted to the hospital.
Fields: patient_id (primary key), name, surname, address, Gender, phone, primary_check (foreign key referencing Physician).
Patient_Diagnosis:

Records diagnosis and prescriptions for patients.
Fields: Diagnosis, Prescription, Patient_ID (foreign key referencing Patient), Physician_id (foreign key referencing Physician).
Procedures:

Contains details about medical procedures offered by the hospital.
Fields: code (primary key), name, cost.
