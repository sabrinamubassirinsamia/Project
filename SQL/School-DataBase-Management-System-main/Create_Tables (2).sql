drop table Employee CASCADE CONSTRAINTS;
CREATE TABLE Employee(
    SSN NUMBER(10),
    Emp_ID NUMBER(10), 
    Fname VARCHAR2(15),
    Minit VARCHAR2(15),
    Lname VARCHAR2(15) NOT NULL,
    Sex char,
    Salary DECIMAL,
    Email VARCHAR2(30),
    Bdata DATE,
    Super_ID NUMBER(10),
    CONSTRAINTS Employee_Pk PRIMARY KEY (Emp_ID),
    CONSTRAINTS Employee_Employee_Fk FOREIGN KEY(Super_ID) REFERENCES Employee(Emp_ID) on delete CASCADE
);


drop table Emp_Phone CASCADE CONSTRAINTS;
CREATE TABLE Emp_phone(
    Emp_ID NUMBER(10) , 
    Emp_Phone VARCHAR2(15),
    CONSTRAINTS Emp_Phone_PK PRIMARY KEY (Emp_ID,Emp_Phone),
    CONSTRAINTS Emp_Phone_Fk FOREIGN KEY(Emp_ID) REFERENCES Employee(Emp_ID) on delete CASCADE
);


drop table Teacher CASCADE CONSTRAINTS;
create table Teacher(
    Emp_ID number(10) ,
    Specialization varchar2(15),
    CONSTRAINTS Teacher_PK PRIMARY KEY (Emp_ID),
    CONSTRAINTS Teacher_Fk FOREIGN KEY(Emp_ID) REFERENCES Employee(Emp_ID) on delete CASCADE
);


drop table IT_Worker CASCADE CONSTRAINTS;
create table IT_Worker(
    Emp_ID number(10),
    Specialization varchar2(15),
    CONSTRAINTS IT_Worker_PK PRIMARY KEY (Emp_ID),
    CONSTRAINTS IT_worker_Fk FOREIGN KEY(Emp_ID) REFERENCES Employee(Emp_ID) on delete CASCADE
	);


drop table Cleaning_Staff CASCADE CONSTRAINTS;
CREATE TABLE Cleaning_Staff (
    Emp_ID NUMBER(10),
    CONSTRAINTS Cleaning_Staff_PK PRIMARY KEY (Emp_ID),
    CONSTRAINTS Cleaning_Staff_FK FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID) on delete CASCADE
);


drop table librarian CASCADE CONSTRAINTS;

create table librarian (
    Emp_ID NUMBER(10) ,
    CONSTRAINTS librarian_PK PRIMARY KEY (Emp_ID),
    CONSTRAINTS librarian_Fk FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID) on delete CASCADE
);


drop table lib_managers CASCADE CONSTRAINTS;

create table lib_managers (
    Emp_ID number(10) UNIQUE,
    Lib_ID number(10) UNIQUE,
    Strt_Date DATE,
    CONSTRAINTS lib_managers_PK PRIMARY KEY (Emp_ID,Lib_ID),
    CONSTRAINTS lib_managers_FK1 FOREIGN KEY(Emp_ID) REFERENCES librarian(Emp_ID) on delete CASCADE, 
    CONSTRAINTS lib_managers_FK2 FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID) on delete CASCADE
);


drop table Library CASCADE CONSTRAINTS;
CREATE TABLE Library(
    Lib_ID NUMBER(10),
    Lib_Name VARCHAR2(15),
    CONSTRAINTS Library_PK PRIMARY KEY (Lib_ID)
);


drop table Books CASCADE CONSTRAINTS;
CREATE TABLE Books(
    Book_ID NUMBER(10),
    Book_Name VARCHAR2(30),
    Author varchar2(15),
    Lib_ID NUMBER(10),
    CONSTRAINTS Books_PK PRIMARY KEY (Book_ID),
    CONSTRAINTS Books_FK FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID) on delete CASCADE
);


drop table Members CASCADE CONSTRAINTS;
CREATE TABLE Members(
    Memb_id NUMBER(10),
    Lib_ID NUMBER(10),
    CONSTRAINTS Members_PK PRIMARY KEY (Memb_id),
    CONSTRAINTS Members_FK FOREIGN KEY(Lib_ID) REFERENCES Library(Lib_ID) on delete CASCADE,
	CONSTRAINTS Members_FK2 FOREIGN KEY(Memb_id) REFERENCES students(Stud_SSN) on delete CASCADE
);


drop table Students CASCADE CONSTRAINTS;
CREATE TABLE Students(
     Stud_SSN number(10),
     Fname VARCHAR2(15),
     Minit  VARCHAR2(15),
     Lname varchar2(15),
     Bdata DATE,
     Stud_Address varchar2(30) NULL,
     Email VARCHAR2(25),
     CONSTRAINTS Students_PK PRIMARY KEY (Stud_SSN)
);

