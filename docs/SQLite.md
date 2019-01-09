# [SQLITE](http://www.runoob.com/sqlite/sqlite-where-clause.html)

### 删除表
```
DROP TABLE database_name.table_name;
```

### Insert 语句
```
INSERT INTO TABLE_NAME [(column1, column2, column3,...columnN)]  
VALUES (value1, value2, value3,...valueN);
```
在这里，column1, column2,...columnN 是要插入数据的表中的列的名称。
如果要为表中的所有列添加值，您也可以不需要在 SQLite 查询中指定列名称。但要确保值的顺序与列在表中的顺序一致。SQLite 的 INSERT INTO 语法如下：
```
INSERT INTO TABLE_NAME VALUES (value1,value2,value3,...valueN);
```


### 使用一个表来填充另一个表
通过在一个有一组字段的表上使用 select 语句，填充数据到另一个表中。下面是语法：
```
INSERT INTO first_table_name [(column1, column2, ... columnN)] 
   SELECT column1, column2, ...columnN 
   FROM second_table_name
   [WHERE condition];
```

### Select 语句
```
SELECT column1, column2, columnN FROM table_name;
```
在这里，column1, column2...是表的字段，他们的值即是您要获取的。如果您想获取所有可用的字段，那么可以使用下面的语法：
```
SELECT * FROM table_name;
```
下面是一个实例，使用 SELECT 语句获取并显示所有这些记录。在这里，前三个命令被用来设置正确格式化的输出。
```
sqlite>.header on
sqlite>.mode column
sqlite> SELECT * FROM COMPANY;
```

### 设置输出列的宽度
有时，由于要显示的列的默认宽度导致 .mode column，这种情况下，输出被截断。此时，您可以使用 .width num, num.... 命令设置显示列的宽度，如下所示：
```
sqlite>.width 10, 20, 10
sqlite>SELECT * FROM COMPANY;
```

### Schema 信息
因为所有的点命令只在 SQLite 提示符中可用，所以当您进行带有 SQLite 的编程时，您要使用下面的带有 sqlite_master 表的 SELECT 语句来列出所有在数据库中创建的表：
```
sqlite> SELECT tbl_name FROM sqlite_master WHERE type = 'table';
```
您可以列出关于 COMPANY 表的完整信息，如下所示：
```
sqlite> SELECT sql FROM sqlite_master WHERE type = 'table' AND tbl_name = 'COMPANY';
```


### SQLite 比较运算符
```
运算符 描述  实例
==  检查两个操作数的值是否相等，如果相等则条件为真。    (a == b) 不为真。
=   检查两个操作数的值是否相等，如果相等则条件为真。    (a = b) 不为真。
!=  检查两个操作数的值是否相等，如果不相等则条件为真。   (a != b) 为真。
<>  检查两个操作数的值是否相等，如果不相等则条件为真。   (a <> b) 为真。
>   检查左操作数的值是否大于右操作数的值，如果是则条件为真。    (a > b) 不为真。
<   检查左操作数的值是否小于右操作数的值，如果是则条件为真。    (a < b) 为真。
>=  检查左操作数的值是否大于等于右操作数的值，如果是则条件为真。  (a >= b) 不为真。
<=  检查左操作数的值是否小于等于右操作数的值，如果是则条件为真。  (a <= b) 为真。
!<  检查左操作数的值是否不小于右操作数的值，如果是则条件为真。   (a !< b) 为假。
!>  检查左操作数的值是否不大于右操作数的值，如果是则条件为真。   (a !> b) 为真。
```

### SQLite 逻辑运算符
```

运算符 描述
AND AND 运算符允许在一个 SQL 语句的 WHERE 子句中的多个条件的存在。
BETWEEN BETWEEN 运算符用于在给定最小值和最大值范围内的一系列值中搜索值。
EXISTS  EXISTS 运算符用于在满足一定条件的指定表中搜索行的存在。
IN  IN 运算符用于把某个值与一系列指定列表的值进行比较。
NOT IN  IN 运算符的对立面，用于把某个值与不在一系列指定列表的值进行比较。
LIKE    LIKE 运算符用于把某个值与使用通配符运算符的相似值进行比较。
GLOB    GLOB 运算符用于把某个值与使用通配符运算符的相似值进行比较。GLOB 与 LIKE 不同之处在于，它是大小写敏感的。
NOT NOT 运算符是所用的逻辑运算符的对立面。比如 NOT EXISTS、NOT BETWEEN、NOT IN，等等。它是否定运算符。
OR  OR 运算符用于结合一个 SQL 语句的 WHERE 子句中的多个条件。
IS NULL NULL 运算符用于把某个值与 NULL 值进行比较。
IS  IS 运算符与 = 相似。
IS NOT  IS NOT 运算符与 != 相似。
||  连接两个不同的字符串，得到一个新的字符串。
UNIQUE  UNIQUE 运算符搜索指定表中的每一行，确保唯一性（无重复）。
```

