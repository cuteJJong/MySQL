/*
Date : 07 - 24
Objective : Basic Insert
Environment : Windows 11 ,MySQL Workbench 8.0, MySQL Community Server 8.0.33
*/

use mycompany;

SELECT * FROM dept;

#INSERT
INSERT INTO dept
VALUES (50, 'Design', 'Busan');

INSERT INTO dept(deptno, dname, loc)
VALUES(60, 'Development', 'Taejeon');

#명시적 NULL
INSERT INTO dept(deptno, dname,loc)
VALUES(70, NULL, 'Inchon');

#암시적 NULL
INSERT INTO dept(deptno, loc)
VALUES(80,'Seoul');

# INSERT INTO dept(dname, loc) 제약조건 지켜야한다.
# VALUES('Account', 'Yongin');

#INSERT에서 현재 날짜는 CURDATE() 사용, NOW() -> 시,분,초

INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES(9998, 'Jimin', CURDATE(),80);

#Table 복제
CREATE TABLE emp_copy
AS
SELECT empno, ename, sal, hiredate
FROM emp
WHERE deptno = 10;

#스키마만 복사(data=X)
CREATE TABLE emp_copy1
AS
SELECT *
FROM emp
WHERE 0 = 1;

INSERT INTO emp_copy1(empno, ename)
VALUES(1111,'한지민');

SELECT * FROM emp_copy1;

INSERT INTO emp_copy(empno, ename, hiredate, deptno)
VALUES (6666, '한라산', STR_TO_DATE('20080501', '%Y%m%d'), 30);

#INSERT문으로 복제
#사원테이블에서 부서번호 10번의 레코드만 emp_clone 으로 복사하시오.
INSERT INTO emp_clone(empno, ename, sal, hiredate)
SELECT empno, ename, sal, hiredate
FROM emp
WHERE deptno = 10;

#UPDATE문
/*
1. 기본 행 수정
2. 필요한 경우 한번에 여러 행 갱신 가능
 */

SELECT * FROM dept;

UPDATE dept
SET dname = 'FINANCE'
WHERE deptno = '70';

UPDATE dept
SET dname = 'HR', loc = 'Busan'
WHERE deptno = 70;