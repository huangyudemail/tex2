# 进阶6 连接插叙
/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询
笛卡尔乘积现象：表1 有m行，表2有n行，结果=m*n行
发生原因：没有有效的连接条件
如何避免：添加有效的匹配条件
分类：
	按年代分类：
	sq92标准：仅仅支持内连接
	sq99标准（推荐）
	按功能分类：支持内连接+外连接（左外和右外）+交叉连接
		内连接
			等值连接
			非等值连接
			自连接
		外连接
			
			左外连接
			右外连接
			全外连接
		交叉连接
*/
SELECT * FROM beauty;
SELECT * FROM boys;
SELECT NAME,boyname FROM boys,beauty; #明显有问题，思考为什么会出现这样问题？因为没有连接条件 12*4 笛卡尔乘积现象
SELECT NAME,boyname FROM boys,beauty WHERE beauty.boyfriend_id=boys.id;                                      
#一、sql92标准
#案例1：查询女神名和对应的男神名
SELECT NAME,boyname FROM boys,beauty WHERE beauty.boyfriend_id=boys.id; 
#案例2：查询员工名和对应部门名
SELECT last_name,department_name FROM departments,employees WHERE departments.department_id=employees.department_id;
#2.为表去别名
/*
(1) 提高了语句的简洁度
(2) 区分多个重名的字段
注意：如果为表起了别名，则查询的字段就不能使用原来的表名去限定
*/
#查询员工名，工种号，工种名
SELECT last_name,employees.job_id,job_title FROM employees,jobs WHERE employees.job_id=jobs.job_id; #太长了
SELECT last_name,e.employees.job_id,job_title FROM employees AS e,jobs j WHERE e.job_id=j.job_id; #提高表的简洁度
