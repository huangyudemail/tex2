# 常见函数
/*
概念：类似JAVA中的方法；将一组逻辑语句封装在方法体中，对外暴露方法名
好处：1.隐藏了实现细节；2.提高了代码的复用性；
调用：select 函数名（实参列表）； from 表；（用到了表中字段才加from表）
特点：
	1.叫什么（函数名）
	2.干什么（函数功能）
分类：
	1.单行函数
	如：concat,length,ifnull等。
	2.分组函数
	功能：做统计使用（传一组值返回一个值），又称为统计函数，聚合函数，组函数
*/
/*
字符函数
数学函数
日期函数
其他函数（补充）
流程控制函数（补充）
*/
#一、字符函数
#1.length 获取参数值得字节个数（所有函数中只有这个函数是字节）
SELECT LENGTH('huangyu'); #英文
SELECT LENGTH('黄余');#中文
SHOW VARIABLES LIKE '%char%'; #utf8 一个汉字三个字节 GBK一个汉字两个字节
#2.concat 拼接字符串
SELECT CONCAT(last_name,first_name) FROM employees;
#3.upper、lower
SELECT UPPER('huangyu'); #变大写
SELECT LOWER('HUANGYU'); #变小写
#案例：将姓变大写，名变表写，然后拼接
SELECT CONCAT(UPPER(last_name),LOWER(first_name)) FROM employees;
#4.substr（substring）
#注意：索引从1开始 
SELECT SUBSTR('李莫愁爱上了陆展元',7) out_put; #截取从指定所引出后面所有字符
SELECT SUBSTR('李莫愁爱上了陆展元',1,3) out_put; #截取从指定索引出指定长度的字符
#案例：姓名中首字符大写，其他字符小写然后用_拼接，显示出来
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),'_',LOWER(SUBSTR(last_name,2))) FROM employees;
#5.instr 返回子串第一次出现出现的索引，如果找不到返回0；
SELECT INSTR('杨不悔爱上了殷六侠','殷六侠') AS out_put;
#6.trim
SELECT TRIM('       张翠山            ') AS out_put;
SELECT LENGTH(TRIM('       张翠山            ')) AS out_put;
SELECT TRIM('a' FROM 'aaaaaaaaaaaaaaaaaaaaaaaaa张aaaaaa翠aaaaaa山aaaaaaaaaaaaaaaaaaaa')AS out_put; #只能去前后
SELECT TRIM('aa' FROM 'aaaaaaaaaaaaaaaaaaaaaaaaa张aaaaaa翠aaaaaa山aaaaaaaaaaaaaaaaaaaa')AS out_put;
#7.lpad 用指定的字符实现左填充指定长度
SELECT LPAD('殷素素',10,'******') AS out_put;
SELECT LPAD('殷素素',2,'*') AS out_put;
#8.rpad  用指定的字符实现右填充指定长度
SELECT RPAD('殷素素',10,'******') AS out_put;
#9.REPLACE 替换
SELECT REPLACE ('张无忌爱上了周芷若','周芷若','赵敏'); 
SELECT REPLACE ('张无忌爱上了周芷若周芷若','周芷若','赵敏');
#二 数学函数
#1.round 四舍五入
SELECT ROUND(1.45);
SELECT ROUND(-1.45);
SELECT ROUND(-1.45667,2);
#2.ceil 向下取整,返回>=该参数的最小整数
SELECT CEIL(1.00);
SELECT CEIL(1.02);
SELECT CEIL(-1.02);
#3.floor 向上取整,返回<=该参数的最大整数
SELECT CEIL(9.99);
SELECT CEIL(-9.99);
#4.truncate 截断(和四舍五入不一样)
SELECT TRUNCATE(1.65,1);
#5.mod 取余
SELECT  MOD(10,3);
SELECT  MOD(-10,3);
SELECT  MOD(10,-3);
SELECT  MOD(-10,-3);
#mod(a,b) a-a/b*b
#三 日期函数
#1.now
SELECT NOW();
#2.curdate 返回当前系统日期，不包含时间
SELECT CURDATE();
#3.获取指定的部分年、月、小时、分钟、秒
SELECT YEAR(NOW());
SELECT YEAR('1998-1-10');
SELECT YEAR(hiredate) FROM employees;
SELECT MONTH(NOW());
SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;
/*
%Y 四位年份
%y 两位年份
%m 月份（01,02....）
%c 月份（1,2.....）
%d 日（01,02.....）
%H 小时（24小时制）
%h 小时（12小时制）
%i 分钟（00,01...）
%s 秒（00,01.....）
*/
#4.str_to_date 将字符他通过指定的格式转化成日期
SELECT STR_TO_DATE('1992-3-3','%Y-%c-%d')  out_put;
#查询入职日期为（1992-4-3）的员工信息
SELECT * FROM employees WHERE hiredate='1992-4-3';
#web 输入的日期为字符串 如'4-3 1992'
SELECT * FROM employees WHERE hiredate=STR_TO_DATE('4-3 1992','%c-%d %Y');
#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年%m月%d日');
#查询有奖金的员工名和入职日期（xx年/xx月/xx日）
#四.其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();
#五.流程控制函数
#if函数，if else 的效果
SELECT IF(10>5,'真','假') AS 'out';
SELECT last_name,commission_pct,IF(commission_pct IS NULL,'没奖金，呵呵','有奖金，嘿嘿') AS 备注 FROM employees;
#case 函数使用一，switch case 的效果
/*
这种适合等值判断
java 中
switch(变量或表达式)
	case 常量1：语句1;break;
	.....
	dafault:语句n;break;
MySQL中
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1；
when 常量2 then 要显示的值1或语句2；
....
else 要显示的值n或语句n;
end
*/
/* 案例1：查询员工的工资，
要求部门号=30，显示的工资为1.1倍
要求部门号=40，显示的工资为1.2倍
要求部门号=50，显示的工资为1.3倍
其他部门，显示的工资为原工资
*/
SELECT 
  salary 原工资,
  department_id,
  CASE  department_id
   WHEN 30 THEN salary*1.1 #是一个值不放分号
   WHEN 40 THEN salary*1.2
   WHEN 50 THEN salary*1.3
   ELSE salary
   END  AS 新工资
   FROM employees;
 #case 函数使用二：类似于 多重if
 /*
 适合判断区间
 java 中
 if（条件1）：{
	语句1：
 }else  if(条件2)
 {
	语句2:
 }
 ...
 else{
 语句n;
  }
 mysql 中：
 case 
 when 条件1 then 要显示的值1或语句（语句要加分号）
 when 条件2 then 要显示的值2或语句
 ....
 else 要显示的值n或语句n
 end
 */
 /*案例：查询员工的工资情况
 如果工资>20000,显示A级别;
 如果工资>15000,显示B级别;
 如果工资>10000,显示B级别;
 否则，显示D级别
  */
SELECT salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees
#练习
#1. 显示系统时间（注：日期+时间）
SELECT NOW();
#2.查询员工号，姓名，以及工资提高百分之20%后的结果（new salary）
SELECT employee_id,last_name,salary*1.2 AS 'new salary' FROM employees;
#3.将员工的姓名按首字符排序，并写出姓名的长度（length）
SELECT LENGTH(last_name)AS 长度,SUBSTR(last_name,1,1) 首字符,last_name FROM employees ORDER BY 首字符;
#4. 做一个查询，产生下面的结果
<last_name> earns <salary> monthly but wants <salary*3> 
dream salary
Ring earns 24000 mothly but wants 72000
SELECT CONCAT(last_name,'earns',salary,'monthly but wants',salary*3) AS 'dream salary' FROM employees WHERE salary=24000;
#5. 使用case—when 按照下面的条件
job       grade
AD_PRES   A
ST_MAN    B
IT_PROG   C
SA_REP    D
ST_CLERK  E
SELECT job_id AS job,
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN'  THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_REP'  THEN 'D'
WHEN 'ST_CLERK'  THEN 'E'
END AS grades
FROM employees 
