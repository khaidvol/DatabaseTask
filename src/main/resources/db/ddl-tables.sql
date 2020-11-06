--create database univercitydb;

DROP TABLE IF EXISTS results CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS students CASCADE;


CREATE TABLE students (
	id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	surname varchar(255) NOT NULL,
	birth_date date NULL,
	phone varchar(255) NULL,
	primary_skill varchar(255) NOT NULL,
	created_datetime timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updated_datetime timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT students_name_surname_key UNIQUE (name, surname),
	CONSTRAINT students_pkey PRIMARY KEY (id)
);

CREATE TABLE subjects (
	id serial NOT NULL,
	subject_name varchar(255) NOT NULL,
	tutor varchar(255) NOT NULL,
	CONSTRAINT subjects_pkey PRIMARY KEY (id),
	CONSTRAINT subjects_subject_name_key UNIQUE (subject_name)
);

CREATE TABLE results (
	student int NOT NULL,
	subject int NOT NULL,
	mark int NOT NULL,
	CONSTRAINT results_student_subject_key UNIQUE (student, subject),
	CONSTRAINT fk_student FOREIGN KEY (student) REFERENCES students(id),
	CONSTRAINT fk_subject FOREIGN KEY (subject) REFERENCES subjects(id)
);