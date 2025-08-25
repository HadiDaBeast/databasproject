-- use course_overview;
drop procedure if exists add_course;
drop procedure if exists remove_course;
drop procedure if exists get_course;
drop procedure if exists update_course_code;
drop procedure if exists update_course_hp;
drop procedure if exists update_course_type;
drop procedure if exists update_course_requirements;

DELIMITER //
CREATE procedure add_course(in code varchar(20), in hp float, in type varchar(20))
begin 
	declare present int;
	select count(course_code) into present from courses where courses.course_code = code;
    if present = 0 then
		insert into courses (course_code, course_hp, course_type) values
        (code, hp, type);
    end if;
    
end//

CREATE procedure remove_course(in code varchar(20))
begin 
	delete from requirements where requirements.course_code = code;
    delete from registrations where registrations.course_code = code;
	delete from courses where courses.course_code = code;
end //

create procedure update_course_code (in code varchar(20), in new_code varchar(20)) 
begin 
	declare exist int;
    select count(*) into exist from courses where courses.course_code = code;
    if exist > 0 then
		update courses set courses.course_code = new_code where courses.course_code = code;
    end if;
end//

create procedure update_course_hp (in code varchar(20), in hp float) 
begin 
	declare exist int;
    select count(*) into exist from courses where courses.course_code = code;
    if exist > 0 then
		update courses set courses.course_hp = hp where courses.course_code = code;
    end if;
end//

create procedure update_course_type (in code varchar(20), in type varchar(20)) 
begin 
	declare exist int;
    select count(*) into exist from courses where courses.course_code = code;
    if exist > 0 then
		update courses set courses.course_type = type where courses.course_code = code;
    end if;
end//

DELIMITER ;