下面的 SELECT 语句列出了 AGE 大于等于 25 且工资大于等于 65000.00 的所有记录：
```
sqlite> SELECT * FROM COMPANY WHERE AGE >= 25 AND SALARY >= 65000;
```

下面的 SELECT 语句列出了 AGE 不为 NULL 的所有记录，结果显示所有的记录，意味着没有一个记录的 AGE 等于 NULL：
```
sqlite>  SELECT * FROM COMPANY WHERE AGE IS NOT NULL;
```

下面的 SELECT 语句列出了 NAME 以 'Ki' 开始的所有记录，'Ki' 之后的字符不做限制：
```
sqlite> SELECT * FROM COMPANY WHERE NAME LIKE 'Ki%';
```

下面的 SELECT 语句列出了 NAME 以 'Ki' 开始的所有记录，'Ki' 之后的字符不做限制：
```
sqlite> SELECT * FROM COMPANY WHERE NAME GLOB 'Ki*';
```

下面的 SELECT 语句列出了 AGE 的值为 25 或 27 的所有记录：
```
sqlite> SELECT * FROM COMPANY WHERE AGE IN ( 25, 27 );
```

下面的 SELECT 语句列出了 AGE 的值既不是 25 也不是 27 的所有记录：
```
sqlite> SELECT * FROM COMPANY WHERE AGE NOT IN ( 25, 27 );
```

下面的 SELECT 语句列出了 AGE 的值在 25 与 27 之间的所有记录：
```
sqlite> SELECT * FROM COMPANY WHERE AGE BETWEEN 25 AND 27;
```

下面的 SELECT 语句使用 SQL 子查询，子查询查找 SALARY > 65000 的带有 AGE 字段的所有记录，后边的 WHERE 子句与 EXISTS 运算符一起使用，列出了外查询中的 AGE 存在于子查询返回的结果中的所有记录：
```
sqlite> SELECT AGE FROM COMPANY 
        WHERE EXISTS (SELECT AGE FROM COMPANY WHERE SALARY > 65000);
```

下面的 SELECT 语句使用 SQL 子查询，子查询查找 SALARY > 65000 的带有 AGE 字段的所有记录，后边的 WHERE 子句与 > 运算符一起使用，列出了外查询中的 AGE 大于子查询返回的结果中的年龄的所有记录：
```
sqlite> SELECT * FROM COMPANY 
        WHERE AGE > (SELECT AGE FROM COMPANY WHERE SALARY > 65000);
```


### SQLite 表达式
#### SQLite - 布尔表达式
SQLite 的布尔表达式在匹配单个值的基础上获取数据。语法如下：
```
SELECT column1, column2, columnN 
FROM table_name 
WHERE SINGLE VALUE MATCHTING EXPRESSION;
```

下面的实例演示了 SQLite 布尔表达式的用法：
```
sqlite> SELECT * FROM COMPANY WHERE SALARY = 10000;
```

#### SQLite - 数值表达式
这些表达式用来执行查询中的任何数学运算。语法如下：
```
SELECT numerical_expression as  OPERATION_NAME
[FROM table_name WHERE CONDITION] ;
```

在这里，numerical_expression 用于数学表达式或任何公式。下面的实例演示了 SQLite 数值表达式的用法：
```
sqlite> SELECT (15 + 6) AS ADDITION
ADDITION = 21
```

有几个内置的函数，比如 avg()、sum()、count()，等等，执行被称为对一个表或一个特定的表列的汇总数据计算。
```
sqlite> SELECT COUNT(*) AS "RECORDS" FROM COMPANY; 
RECORDS = 7
```

#### SQLite - 日期表达式
日期表达式返回当前系统日期和时间值，这些表达式将被用于各种数据操作。
```
sqlite>  SELECT CURRENT_TIMESTAMP;
CURRENT_TIMESTAMP = 2013-03-17 10:43:35
```

