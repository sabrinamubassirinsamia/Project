-- Database: `SchoolManagement`
create database `SchoolManagement`;
use `SchoolManagement`;
DELIMITER $$


CREATE TABLE Employee(
    `SSN` BIGINT,
    `Emp_ID` BIGINT, 
    `Fname` VARCHAR(15),
   ` Minit` VARCHAR(15),
    `Lname` VARCHAR(15) NOT NULL,
    `Sex` char,
    `Salary` DECIMAL,
    `Email` VARCHAR(30),
    `Bdata` DATE,
    `Super_ID` BIGINT,
    #CONSTRAINTS Employee_Pk PRIMARY KEY (Emp_ID),
    #CONSTRAINTS Employee_Employee_Fk FOREIGN KEY(Super_ID) REFERENCES 
    #Employee(Emp_ID) on delete CASCADE
    CONSTRAINT Employee_Pk PRIMARY KEY (Emp_ID),
    CONSTRAINT Employee_Employee_Fk FOREIGN KEY (Super_ID) REFERENCES 
    Employee(Emp_ID)
    -- Additional constraints or definitions can follow here
);



CREATE TABLE Emp_phone(
    `Emp_ID` BIGINT, 
    `Emp_Phone` VARCHAR(15),
    PRIMARY KEY (Emp_ID, Emp_Phone),
    CONSTRAINT Emp_Phone_Fk FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);

CREATE TABLE Teacher (
    `Emp_ID` BIGINT,
    `Specialization` varchar(15),
    PRIMARY KEY (Emp_ID),
    CONSTRAINT Teacher_Fk FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);


create table IT_Worker(
    `Emp_ID` BIGINT,
    `Specialization` varchar(15),
    CONSTRAINT IT_Worker_PK PRIMARY KEY (Emp_ID),
    CONSTRAINT IT_worker_Fk FOREIGN KEY(Emp_ID) REFERENCES Employee(Emp_ID)
	);

CREATE TABLE Cleaning_Staff (
    Emp_ID BIGINT,
    CONSTRAINT Cleaning_Staff_PK PRIMARY KEY (Emp_ID),
    CONSTRAINT Cleaning_Staff_FK FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);




create table librarian (
    Emp_ID BIGINT ,
    CONSTRAINT librarian_PK PRIMARY KEY (Emp_ID),
    CONSTRAINT librarian_Fk FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID) 
);



create table lib_managers (
    Emp_ID BIGINT UNIQUE,
    Lib_ID BIGINT UNIQUE,
    Strt_Date DATE,
    CONSTRAINT lib_managers_PK PRIMARY KEY (Emp_ID,Lib_ID),
    CONSTRAINT lib_managers_FK1 FOREIGN KEY(Emp_ID) REFERENCES librarian(Emp_ID), 
    CONSTRAINT lib_managers_FK2 FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID) 
);



CREATE TABLE Library(
    Lib_ID BIGINT,
    Lib_Name VARCHAR(15),
    CONSTRAINT Library_PK PRIMARY KEY (Lib_ID)
);



CREATE TABLE Books(
    Book_ID BIGINT,
    Book_Name VARCHAR(30),
    Author varchar(15),
    Lib_ID BIGINT,
    CONSTRAINT Books_PK PRIMARY KEY (Book_ID),
    CONSTRAINT Books_FK FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID)
);

CREATE TABLE Students(
     Stud_SSN BIGINT,
     Fname VARCHAR(15),
     Minit  VARCHAR(15),
     Lname varchar(15),
     Bdata DATE,
     Stud_Address varchar(30) NULL,
     Email VARCHAR(25),
     CONSTRAINT Students_PK PRIMARY KEY (Stud_SSN)
);

CREATE TABLE Members(
    Memb_id BIGINT,
    Lib_ID BIGINT,
    CONSTRAINT Members_PK PRIMARY KEY (Memb_id),
    CONSTRAINT Members_FK FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID),
	CONSTRAINT Members_FK2 FOREIGN KEY(Memb_id) REFERENCES Students(Stud_SSN)
);


create table courses(
    Course_ID BIGINT,
    Course_Name varchar(15),
    Prerequisite varchar(15),
    CONSTRAINT courses_PK PRIMARY KEY (Course_ID)
);


CREATE TABLE Enrollment(
    Stud_SSN BIGINT,
    Course_ID BIGINT,
    En_year varchar(15),
    Stud_Status varchar(15),
    Quarter VARCHAR(15),
    CONSTRAINT Enrollment_PK  PRIMARY KEY (Stud_SSN , Course_ID , En_year , Stud_Status),
    CONSTRAINT Enrollment_FK1 FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN),
	CONSTRAINT Enrollment_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID)
);

create table Legal_Guardian(
    Stud_SSN BIGINT UNIQUE ,
    LG_Name varchar(15) UNIQUE,
    Releationship varchar(15),
    CONSTRAINT Legal_Guardian_PK PRIMARY KEY (Stud_SSN,LG_Name),
    CONSTRAINT Legal_Guardian_FK FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN) 
    
);



create table LG_Info (
    LG_Name varchar(15),
    Bdata DATE,
    Sex CHAR,
    LG_Email VARCHAR(25),
    CONSTRAINT LG_Info_PK PRIMARY KEY (LG_Name),
    CONSTRAINT LG_Info_FK FOREIGN KEY(LG_Name) REFERENCES Legal_Guardian(LG_Name)
);



create table LG_Phones(
    LG_Name VARCHAR(15),
    LG_Phone BIGINT,
    CONSTRAINT LG_Phones_PK PRIMARY KEY (LG_Name,LG_Phone),
    CONSTRAINT LG_Phones_FK FOREIGN KEY(LG_Name) REFERENCES LG_Info(LG_Name)
);

DROP TABLE IF EXISTS grades;

CREATE TABLE grades (
    Stud_SSN BIGINT,
    Course_ID BIGINT,
    Quarter VARCHAR(15),
    Behavior BIGINT,
    Attendance BIGINT,
    Year_Works BIGINT,
    final_mark INT GENERATED ALWAYS AS ((Behavior/10) + (Attendance/10) + Year_Works) VIRTUAL,
    PRIMARY KEY (Stud_SSN, Course_ID, Quarter),
    CONSTRAINT Grades_FK1 FOREIGN KEY (Stud_SSN) REFERENCES Students(Stud_SSN),
    CONSTRAINT Grades_FK2 FOREIGN KEY (Course_ID) REFERENCES courses(Course_ID)
);




create table Exams(
    Exam_Title VARCHAR(15),
    Stud_SSN BIGINT,
    Course_ID BIGINT,
    Semester varchar(30),
    Exame_Date DATE ,
    Exame_Mark BIGINT,
    Exame_time VARCHAR(8),
    CONSTRAINT Exams_PK PRIMARY KEY (Exam_Title,Stud_SSN,Course_ID,Semester),
    CONSTRAINT Exams_FK1 FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN),
    CONSTRAINT Exams_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID)
);



CREATE table Rooms (
    Room_No BIGINT,
    Floor_No BIGINT,
    Capacity BIGINT,
    CONSTRAINT Rooms PRIMARY KEY (Room_No)
);

create table Class (
    Teacher_ID BIGINT,
    Course_ID BIGINT,
    Semester varchar(15),
    C_Period varchar(15),
    Room_No BIGINT,
    Start_time VARCHAR(8),
    CONSTRAINT Class_PK PRIMARY KEY (Teacher_ID,Course_ID),
    CONSTRAINT Class_FK1 FOREIGN KEY(Teacher_ID) REFERENCES Teacher(Emp_ID),
    CONSTRAINT Class_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID)
);





