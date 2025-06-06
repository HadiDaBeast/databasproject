-- Registration procedures;

use course_overview;

drop procedure if exists add_registrations;
drop procedure if exists remove_registrations;
drop procedure if exists update_registrations_hp;
drop trigger if exists new_reg;
drop procedure if exists update_hp;
drop function if exists check_eligibility;


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
    
    if registration_exists > 0 and hp_before > hp then
		set op = '-';
        Set hp = abs(hp_before - hp);
        call update_hp(personnumber, code, hp, op);
    elseif registration_exists > 0 and hp_before < hp then
		set op = '+';
        Set hp = abs(hp_before - hp);
        call update_hp(personnumber, code, hp, op);
    end if;
end//

CREATe trigger new_reg after insert on registrations
for each row
begin
	declare cell_is_null float;
	declare types1 varchar(50);
	declare counter int;
    declare current_type varchar(50);
    declare len int;
	set counter = 0;

	select course_type into types1 from courses inner join registrations on courses.course_code = registrations.course_code where registrations.person_nr = new.person_nr and registrations.course_code = new.course_code;
	While counter <= length(types1) DO

		select substring(types1, counter, 1) into current_type;
        Set SQL_SAFE_UPDATES = 0;
		if current_type = '0' then
			select Zero into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Zero = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '1' then
			select One into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set One = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '2' then
			select Two into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Two = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '3' then
			select Three into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Three = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '4' then
			select Four into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Four = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '5' then
			select Five into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Five = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '6' then
			select Six into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Six = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '7' then
			select Seven into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Seven = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '8' then
			select Eight into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Eight = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = '9' then
			select Nine into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Nine = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'A' then
			select A into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set A = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'B' then
			select B into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set B = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'C' then
			select C into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set C = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'D' then
			select D into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set D = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'E' then
			select E into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set E = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'F' then
			select F into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set F = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'G' then
			select G into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then  
				update students set G = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'H' then
			select H into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set H = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'I' then
			select I into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then  
				update students set I = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'J' then
			select J into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set J = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'K' then
			select K into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set K = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'L' then
			select L into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set L = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'M' then
			select M into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then  
				update students set M = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'N' then
			select N into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then  
				update students set N = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'O' then
			select O into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set O = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'P' then
			select P into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set P = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'Q' then
			select Q into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Q = 0 where person_nr = new.person_nr;
			end if; 
		elseif current_type = 'R' then
			select R into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set R = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'S' then
			select S into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set S = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'T' then
			select T into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set T = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'U' then
			select U into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set U = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'V' then
			select V into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set V = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'W' then
			select W into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set W = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'X' then
			select X into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set X = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'Y' then
			select Y into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Y = 0 where person_nr = new.person_nr;
			end if;
		elseif current_type = 'Z' then
			select Z into cell_is_null from students where person_nr = new.person_nr;
			if cell_is_null is null then 
				update students set Z = 0 where person_nr = new.person_nr;
			end if;
		END IF;
        
		Set SQL_SAFE_UPDATES = 1;
		set counter=counter+1;
	END while;

end//

