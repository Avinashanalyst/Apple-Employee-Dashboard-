CREATE DATABASE EmployeePerformanceDB;
USE EmployeePerformanceDB;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Role VARCHAR(50),
    HireDate DATE
);

CREATE TABLE PerformanceMetrics (
    MetricID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectCompletionRate DECIMAL(5, 2),
    TotalTasksCompleted INT,
    AverageTrainingHours DECIMAL(5, 2),
    EmployeeSatisfactionScore DECIMAL(2, 1),
    PerformanceReviewDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Training (
    TrainingID INT PRIMARY KEY,
    EmployeeID INT,
    TrainingProgram VARCHAR(50),
    TrainingHours INT,
    CompletionDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    EmployeeID INT,
    FeedbackDate DATE,
    FeedbackType VARCHAR(50),
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees (EmployeeID, Name, Department, Role, HireDate) VALUES
(1, 'Alice Johnson', 'Engineering', 'Software Engineer', '2020-01-15'),
(2, 'Bob Smith', 'Marketing', 'Marketing Manager', '2019-03-20'),
(3, 'Carol Williams', 'HR', 'HR Specialist', '2021-05-30'),
(4, 'David Brown', 'Engineering', 'DevOps Engineer', '2018-07-22'),
(5, 'Eva Green', 'Sales', 'Sales Executive', '2022-11-10'),
(6, 'Frank Miller', 'Engineering', 'Data Scientist', '2020-09-15'),
(7, 'Grace Davis', 'HR', 'Talent Acquisition', '2021-02-28'),
(8, 'Henry Wilson', 'Marketing', 'Digital Marketer', '2018-12-12'),
(9, 'Irene Martinez', 'Sales', 'Account Manager', '2019-08-05'),
(10, 'John Taylor', 'Engineering', 'Project Manager', '2020-04-17');

INSERT INTO PerformanceMetrics (MetricID, EmployeeID, ProjectCompletionRate, TotalTasksCompleted, AverageTrainingHours, EmployeeSatisfactionScore, PerformanceReviewDate) VALUES
(1, 1, 85, 45, 20, 4.5, '2023-12-01'),
(2, 2, 90, 50, 15, 4.7, '2023-12-01'),
(3, 3, 80, 30, 10, 4.2, '2023-12-01'),
(4, 4, 88, 40, 25, 4.6, '2023-12-01'),
(5, 5, 75, 35, 18, 4.1, '2023-12-01'),
(6, 6, 92, 55, 30, 4.9, '2023-12-01'),
(7, 7, 78, 28, 12, 3.8, '2023-12-01'),
(8, 8, 85, 47, 22, 4.4, '2023-12-01'),
(9, 9, 77, 33, 20, 4.0, '2023-12-01'),
(10, 10, 89, 48, 28, 4.5, '2023-12-01');

INSERT INTO Training (TrainingID, EmployeeID, TrainingProgram, TrainingHours, CompletionDate) VALUES
(1, 1, 'Agile Methodologies', 10, '2023-06-15'),
(2, 2, 'Digital Marketing', 8, '2023-06-20'),
(3, 3, 'Employee Relations', 6, '2023-06-10'),
(4, 4, 'Cloud Computing', 12, '2023-06-25'),
(5, 5, 'Sales Techniques', 5, '2023-06-30'),
(6, 6, 'Data Analysis', 15, '2023-06-05'),
(7, 7, 'Recruitment Strategies', 8, '2023-06-12'),
(8, 8, 'Content Marketing', 7, '2023-06-18'),
(9, 9, 'Negotiation Skills', 6, '2023-06-28'),
(10, 10, 'Project Management Basics', 10, '2023-06-15');

INSERT INTO Feedback (FeedbackID, EmployeeID, FeedbackDate, FeedbackType, Comments) VALUES
(1, 1, '2023-12-01', 'Positive', 'Excellent problem-solving skills.'),
(2, 2, '2023-12-01', 'Positive', 'Great leadership and teamwork.'),
(3, 3, '2023-12-01', 'Neutral', 'Needs improvement in time management.'),
(4, 4, '2023-12-01', 'Positive', 'Very proactive and reliable.'),
(5, 5, '2023-12-01', 'Negative', 'Needs more engagement with clients.'),
(6, 6, '2023-12-01', 'Positive', 'Exceptional analytical skills.'),
(7, 7, '2023-12-01', 'Neutral', 'Good work ethic, but could improve communication.'),
(8, 8, '2023-12-01', 'Positive', 'Creative approach to marketing challenges.'),
(9, 9, '2023-12-01', 'Negative', 'Needs to work on conflict resolution skills.'),
(10, 10, '2023-12-01', 'Positive', 'Strong project management capabilities.');

SELECT 
    Department,
    AVG(ProjectCompletionRate) AS AvgProjectCompletionRate
FROM 
    Employees e
JOIN 
    PerformanceMetrics p ON e.EmployeeID = p.EmployeeID
GROUP BY 
    Department;

SELECT 
    e.EmployeeID,
    e.Name,
    SUM(t.TrainingHours) AS TotalTrainingHours
FROM 
    Employees e
JOIN 
    Training t ON e.EmployeeID = t.EmployeeID
GROUP BY 
    e.EmployeeID, e.Name;

CREATE VIEW DepartmentPerformance AS
SELECT 
    e.Department,
    COUNT(e.EmployeeID) AS TotalEmployees,
    AVG(p.ProjectCompletionRate) AS AvgProjectCompletionRate,
    AVG(p.TotalTasksCompleted) AS AvgTasksCompleted,
    AVG(p.EmployeeSatisfactionScore) AS AvgSatisfactionScore
FROM 
    Employees e
JOIN 
    PerformanceMetrics p ON e.EmployeeID = p.EmployeeID
GROUP BY 
    e.Department;

CREATE VIEW EmployeeTrainingSummary AS
SELECT 
    e.EmployeeID,
    e.Name,
    e.Department,
    SUM(t.TrainingHours) AS TotalTrainingHours,
    COUNT(t.TrainingID) AS TrainingsCompleted
FROM 
    Employees e
JOIN 
    Training t ON e.EmployeeID = t.EmployeeID
GROUP BY 
    e.EmployeeID, e.Name, e.Department;
    
