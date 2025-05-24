
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
	Zero int,
    One int,
    Two int,
    Three int,
    Four int,
    Five int,
    Six int,
    Seven int,
    Eight int,
    Nine int,
    A INT,
    B INT,
    C INT,
    D INT, 
    E INT, 
    F INT,
    G INT,
    H int,
    I INT,
    J INT,
    K INT,
    L INT,
    M INT,
    N INT,
    O INT,
    P INT,
    Q INT,
    R INT,
    S INT,
    T INT,
	U INT,
    V INT,
    W INT,
    X INT,
    Y INT,
    Z INT
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
    type varchar(255),
    foreign key (course_code) references courses(course_code)
);

