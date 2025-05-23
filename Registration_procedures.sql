-- Registration procedures;

use course_overview;

drop procedure if exists add_registrations;
drop procedure if exists remove_registrations;
drop procedure if exists update_registrations_hp;
drop trigger if exists new_reg;


DELIMITER // 
create procedure add_registrations(in personnumber varchar(12),in code varchar(20)) 
begin 
	declare person_exists int;
    declare course_exists int;
    select count(*) into person_exists from students where students.person_nr = personnumber;
    select count(*) into course_exists from courses where courses.course_code = code;
    
    if  person_exists > 0 and course_exists > 0 then
		insert into registrations (person_nr, course_code, completed_hp_course) values
        (personnumber, code, 0);
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

CREATe trigger new_reg after insert on registrations
for each row
begin

	declare types1 varchar(50);
	declare counter int;
    declare current_type varchar(50);
    declare len int;
	set counter = 0;

	select course_type into types1 from courses inner join registrations on courses.course_code = registrations.course_code where registrations.person_nr = new.person_nr;
	While counter <= length(types1) DO

		select substring(types1, counter, 1) into current_type;
        Set SQL_SAFE_UPDATES = 0;
		if current_type = '0' then
			update students set Zero = 0 where person_nr = new.person_nr;
		elseif current_type = '1' then
			update students set One = 0 where person_nr = new.person_nr;
		elseif current_type = '2' then
			update students set Two = 0 where person_nr = new.person_nr; 
		elseif current_type = '3' then
			update students set Three = 0 where person_nr = new.person_nr;
		elseif current_type = '4' then
			update students set Four = 0 where person_nr = new.person_nr;
		elseif current_type = '5' then
			update students set Five = 0 where person_nr = new.person_nr;
		elseif current_type = '6' then
			update students set Six = 0 where person_nr = new.person_nr;
		elseif current_type = '7' then
			update students set Seven = 0 where person_nr = new.person_nr;
		elseif current_type = '8' then
			update students set Eight = 0 where person_nr = new.person_nr;
		elseif current_type = '9' then
			update students set Nine = 0 where person_nr = new.person_nr; 
		elseif current_type = 'A' then
			update students set A = 0 where person_nr = new.person_nr; 
		elseif current_type = 'B' then
			update students set B = 0 where person_nr = new.person_nr; 
		elseif current_type = 'C' then
			update students set C = 0 where person_nr = new.person_nr;
		elseif current_type = 'D' then
			update students set D = 0 where person_nr = new.person_nr; 
		elseif current_type = 'E' then
			update students set E = 0 where person_nr = new.person_nr;
		elseif current_type = 'F' then
			update students set F = 0 where person_nr = new.person_nr;
		elseif current_type = 'G' then
			update students set G = 0 where person_nr = new.person_nr;
		elseif current_type = 'H' then
			update students set H = 0 where person_nr = new.person_nr;
		elseif current_type = 'I' then
			update students set I = 0 where person_nr = new.person_nr;
		elseif current_type = 'J' then
			update students set J = 0 where person_nr = new.person_nr; 
		elseif current_type = 'K' then
			update students set K = 0 where person_nr = new.person_nr; 
		elseif current_type = 'L' then
			update students set L = 0 where person_nr = new.person_nr;
		elseif current_type = 'M' then
			update students set M = 0 where person_nr = new.person_nr;
		elseif current_type = 'N' then
			update students set N = 0 where person_nr = new.person_nr;
		elseif current_type = 'O' then
			update students set O = 0 where person_nr = new.person_nr;
		elseif current_type = 'P' then
			update students set P = 0 where person_nr = new.person_nr;
		elseif current_type = 'Q' then
			update students set Q = 0 where person_nr = new.person_nr; 
		elseif current_type = 'R' then
			update students set R = 0 where person_nr = new.person_nr;
		elseif current_type = 'S' then
			update students set S = 0 where person_nr = new.person_nr;
		elseif current_type = 'T' then
			update students set T = 0 where person_nr = new.person_nr;
		elseif current_type = 'U' then
			update students set U = 0 where person_nr = new.person_nr;
		elseif current_type = 'V' then
			update students set V = 0 where person_nr = new.person_nr;
		elseif current_type = 'W' then
			update students set W = 0 where person_nr = new.person_nr;
		elseif current_type = 'X' then
			update students set X = 0 where person_nr = new.person_nr;
		elseif current_type = 'Y' then
			update students set Y = 0 where person_nr = new.person_nr;
		elseif current_type = 'Z' then
			update students set Z = 0 where person_nr = new.person_nr; 
		END IF;
        
		Set SQL_SAFE_UPDATES = 1;
		set counter=counter+1;
	END while;

