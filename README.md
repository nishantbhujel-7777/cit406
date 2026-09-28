# CIT 406 — Clinic Management System (Module 2, Assignment 2)

Normalized database design for a small clinic, implemented in Supabase (PostgreSQL).
The full database can be rebuilt from this repository alone by running
`schema.sql`, then `seed.sql`, in the Supabase SQL Editor.

## Files

- **`schema.sql`** — 9 normalized tables with all constraints and foreign keys
- **`seed.sql`** — deterministic sample data (fixed UUIDs)

## Schema Overview

| Table | Purpose |
|---|---|
| `departments` | Clinic departments (e.g., Cardiology, Pediatrics) |
| `doctors` | Doctors, each belonging to one department |
| `patients` | Registered patients |
| `addresses` | One mailing address per patient (1:1) |
| `services` | Catalog of services offered by the clinic |
| `appointments` | Scheduled visits linking a patient and a doctor |
| `appointment_services` | Junction — services ordered per appointment, with quantity and price snapshot |
| `medical_records` | Diagnoses and prescriptions authored by doctors |
| `payments` | Payments attached to appointments |

## Referential Action Documentation

Each foreign key is listed below with its referential action and the business
rule that drives the choice.

| # | Foreign Key | ON DELETE | ON UPDATE | Business Rule / Justification |
|---|---|---|---|---|
| 1 | `doctors.department_id → departments.department_id` | **RESTRICT** | CASCADE | A doctor must belong to a department (Scope §4). Deleting a department that still has doctors would orphan them, so the database blocks the delete. An admin must reassign doctors to another department first. |
| 2 | `addresses.patient_id → patients.patient_id` | **CASCADE** | CASCADE | An address has no meaning without its patient. If a patient record is removed, the address is dependent data and must go too. The `UNIQUE` constraint enforces the "one address per patient" assumption. |
| 3 | `appointments.patient_id → patients.patient_id` | **CASCADE** | CASCADE | Appointments are owned by the patient. Removing a patient removes their appointment history to avoid orphaned rows. |
| 4 | `appointments.doctor_id → doctors.doctor_id` | **RESTRICT** | CASCADE | Clinical history must remain attributable to the doctor who performed it. A doctor with existing appointments cannot be deleted until those appointments are cancelled or reassigned. |
| 5 | `appointment_services.appointment_id → appointments.appointment_id` | **CASCADE** | CASCADE | Junction rows describe a specific appointment. When the appointment is deleted, its service lines are meaningless and cascade away automatically. |
| 6 | `appointment_services.service_id → services.service_id` | **RESTRICT** | CASCADE | Services are catalog data referenced by historical billing. Deleting a service still referenced by appointments would corrupt past bills. The price is snapshotted into `unit_cents` so historical charges survive even if the catalog price changes later. |
| 7 | `medical_records.patient_id → patients.patient_id` | **CASCADE** | CASCADE | Medical records belong to a patient and have no meaning without them. Deleting a patient removes their records (subject to the clinic's retention policy). |
| 8 | `medical_records.doctor_id → doctors.doctor_id` | **RESTRICT** | CASCADE | The authoring doctor must remain identifiable on every medical record for accountability. A doctor who authored records cannot be deleted. |
| 9 | `medical_records.appointment_id → appointments.appointment_id` | **SET NULL** | CASCADE | A medical record is a clinical document that outlives the scheduling row it was tied to. If the appointment is cancelled or purged, the record is kept but the link is nulled. The FK is nullable to support this. |
| 10 | `payments.appointment_id → appointments.appointment_id` | **CASCADE** | CASCADE | Payments in this design are attached to a single appointment (per the assignment assumptions). Removing the appointment removes its payment rows. |

### Pattern Summary

- **CASCADE** — dependent / owned rows (addresses, junction rows, payments, a patient's appointments and records).
- **RESTRICT** — referenced catalog or accountable actors (departments, services, doctors).
- **SET NULL** — optional historical linkage (medical record → appointment).
- **ON UPDATE CASCADE everywhere** — all keys are surrogate UUIDs; if a key is ever regenerated, children follow automatically.

## Business Rules Enforced by CHECK Constraints

- `appointments.status ∈ {scheduled, completed, cancelled, no_show}`
- `payments.method ∈ {cash, card, insurance, transfer}`
- `appointment_services.quantity > 0`
- All money columns (`cost_cents`, `unit_cents`, `amount_cents`) `≥ 0`

## Rebuilding the Database

1. Open the Supabase project dashboard → **SQL Editor**.
2. Run `schema.sql` — creates all 9 tables and 10 foreign keys.
3. Run `seed.sql` — inserts sample data.
4. Verify in **Database → Schema Visualizer** (relationships shown as lines between tables).

## Deliverables

- `schema.sql`
- `seed.sql`
- Screenshot of the Supabase Schema Visualizer
- This README documenting referential actions and business rules
