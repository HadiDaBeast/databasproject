
-- initiate database and tables

drop database if exists course_overview;
Create database course_overview;

use course_overview;

drop table if exists registrations;
drop table if exists requirements;
drop table if exists students;
drop table if exists courses;


create table students (
	person_nr varchar(12) primary key,
    student_name varchar(50),
    program varchar(20),
	Zero float,
    One float,
    Two float,
    Three float,
    Four float,
    Five float,
    Six float,
    Seven float,
    Eight float,
    Nine float,
    A float,
    B float,
    C float,
    D float, 
    E float, 
    F float,
    G float,
    H float,
    I float,
    J float,
    K float,
    L float,
    M float,
    N float,
    O float,
    P float,
    Q float,
    R float,
    S float,
    T float,
	U float,
    V float,
    W float,
    X float,
    Y float,
    Z float
    );
create table courses (
	course_code varchar(20) primary key, 
    course_hp float,
    course_type varchar(20)
    );
create table registrations (
	person_nr varchar(12), 
	course_code varchar(20), 
	completed_hp_course float, 
	foreign key (person_nr) references students(person_nr), 
	foreign key (course_code) references courses(course_code)
    );
    
create table requirements (
	course_code varchar(20),
    course_required_hp float,
    type varchar(255),
    foreign key (course_code) references courses(course_code)
);

