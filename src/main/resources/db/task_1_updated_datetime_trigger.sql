drop trigger if exists students_stamp on students;
drop function if exists students_stamp;

create function students_stamp() returns trigger as $students_stamp$
    begin
        if new.name is null then
            raise exception 'name cannot be null';
        end if;
        if new.surname is null then
            raise exception 'surname cannot be null';
        end if;
        if new.surname is null then
            raise exception 'surname cannot be null';
        end if;
		if new.birth_date is null then
            raise exception 'birth_date cannot be null';
        end if;
		if new.phone is null then
            raise exception 'phone cannot be null';
        end if;
			if new.primary_skill is null then
            raise exception 'primary_skill cannot be null';
        end if;

        new.updated_datetime := current_timestamp;
        return new;
    end;
$students_stamp$ language plpgsql;

create trigger students_stamp before insert or update on students
    for each row execute function students_stamp();


--select * from information_schema.triggers;
--update students set birth_date = '1995-02-18' where name = 'yer' and surname = 'murchinson';
--select * from students;