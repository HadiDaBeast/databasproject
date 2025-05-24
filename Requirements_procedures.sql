-- Requirements Procedures

use course_overview;

drop procedure if exists add_requirements;
drop procedure if exists remove_requirements;

DELIMITER // 

create procedure add_requirements (in code varchar(20), in hp float, in required varchar(255))
begin 
	declare exist int;
    select count(*) into exist from requirements where requirements.course_code = code and requirements.type = required;
    if exist = 0 then
		insert into requirements (course_code, course_required_hp, type) values 
        (code, hp, required);
    end if;
end// 

create procedure remove_requirements (in code varchar(20), in required varchar(255)) 
begin 
	delete from requirements where requirements.course_code = code and requirements.type = required;
end//

DELIMITER ;