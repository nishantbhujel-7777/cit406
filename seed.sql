-- CIT 406 - Task 2: Five valid club members

INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('Nishant', 'Bhujel', 'nishant.bhujel@university.edu', 'Information Technology', '2026-09-01');

INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('Diben', 'Dangol', 'diben.dangol@university.edu', 'Computer Science', '2026-09-02');

INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('Yogesh', 'Oli', 'yogesh.oli@university.edu', 'Cybersecurity', '2026-09-03');

INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('Swastika', 'Shrestha', 'swastika.shrestha@university.edu', 'Business Administration', '2026-09-04');

INSERT INTO club_members (first_name, last_name, email, major, join_date)
VALUES ('Manisha', 'Pun', 'manisha.pun@university.edu', 'Information Systems', '2026-09-05');

-- Display all five records
SELECT *
FROM club_members;
