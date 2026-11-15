/*
Q1. Parental Education and Student Math Performance
Stakeholder requirement
The academic management team wants to understand whether students whose parents have different educational backgrounds demonstrate differences in mathematics performance.
They want to identify the parental education categories where the average mathematics score is higher than the overall average mathematics score of all students.

Business question
"Which parental education categories have an average math score greater than the overall average math score of all students?"

Expected output
Column	Description
parental level of education	Parent's education category
average_math_score	Average math score for that category

SQL concepts to apply
- CTE
- Scalar subquery
- GROUP BY
- AVG
- Comparison operator
Analytical purpose: Identify parental education categories whose students perform above the overall mathematics average.
*/

WITH avg_math_score_calc AS (
    SELECT
        "parental level of education",
        ROUND(AVG("math score"), 2) AS avg_math_score
    FROM project_4_students_performance_in_exams
    GROUP BY "parental level of education"
    HAVING AVG("math score") > (
        SELECT 
            AVG("math score")
        FROM project_4_students_performance_in_exams
    )
)

SELECT
    "parental level of education",
    avg_math_score
FROM avg_math_score_calc
ORDER BY "parental level of education" ASC;

/*
Q2. Comparison of Student Performance Based on Test Preparation Course
Stakeholder requirement:

The academic management team wants to evaluate the academic performance of students based on their test preparation course status. They want to compare the average mathematics, reading, and writing scores across male and female students.

Business question:

"Compare the average mathematics, reading, and writing scores of male and female students based on their test preparation course status (completed or none). Use a supplementary lookup table to map each preparation status to a course delivery mode (Online or Offline), and present the subject-wise average scores for each gender and delivery mode."
Expected output
Column	Description
gender	Male / Female
mode	Online / Offline
average_math_score	Average mathematics score
average_reading_score	Average reading score
average_writing_score	Average writing score

Dummy table details
Table name: test_preparation_lookup
test_preparation_course (PK)	mode
completed	Online
none	Offline

SQL concepts
1. CTE
2. INNER JOIN
3. GROUP BY
4. Aggregate functions
5. ORDER BY
*/

CREATE TABLE test_preparation_mode (
    "test_preparation_course" VARCHAR NOT NULL,
    "mode" VARCHAR NOT NULL
)

INSERT INTO test_preparation_mode ("test_preparation_course" , "mode")
VALUES 
    ('completed', 'Online'),
    ('none', 'Offline')

SELECT * FROM test_preparation_mode


WITH mode_of_learning_inclusion AS (
    SELECT 
        org_tab.gender AS gender, 
        dum_tab.mode AS "mode",
        org_tab."math score" AS math_score,
        org_tab."reading score" AS reading_score,
        org_tab."writing score" AS writing_score
    FROM project_4_students_performance_in_exams AS org_tab
    INNER JOIN test_preparation_mode AS dum_tab
        ON org_tab."test preparation course" = dum_tab.test_preparation_course
)

SELECT 
    gender,
    "mode",
    ROUND(AVG(math_score), 2) AS avg_of_math_score,
    ROUND(AVG(reading_score), 2) AS avg_of_reading_score,
    ROUND(AVG(writing_score), 2) AS avg_of_writing_score
FROM mode_of_learning_inclusion
GROUP BY gender, "mode"
ORDER BY gender ASC, "mode" ASC;

/*
Q3. Student Performance Ranking Within Each Gender
Stakeholder requirement:

The academic management team wants to identify the top-performing students within each gender based on their overall academic performance. They want students ranked separately for male and female categories.

Business question:

"Rank students within each gender based on their total score across mathematics, reading, and writing. Display the top 5 students in each gender category."

Expected output:
- gender
- total_score
- gender_rank
Mandatory SQL concept: Window Function (RANK())

Other SQL concepts: CTE, arithmetic operations, ORDER BY, filtering.

One dataset limitation: There is no student ID or name in the dataset. Therefore, we will use the row-level records and display the calculated total score and rank, rather than identifying individual students by name.

Does this business question look good? We'll finalize it before writing the SQL.
*/

WITH total_scores_calc AS (
    SELECT
        gender, 
        "math score" + "reading score" + "writing score" AS total_scores
    FROM project_4_students_performance_in_exams
),

rank_calc AS (
    SELECT
        gender, 
        total_scores,
        RANK() OVER (
            PARTITION BY "gender"
            ORDER BY total_scores DESC
        ) AS gender_rank
    FROM total_scores_calc
)

SELECT
    gender,
    total_scores,
    gender_rank
FROM rank_calc
WHERE gender_rank <= 5
ORDER BY gender ASC;

/*
Q4. Comparison of High-Performing Students Based on Test Preparation
Stakeholder requirement:

The academic management team wants to understand whether students who completed the test preparation course perform differently from those who did not. They want to compare the number of high-performing students in each subject.

Business question:

"Compare students who completed and did not complete the test preparation course. For each group, calculate the total number of students and the number of students who scored 80 or above in mathematics, reading, and writing. Combine the results using a set operator."

Expected output:
- test_preparation_course
- total_students
- high_math_scorers
- high_reading_scorers
- high_writing_scorers
Mandatory SQL concepts:
- CTE
- UNION ALL
- Conditional Aggregation using SUM(CASE WHEN...)
Other SQL concepts:
- COUNT()
- Aggregate functions
Important: We'll use 80 as the threshold for a high score in all three subjects.
*/

SELECT 
    'completed' AS "status",
    COUNT(*) AS total_students,
    COUNT(
        CASE
            WHEN "math score" >= 80 THEN 1
        END 
    ) AS high_math_scorers,
    COUNT(
        CASE 
            WHEN "reading score" >= 80 THEN 1
        END
    ) AS high_reading_scorers,
    COUNT(
        CASE 
            WHEN "writing score" >= 80 THEN 1
        END
    ) AS high_writing_scorers
FROM project_4_students_performance_in_exams
WHERE "test preparation course" = 'completed'

UNION

SELECT
    'none' AS "status",
    COUNT(*) AS total_students,
    COUNT(
        CASE 
            WHEN "math score" >= 80 THEN 1
        END
    ) AS high_math_scorers,
    COUNT(
        CASE 
            WHEN "reading score" >= 80 THEN 1
        END
    ) AS high_reading_scorers,
    COUNT(
        CASE 
            WHEN "writing score" >= 80 THEN 1
        END
    ) AS high_writing_scorers
FROM project_4_students_performance_in_exams
WHERE "test preparation course" = 'none'