end//

create trigger Update_hp_reg after update on registrations
for each row
begin 
	declare types1 varchar(50);
	declare counter int;
    declare current_type varchar(50);
    declare completed_hp int;
	set counter = 0;

	select course_type into types1 from courses inner join registrations on courses.course_code = registrations.course_code where registrations.person_nr = new.person_nr;
    select completed_hp_course into completed_hp from courses inner join registrations on courses.course_code = registrations.course_code where registrations.person_nr = new.person_nr;
    
	While counter <= length(types1) DO

		select substring(types1, counter, 1) into current_type;
        Set SQL_SAFE_UPDATES = 0;
		if current_type = '0' then
			update students set Zero = 0 where person_nr = new.person_nr;
		elseif current_type = '1' then
			update students set One = 0 where person_nr = new.person_nr;
		elseif current_type = '2' then
			update students set Two = 0 where person_nr = new.person_nr; 
		elseif current_type = '3' then
			update students set Three = 0 where person_nr = new.person_nr;
		elseif current_type = '4' then
			update students set Four = 0 where person_nr = new.person_nr;
		elseif current_type = '5' then
			update students set Five = 0 where person_nr = new.person_nr;
		elseif current_type = '6' then
			update students set Six = 0 where person_nr = new.person_nr;
		elseif current_type = '7' then
			update students set Seven = 0 where person_nr = new.person_nr;
		elseif current_type = '8' then
			update students set Eight = 0 where person_nr = new.person_nr;
		elseif current_type = '9' then
			update students set Nine = 0 where person_nr = new.person_nr; 
		elseif current_type = 'A' then
			update students set A = 0 where person_nr = new.person_nr; 
		elseif current_type = 'B' then
			update students set B = 0 where person_nr = new.person_nr; 
		elseif current_type = 'C' then
			update students set C = 0 where person_nr = new.person_nr;
		elseif current_type = 'D' then
			update students set D = 0 where person_nr = new.person_nr; 
		elseif current_type = 'E' then
			update students set E = 0 where person_nr = new.person_nr;
		elseif current_type = 'F' then
			update students set F = 0 where person_nr = new.person_nr;
		elseif current_type = 'G' then
			update students set G = 0 where person_nr = new.person_nr;
		elseif current_type = 'H' then
			update students set H = 0 where person_nr = new.person_nr;
		elseif current_type = 'I' then
			update students set I = 0 where person_nr = new.person_nr;
		elseif current_type = 'J' then
			update students set J = 0 where person_nr = new.person_nr; 
		elseif current_type = 'K' then
			update students set K = 0 where person_nr = new.person_nr; 
		elseif current_type = 'L' then
			update students set L = 0 where person_nr = new.person_nr;
		elseif current_type = 'M' then
			update students set M = 0 where person_nr = new.person_nr;
		elseif current_type = 'N' then
			update students set N = 0 where person_nr = new.person_nr;
		elseif current_type = 'O' then
			update students set O = 0 where person_nr = new.person_nr;
		elseif current_type = 'P' then
			update students set P = 0 where person_nr = new.person_nr;
		elseif current_type = 'Q' then
			update students set Q = 0 where person_nr = new.person_nr; 
		elseif current_type = 'R' then
			update students set R = 0 where person_nr = new.person_nr;
		elseif current_type = 'S' then
			update students set S = 0 where person_nr = new.person_nr;
		elseif current_type = 'T' then
			update students set T = 0 where person_nr = new.person_nr;
		elseif current_type = 'U' then
			update students set U = 0 where person_nr = new.person_nr;
		elseif current_type = 'V' then
			update students set V = 0 where person_nr = new.person_nr;
		elseif current_type = 'W' then
			update students set W = 0 where person_nr = new.person_nr;
		elseif current_type = 'X' then
			update students set X = 0 where person_nr = new.person_nr;
		elseif current_type = 'Y' then
			update students set Y = 0 where person_nr = new.person_nr;
		elseif current_type = 'Z' then
			update students set Z = 0 where person_nr = new.person_nr; 
		END IF;
        
		Set SQL_SAFE_UPDATES = 1;
		set counter=counter+1;
	END while;

end//


DELIMITER ;