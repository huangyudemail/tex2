# 分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数（传一组值得到一个值）
sum 求和，avg 求平均，max 求最大，min 求最小，count计算个数
特点：
1.sum，avg 只支持数值型
  max ，min ，count 可以处理任何类型
2、这五个分组函数忽略NULL值
3、可以和distinct搭配使用实现去重
4、count函数的简单介绍
一般使用count(*)统计行数
5、和分组函数一起查询的字段要求是group by 后的字段
*/
#1、简单应用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;
SELECT SUM(salary) 求和, ROUND(AVG(salary),2) 平均,MAX(salary)最大,MIN(salary) 最小,COUNT(salary) 个数 FROM employees;
#2、参数支持哪些类型
SELECT SUM(last_name) FROM employees ;#为什么错了，不像JAVA这样错就是错，对就是对强语言
SELECT SUM(hiredate) FROM employees; 
#-----------------说明sum，avg 只支持数值型--------------------
SELECT MAX(last_name),MIN(last_name) ,COUNT(last_name)FROM employees;#支持日期型、数值型、字符型
#3、忽略null
SELECT SUM(commission_pct),AVG(commission_pct) FROM employees #由于null+任何值都等于NULL，那么说明没有加入运算
SELECT MAX(commission_pct),MIN(commission_pct) ,COUNT(commission_pct)FROM employees; #count 计算非空的函数
#4、和distinct搭配
SELECT SUM(DISTINCT salary),SUM(salary) FROM employees; 
SELECT COUNT(DISTINCT salary),COUNT(salary) FROM employees;
#5. count 函数的详细介绍
SELECT COUNT(salary) FROM employees;
SELECT COUNT(*) FROM employees; #我们经常用这种方式统计函数，只要任意行有不为空，就用加1
SELECT COUNT(1) FROM employees; #多出1列，实际统计1的个数，写任意常量值都可以
/*效率
myisam存储引擎下，count(*)的效率高
innodb存储引擎下，COUNT(*)和COUNT(1)效率差不多，比count（字段）要高一些；
*/
#6、和分组函数一同查询的字段有限制 
SELECT AVG(salary) ,employee_id FROM employees; #不是一个规则表格
# 练习
#1.查询公司员工资的最大值、最小值、平均值、总和
SELECT MAX(salary) 最大值,MIN(salary) 最小值,ROUND(AVG(salary),2)AS 平均值,SUM(salary) 总和 FROM employees;
#2.查询员工表中最大入职时间和最小入职时间相差的天数（differnce）
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) AS DIFFERCE FROM employees;#DATEDIFF()函数是计算两个时间的相差的天数
#3.查询部门编号为90的员工个数
SELECT COUNT(*) FROM employees WHERE department_id=90;