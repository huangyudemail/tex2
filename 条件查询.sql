# 条件查询
/*
语法：
	select  
		查询（第三步）
	from 
		表名（第一步）
	where
		筛选条件 #相当于JAVA 中if() 返回值为true或false （第二步）
分类：
	一、按条件表达式筛选
		条件运算符（>,<,=,!=,<>,>=,<=）
	二、按逻辑表达式筛选
		逻辑运算符（&&,||,!) java
			   (and not or) mysql
		作用：用于连接条件表达式
		&&和and 两个条件都为true，结果为true，反之为false
	三、模糊查询
		like
		between and
		in
		is null
*/
# 一、按条件表达式筛选
#案例1：查询工资>12000的员工信息
SELECT * FROM employees WHERE salary>12000;
#案例2： 部门编号不等于90号的员工名和部门编号
SELECT last_name,department_id FROM employees WHERE manager_id<>90;
#二、逻辑运算符
# &&或and 两个条件都为true，结果为true，反之为false
# ||或or  只要有一个条件为true，结果为true，反之为false
# ！或not  如果连接的条件本身为false，结果为true，反之为false
#案例1：查询工资在10000到20000之间的员工名、工资及奖金
SELECT last_name,salary,commission_pct FROM employees WHERE 10000<=salary<=20000; #或
SELECT last_name,salary,commission_pct FROM employees WHERE 10000<=salary AND  salary<=20000; 
#案例2：查询部门编号不是在90到110之间，或工资高于15000的员工信息
SELECT * FROM employees WHERE  department_id<90 OR department_id>110 OR salary>15000;#或
SELECT * FROM employees WHERE  NOT(department_id>=90 AND department_id<=110) OR salary>15000;
#三、模糊查询
#1.like
#案例1：查询员名中包含字符a的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%'
/*
1。一般和通配符搭配使用
通配符：
	'%'代表任意多个字符（包含0个字符）
	'_'任意单个字符
*/
#案例2 查询员工名中，第三个字符中，第五个字符为a的员工名和员工工资
SELECT last_name,salary FROM employees WHERE last_name LIKE '__e_a%';
#案例3：查询员工名中第二个字符为_的员工名
SELECT last_name FROM employees WHERE last_name LIKE '_\_%'； # '\' 使用转义符
#或则自定义转义符
SELECT last_name FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$'；
#2.between and
#案例1：查询员工编号在100到120之间的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120;

/*
说明：
1.使用between and 可以提高语句的简洁度；
2.包含临界值
3.两个临界值不要调换顺序
*/
#3.in
#案例：查询员工的工种名称是IT_PROG,AD_VP,AD_PRES中的一个员工名和工种编号
SELECT last_name,job_id FROM employees WHERE job_id='IT_PROG' OR job_id='AD_VP' OR job_id='AD_PRES'; #这样很麻烦
SELECT last_name,job_id FROM employees WHERE job_id IN ('IT_PROG','AD_VP','AD_PRES');
/*
含义：
1.判断某字段的值是否属于in列表中的某一项
特点：
1.使用in提高语句简洁度
2.in列表的值类型必须一致或兼容
3.in不支持通配符，因为in相当于‘=’
*/
#4. is null 和is not null
#案例1：查询没有奖金的员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE  commission_pct=NULL; #思考一下能达到效果吗？原因'='不能判读NULL值
SELECT last_name,commission_pct FROM employees WHERE  commission_pct IS NULL;
#案例2：查询有奖金的员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE  commission_pct IS NOT NULL;
/*
1.=或<>不能用于判断NULL值
2.is null 或 is not null 可以判断NULL值（也只能判断NULL，不能判断具体值）
*/
# 补充 安全等于 <=>
SELECT last_name,commission_pct FROM employees WHERE  commission_pct <=>  NULL;
SELECT last_name,commission_pct,salary FROM employees WHERE  salary<=>12000;
/*is null pk <=>
is null: 仅仅可以判断null值，可读性较高
<=> :既可以判断NULL值，又可以判断普通的数值，可读性较低
*/
#1.查询员工号为176的员工姓名和部门号和年薪
SELECT last_name,department_id,salary*12*(1+IFNULL(commission_pct,0))AS 年薪 FROM employees;
#练习
#1.查询没有奖金，且工资小于18000的salary，last_name
SELECT salary,last_name FROM employees WHERE commission_pct IS NULL AND salary<18000;
#2.查询部门employees表中，job_id不为‘IT’或者工资为12000的员工信息
SELECT * FROM employees  WHERE job_id<>'IT' OR salary=12000;
#3.查询部门departments表的结构
DESC departments
#4.查询部门departments表中设计到了那些位置编号
SELECT DISTINCT location_id FROM departments;
#经典面试题
#试问 select * from employees 和select * from employees where commission_pct like '%%' and last_name like '%%';结果是否一样？并说明原因。
#不一样，如果判断的字段有NULL值结果就不一样，思考一下是OR