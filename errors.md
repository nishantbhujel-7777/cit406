# CIT 406 - Task 2: Constraint Error Tests

## Test 1: Missing First Name

### SQL used

```sql
INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES (NULL, 'TestStudent', 'test1@university.edu', 'Computer Science', '2026-09-08');
```

### PostgreSQL error

Run the statement in pgAdmin and copy the **exact error message shown in the Messages tab** below:

> PASTE YOUR EXACT POSTGRESQL ERROR MESSAGE HERE

The main error is expected to indicate that a NULL value was inserted into the `first_name` column, which is defined as `NOT NULL`.

### Reflection

PostgreSQL rejected this row because `first_name` is required by the table definition. The `NOT NULL` constraint prevents a club member record from being created without a first name.

---

## Test 2: Missing Email Address

### SQL used

```sql
INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('TestStudent', 'NoEmail', NULL, 'Computer Science', '2026-09-08');
```

### PostgreSQL error

Run the statement in pgAdmin and copy the **exact error message shown in the Messages tab** below:

> PASTE YOUR EXACT POSTGRESQL ERROR MESSAGE HERE

The main error is expected to indicate that a NULL value was inserted into the `email` column, which is defined as `NOT NULL`.

### Reflection

PostgreSQL rejected this row because `email` is required by the table definition. The `NOT NULL` constraint prevents a club member record from being created without an email address.

---

## Important

The assignment specifically asks for the **exact PostgreSQL error message**, so replace both placeholders above with the messages from your own pgAdmin Messages tab rather than guessing or changing the wording.
