drop function if exists get_average_mark_for_input_subject_name;

create function get_average_mark_for_input_subject_name(subj_name text)
	returns float
	language plpgsql
as $$
declare
	average_mark float;
begin
	select AVG(mark)  into average_mark
    from subjects
    left join results on subjects.id = results.subject
    where subjects.subject_name = subj_name
    group by subjects.id;
    return average_mark;
end; $$

--select get_average_mark_for_input_subject_name('Archaeology');