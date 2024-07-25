# 우리 회사 직원 중 20번 부서 또는 30번 부서의 연봉 내림차순으로 설명하시오
SELECT deptno, ename, (sal + IFNULL(comm, 0)) * 12 AS Annual
FROM emp
WHERE deptno IN (20, 30)
ORDER BY Annual DESC;

# 모든 사원에 대해 200$씩 급여차감을 계산한 후 출력결과를 "SAL-200"로 표시하는 SQL문을 작성하시오.
SELECT sal-200 AS "SAL-200"
FROM emp;

# 모든 사원에 대해 사원의 이름, 급여 및 연간 총수입을 표시하는 SQL문을 작성하시오. 단 연간총 수입은 년봉에 상여금 200$씩 합하여 출력해야 합니다.
SELECT ename AS "이름" , sal AS "급여" , sal*12 + 200 AS "연간 총 수입"
FROM emp;
#
모든 사원에 대해 다음과 같은 출력이 나오도록 SQL문을 작성하시오.
Monthly Salary
--------------------------------------
SMITH : 1 Month salary = 800 (이하생략)
SELECT CONCAT(ename,' : 1 Month salary = ', sal) AS "Monthly Salary"
FROM emp;

--모든 사원에 대해 사번, 이름, 급여, 담당업무를 표시하되 각각 열이름을 한글로 출력하게 하는
SQL문을 작성하시오.
SELECT empno AS "사번", ename AS "이름", sal "급여",job "담당업무"
FROM emp;

모든 사원에 대해 사번, 이름, 급여, 보너스(comm), 보너스금액을 출력하는 SQL문을
작성하시오. 단 보너스금액은 실급여(급여와 보너스의 합)에 10%를 더해서 출력합니다.
SELECT empno AS "사번", ename AS "이름", sal AS "급여", comm AS "보너스", (sal + IFNUll(comm,0)) * 1.1 AS "보너스 금액"
FROM emp;

부서에 대한 정보를 출력하되, 각 부서의 이름과 부서의 위치를 아래와 같은 형태로 출려하게 하는 SQL문을 작성하시오.
부서상세정보
----------------------------------
ACCOUNTING is at NEW YORK
SELECT CONCAT(dname, ' is at ', dept.loc) AS "부서상세정보"
FROM dept;

--모든 사원에 대해 이름과 연봉을 "KING : 1 Year Salary = 60000"형식으로 출력하되 칼
럼제목을 "Annual Salary"라고 출력하는 SQL문을 작성하시오.
SELECT CONCAT(ename, ' : 1 Year Salary = ', sal*12) AS "Annual Salary"
FROM emp;

--emp 테이블에서 담당하고 있는 업무는 모두 몇가지인가요?
SELECT DISTINCT job
FROM emp;

--부서별로 담당하는 업무를 출력하는 SQL문을 작성하시오.
SELECT DISTINCT deptno, job
FROM emp;

SELECT *
FROM dept;


# 63
# 64 SELECT DISTINCT deptno, job
    #        65 FROM emp;
# 66
# 67
#다음을 수행하고 혹시 Error가 난다면 올바르게 실행할 수 있도록 디버깅을 하시오.
#SELECT empno, ename, sal X 12 년 봉
#FROM emp;
SELECT empno, ename, sal * 12 AS "년 봉"
FROM emp;

#1983년 이후에 입사한 사원의 사번, 이름, 입사일을 출력하시오 (4가지).
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1981-01-01' AND hiredate <= '1981-12-31';

SELECT empno, ename, hiredate
FROM  emp
WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate LIKE '1981%';

SELECT empno, ename, hiredate
FROM emp
WHERE YEAR(hiredate) = 1981;


# 급여가 보너스(comm) 이하인 사원의 이름, 급여 및 보너스를 출력하시오.
SELECT ename, sal AS "급여", IFNULL(comm, 0) AS "보너스"
FROM emp
WHERE sal <= comm;

# 81 13. 관리자의 사원번호가 7902, 7566, 7788인 모든 사원의 사원번호,이름,급여 및 관리자의 사원번호를 출력하시오.
SELECT ename, empno, sal, mgr
FROM emp
WHERE mgr IN (7902, 7566, 7788);

# 83 14. 이름이 FORD 또는 ALLEN인 사원의 사번, 이름, 관리자 사원번호, 부서번호를 출력하시오.
SELECT empno, ename, mgr, deptno
FROM emp
WHERE ename = 'FORD' OR ename = 'ALLEN';

SELECT empno, ename, mgr, deptno
FROM emp
WHERE ename IN('FORD', 'ALLEN');


