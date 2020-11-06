ALTER TABLE students
ADD CONSTRAINT username_validation 
CHECK (
	students.name not similar to  '%(@|#|$)%'
	AND students.surname not similar to  '%(@|#|$)%'
);

--insert into students (name, surname, birth_date, phone, primary_skill) values('Yersey$','Murchinsonaa$','1990-02-18','+18015304552','Fashion Design');
