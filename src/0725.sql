/*
Date : 07 - 25
Objective : Basic Select
Environment : Windows 11 ,MySQL ,

*/

se mycompany;

--1987년에 입사한 사원 정보를 출력하시오
SELECT empno, ename, hiredate
FROM emp
         #WHERE hiredat >= '1987-01-01' AND hidirdate <= '1987-01-01';
#WHERE hiredat BETWEEN '1987-01-01' AND '1987-01-01';
#WHERE hiredate LIKE '1987%';
WHERE YEAR(hiredate) = 1987;

/*
REM DML과 TRANSACTION
DDL 명령어인 경우에는 직접 Database의 table에 영향을 미치기 때문에 DDL명령어를 입력
하는 순간 명령어에 해당하는 작업이 즉시(AUTO COMMIT) 완료된다.
하지만, DML 명령어의 경우, 조작하려는 table을 memory buffer에 올려놓고 작업을 하기
때문에 실시간으로 table에 영향을 미치는 것이 아니다.
따라서 buffer에서 처리한 DML 명령어가 실제 table에 반영되기 위해서는 COMMIT 명령어를
입력하여 Transaction을 종료해야 한다.
table의 전체 data를 삭제하는 경우, System 활용 측면에서는 삭제된 data를 log로 저장하는
DELETE TABLE 보다는 System 부하가 적은 TRUNCATE TABLE을 권고한다.
단, TRUNCATE TABLE의 경우 삭제된 data의 log가 없으므로 ROLLBACK이 불가능하므로
주의해야 한다.
*/

# TCL(Tracnsaction Control Language)
# 1)COMMIT : 보류중인 데이터를 영구적인 데이타베이스로 변경사항을 저장하고 현재의
# TRANSACTION 을 종료한다.
# 2)ROLLBACK [TO SAVEPOINT name]: 보류중인 데이터의 변경사항을 모두 되돌리고 현재의
# 트랜젝션을 종료한다. 만일 특정지점을 지정하지 않으면 모든 트랜젝션 취소한다.
# 3)SAVEPOINT name :현재의 트랜젝션의 저장점을 표시한다.

START TRANSACTION;

SELECT * FROM emp
WHERE empno = 7782;

UPDATE emp
SET deptno = 30
WHERE empno = 7782;

SAVEPOINT a;

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7999, 'TOM', 'SALESMAN', 7782, CURDATE(), 2000, 2000, 10);

ROLLBACK TO a;

#DATA TYPE
1. CHAR
    1) 고정길이의 문자 데이타
    2) 기본값 및 최소크기 : 1Byte
    3) 최대크기 255Bytes
    4)나머지 공간을 여백으로 채워서 처음 정의된 공간을 모두 사용하는 타입
2. VARCHAR
    1) Variable Character의 약자
    2) 가변길이의 문자 데이타
    3) 기본값 및 최소 크기 : 1Byte
    4) 최대크기 : 65535Bytes
    5) 여백으로 채우지 않고 필요한 공간만 사용
4. 정수
    1) TINYINT(1), SMALLINT(2), INT(4), BIGINT(8)
    2) 부호없는 정수를 저장할 때는 UNSIGNED 예약어를 뒤에 붙여준다.
5. 실수
    1) 숫자값을 -38자리 ~ 38자리(-308자리 ~ 308자리) 저장
    2) MySQL 부동소수점 자료형
        -float  , -double
6.DATE
    -DATE, DATETIME, TIMESTAMP, YEAR, TIME

-SUB_QUERY 에 의해 검색된 테이블과 동일한 구조로 생성
-테이블 복사, CTAS(Create Table ~ As Select ~)방법
-주의할 점은 기존 테이블의 제약조건이 모두 없어진다는 점

#테이블 생성 AS를 이용한
CREATE TABLE emp20
AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 20;

SELECT * FROM emp20;

DROP TABLE emp20;

#컬럼 추가
ALTER TABLE emp20
    ADD age TINYINT AFTER ename;

#컬럼삭제
ALTER TABLE emp20
DROP COLUMN sal;

ALTER TABLE emp20
    MODIFY ename VARCHAR(20);


CREATE TABLE Jusorok
(
    bunho SMALLINT,
    gender CHAR(6) DEFAULT 'male'
);

INSERT INTO jusorok VALUE(1, 'FEMALE');
INSERT INTO jusorok VALUES(2, DEFAULT);