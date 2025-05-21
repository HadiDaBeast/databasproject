
-- initiate database and tables

drop database if exists course_overview;
Create database course_overview;

use course_overview;

drop table if exists students;
drop table if exists courses;
drop table if exists registrations;

create table students (
	person_nr varchar(12) primary key,
    student_name varchar(50),
    program varchar(20),
    completed_hp int
    );
create table courses (
	course_code varchar(20) primary key, 
    course_hp int,
    course_type varchar(20)
    );
create table registrations (
	person_nr varchar(12), 
	course_code varchar(20), 
	completed_hp_course int, 
	foreign key (person_nr) references students(person_nr), 
	foreign key (course_code) references courses(course_code)
    );
    
create table requirements (
	course_code varchar(20),
    course_required_hp int,
    type varchar(20),
    foreign key (course_code) references courses(course_code)
);