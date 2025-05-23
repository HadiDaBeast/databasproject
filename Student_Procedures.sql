-- Procedures

use course_overview;
drop procedure if exists add_student;
drop procedure if exists update_student_program;
drop procedure if exists get_student;
drop procedure if exists update_student_hp;
drop procedure if exists remove_student;
drop procedure if exists update_student_name;
drop procedure if exists update_student_personnumber;

DELIMITER //
CREATE procedure add_student(in personnumber varchar(12), in name varchar(50), in program varchar(20))
begin 
	declare present int;
	select count(person_nr) into present from students where students.person_nr = personnumber;
    if present = 0 then
		insert into students (person_nr, student_name, program,
		Zero,
		One,
		Two,
		Three,
		Four,
		Five,
		Six,
		Seven,
		Eight,
		Nine,
		A,
		B,
		C,
		D, 
		E, 
		F,
		G,
		H,
		I ,
		J,
		K,
		L,
		M,
		N,
		O,
		P,
		Q,
		R,
		S,
		T,
		U,
		V,
		W,
		X,
		Y,
		Z) values
        (personnumber, name, program, NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL); 
    end if;
    
end//


CREATE procedure remove_student(in personnumber varchar(12)) 
begin 
	delete from students where students.person_nr = personnumber;
end//

 
create procedure get_student(in personnumber varchar(12), out per_nr varchar(12))
begin
	select person_nr into per_nr from students where personnumber = students.person_nr;
end//

create procedure update_student_program (in personnumber varchar(12), in prog varchar(20)) 
begin 
	declare exist int;
    select count(*) into exist from students where students.person_nr = personnumber;
    if exist > 0 then
		update students set program = prog where students.person_nr = personnumber;
    end if;
end//

create procedure update_student_name (in personnumber varchar(12), in name varchar(50)) 
begin 
	declare exist int;
    select count(*) into exist from students where students.person_nr = personnumber;
    if exist > 0 then
		update students set student_name = name where students.person_nr = personnumber;
    end if;
end//

create procedure update_student_personnumber (in personnumber varchar(12), in new_personnumber varchar(12)) 
begin 
	declare exist int;
    select count(*) into exist from students where students.person_nr = personnumber;
    if exist > 0 then
		update students set person_nr = new_personnumber where students.person_nr = personnumber;
    end if;
end // DELIMITER ;