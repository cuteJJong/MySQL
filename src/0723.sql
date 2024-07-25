/*
Date : 07 - 23
Objective : Basic Select
Environment : Windows 11 ,MySQL Workbench 8.0, MySQL Community Server 8.0.33
*/

use mycompany;
/*
여러행 다중 함수
1)AVG
2)COUNT
3)MAX
4)MIN
5)SUM
6)STDDEV
7)VARIANCE
*/


#NULL 은 계산에서 제외됨
SELECT AVG(comm), AVG(IFNULL(comm, 0)) /*앞에는 comm을 받는 사람만 계산, 뒤에는 모든 comm받는사람*/
FROM emp;

#COUNT (전체 행 수 세기)
#*을 사용하면 중복 행 및 NULL 값을 가진 행을 포함하여 선택한 행 모두를 계산
SELECT deptno
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE deptno = 30;

SELECT COUNT(job)
FROM emp;

SELECT AVG(comm), AVG(IFNULL(comm,0)), SUM(IFNULL(comm,0)) / COUNT(*)
FROM emp;

SELECT COUNT(DISTINCT(job))
FROM emp;

#MIN, MAX
SELECT MIN(hiredate), MAX(hiredate)
FROM emp;

# GROUP BY
# GROUPT BY 절엔 열을 포함, 열 별칭(AS) 사용X, 자동 오름차순 정렬
# SELECT 절에서 GROUP 함수(복수행 함수)와 column이 같이 기술되면, 반드시 GROUP BY 절이 기술되어야 한다.

/*SELECT MAX(sal)   error GROUP BY 절을 포함 해줘야한다.
FROM emp
WHERE sal = MAX(sal);
 */

    SELECT deptno, AVG(sal), MIN(sal), MAX(sal)
  FROM emp
  GROUP BY deptno
  HAVING deptno;

SELECT job, SUM(sal)
FROM emp
GROUP BY job;

SELECT YEAR(hiredate), COUNT(*)
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY YEAR(hiredate);

#SELECT 절에 복수행함수만 기술되고, column을 사용하지 않았다면 GROUP BY를 필요로 하지 않는다
SELECT MAX(sal), MIN(sal), SUM(sal), AVG(sal)
FROM emp;

#Multiple Grouping
#부서별, 업무별로 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하시오.
SELECT deptno, job, COUNT(*), AVG(sal), SUM(sal)
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC, job DESC;

#HAVING
/*
1.WHERE 절에서는 복수행 함수를 사용할 수 없다.
2.GROUP BY의 조건절은 HAVING 이다.
 */

#부서멤버가 4명 이상인 부서만
SELECT deptno, COUNT(*), SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*) >= 4;

#사원테이블에서 업무별 급여의 평균이 3000불 이상인 업무에 대해, 업무명, 평균급여,급여의 합을 구하시오.
SELECT job, AVG(sal), SUM(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= 3000;

#사원테이블에서 전체 월급이 5000불을 초과하는 각 업무에 대해 업무이름과 월 급여의 합계를 출력하라. (셤 문제)
# 단, 판매원은 제외하고 월급여 합계의 내림차순으로 출력하라
SELECT job, SUM(sal)
FROM emp
WHERE job NOT LIKE 'SA%'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal) DESC ;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

# ORDER BY 절 사용 가능
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno
ORDER BY AVG(sal);

/*그룹 결과 제외 : HAVING 절
1)WHERE 를 사용하여 행을 제한하는 것과 같이 HAVING 절을 사용하여 그룹을 제한
2)그룹 함수의 결과를 기반으로 행을 제한할 경우 GROUP BY 절 및 HAVING 절이 모두 있어야
3)주의할 점 : WHERE 절로 그룹을 제한할 수 없음
 */


#ROLLUP
/*
1.GROUP BY절과 함께 사용
2.GROUP BY절에 의해서 그룹핑 된 집합 결과에 대해 좀 더 상세한 정보를 반환하는 기능을 수행
3.보통 SELECT 절에 ROLLUP을 사용함으로써 보통의 SELECT된 데이터와 그 데이터의 총계를 구할 수 있다.
*/

SELECT job, SUM(sal)
FROM emp
GROUP BY job;

#ROLLUP을 사용해서 직무별로 급여 합계의 총계를 구한다.
SELECT job, SUM(sal)
FROM emp
GROUP BY job
WITH ROLLUP;