CREATe procedure update_hp (in personnumber varchar(12), in code varchar(20), in total_hp float, in op char)
begin

	declare types1 varchar(50);
	declare counter int;
    declare current_type varchar(50);
	set counter = 0;
	select course_type into types1 from courses inner join registrations on courses.course_code = registrations.course_code where registrations.person_nr = personnumber and registrations.course_code = code;
    
    
	While counter <= length(types1) DO

		select substring(types1, counter, 1) into current_type;
        Set SQL_SAFE_UPDATES = 0;
		if current_type = '0' then
			if op = '+' then
				update students set Zero = Zero + total_hp where person_nr = personnumber;
            else
				update students set Zero = Zero - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '1' then
			if op = '+' then
				update students set One = One + total_hp where person_nr = personnumber;
            else
				update students set One = One - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '2' then
			if op = '+' then
				update students set Two = Two + total_hp where person_nr = personnumber;
            else
				update students set Two = Two - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '3' then
			if op = '+' then
				update students set Three = Three + total_hp where person_nr = personnumber;
            else
				update students set Three = Three - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '4' then
			if op = '+' then
				update students set Four = Four + total_hp where person_nr = personnumber;
            else
				update students set Four = Four - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '5' then
			if op = '+' then
				update students set Five = Five + total_hp where person_nr = personnumber;
            else
				update students set Five = Five - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '6' then
			if op = '+' then
				update students set Six = Six + total_hp where person_nr = personnumber;
            else
				update students set Six = Six - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '7' then
			if op = '+' then
				update students set Seven = Seven + total_hp where person_nr = personnumber;
            else
				update students set Seven = Seven - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '8' then
			if op = '+' then
				update students set Eight = Eight + total_hp where person_nr = personnumber;
            else
				update students set Eight = Eight - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = '9' then
			if op = '+' then
				update students set Nine = Nine + total_hp where person_nr = personnumber;
            else
				update students set Nine = Nine - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'A' then
			if op = '+' then
				update students set A = A + total_hp where person_nr = personnumber;
            else
				update students set A = A - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'B' then
			if op = '+' then
				update students set B = B + total_hp where person_nr = personnumber;
            else
				update students set B = B - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'C' then
			if op = '+' then
				update students set C = C + total_hp where person_nr = personnumber;
            else
				update students set C = C - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'D' then
			if op = '+' then
				update students set D = D + total_hp where person_nr = personnumber;
            else
				update students set D = D - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'E' then
			if op = '+' then
				update students set E = E + total_hp where person_nr = personnumber;
            else
				update students set E = E - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'F' then
			if op = '+' then
				update students set F = F + total_hp where person_nr = personnumber;
            else
				update students set F = F - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'G' then
			if op = '+' then
				update students set G = G + total_hp where person_nr = personnumber;
            else
				update students set G = G - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'H' then
			if op = '+' then
				update students set H = H + total_hp where person_nr = personnumber;
            else
				update students set H = H - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'I' then
			if op = '+' then
				update students set I = I + total_hp where person_nr = personnumber;
            else
				update students set I = I - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'J' then
			if op = '+' then
				update students set J = J + total_hp where person_nr = personnumber;
            else
				update students set J = J - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'K' then
			if op = '+' then
				update students set K = K + total_hp where person_nr = personnumber;
            else
				update students set K = K - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'L' then
			if op = '+' then
				update students set L = L + total_hp where person_nr = personnumber;
            else
				update students set L = L - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'M' then
			if op = '+' then
				update students set M = M + total_hp where person_nr = personnumber;
            else
				update students set M = M - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'N' then
			if op = '+' then
				update students set N = N + total_hp where person_nr = personnumber;
            else
				update students set N = N - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'O' then
			if op = '+' then
				update students set O = O + total_hp where person_nr = personnumber;
            else
				update students set O = O - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'P' then
			if op = '+' then
				update students set P = P + total_hp where person_nr = personnumber;
            else
				update students set P = P - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'Q' then
			if op = '+' then
				update students set Q = Q + total_hp where person_nr = personnumber;
            else
				update students set Q = Q - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'R' then
			if op = '+' then
				update students set R = R + total_hp where person_nr = personnumber;
            else
				update students set R = R - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'S' then
			if op = '+' then
				update students set S = S + total_hp where person_nr = personnumber;
            else
				update students set S = S - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'T' then
			if op = '+' then
				update students set T = T + total_hp where person_nr = personnumber;
            else
				update students set T = T - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'U' then
			if op = '+' then
				update students set U = U + total_hp where person_nr = personnumber;
            else
				update students set U = U - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'V' then
			if op = '+' then
				update students set V = V + total_hp where person_nr = personnumber;
            else
				update students set V = V - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'W' then
			if op = '+' then
				update students set W = W + total_hp where person_nr = personnumber;
            else
				update students set W = W - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'X' then
			if op = '+' then
				update students set X = X + total_hp where person_nr = personnumber;
            else
				update students set X = X - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'Y' then
			if op = '+' then
				update students set Y = Y + total_hp where person_nr = personnumber;
            else
				update students set Y = Y - total_hp where person_nr = personnumber;
			end if;
		elseif current_type = 'Z' then
			if op = '+' then
				update students set Z = Z + total_hp where person_nr = personnumber;
            else
				update students set Z = Z - total_hp where person_nr = personnumber;
			end if;
		END IF;
		Set SQL_SAFE_UPDATES = 1;
		set counter=counter+1;
	END while;

