use course_overview;

select * from registrations inner join requirements on registrations.course_code = requirements.course_code;

select check_eligibility('DV1493', '0205189000');

select * from students;




