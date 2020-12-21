#进阶5 分组查询
#引入：查询每个部门的平均工资
SELECT AVG(salary) FROM employees; #计算出的是全部的平均工资
/*
1.结构
select  分组函数，列（要求出现在group by的后面） （第四步）
	from 表 （第一步）
	where 筛选条件（第二步）
	group by  分组字段（第三步） 
	order by  排序列表【ASC/DESC】（第五步)
注意：
	查询李彪必须特殊，要求是分组函数和group by后出现的字段
特点：
	1.分组查询中的筛选条件分为两类
			数据源		位置			关键字
	分组前筛选	原始表		group by子句的前面	where
	分组后筛选	分组后的结果表	group by子句的后面	having
	（1）分组函数做条件肯定放在having当中
	（2）能用分组前筛选，就用分组前筛选
	2.group by子句支持单个字段分组，也支持多个字段分组（多个字段用逗号隔开没有顺序要求）
	表达式或函数（用的较少）
	3.也可以添加排序（排序放在整个分组查询的最后）

*/
#1.简单分组查询
#案例1 每个工种的的最高工种
SELECT MAX(salary),job_id FROM employees GROUP BY job_id;
#案例2 查询每个位置的部门个数
SELECT COUNT(department_id),location_id FROM departments GROUP BY location_id;
#2.添加筛选条件
#案例1：查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary) average,department_id FROM employees WHERE email LIKE '%a%' GROUP BY manager_id;
#案例2：查询奖金的每个领导手下员工的最高工资
SELECT  MAX(salary),manager_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY manager_id;
#3.添加分组后的筛选条件
#案例1：查询哪个部门的员工个数>2
#(1).查询每个部门的员工个数‘
SELECT COUNT(*),department_id FROM employees GROUP BY department_id;
#(2).根据1的结果进行筛选，查询哪个部门的员工个数>2
SELECT COUNT(*),department_id FROM employees GROUP BY department_id HAVING COUNT(*)>2;
#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#(1).查询每个工种有奖金的的员工的最高工资
SELECT MAX(salary),job_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id; #先写没有条件前的原始语句，写完后在加条件
#(2).根据1结果继续筛选，最高工资>12000
SELECT MAX(salary),job_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id HAVING MAX(salary)>12000;
#案例3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个
#（1）查询领导编号>102的每个领导手下的员工固定最低工资
SELECT manager_id,MIN(salary) FROM employees WHERE manager_id>102 GROUP BY manager_id;
#（2）根据1结果继续筛选，最低工资>5000
SELECT manager_id,MIN(salary) FROM employees WHERE manager_id>102 GROUP BY manager_id HAVING MIN(salary)<5000;
#4.按表达式或函数分组
#1.案例1：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5
#(1)查询每个长度的员工个数
SELECT COUNT(*) ,LENGTH(last_name) AS 长度 FROM employees GROUP BY LENGTH(last_name);
SELECT COUNT(*) ,LENGTH(last_name) AS 长度 FROM employees GROUP BY LENGTH(last_name) HAVING COUNT(*)>5;# 也支持别名，但where 后面是不支持别名
#5.按多个字段分组
#案例：查询每个部门每个工种的员工的平均工资
SELECT AVG(salary),department_id,job_id FROM employees GROUP BY department_id,job_id;#两个条件一致在一组
#6.添加排序
#案例：查询每个部门每个工种的员工的平均工资，并且按平均工资的高低显示
SELECT AVG(salary),department_id,job_id FROM employees GROUP BY department_id,job_id ORDER BY AVG(salary) DESC;
#练习
#1.查询个job_id的员工工资的最大值，最小值，平均值，总和，并按job_id升序
#2.查询员工最高工资和最低工资的差距（DIFFERENCE）
#3.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
#4.查询所有部门的编号，员工数量和平均值，并按平均工资排序
#5.选择具有各个job_id的员工人数