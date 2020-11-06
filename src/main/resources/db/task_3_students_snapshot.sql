--materialized view stores information as it was on the moment of snapshot. 
--data in materialized view can be updated with refresh command.
create materialized view students_snapshot as
select students.name, students.surname, subjects.subject_name, results.mark 
from students
left join results on students.id = results.student
left join subjects on subjects.id = results.subject;

--update students set surname = 'Cambinerri' where name = 'Brandon' and surname = 'Cambi';

--compare info in materialized view 
select * from students_snapshot;

--with actual updated information
select students.name, students.surname, subjects.subject_name, results.mark 
from students
left join results on students.id = results.student
left join subjects on subjects.id = results.subject;