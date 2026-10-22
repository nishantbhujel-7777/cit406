# Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    DEPARTMENTS ||--o{ DOCTORS : "has"
    PATIENTS ||--o{ APPOINTMENTS : "books"
    DOCTORS ||--o{ APPOINTMENTS : "conducts"
    PATIENTS ||--o| ADDRESSES : "lives at"
    POSTAL_LOCATIONS ||--o{ ADDRESSES : "located in"
    APPOINTMENTS ||--o{ APPOINTMENT_SERVICES : "includes"
    SERVICES ||--o{ APPOINTMENT_SERVICES : "used in"
    PATIENTS ||--o{ MEDICAL_RECORDS : "has"
    DOCTORS ||--o{ MEDICAL_RECORDS : "creates"
    APPOINTMENTS ||--o{ MEDICAL_RECORDS : "results in"
    APPOINTMENTS ||--o| PAYMENTS : "paid by"