#job이 CLERK이면서 급여가 $1100 이상인 사원의 사번, 이름, 직위, 급여를 출력하시오.
SELECT empno, ename,job, sal
FROM emp
WHERE job = 'CLERK' AND sal >= 1000;

# 87 16. 직위가 CLERK, MANAGER, ANALYST가 아닌 모든 사원의 이름 및 직위를 출력하시오.
SELECT ename, job
FROM emp
WHERE job NOT IN('CLERK', 'MANAGER', 'ANALYST');
# 89 17. 두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
# 90 1) 직위가 PRESIDENT면서 급여가 1500을 넘어야 한다.
SELECT ename, job, sal
FROM emp
WHERE job = 'PRESIDENT' AND sal > 1500;
# 91 2) 직위가 SALESMAN이어야 한다.
SELECT ename, job, sal
FROM emp
WHERE job = 'SALESMAN';

#두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
#직위가 PRESIDENT 또는 SALESMAN이어야 한다 급여가 1500을 넘어야 한다.
SELECT ename, job, sal
FROM emp
WHERE job IN('PRESIDENT', 'SALESMAN') AND sal >= 1500;

#다음 2개의 쿼리를 생각해 보자.
SELECT empno, ename, job, sal
FROM emp
WHERE job= 'PRESIDENT' AND sal >= 2000 OR job = 'SALESMAN';

SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'PRESIDENT' OR job = 'SALESMAN') AND sal >= 2000;

# 107 20. emp Table에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여 총액이 많은 순서로 출력하라.
# 단, 커미션이 NULL인 사람은 제외한다.
SELECT ename, sal, comm, (sal + comm) AS 'total'
FROM emp
WHERE comm IS NOT NULL
ORDER BY total DESC;
#10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여,
#보너스 금액, 부서번호를 출력하라.
SELECT ename, sal, (sal * 0.13) AS 'bonus' , deptno
FROM emp
WHERE deptno = 10;

#30번 부서의 연봉을 계산하여 이름, 부서번호, 급여,
#연봉을 출력하라. 단, 연말에 급여의 150%를 보너스로 지급한다.
SELECT deptno,ename, empno, sal, (Sal * 12  + (sal * 1.5)) AS "연봉"
FROM emp
WHERE deptno = 30;
#부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라. 단, 1달의 근무일수는 12일이고,
#1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올림)을 출력하라
SELECT ename AS '이름', sal AS '급여', ROUND(sal / (12 * 5), 1) AS '시간당 임금'
FROM emp
WHERE deptno = 20;

#모든 사원의 실수령액을 계산하여 출력하라. 단, 이름, 급여, 실수령액을 출력하라.(실수령액은 금여에 대해 10%의 세금을 뺀 금액)
SELECT ename AS '이름', sal '급여', sal - (sal * 0.1) AS '실수령액'
FROM emp;

#dept 테이블의 구조와 내용을 조회하라.
SELECT *
FROM dept;

DESCRIBE dept;

# 118
# 119 26. dept 테이블에서 부서명과 위치를 연결하여 출력하라.
# 120
# 121 27. emp 테이블에서 사원번호가 7788인 사원의 이름과 부서번호를 출력하는 문장을 작성하시오.
# 122
# 123 28. emp Table에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여 총액이 많은 순서로 출
# 력하라. 단, 커미션이 NULL인 사람은 제외한다.
# 124
# 125 SELECT ename, sal, comm, sal +comm AS Total
                        #         126 FROM emp
                                               #         127 WHERE comm IS NOT NULL
                        #         128 ORDER BY Total DESC;
# 129
# 130
# 131 29. 10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여,
# 보너스 금액, 부서번호를 출력하라.
# 132
# 133 SELECT ename, sal, sal * 1.13, deptno
    #         134 FROM emp
                           #         135 WHERE deptno = 10;
# 136
# 137 30. 30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉을 출력하라. 단, 연말에 급여의 150%를 보너스로 지급한다.
# 138
# 139 SELECT ename, deptno, sal, (sal*12)+(sal*1.5)
    #         140 FROM emp
                           #         141 WHERE deptno = 30;
# 142
# 143
# 144 31. 부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라. 단, 1달의 근무일수는 12일이고,
# 1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올
# 림)을 출력하라
# 145
# 146 SELECT ename, sal, (sal/12)/5
    #         147 FROM emp
                           #         148 WHERE deptno = 20;
# 149
# 150
# 151 32. 부서번호가 10번인 부서의 사람 중 사원번호, 이름, 월급을 출력하시오
# 152
# 153 SELECT dname FROM DEPT WHERE deptno = 10;
# 154 SELECT empno, ename, sal
    #         155 FROM EMP
                           #         156 WHERE deptno = 10;
