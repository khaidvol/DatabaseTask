drop table if exists student_address;

create table student_address (
	student int not null,
	address text not null,
	constraint fk_student_address foreign key (student) references students(id)
);

drop trigger if exists immutable_address on student_address;
drop function if exists immutable_address;

create function immutable_address() returns trigger as $immutable_address$
    begin
	    if new.student is distinct from old.student
	    	then new.student = old.student;
	    end if;
	    if new.address is distinct from old.address
	     	then new.address = old.address;
	    end if;
	    return new;
    end;
$immutable_address$ language plpgsql;

create trigger immutable_address before update on student_address
for each row execute function immutable_address();

insert into student_address(student, address) values ('1', 'new york');
insert into student_address(student, address) values ('2', 'london');
insert into student_address(student, address) values ('3', 'berlin');
insert into student_address(student, address) values ('4', 'madrid');
insert into student_address(student, address) values ('5', 'rome');
insert into student_address(student, address) values ('6', 'paris');   
   
update student_address set address = 'kyiv' where student = '2';