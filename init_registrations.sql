use course_overview;

#call add_registrations('0205189000', 'DV1574');
#call update_registrations_hp('0205189000', 'DV1625', 6);
#call add_registrations('0205189000', 'DV1625');

select check_eligibility('PA2572', '9902130000');

select * from registrations;
select * from students where person_nr = "9902130000";

select* from requirements where course_code = 'PA2554';




