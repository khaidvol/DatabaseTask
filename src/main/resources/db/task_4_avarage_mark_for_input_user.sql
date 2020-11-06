drop function if exists get_average_mark_for_student;

create function get_average_mark_for_student(student_name text, student_surname text)
	returns float
	language plpgsql
as $$
declare
	average_mark float;
begin
	select AVG(mark) into average_mark
	from students
	left join results on students.id = results.student
	where students.name = student_name and students.surname = student_surname
	group by students.id;
	return average_mark;
end; $$

--select get_average_mark_for_student('Tom', 'Ravenell');