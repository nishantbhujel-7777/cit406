# CIT 406 - PostgreSQL Data Type Selection Exercise

## Task 1: Campus Event Management System

| # | Column | PostgreSQL Data Type | Justification |
|---|--------|----------------------|---------------|
| 1 | student_id | `integer GENERATED ALWAYS AS IDENTITY` | An identity integer automatically generates increasing numeric values and is appropriate for a system-generated unique student identifier. |
| 2 | first_name | `varchar(50)` | `varchar(50)` stores names efficiently while enforcing a reasonable maximum length of 50 characters. |
| 3 | email_address | `varchar(255)` | `varchar(255)` is suitable for storing email addresses because it provides enough room for standard email address lengths. |
| 4 | date_of_birth | `date` | The `date` type stores a calendar date without unnecessary time-of-day information. |
| 5 | account_balance | `numeric(10,2)` | `numeric(10,2)` stores exact monetary values with two decimal places and avoids floating-point rounding problems. |
| 6 | is_active | `boolean` | `boolean` is designed for values with only two logical states, such as active and inactive. |
| 7 | event_start | `timestamptz` | `timestamptz` stores an exact point in time and handles time-zone-aware event timestamps. |
| 8 | event_description | `text` | `text` is appropriate because the description can contain multiple paragraphs and has no fixed maximum length. |
| 9 | maximum_attendees | `integer` | `integer` is appropriate for a whole-number count of the maximum number of attendees. |
| 10 | student_attended | `boolean` | `boolean` directly represents the two possible Yes/No attendance states. |
| 11 | phone_number | `text` | `text` is appropriate because phone numbers can contain `+`, spaces, parentheses, and hyphens and should not be treated as numbers. |
| 12 | postal_code | `varchar(10)` | `varchar(10)` preserves postal codes as text, including leading zeros, while allowing common postal-code formats. |
| 13 | event_status | `text` | `text` is flexible for values such as scheduled, cancelled, and completed and allows additional statuses to be added later. |
| 14 | student_number | `char(6)` | `char(6)` preserves the university's six-character student numbers, including leading zeros such as `001245`. |
