# Students Performance in Exams – SQL Analysis

## Project Overview

This project focuses on analyzing students' academic performance using PostgreSQL. The analysis explores the relationship between students' demographic backgrounds, parental education, lunch type, test preparation course status, and their performance in Mathematics, Reading, and Writing.

The project uses SQL to perform data aggregation, comparisons, ranking, and performance analysis. It demonstrates practical applications of SQL concepts through four business questions.

## Dataset Overview

**Dataset Name:** Students Performance in Exams

**Dataset Source:** [Kaggle – Students Performance in Exams](https://www.kaggle.com/datasets/spscientist/students-performance-in-exams)

**Dataset Statistics:**
- Total Records: 1,000
- Total Columns: 8
- Missing Values: None
- Duplicate Records: None

### Dataset Columns

| Column | Description |
|---|---|
| gender | Gender of the student |
| race/ethnicity | Student's race/ethnicity group |
| parental level of education | Highest education level of the student's parent |
| lunch | Type of lunch received by the student |
| test preparation course | Test preparation course completion status |
| math score | Mathematics examination score |
| reading score | Reading examination score |
| writing score | Writing examination score |

## Project Objectives

1. Analyze academic performance across different parental education categories.
2. Compare subject-wise average scores based on gender and test preparation course status.
3. Identify and rank students based on their overall academic performance within each gender.
4. Compare the number of high-performing students based on test preparation course completion status.

## Business Questions and SQL Analysis

### Q1. Parental Education and Mathematics Performance

**Business Requirement:**

Academic management wants to identify parental education categories whose students achieve an average Mathematics score greater than the overall average Mathematics score of all students.

**Analysis:**
- Calculate the average Mathematics score for each parental education category.
- Calculate the overall average Mathematics score.
- Identify categories with an average Mathematics score strictly greater than the overall average.

**SQL Concepts Used:**
- Common Table Expressions (CTEs)
- Scalar Subquery
- GROUP BY
- AVG()
- HAVING
- ORDER BY

### Q2. Comparison of Student Performance Based on Test Preparation Course

**Business Requirement:**

Academic management wants to compare the average Mathematics, Reading, and Writing scores of male and female students based on their test preparation course status (completed or none).

A supplementary lookup table is used to map each preparation status to a course delivery mode (Online or Offline).

**Analysis:**
- Compare students based on gender and course delivery mode.
- Calculate average Mathematics, Reading, and Writing scores for each group.
- Present the subject-wise average scores.

**Expected Output:**
- Gender
- Course Delivery Mode
- Average Mathematics Score
- Average Reading Score
- Average Writing Score

**SQL Concepts Used:**
- Common Table Expressions (CTEs)
- INNER JOIN
- GROUP BY
- AVG()
- ORDER BY

### Q3. Student Performance Ranking Within Each Gender

**Business Requirement:**

Academic management wants to identify the top-performing students within each gender based on their overall academic performance.

**Analysis:**
- Calculate the total score of each student across Mathematics, Reading, and Writing.
- Rank students separately within each gender.
- Display students belonging to the top five ranks in each gender category.

**Total Score Calculation:**

Total Score = Mathematics Score + Reading Score + Writing Score

**Expected Output:**
- Gender
- Total Score
- Gender Rank

**SQL Concepts Used:**
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- PARTITION BY
- ORDER BY
- Filtering

### Q4. High-Performing Students Based on Test Preparation Course

**Business Requirement:**

Academic management wants to compare students who completed and did not complete the test preparation course based on the number of students achieving scores of 80 or above in each subject.

**Analysis:**
- Calculate the total number of students in each test preparation category.
- Count students scoring 80 or above in Mathematics.
- Count students scoring 80 or above in Reading.
- Count students scoring 80 or above in Writing.
- Combine the results for both preparation categories using a set operator.

**Expected Output:**
- Test Preparation Course Status
- Total Students
- High Mathematics Scorers
- High Reading Scorers
- High Writing Scorers

**SQL Concepts Used:**
- Common Table Expressions (CTEs)
- Set Operators (UNION ALL)
- Conditional Aggregation
- CASE WHEN
- COUNT()

## SQL Concepts Covered

The project demonstrates the following SQL concepts:

| Category | SQL Concepts |
|---|---|
| Query Fundamentals | SELECT, WHERE, ORDER BY |
| Aggregate Functions | COUNT(), AVG() |
| Grouping | GROUP BY, HAVING |
| Subqueries | Scalar Subqueries |
| Joins | INNER JOIN |
| Common Table Expressions | CTEs |
| Window Functions | RANK(), PARTITION BY |
| Set Operators | UNION ALL |
| Conditional Logic | CASE WHEN |
| Conditional Aggregation | COUNT(CASE WHEN...) |

## Database Information

**Database Management System:** PostgreSQL

**Schema:** public

**Main Table:** `project_4_students_performance_in_exams`

**Supplementary Lookup Table:** `test_preparation_mode`

## Important Notes

1. The original dataset does not contain a student ID or student name. Therefore, the ranking analysis uses the available student records and calculated total scores.
2. The supplementary `test_preparation_mode` table was created specifically for practicing JOIN operations.
3. The mapping of `completed` to `Online` and `none` to `Offline` is illustrative and does not represent actual course delivery modes in the original dataset.
4. A score of 80 or above is considered a high score for the analysis in Q4.
5. The original CSV dataset is not included in this repository. Refer to the dataset source link to obtain it.

## Repository Structure

```text
P4_Students-Performance-in-Exams_SQL/
│
├── project_4_students_performance_in_exams.sql
├── P4_Students Performance in Exams.txt
└── README.md
```

## Tools and Technologies

- PostgreSQL
- pgAdmin 4
- SQL

## Project Outcome

This project demonstrates the application of SQL for analyzing academic performance data through aggregation, subqueries, joins, window functions, set operations, and conditional aggregation. It provides practical experience in translating business requirements into SQL queries and generating meaningful analytical outputs.