drop table courses CASCADE CONSTRAINTS;
create table courses(
    Course_ID number(15),
    Course_Name varchar2(15),
    Prerequisite varchar2(15),
    CONSTRAINTS courses_PK PRIMARY KEY (Course_ID)
);

drop table Enrollment CASCADE CONSTRAINTS;
CREATE TABLE Enrollment(
    Stud_SSN NUMBER(10),
    Course_ID NUMBER(10),
    En_year varchar2(15),
    Stud_Status varchar2(15),
    Quarter VARCHAR2(15),
    CONSTRAINTS Enrollment_PK  PRIMARY KEY (Stud_SSN , Course_ID , En_year , Stud_Status),
    CONSTRAINTS Enrollment_FK1 FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN) on delete CASCADE,
	CONSTRAINTS Enrollment_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID) on delete CASCADE
);


drop table Legal_Guardian CASCADE CONSTRAINTS;
create table Legal_Guardian(
    Stud_SSN NUMBER(10) UNIQUE ,
    LG_Name varchar2(15) UNIQUE,
    Releationship varchar2(15),
    CONSTRAINTS Legal_Guardian_PK PRIMARY KEY (Stud_SSN,LG_Name),
    CONSTRAINTS Legal_Guardian_FK FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN) on delete CASCADE
);


drop table LG_Info CASCADE CONSTRAINTS;
create table LG_Info (
    LG_Name varchar2(15),
    Bdata DATE,
    Sex CHAR,
    LG_Email VARCHAR2(25),
    CONSTRAINTS LG_Info_PK PRIMARY KEY (LG_Name),
    CONSTRAINTS LG_Info_FK FOREIGN KEY(LG_Name) REFERENCES Legal_Guardian(LG_Name) on delete CASCADE
);


drop table LG_Phones CASCADE CONSTRAINTS;
create table LG_Phones(
    LG_Name VARCHAR2(15),
    LG_Phone NUMBER(10),
    CONSTRAINTS LG_Phones_PK PRIMARY KEY (LG_Name,LG_Phone),
    CONSTRAINTS LG_Phones_FK FOREIGN KEY(LG_Name) REFERENCES LG_Info(LG_Name) on delete CASCADE
);


drop table Grades CASCADE CONSTRAINTS;
create table Grades(
    Stud_SSN NUMBER(10),
    Course_ID NUMBER(10),
    Quarter varchar2(15),
    Behavior NUMBER,
    Attendance NUMBER,
    Year_Works NUMBER,
	final_mark number GENERATED ALWAYS AS ((Behavior/10) + (Attendance/10) + Year_Works) virtual,
    CONSTRAINTS Grades_PK PRIMARY KEY (Stud_SSN,Course_ID,Quarter),
    CONSTRAINTS Grades_FK1 FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN) on delete CASCADE,
    CONSTRAINTS Grades_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID) on delete CASCADE
);


drop table Exams CASCADE CONSTRAINTS;
create table Exams(
    Exam_Title VARCHAR2(15),
    Stud_SSN number(10),
    Course_ID NUMBER(10),
    Semester varchar2(30),
    Exame_Date DATE ,
    Exame_Mark NUMBER(3),
    Exame_time VARCHAR2(8),
    CONSTRAINTS Exams_PK PRIMARY KEY (Exam_Title,Stud_SSN,Course_ID,Semester),
    CONSTRAINTS Exams_FK1 FOREIGN KEY(Stud_SSN) REFERENCES Students(Stud_SSN) on delete CASCADE,
    CONSTRAINTS Exams_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID) on delete CASCADE
);


drop table Rooms CASCADE CONSTRAINTS;
CREATE table Rooms (
    Room_No NUMBER(10),
    Floor_No NUMBER(10),
    Capacity NUMBER(10),
    CONSTRAINTS Rooms PRIMARY KEY (Room_No)
);


drop table Class CASCADE CONSTRAINTS;
create table Class (
    Teacher_ID NUMBER(10),
    Course_ID NUMBER(10),
    Semester varchar2(15),
    C_Period varchar2(15),
    Room_No NUMBER(10),
    Start_time VARCHAR2(8),
    CONSTRAINTS Class_PK PRIMARY KEY (Teacher_ID,Course_ID),
    CONSTRAINTS Class_FK1 FOREIGN KEY(Teacher_ID) REFERENCES Teacher(Emp_ID) on delete CASCADE,
    CONSTRAINTS Class_FK2 FOREIGN KEY(Course_ID) REFERENCES courses(Course_ID) on delete CASCADE
);





