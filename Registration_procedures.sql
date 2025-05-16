-- Registration procedures;

use course_overview;

drop procedure if exists add_registration;

DELIMITER // 
create procedure add_registrations(personnumber varchar(12), code varchar(20)) 
begin 
	declare person_exists int;
    declare course_exists int;
    select count(*) into person_exists from students where students.person_nr = personnumber;
    select count(*) into course_exists from courses where courses.course_code = code;
    
    if  person_exists > 0 and course_exists > 0 then
		insert into registrations (person_nr, course_code, completed_hp) values
        (personnumber, code, '0');
    end if;
    
    
end;
// DELIMITER ;