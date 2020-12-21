/*
语法：
	select  
		查询（第二步）查询的东西可以多样
	from 
		表名（第一步）
类似JAVA 里面，system.out.println( ) 输出的表为续表
特点：
	1.查询列表可以是表中的字段、常量值、表达式、函数
	2、查询的结构是一个虚拟的表格
*/
#查询字段
#1.查询表中全部字段
SELECT * FROM employees;
#2.查询表中单个字段
SELECT last_name FROM employees;
#3.查询表中多个字段
SELECT last_name,salary,email FROM employees;
/*说明：
	可以双击添加字段；
	* 代表所有
	F12(笔记本Ctrl +F12)，变为规范版本；
*/

# 查询常量值
SELECT 100;
SELECT 'huangyu';
# Mysql 中不区分字符与字符串，都用单引号。
# 查询表达式
SELECT  100%98;
# 查询函数（类似JAVA 里面的方法）
SELECT VERSION();
# 起别名（方便理解）
/*
1.便于理解
2.如果要查询字段有重名的情况，使用别名可以区分开来。
*/
# 方式一
SELECT 100%98 AS 结果；
SELECT	last_name AS 姓,first_name AS 名 FROM employees;
#方式二
SELECT	last_name  姓,first_name 名 FROM employees;
# 案例 查询 salary  显示结果为 out put
SELECT salary AS "out put" FROM employees;
# 由于别名中有特殊符号（包括空格，#等）就会报错，所以我们在取别名时，请加上双引号（单引号也可以）
#去重
# 案例 查询员工表中涉及到的所有的部门编号
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;
# 请对比两条语句的运行结果，
/*
java 中的+号
1，运算符 两个操作数都为数值型
2，连接符 只要有一个操作数为字符串
Mysql 中的+号
只有一个功能：运算符
select 100+50; 两个操作数都为数值型，则做加法运算
select '123'+90;  其中一方为字符型，视图将字符数值转化成数值型，
                  如果转换成果继续做加法运算
SELECT 'john'+90; 如果转换失败，则将字符型转化为0
SELECT null+10;   只要其中一方为null,则结果肯定为null
*/
# +号的作用
#案例：查询员工名和链接成一个字段，并显示为姓名
SELECT last_name+first_name AS 姓名 FROM employees;#思考一下为什么没有达到效果
# 拼接函数 CONCAT
SELECT CONCAT('a','b','c')AS 结果；
SELECT CONCAT(last_name,first_name) AS 姓名 FROM employees;
#练习
#下面的语句是否可以执行成功
SELECT `last_name`,`job_id`,`salary` AS sal FROM employees;
#下面的语句是否可以执行成功
SELECT * FROM employees;
#下面的语句的错误
SELECT employee_id,last_name，`salary`*12  " ANNUAL SALARY" FROM employees;# 提示两处标点符号。
# 显示表departments的结构，并查询其中的全部数据
DESC departments
SELECT * FROM departments;
# 显示出表employees中全部的job_id(不能重复)
SELECT DISTINCT job_id FROM employees;
# 显示出表employees中全部全部列，各个列之间用逗号连接，列头显示成 OUT_PUT
#select CONCAT(first_name,',',last_name,',',job_id,',',`commission_pct`) AS OUT_PUT FROM employees; #思考为什么都为NULL
/*select 
  ifnull(commission_pct,0)as 奖金率,
  commission_pct
FROM
  employees;
*/
#-----------------------------------------------------------------
SELECT CONCAT(first_name,',',last_name,',',job_id,',',IFNULL(commission_pct,0)) AS OUT_PUT FROM employees;