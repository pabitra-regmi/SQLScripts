CREATE DATABASE CollegeDB;
GO

USE CollegeDB;
GO

CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Course VARCHAR(50),
    Marks INT
);

INSERT INTO Students(Name , Age,Course,Marks)
VALUES 
('Asmita', 21, 'BCA', 85),
('Ramesh', 20, 'BCA', 35),
('Sita', 22, 'CSIT', 72),
('Hari', 21, 'BCA', 40);

SELECT * FROM Students;
GO
--creating stored procedure

CREATE PROCEDURE dbo.GetAllStudents
AS
BEGIN
    SELECT * FROM Students;	
END;
EXEC dbo.GetAllStudents;
GO

--stored procedure with input parameter

CREATE PROCEDURE dbo.GetStudentById
    @StudentId INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE StudentID = @StudentId;
END;
EXEC dbo.GetStudentById 4;
GO

--stored procedure with multiple input parameter

CREATE PROCEDURE dbo.GetStudentsByCourseAndAge
     @Course VARCHAR(50),
	 @Age INT
AS
BEGIN
  SELECT *
  FROM Students
  WHERE Course= @Course
    OR   Age= @Age;
END;
EXEC dbo.GetStudentsByCourseAndAge BCA,23;
GO

--INSERT DATA USING STORED PROCEDURE

CREATE PROCEDURE dbo.InsertStudent
    @Name VARCHAR(50),
    @Age INT,
    @Course VARCHAR(50),
    @Marks INT
AS
BEGIN
    INSERT INTO Students (Name, Age, Course, Marks)
    VALUES (@Name, @Age, @Course, @Marks);
END;
EXEC dbo.InsertStudent 'Gita', 20, 'CSIT', 90;
GO 

--UPDATE USING STORED PROCEDURE

CREATE PROCEDURE dbo.UpdateStudentsMarks
	   @Age INT ,
	     @Marks INT
AS
BEGIN
    UPDATE Students
	SET Marks = @Marks
	WHERE Age= @Age;
END;
EXEC dbo.UpdateStudentsMarks 21, 55;
GO

--STORED PROCEDURE WITH ONE OUTPUT PARAMETER

CREATE PROCEDURE dbo.CheckResult
    @StudentId INT,
    @Result VARCHAR(10) OUTPUT
AS
BEGIN
    DECLARE @Marks INT;

    SELECT @Marks = Marks
    FROM Students
    WHERE StudentID = @StudentId;

    IF @Marks >= 40
        SET @Result = 'PASS';
    ELSE
        SET @Result = 'FAIL';
END;
DECLARE @Status VARCHAR(10);

EXEC dbo.CheckResult 2, @Status OUTPUT;
SELECT @Status AS Result;
GO

--STORED PROCEDURE WITH TWO OUTPUT PARAMETER

CREATE PROCEDURE dbo.CheckResultWithName
      @studentId INT,
	  @Result VARCHAR(10)  OUTPUT,
	  @StudentName VARCHAR(50)    OUTPUT
AS 
BEGIN 
     DECLARE @Marks INT;

	 SELECT @Marks = Marks, @StudentName = Name
	 FROM Students
	 WHERE StudentID =  @studentId;

	 IF @Marks >=40
	 SET @Result ='Pass';

	 ELSE 
	 SET @Result = 'Fail';

END;

DECLARE @Staus VARCHAR(10);
DECLARE @Name VARCHAR(50);
EXEC dbo.CheckResultWithName 2,@Staus OUTPUT,@Name OUTPUT;
SELECT @Name AS StudentName, @Staus AS Result;
GO

--STORED PROCEDURE WITH TRANSACTION
CREATE PROCEDURE PayFees
    @StudentID INT,
    @Amount INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Students
        SET Marks = Marks + 1
        WHERE StudentID = @StudentID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Payment Failed';
    END CATCH
END;

