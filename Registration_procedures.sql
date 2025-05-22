-- Registration procedures;

use course_overview;

drop procedure if exists add_registrations;
drop procedure if exists remove_registrations;
drop procedure if exists update_registrations_hp;


DELIMITER // 
create procedure add_registrations(in personnumber varchar(12),in code varchar(20)) 
begin 
	declare person_exists int;
    declare course_exists int;
    select count(*) into person_exists from students where students.person_nr = personnumber;
    select count(*) into course_exists from courses where courses.course_code = code;
    
    if  person_exists > 0 and course_exists > 0 then
		insert into registrations (person_nr, course_code, completed_hp_course) values
        (personnumber, code, '0');
    end if;
end//

create procedure remove_registrations(in personnumber varchar(12),in code varchar(20)) 
begin 
	declare registration_exists int;
    declare course_exists int;
    select count(*) into course_exists from courses where courses.course_code = code;
    select count(*) into registration_exists from students where students.person_nr = personnumber;
    
    if  registration_exists > 0 then
		delete from registrations where person_nr = personnumber and course_code = code;
    end if;
end//

create procedure update_registrations_hp(in personnumber varchar(12), in code varchar(20), in hp int) 
begin 
	declare registration_exists int;
    declare course_exists int;
	select count(*) into course_exists from courses where courses.course_code = code;
    select count(*) into registration_exists from students where students.person_nr = personnumber;
    
    if registration_exists > 0 then 
		update registrations set registrations.completed_hp_course = hp where person_nr = personnumber and course_code = code;
    end if;
end//

DELIMITER ;

