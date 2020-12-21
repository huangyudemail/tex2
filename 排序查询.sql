# 排序查询
/*#引入：
select * from employees; # 顺序与源数据数据一致
语法：
	select 查询列表 （第三步）
	from 表 （第一步）
	【where 筛选条件】（第二步）
	order by  排序列表【ASC/DESC】（第四步）
特点：
	1.ASC代表升序，DESC代表的是降序
	2.如果不写，默认是升序
	3.order by子句中可以支持单个字段、多个字段、表达式、函数、别名
	4.order by子句一般放在查询语句的最后面，但limit子句除外
*/
#案例1：查询员工信息要求工资从高到低排序[]添加筛选条件
SELECT * FROM employees ORDER BY salary DESC;
#案例2：查询部门编号>=90的员工信息，按入职时间先后
SELECT * FROM employees WHERE department_id>=90 ORDER BY hiredate;
#案例3：按年薪的高低显示员工的信息和年薪【按表达式排序】
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY salary*12*(1+IFNULL(commission_pct,0));
#案例4：按年薪的高低显示员工的信息和年薪【按别名排序】
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY 年薪;
#案例5：按姓名的长度显示员工的姓名和工资【按函数排序】
SELECT LENGTH('huangyu');
SELECT LENGTH(last_name) 字节长度,last_name,salary FROM employees ORDER BY LENGTH(last_name) DESC;
#案例6：查询员工信息，要求先按员工资排序，再按员工编号排序[按多个字段排序]
SELECT * FROM employees ORDER BY salary ASC,employee_id DESC;
#练习
#1.查询员工的姓名和部门号、年薪，按年薪降序，按姓名升序
SELECT first_name,department_id,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY 年薪 DESC,last_name;
#2.选择工资不在8000到17000的员工的姓名和工资，按工资降序
SELECT last_name,salary FROM employees WHERE NOT salary BETWEEN 8000 AND 170000 ORDER BY salary DESC;
#3.查询邮箱中包含e的员工信息，并先按照邮箱的字节数降序，再按部门号升序
SELECT *,LENGTH(email) FROM employees WHERE email LIKE '%e%' ORDER BY LENGTH(email) DESC,department_id ASC;