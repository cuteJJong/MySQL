/*
Date : 07 - 22
Objective : Basic Select
Environment : Windows 11 ,MySQL ,

*/

SELECT *
FROM emp;

SELECT ename "Name" , sal AS "Salary", sal * 12 + IFNULL(comm, 0) AS "Annual Salary"
FROM emp;

SELECT CONCAT(ename, '의 봉급은 ', sal, ' 입니다 .')
FROM emp;

# REM Literals(상수)
SELECT CONCAT(dname, ' is located at ', loc)
FROM dept;
#Duplicate Values(중복 행 제거)
SELECT /*ALL*/ DISTINCT job
FROM emp;

# DISTINCT  //중복제거
SELECT DISTINCT deptno
FROM emp;

# where 절   : 자신이 원하는 자료만 검색하기 위해
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE ename = 'SMITH';

#문제 1982년에 입사한 사람을 조회하는 4가지 방법

/* 비교연산자
--<, >, <=, >=, =, !=, <>(같지 않다)
 */
SELECT ename, job, deptno
FROM emp
WHERE job = 'CLERK';

SELECT empno, ename, job
FROM emp
WHERE empno = 7934;

SELECT empno, ename, job, hiredate
FROM emp
WHERE hiredate = '1981-12-03';

#1980년에 입사한 직원 조회
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1980-01-01' AND hiredate <= '1980-12-31';

# SQL 연산자
#1987년에 입사한 사원의 이름과 봉급과 입사날짜를 출력 //두 번째 방법
#BETWEEN
SELECT ename, sal, hiredate
FROM emp
WHERE hiredate BETWEEN '1987-01-01' AND '1987-12-31';

# 우리 회사 직원중에서 직무가 회사원이거나 분석가인 사원의 사원이름, 사원의 직무를 출력하시오.
#IN
SELECT ename, job
FROM emp
WHERE job IN('CLERK', 'ANALYST'); # ->  job= 'clerk' or job = 'analyst'

#LIKE(%,_)
SELECT ename
FROM emp
WHERE ename LIKE'S%';   # %T T로 끝나는

SELECT ename
FROM emp
WHERE ename LIKE'SMIT_';   # _ 한글자만 모를 때

SELECT ename
FROM emp
WHERE ename LIKE'%I%';

#3 1987년에 입사한 사람 3번째
SELECT ename, job, hiredate
FROM emp
WHERE hiredate LIKE '1987%';

# IS NULL / IS NOT NULL
#우리 회사 직원 중에 보너스를 받는 사람
SELECT empno, ename, comm, deptno
FROM emp
WHERE comm IS NOT NULL;

#ORDER BY
#입사일 기준 내림차순(DESC), 오름차순(ASC)
SELECT empno, ename, hiredate, sal
FROM emp
Order by hiredate DESC, sal ASC;

#DESCRIBE
#테이블의 구조(열 이름, 데이터 유형, 키 정보 등)를 확인하려면 DESCRIBE 명령을 사용

DESCRIBE emp;



