-- Registration procedures;

use course_overview;

drop procedure if exists add_registrations;
drop procedure if exists remove_registrations;
drop procedure if exists update_registrations_hp;
drop function if exists eli;

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

create procedure update_registrations_hp(in personnumber varchar(12), in code varchar(20), in hp float) 
begin 
	declare registration_exists int;
    declare hp_before float;
    declare op char;
    select count(*) into registration_exists from students where students.person_nr = personnumber;
    select completed_hp_course into hp_before from registrations where person_nr = personnumber and course_code = code;
    
    if registration_exists > 0 then 
		update registrations set registrations.completed_hp_course = hp where person_nr = personnumber and course_code = code;
    end if;
end//

create function eli(code varchar(20), personnumber varchar(12)) returns int
deterministic
begin 
	declare i int;
    declare j int;
	declare len int;
    declare current_hp_sum float;
    declare reqiured_hp float;
    declare current_char varchar(1);
    declare current_type varchar(255);
    declare final_sum float;
    
    select count(*) into len from courses inner join requirements on courses.course_code = requirements.course_code where courses.course_code = code;
	set i = 0;
    while i<len do
		set final_sum = 0;
		select requirements.type, requirements.course_required_hp into current_type, reqiured_hp from courses inner join requirements on courses.course_code = requirements.course_code where courses.course_code = code limit 1 offset i;
        
        set j = 0;
        while j < length(current_type) do
			set current_hp_sum = 0;
			select substring(current_type, j+1, 1) into current_char;
			select sum(completed_hp_course) into current_hp_sum from registrations inner join courses on registrations.course_code = courses.course_code where course_type like concat('%', current_char, '%') and registrations.person_nr = personnumber;
			if current_hp_sum is not NULL then
				set final_sum = final_sum + current_hp_sum;
			end if;
			set j = j + 1;
        end while;
        if final_sum < reqiured_hp then
			return 0;
        end if;
        set i = i + 1;
    end while;
    return 1;
end//

DELIMITER ;