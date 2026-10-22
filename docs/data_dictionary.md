# Data Dictionary: Clinic Management System

## 1. departments
Stores clinic departments.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| department_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the department |
| name | VARCHAR(100) | NOT NULL | Name of the department (e.g., Cardiology) |
| location | VARCHAR(100) | | Physical location (e.g., Floor 2) |
| phone | VARCHAR(20) | | Contact number |

## 2. doctors
Stores doctor information.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| doctor_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the doctor |
| department_id | UUID | FOREIGN KEY REFERENCES departments(department_id) | The department the doctor belongs to |
| first_name | VARCHAR(50) | NOT NULL | Doctor's first name |
| last_name | VARCHAR(50) | NOT NULL | Doctor's last name |
| specialty | VARCHAR(100) | | Medical specialty |
| email | VARCHAR(100) | UNIQUE | Contact email |
| phone | VARCHAR(20) | | Contact phone |

## 3. patients
Stores patient demographic information.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| patient_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the patient |
| first_name | VARCHAR(50) | NOT NULL | Patient's first name |
| last_name | VARCHAR(50) | NOT NULL | Patient's last name |
| date_of_birth | DATE | | Patient's birth date |
| phone | VARCHAR(20) | | Contact phone |
| email | VARCHAR(100) | | Contact email |

## 4. postal_locations
Stores city and state based on postal code (BCNF decomposition).
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| postal_code | VARCHAR(20) | PRIMARY KEY | The postal/zip code |
| city | VARCHAR(100) | NOT NULL | City name |
| state | VARCHAR(50) | NOT NULL | State name |

## 5. addresses
Stores patient addresses (BCNF decomposition).
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| address_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the address |
| patient_id | UUID | FOREIGN KEY REFERENCES patients(patient_id) | The patient this address belongs to |
| street | VARCHAR(150) | NOT NULL | Street address |
| postal_code | VARCHAR(20) | FOREIGN KEY REFERENCES postal_locations(postal_code) | Postal code linked to city/state |
| country | VARCHAR(50) | DEFAULT 'USA' | Country |

## 6. appointments
Stores scheduled patient visits.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| appointment_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the appointment |
| patient_id | UUID | FOREIGN KEY REFERENCES patients(patient_id) | The patient being seen |
| doctor_id | UUID | FOREIGN KEY REFERENCES doctors(doctor_id) | The doctor seeing the patient |
| scheduled_at | TIMESTAMPTZ | NOT NULL | Date and time of appointment |
| status | VARCHAR(20) | DEFAULT 'scheduled' | Status (scheduled, completed, cancelled) |
| notes | TEXT | | Clinical notes |

## 7. services
Stores billable medical services offered by the clinic.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| service_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the service |
| name | VARCHAR(100) | NOT NULL | Name of the service (e.g., Blood Test) |
| description | TEXT | | Detailed description |
| cost_cents | INTEGER | NOT NULL, CHECK (cost_cents >= 0) | Base cost in cents |

## 8. appointment_services
Associative entity resolving the M:N relationship between appointments and services.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| appointment_id | UUID | FOREIGN KEY REFERENCES appointments(appointment_id) ON DELETE CASCADE | The appointment |
| service_id | UUID | FOREIGN KEY REFERENCES services(service_id) | The service provided |
| quantity | INTEGER | NOT NULL, CHECK (quantity > 0) | Number of times service was performed |
| unit_cents | INTEGER | NOT NULL, CHECK (unit_cents >= 0) | Price charged per unit at time of service |
| PRIMARY KEY | (appointment_id, service_id) | | Composite primary key |

## 9. medical_records
Stores clinical diagnosis and prescriptions.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| record_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the record |
| patient_id | UUID | FOREIGN KEY REFERENCES patients(patient_id) | The patient |
| doctor_id | UUID | FOREIGN KEY REFERENCES doctors(doctor_id) | The doctor who created the record |
| appointment_id | UUID | FOREIGN KEY REFERENCES appointments(appointment_id) | The associated appointment |
| created_at | TIMESTAMPTZ | DEFAULT now() | Timestamp of record creation |
| diagnosis | TEXT | | Doctor's diagnosis |
| prescription | TEXT | | Prescribed medication/treatment |

## 10. payments
Stores financial transactions for appointments.
| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| payment_id | UUID | PRIMARY KEY, DEFAULT gen_random_uuid() | Unique identifier for the payment |
| appointment_id | UUID | FOREIGN KEY REFERENCES appointments(appointment_id) | The appointment being paid for |
| amount_cents | INTEGER | NOT NULL, CHECK (amount_cents >= 0) | Amount paid in cents |
| method | VARCHAR(20) | NOT NULL | Payment method (card, cash, insurance) |
| paid_at | TIMESTAMPTZ | DEFAULT now() | Date and time payment was made |
