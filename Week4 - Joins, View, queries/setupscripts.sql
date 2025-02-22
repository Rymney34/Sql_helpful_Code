create table staff
(
staff_number char(4) primary key,
staff_name varchar(20),
)

create table student
(
student_number char(3) primary key,
student_name varchar(30),
birthdate datetime,
sex char(1),
degree varchar(20),
year_enrolled numeric(4),
tutor char(4),
constraint tutor_fk foreign key (tutor) references staff
)

create table course
(
course_code char(3) primary key,
title varchar(20),
unit numeric(1)
)

create table teaches
(
course_code char(3),
staff_number char(4),
constraint teaches_pk primary key(course_code,staff_number),
constraint teachescc_fk foreign key (course_code) references course,
constraint teachesstn_fk foreign key (staff_number) references staff
)

create table enrolment
(
student_number char(3),
course_code char(3),
constraint enrol_pk primary key(student_number,course_code),
constraint enrolcc_fk foreign key (course_code) references course,
constraint enrolsn_fk foreign key (student_number) references student
)

create table assessment
(
student_number char(3),
course_code char(3),
assessment_number numeric(1),
grade numeric(5,1),
constraint assess_pk primary key (student_number, course_code, assessment_number),
constraint assesssn_fk foreign key (student_number) references student,
constraint assesscc_fk foreign key (course_code) references course

)

Select * from enrolment

Select * 
From course
Inner Join enrolment on course.course_code = enrolment.course_code
Where student_number is NULL

Select course.course_code , course.title, student.student_name
FROM course 
INNER JOIN enrolment on course.course_code = enrolment.course_code
INNER JOIN student on enrolment.student_number = student.student_number

Select course.course_code , course.title, student.student_name
FROM course 
INNER JOIN enrolment on course.course_code = enrolment.course_code
INNER JOIN student on enrolment.student_number = student.student_number

Select * from staff

Create View  test_view as
Select staff.staff_name, course.course_code, course.title
From teaches
Inner join staff on staff.staff_number = teaches.staff_number
Inner join course on course.course_code = teaches.course_code

Select * from test_view;

Drop view test_view 


select student_name, degree, year_enrolled
from student
where degree > 'BSc Computer Science'

select student_number, grade
from assessment
where grade<50 or grade !=55

select student_name, birthdate from student
where student_name like '%J_%' 
select student_name from student
where student_name like '%S_%' 

select student_number, 1998 - year_enrolled
from student
where sex='F'

select student_number, 1998 - year_enrolled years_gone
from student
where sex='F'


select student_number, course_code from assessment
where student_number='s02'

--To exclude duplicate rows from a result table, the key word distinct should be used:

select distinct student_number, course_code from assessment
where student_number='s02'

select distinct student_number, course_code from assessment
order by student_number desc, course_code

SELECT * INTO mature_student
FROM student
WHERE birthdate < '1-Jan-1976'

create view male_student (snumber, sname, dob) as
select student_number, student_name, birthdate
from student
where sex='M'

Select * from male_student

update assessment
set grade=40
where student_number='s06'
and course_code='c02'
and assessment_number=1--it does update but acctual tableupdate assessment
set grade=1.20*grade
where course_code='c08'
and assessment_number=1


create table post97_student (student_number char(3) primary key,
student_name varchar(30), birthdate datetime, sex char(1), degree varchar(20),
year_enrolled numeric(4), tutor char(4))

insert into staff (staff_number, staff_name)
values ('st12', 'Nesbitt, Rab C')
insert into post97_student
select * from student
where year_enrolled>=1997

Select * from post97_student

Select birthdate , student_name  from post97_student
Where Year(birthdate) = 1979;

drop view male_student
drop table post97_student

select student.student_name, staff.staff_name tutor
from student, staff
where student.tutor=staff.staff_number
and student.student_name Like 'Green, Theresa'

--short version to save typying table names in full, should be declared in from 

select stu.student_name, sta.staff_name tutor
from student stu, staff sta
where stu.tutor=sta.staff_number
and stu.student_name like 'Green, Theresa'

Select staff.staff_name , course.title
from teaches
inner join course on course.course_code = teaches.course_code
inner join staff on staff.staff_number = teaches.staff_number

-- another way of doing it 

select s.staff_name, c.title
from staff s, course c, teaches t
where t.course_code=c.course_code
and t.staff_number=s.staff_number


select * from staff

select * from course

Select * from teaches

Select distinct stu.student_name, c.title, a.assessment_number, a.grade, staff.staff_name
from staff sta, student stu, teaches t, course c, assessment a
 join student as s on s.student_number = a.student_number 
 join course as co on co.course_code = a.course_code 
 inner join staff on staff.staff_number = staff_number
 Where staff.staff_name like 'Media Studies'
 


 select distinct stu.student_name, c.title, a.assessment_number, a.grade
from teaches t, staff sta, student stu, course c, assessment a
where c.course_code=t.course_code
and sta.staff_number=t.staff_number
and a.course_code=c.course_code
and a.student_number=stu.student_number
and sta.staff_name = 'Media Studies'
order by stu.student_name, c.title, a.assessment_number