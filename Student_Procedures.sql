-- Procedures

use course_overview;
drop procedure if exists add_student;

DELIMITER //
CREATE procedure add_student(in personnumber varchar(12), in name varchar(50), in program varchar(20))
begin 
	declare present int;
	select count(person_nr) into present from students where students.person_nr = personnumber;
    if present = 0 then
		insert into students (person_nr, student_name, program, completed_hp) values
        (personnumber, name, program, 0);
    end if;
    
end;
// DELIMITER ;

drop procedure if exists remove_student;

DELIMITER // 
CREATE procedure remove_student(in personnumber varchar(20)) 
begin 
	delete from students where students.person_nr = personnumber;
end;

// DELIMITER ;

select * from students;