end//

create function check_eligibility(code varchar(20), personnumber varchar(12)) returns int 
deterministic
begin 
	declare eligible int;
    declare i int;
    declare j int;
    declare len int;
    declare hp float;
    declare current_type varchar(50);
    declare current_char varchar(1);
    declare current_hp float;
	declare sum_hp float;
    select count(*) into len from courses inner join requirements on courses.course_code = requirements.course_code where courses.course_code = code;
    set i = 0;

    while i<len do
		set sum_hp = 0;
	    set j = 1;
		select type, course_required_hp into current_type, hp from courses inner join requirements on courses.course_code = requirements.course_code where courses.course_code = code limit 1 offset i;
			while j-1 < length(current_type) do
				select substring(current_type, j, 1) into current_char;
					if current_char = '0' then
						select Zero into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
						end if;
					elseif current_char = '1' then
						select One into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
						end if;
					elseif current_char = '2' then
						select Two into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
						end if;
					elseif current_char = '3' then
						select Three into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                        else
							return 0;
						end if;
					elseif current_char = '4' then
						select Four into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
						end if;
					elseif current_char = '5' then
						select Five into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
						end if;
					elseif current_char = '6' then
						select Six into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;

						end if;
					elseif current_char = '7' then
						select Seven into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                        
						end if;
					elseif current_char = '8' then
						select Eight into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                
						end if;
					elseif current_char = '9' then
						select Nine into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                
						end if;
					elseif current_char = 'A' then
						select A into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                        
						end if;
					elseif current_char = 'B' then
						select B into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
         
						end if; 
					elseif current_char = 'C' then
						select C into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
             
						end if;
					elseif current_char = 'D' then
						select D into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
           
						end if;
					elseif current_char = 'E' then
						select E into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
            
						end if;
					elseif current_char = 'F' then
						select F into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                 
						end if;
					elseif current_char = 'G' then
						select G into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
        
						end if;
					elseif current_char = 'H' then
						select H into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                     
						end if;
					elseif current_char = 'I' then
						select I into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                     
						end if;
					elseif current_char = 'J' then
						select J into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                  
						end if;
					elseif current_char = 'K' then
						select K into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
           
						end if;
					elseif current_char = 'L' then
						select L into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                 
						end if;
					elseif current_char = 'M' then
						select M into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                   
						end if;
					elseif current_char = 'N' then
						select N into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
              
						end if;
					elseif current_char = 'O' then
						select O into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
              
						end if;
					elseif current_char = 'P' then
						select P into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
               
						end if;
					elseif current_char = 'Q' then
						select Q into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                   
						end if;
					elseif current_char = 'R' then
						select R into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                
						end if;
					elseif current_char = 'S' then
						select S into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                  
						end if;
					elseif current_char = 'T' then
						select T into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                   
						end if;
					elseif current_char = 'U' then
						select U into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                   
						end if;
					elseif current_char = 'V' then
						select V into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
            
						end if;
					elseif current_char = 'W' then
						select W into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
               
						end if;
					elseif current_char = 'X' then
						select X into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
                  
						end if;
					elseif current_char = 'Y' then
						select Y into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
              
						end if;
					elseif current_char = 'Z' then
						select Z into current_hp from students where person_nr = personnumber;
                        if current_hp is not null then
							set sum_hp = sum_hp + current_hp;
             
						end if;
					END IF;
				Set j = j + 1;
            end while;
            if sum_hp < hp then
             return 0;
			end if;
        set i = i + 1;
    end while;
    return 1;
    
end//

DELIMITER ;