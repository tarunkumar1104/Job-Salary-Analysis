-- ============================================
-- Job Salary Analysis - SQL Queries
-- Dataset: job_prediction.csv (250,000 rows)
-- Author: tarunkumar1104
-- ============================================

-- ─── CREATE TABLE ───────────────────────────
CREATE TABLE job_prediction (
    job_title         VARCHAR(100),
    experience_years  INT,
    education_level   VARCHAR(50),
    skills_count      INT,
    industry          VARCHAR(50),
    company_size      VARCHAR(50),
    location          VARCHAR(100),
    remote_work       VARCHAR(10),
    certifications    INT,
    salary            INT
);

-- ─── 1. AVERAGE SALARY BY JOB TITLE ────────
SELECT job_title,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total_jobs
FROM   job_prediction
GROUP  BY job_title
ORDER  BY avg_salary DESC;

-- ─── 2. SALARY BY EDUCATION LEVEL ──────────
SELECT education_level,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total
FROM   job_prediction
GROUP  BY education_level
ORDER  BY avg_salary DESC;

-- ─── 3. SALARY BY INDUSTRY ──────────────────
SELECT industry,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total_jobs
FROM   job_prediction
GROUP  BY industry
ORDER  BY avg_salary DESC;

-- ─── 4. REMOTE WORK vs SALARY ───────────────
SELECT remote_work,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total
FROM   job_prediction
GROUP  BY remote_work
ORDER  BY avg_salary DESC;

-- ─── 5. EXPERIENCE BAND ANALYSIS ────────────
SELECT
  CASE
    WHEN experience_years BETWEEN 0  AND 4  THEN '1. Junior (0-4 yrs)'
    WHEN experience_years BETWEEN 5  AND 9  THEN '2. Mid (5-9 yrs)'
    WHEN experience_years BETWEEN 10 AND 14 THEN '3. Senior (10-14 yrs)'
    ELSE '4. Expert (15+ yrs)'
  END AS experience_band,
  ROUND(AVG(salary), 0) AS avg_salary,
  COUNT(*)              AS total
FROM   job_prediction
GROUP  BY experience_band
ORDER  BY experience_band;

-- ─── 6. CERTIFICATIONS IMPACT ───────────────
SELECT certifications,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total
FROM   job_prediction
GROUP  BY certifications
ORDER  BY certifications ASC;

-- ─── 7. COMPANY SIZE vs SALARY ──────────────
SELECT company_size,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total
FROM   job_prediction
GROUP  BY company_size
ORDER  BY avg_salary DESC;

-- ─── 8. HIGH EARNERS (Above $200,000) ───────
SELECT job_title, education_level,
       experience_years, industry, salary
FROM   job_prediction
WHERE  salary > 200000
ORDER  BY salary DESC
LIMIT  20;

-- ─── 9. SALARY BAND DISTRIBUTION ────────────
SELECT
  CASE
    WHEN salary < 80000              THEN '1. Low (<$80K)'
    WHEN salary BETWEEN 80000 AND 129999 THEN '2. Mid ($80K-$130K)'
    WHEN salary BETWEEN 130000 AND 199999 THEN '3. High ($130K-$200K)'
    ELSE '4. Very High (>$200K)'
  END AS salary_band,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / 250000, 2) AS percentage
FROM   job_prediction
GROUP  BY salary_band
ORDER  BY salary_band;

-- ─── 10. TOP JOB + EDUCATION COMBO ──────────
SELECT job_title, education_level,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)              AS total
FROM   job_prediction
GROUP  BY job_title, education_level
ORDER  BY avg_salary DESC
LIMIT  15;