SELECT deptno,job, SUM(sal)
FROM emp
GROUP BY deptno,job
    WITH ROLLUP;

#JOIN
/*
1. 한개 이상의 테이블로부터 데이터를 조회하는 것
2. 주로 Primary-Key와 Foreign-Key의 관계를 가진 컬럼을 소유하고 있는 테이블을 통한 검색
시 사용
 */

#CROSS JOIN
SELECT emp.ename, emp.sal, emp.deptno, dept.loc, salgrade.grade
FROM emp CROSS JOIN dept CROSS JOIN salgrade;

#NATURAL JOIN (비 표준join)
    #--사원이름 SMITH의 부서번호와 근무지를 출력
SELECT ename, dept.deptno, loc
FROM dept, emp
WHERE dept.deptno = emp.deptno AND ename = 'SMITH';

SELECT ename, loc
FROM emp NATURAL JOIN dept
WHERE ename = 'SMITH';

#별칭 사용가능
SELECT ename, d.deptno, loc
FROM dept d, emp e
WHERE d.deptno = e.deptno AND ename = 'SMITH';

#JOIN ~ USING
SELECT ename, loc
FROM emp INNER JOIN dept USING(deptno)
WHERE ename = 'SMITH';

#JOIN ~ ON
SELECT ename, loc
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE ename = 'SMITH';

# world database로 이동
use world;
show tables;

SELECT city.name, city.Population, country.name, country.IndepYear, countrylanguage.Language
FROM city JOIN country ON (city.countrycode = country.code)
          JOIN countrylanguage ON (country.code = countrylanguage.countrycode)
WHERE city.name = 'SEOUL';


use mycompany;
# NON-EQUI JOIN (비등가조인)
# 84 1. emp table과 salgrade table간의 관계
# 85 2. 두개의 테이블사이에 직접 대응하는 열이 없다.
# 86 3. 이 관계는 =을 제외한 연산자를 사용하여 형성
SELECT ename, sal, grade
FROM emp, salgrade
WHERE (sal BETWEEN losal AND hisal )AND ename = 'SMITH';


#OUTER JOIN
    SELECT emp.ename, emp.empno, dept.dname, dept.loc
FROM emp RIGHT OUTER JOIN dept ON(emp.deptno = dept.deptno)
# FROM emp INNER JOIN dept ON(emp.deptno = dept.deptno)

#LEFT OUTER JOIN을 수행하기 위해 DEPT에 없는 부서 번호 50번 사원을 입력한다.

CREATE TABLE emp1   #테이블 복사
AS
SELECT * FROM emp;

INSERT INTO emp1(empno, ename, sal, job, deptno)    #JACK생성
    VALUES(8282, 'JACK', 3000, 'ANALYST', 50);

SELECT e.ename, e.job, e.sal, d.loc, d.dname
FROM emp1 e LEFT OUTER JOIN dept d
                            ON (e.deptno = d.deptno);

#SELF JOIN
    #별칭을 써 줘야한다.
SELECT CONCAT(employee.ename, '의 관리자의 이름은 ' , employer.ename, '입니다.')
FROM emp employee JOIN emp employer
ON employee.mgr = employer.empno
#WHERE employee.ename = 'SMITH';

#UNION ALL
SELECT job, deptno
FROM emp
WHERE sal >= 3000
UNION ALL   #ALL있으면 중복허용
SELECT job, deptno
FROM emp
WHERE deptno = 10

    #Subquery
다른 SELECT 문의 절에 삽입된 SELECT 문테이블 자체의 데이터에 종속된 조건을
사용해서 테이블에서 행을 선택할 때 유용
   WHERE 절, SELECT 절, FROM 절에서 사용


--사번 7566의 급여보다 많이 받는 사원의 이름
SELECT sal FROM emp WHERE empno = 7566;
SELECT ename
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE empno > 7566);
--SMITH는 어디서 근무하는가
--단일 행 서브 쿼리
SELECT loc
FROM dept
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');

--부서에서 최소 급여를 받는 사원
--여러 행 서브 쿼리
IN(1300.00, 800,00, 950.00)
SELECT ename, deptno, sal
FROM emp
WHERE sal IN(SELECT MIN(sal)
             FROM emp
             GROUP BY deptno);