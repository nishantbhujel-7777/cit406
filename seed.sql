insert into departments (department_id, name, location, phone) values
  ('d0000000-0000-0000-0000-000000000001', 'General Medicine', 'Floor 1', '305-555-0100'),
  ('d0000000-0000-0000-0000-000000000002', 'Pediatrics',       'Floor 2', '305-555-0200'),
  ('d0000000-0000-0000-0000-000000000003', 'Cardiology',       'Floor 3', '305-555-0300');

insert into doctors (doctor_id, department_id, first_name, last_name, specialty, email, phone) values
  ('d1000000-0000-0000-0000-000000000001',
   'd0000000-0000-0000-0000-000000000001',
   'Anshu', 'Sharma', 'Internal Medicine', 'asharma@clinic.test', '305-555-0111'),
  ('d1000000-0000-0000-0000-000000000002',
   'd0000000-0000-0000-0000-000000000002',
   'Maria', 'Lopez', 'Pediatrics', 'mlopez@clinic.test', '305-555-0222'),
  ('d1000000-0000-0000-0000-000000000003',
   'd0000000-0000-0000-0000-000000000003',
   'David', 'Kim', 'Cardiology', 'dkim@clinic.test', '305-555-0333');

insert into patients (patient_id, first_name, last_name, date_of_birth, phone, email) values
  ('p0000000-0000-0000-0000-000000000001', 'Nishant', 'Bhujel',   '1995-04-12', '305-555-1001', 'nishant@example.com'),
  ('p0000000-0000-0000-0000-000000000002', 'Alice',   'Chen',     '1988-11-02', '305-555-1002', 'alice@example.com'),
  ('p0000000-0000-0000-0000-000000000003', 'Bob',     'Martinez', '1979-06-23', '305-555-1003', 'bob@example.com');

insert into addresses (patient_id, street, city, state, postal_code, country) values
  ('p0000000-0000-0000-0000-000000000001', '100 Biscayne Blvd', 'Miami', 'FL', '33132', 'USA'),
  ('p0000000-0000-0000-0000-000000000002', '250 Ocean Dr',      'Miami', 'FL', '33139', 'USA'),
  ('p0000000-0000-0000-0000-000000000003', '88 Brickell Ave',   'Miami', 'FL', '33131', 'USA');

insert into services (service_id, name, description, cost_cents) values
  ('50000000-0000-0000-0000-000000000001', 'General Consultation', 'Standard office visit', 12000),
  ('50000000-0000-0000-0000-000000000002', 'Blood Test',           'Complete blood panel',   4500),
  ('50000000-0000-0000-0000-000000000003', 'ECG',                  'Electrocardiogram',      8000),
  ('50000000-0000-0000-0000-000000000004', 'Vaccination',          'Routine immunization',   3500);

insert into appointments (appointment_id, patient_id, doctor_id, scheduled_at, status, notes) values
  ('a0000000-0000-0000-0000-000000000001',
   'p0000000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   '2026-09-20 09:00:00-04', 'completed', 'Routine check-up'),
  ('a0000000-0000-0000-0000-000000000002',
   'p0000000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000003',
   '2026-09-22 14:30:00-04', 'scheduled', 'Chest pain follow-up'),
  ('a0000000-0000-0000-0000-000000000003',
   'p0000000-0000-0000-0000-000000000003',
   'd1000000-0000-0000-0000-000000000002',
   '2026-09-25 10:15:00-04', 'scheduled', 'Child vaccination');

insert into appointment_services (appointment_id, service_id, quantity, unit_cents) values
  ('a0000000-0000-0000-0000-000000000001', '50000000-0000-0000-0000-000000000001', 1, 12000),
  ('a0000000-0000-0000-0000-000000000001', '50000000-0000-0000-0000-000000000002', 1,  4500),
  ('a0000000-0000-0000-0000-000000000002', '50000000-0000-0000-0000-000000000003', 1,  8000),
  ('a0000000-0000-0000-0000-000000000003', '50000000-0000-0000-0000-000000000004', 2,  3500);

insert into medical_records (patient_id, doctor_id, appointment_id, diagnosis, prescription) values
  ('p0000000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   'Mild hypertension', 'Lisinopril 10mg daily'),
  ('p0000000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000003',
   null,
   'Suspected angina', 'Nitroglycerin as needed');

insert into payments (appointment_id, amount_cents, method, paid_at) values
  ('a0000000-0000-0000-0000-000000000001', 16500, 'card',      '2026-09-20 10:05:00-04'),
  ('a0000000-0000-0000-0000-000000000002',  8000, 'insurance', '2026-09-22 15:00:00-04');
