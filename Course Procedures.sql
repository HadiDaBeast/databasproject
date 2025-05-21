-- use course_overview;
drop procedure if exists add_course;
drop procedure if exists remove_course;

DELIMITER //
CREATE procedure add_course(in code varchar(12), in hp varchar(50), in type varchar(20), in requirements varchar(20))
begin 
	declare present int;
	select count(course_code) into present from courses where courses.course_code = code;
    if present = 0 then
		insert into courses (course_code, course_hp, course_type, requirements) values
        (code, hp, type, requirements);
    end if;
    
end;
// DELIMITER ;

DELIMITER //
CREATE procedure remove_course(in code varchar(12))
begin 
	delete from courses where courses.course_code = code;
end;
// DELIMITER ;

call add_course('DV1574', '6', '100000000', '000000000000000000000000');
call add_course('MA1486', '4', '0000000010000', '000000000000000000000000');
call add_course('PA1461', '8', '000000000000000000000000');


SELECT * from courses;