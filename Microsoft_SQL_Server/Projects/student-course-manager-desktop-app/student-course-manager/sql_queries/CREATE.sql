-- Create the database
CREATE DATABASE StudentCourseDB;
GO

-- Use the database
USE StudentCourseDB;
GO

-- Create Department table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    head_of_dept VARCHAR(100)
);

-- Create Student table
CREATE TABLE Student (
    std_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone_number VARCHAR(15),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Create Course table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Create Enrollment table
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    std_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (std_id) REFERENCES Student(std_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create Admin table
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);