# 157
# 158
# 159 33. 사원번호가 7369번 인 사람의 이름, 입사일, 부서번호를 출력하시오.
# 160
# 161 34. 이름이 ALLEN인 사람의 모든 정보를 출력하시오.
# 162
# 163 35. 입사일이 1981년 9월 8일 사원의 이름, 부서번호, 월급을 출력하시오.
# 164
# 165 SELECT ename, deptno, sal, hiredate
    #         166 FROM EMP
                           #         167 WHERE CAST(hiredate AS DATE) = '1981-9-8';
# 168
# 169
# 170 36. 직업이 MANAGER 가 아닌 사람의 모든 정보를 출력하시오.
# 171
# 172 SELECT * FROM EMP WHERE NOT job = 'MANAGER';
# 173
# 174
# 175 37. 입사일이 81년 4월 2일 이후에 입사한 사람의 모든 정보를 출력하시오.
# 176
# 177 SELECT * FROM EMP
                          #     178 WHERE CAST(hiredate AS DATE) >= '1981-4-2';
# 179
# 180
# 181 38. 급여가 800 이상인 사람의 이름, 급여, 부서번호를 출력하시오.
# 182
# 183 39. 부서번호가 20번 이상인 사원의 모든 정보를 출력하시오.
# 184
# 185 40. 이름이 K로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보를 출력하시오.186
# 187 41. 입사일이 1981년 12월 9일보다 먼저 입사한 사원의 모든 정보를 출력하시오.
# 188
# 189 42. 입사번호가 7698보다 작거나 같은 사원의 입사번호와 이름을 출력하시오.
# 190
# 191 43. 입사일이 1981년 4월 2일보다 늦고 1982년 12월 9일보다 빠른 사원의 이름, 월급, 부서번호
# 를 출력하시오.
# 192
# 193 44. 급여가 1600만원보다 크고 3000만원보다 작은 사람의 이름, 직업, 급여를 출력하시오.
# 194
# 195 45. 사원번호가 7654와 7782 사이 이외의 사원의 모든 정보를 출력하시오.
# 196
# 197 46. 입사일이 1981년 이외에 입사한 사람의 모든 정보를 출력하시오.
# 198
# 199 47. 직업이 MANAGER와 SALESMAN인 사람의 모든 정보를 출력하시오.
# 200
# 201 48. 부서번호가 20번 30번을 제외한 모든 사람의 이름, 사원번호,부서번호를 출력하시오.
# 202
# 203 49. 이름이 S로 시작하는 사원의 사원번호, 이름, 입사일, 부서번호를 출력하시오.
# 204
# 205 50. 입사일이 1981년도인 사원의 모든 정보를 출력하시오.
# 206
# 207 51. 이름중 S가 들어가 있는 사람의 모든 정보를 출력하시오.
# 208
# 209 52. 이름이 J로 시작하고 마지막 글자가 S로 끝나는 사람의 모든 정보(단 이름은 전체 5글자이다
# .)를 출력하시오.
# 210
# 211 53. 첫번째 문자는 관계없고, 두번째 문자가 A인 사람의 모든 정보를 출력하시오.
# 212
# 213 54. 커미션이 NULL인 사람의 모든 정보를 출력하시오.
# 214
# 215 55. 커미션이 NULL이 아닌 사람의 모든 정보를 출력하시오.
# 216
# 217 56. 부서가 30번 부서이고 급여가 1500만원이상인 사람의 이름,부서, 월급을 출력하시오.
# 218
# 219 57. 이름의 첫글자가 K로 시작하거나 부서번호가 30인 사람의 사원번호, 이름, 부서번호를 출력
# 하시오.
# 220
# 221 58. 급여가 1500만원이상이고, 부서번호가 30번인 사원 중 직업이 MANAGER인 사람의 정보를
# 출력하시오.
# 222
# 223 59. 부서번호가 30인 사람 중 사원번호로 정렬하시오.

#급여가 많은 순으로 정렬하시오.
SELECT *
FROM emp
ORDER BY sal DESC;
# 부서번호로 오름차순 정렬한 후 급여가 많은 사람순으로 출력하시오.
SELECT *
FROM emp
ORDER BY deptno ASC, sal DESC;

# 부서번호로 내림차순 정렬하고 이름순으로 오름차순으로 정렬하고 급여순으로 내림차순으로 출력하시오.
SELECT *
FROM emp
ORDER BY deptno DESC, ename ASC, sal DESC;

# 231 63. 이름이 B와 J 사이의 모든 사원의 정보출력하시오.
SELECT ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE ename BETWEEN 'B' AND 'J';