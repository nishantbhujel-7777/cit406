drop table if exists payments             cascade;
drop table if exists appointment_services cascade;
drop table if exists medical_records      cascade;
drop table if exists appointments         cascade;
drop table if exists services             cascade;
drop table if exists addresses            cascade;
drop table if exists patients             cascade;
drop table if exists doctors              cascade;
drop table if exists departments          cascade;

create table departments (
  department_id   uuid primary key default gen_random_uuid(),
  name            text not null unique,
  location        text,
  phone           text
);

create table doctors (
  doctor_id       uuid primary key default gen_random_uuid(),
  department_id   uuid not null
                    references departments(department_id)
                    on delete restrict
                    on update cascade,
  first_name      text not null,
  last_name       text not null,
  specialty       text,
  email           text unique,
  phone           text
);

create table patients (
  patient_id      uuid primary key default gen_random_uuid(),
  first_name      text not null,
  last_name       text not null,
  date_of_birth   date not null,
  phone           text,
  email           text unique,
  created_at      timestamptz not null default now()
);

create table addresses (
  address_id      uuid primary key default gen_random_uuid(),
  patient_id      uuid not null unique
                    references patients(patient_id)
                    on delete cascade
                    on update cascade,
  street          text not null,
  city            text not null,
  state           text,
  postal_code     text,
  country         text not null default 'USA'
);

create table services (
  service_id      uuid primary key default gen_random_uuid(),
  name            text not null unique,
  description     text,
  cost_cents      integer not null check (cost_cents >= 0)
);

create table appointments (
  appointment_id  uuid primary key default gen_random_uuid(),
  patient_id      uuid not null
                    references patients(patient_id)
                    on delete cascade
                    on update cascade,
  doctor_id       uuid not null
                    references doctors(doctor_id)
                    on delete restrict
                    on update cascade,
  scheduled_at    timestamptz not null,
  status          text not null default 'scheduled'
                    check (status in ('scheduled','completed','cancelled','no_show')),
  notes           text
);

create table appointment_services (
  appointment_id  uuid not null
                    references appointments(appointment_id)
                    on delete cascade
                    on update cascade,
  service_id      uuid not null
                    references services(service_id)
                    on delete restrict
                    on update cascade,
  quantity        integer not null default 1 check (quantity > 0),
  unit_cents      integer not null check (unit_cents >= 0),
  primary key (appointment_id, service_id)
);

create table medical_records (
  record_id       uuid primary key default gen_random_uuid(),
  patient_id      uuid not null
                    references patients(patient_id)
                    on delete cascade
                    on update cascade,
  doctor_id       uuid not null
                    references doctors(doctor_id)
                    on delete restrict
                    on update cascade,
  appointment_id  uuid
                    references appointments(appointment_id)
                    on delete set null
                    on update cascade,
  diagnosis       text not null,
  prescription    text,
  created_at      timestamptz not null default now()
);

create table payments (
  payment_id      uuid primary key default gen_random_uuid(),
  appointment_id  uuid not null
                    references appointments(appointment_id)
                    on delete cascade
                    on update cascade,
  amount_cents    integer not null check (amount_cents >= 0),
  method          text not null
                    check (method in ('cash','card','insurance','transfer')),
  paid_at         timestamptz not null default now()
);

create index on doctors(department_id);
create index on appointments(patient_id);
create index on appointments(doctor_id);
create index on appointments(scheduled_at);
create index on appointment_services(service_id);
create index on medical_records(patient_id);
create index on medical_records(doctor_id);
create index on payments(appointment_id);
