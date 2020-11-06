--a)
select * from students where name = 'Tom';

--b)
select * from students where surname like 'V%';

--c)
select * from students where phone like '+180011%';

--d)
select students.id, students.name, students.surname, subjects.subject_name, results.mark
from students
left join results on students.id = results.student
left join subjects on subjects.id = results.subject
where surname like 'Vi%';

--index size)
select pg_size_pretty (pg_indexes_size('students'));