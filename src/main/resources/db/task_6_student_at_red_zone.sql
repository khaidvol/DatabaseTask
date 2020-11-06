drop function if exists get_students_at_red_zone;

create function get_students_at_red_zone()
	returns table (students_id int, student_name varchar, student_surname varchar)
		language plpgsql
as $$
begin
	return query
	select students.id, students.name, students.surname from students
	left join results on students.id = results.student
	where mark <= 3
	group by students.id
	having count(mark) >= 2;
end; $$

--select * from get_students_at_red_zone();