CREATE DATABASE IF NOT EXISTS `图书管理系统` 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `图书管理系统`;

CREATE TABLE IF NOT EXISTS 读者表 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    账号 VARCHAR(20) UNIQUE NOT NULL COMMENT '账号',
    密码 VARCHAR(255) NOT NULL COMMENT '密码',
    学号 VARCHAR(20) UNIQUE NOT NULL COMMENT '学号',
    姓名 VARCHAR(50) NOT NULL,
    性别 ENUM('男','女') NOT NULL,
    生日 DATE NOT NULL,
    电话 VARCHAR(15) NOT NULL,
    邮箱 VARCHAR(50) UNIQUE NOT NULL,
    注册时间 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    信用分 INT DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ALTER TABLE 借阅表 DROP FOREIGN KEY fk_借阅_图书;
-- DROP TABLE IF EXISTS 借阅表;
-- DROP TABLE IF EXISTS 图书表;

CREATE TABLE IF NOT EXISTS 图书表 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    书名 VARCHAR(100) NOT NULL,
    作者 VARCHAR(50) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL COMMENT 'ISBN',
    出版社 VARCHAR(50) NOT NULL,
    出版日期 DATE NOT NULL,
    分类 VARCHAR(30) NOT NULL,
    语言 VARCHAR(20) DEFAULT '中文',
    价格 DECIMAL(10,2) NOT NULL COMMENT '单位：元',
    简介 TEXT,
    库存量 INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS 借阅表 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    读者ID INT NOT NULL,
    图书ID INT NOT NULL,
    租期 INT NOT NULL DEFAULT 30 COMMENT '单位：天',
    借出日期 DATE NOT NULL,
    归还日期 DATE DEFAULT NULL,
    可续借次数 INT NOT NULL DEFAULT 2,
    状态 ENUM('按期归还','未归还','超期归还','超期未归还') NOT NULL DEFAULT '未归还',
    CONSTRAINT fk_借阅_读者 
        FOREIGN KEY (读者ID) REFERENCES 读者表(ID)
        ON UPDATE CASCADE,
    CONSTRAINT fk_借阅_图书
        FOREIGN KEY (图书ID) REFERENCES 图书表(ID)
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `读者表` (`ID`, `账号`, `密码`, `学号`, `姓名`, `性别`, `生日`, `电话`, `邮箱`) VALUES
(1,'SongZhengfei', SHA2('123456', 256), '2151094', '宋正非', '男', '2003-08-29', '13656267543', '2151094@tongji.edu.cn'),
(2,'lisi', SHA2('abc123', 256), '2230001', '李四', '女', '1999-12-01', '13912345678', 'lisi@example.com'),
(3,'wangwu', SHA2('mypass', 256), '2250002', '王五', '男', '2002-08-20', '13512345678', 'wangwu@example.com'),
(4,'zhaoliu', SHA2('qwerty', 256), '0000000', '赵六', '男', '1981-03-10', '13600001111', 'zhaoliu@example.com'),
(5,'sunqi', SHA2('sun2024', 256), '1111111', '孙七', '女', '1963-11-05', '13755556666', 'sunqi@example.com');

INSERT INTO `图书表` (`ID`,`书名`, `作者`, `ISBN`, `出版社`, `出版日期`, `分类`, `价格`, `库存量`, `简介`) VALUES
(1,'数据库系统概念', 'Abraham Silberschatz', '9787111612728', '机械工业', '2022-01-01', '计算机', 99.00, 2, '经典数据库教材'),
(2,'Python编程：从入门到实践', 'Eric Matthes', '9787115546081', '人民邮电', '2020-06-01', '编程', 89.00, 0, 'Python学习必备'),
(3,'算法导论', 'Thomas Cormen', '9787115353520', '机械工业', '2013-01-01', '算法', 128.00, 3, '算法领域权威著作'),
(4,'机器学习', '周志华', '9787302423287', '清华出版社', '2016-01-01', '人工智能', 79.00, 1, '西瓜书'),
(5,'计算机网络', '谢希仁', '9787121377793', '电子工业', '2021-06-01', '网络', 69.80, 0, '第8版'),
(6,'操作系统导论', 'Remzi Arpaci', '9787115542366', '人民邮电', '2020-09-01', '系统', 119.00, 4, 'OSTEP中文版'),
(7,'深入理解Java虚拟机', '周志明', '9787111641247', '机械工业', '2020-06-01', '编程', 129.00, 2, 'JVM高级特性'),
(8,'C++ Primer', 'Stanley Lippman', '9787121373108', '电子工业', '2020-05-01', '编程', 158.00, 1, 'C++经典教程'),
(9,'数据结构与算法', '王争', '9787121416027', '人民邮电', '2021-05-01', '算法', 89.00, 3, '图解数据结构'),
(10,'人工智能：现代方法', 'Stuart Russell', '9787111641248', '清华出版社', '2020-10-01', '人工智能', 139.00, 0, 'AI经典教材');

INSERT INTO `借阅表` (`ID`, `读者ID`, `图书ID`, `租期`, `借出日期`, `归还日期`, `可续借次数`, `状态`) VALUES
(1, 1, 1, 30, '2023-09-01', '2023-09-25', 2, '按期归还'),  
(2, 2, 3, 45, '2023-10-05', NULL, 1, '未归还'),       
(3, 3, 4, 60, '2023-09-15', '2023-12-20', 0, '超期归还'), 
(4, 4, 7, 30, '2024-10-01', '2024-10-30', 2, '按期归还'),
(5, 5, 8, 30, '2024-12-10', NULL, 2, '未归还'),
(6, 1, 6, 30, '2025-01-15', NULL, 2, '未归还'), 
(7, 2, 2, 30, '2025-01-25', '2025-03-01', 2, '按期归还'), 
(8, 3, 9, 60, '2025-02-01', NULL, 0, '未归还'),
(9, 4, 10, 30, '2025-02-02', NULL, 2, '未归还'),
(10, 5, 5, 45, '2025-02-02', '2025-03-16', 1, '按期归还'); 

ALTER DATABASE `图书管理系统` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE 读者表 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE 图书表 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE 借阅表 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE 读者表 MODIFY 姓名 VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE 图书表 MODIFY 书名 VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DELIMITER $$
CREATE PROCEDURE borrow_bk (
    IN 输入姓名 VARCHAR(50),
    IN 输入书名 VARCHAR(100)
)
BEGIN
    -- 定义临时变量存储读者ID和图书ID
    DECLARE 读者ID INT;
    DECLARE 图书ID INT;
    DECLARE 当前库存量 INT;

    -- 查询读者ID，确保只返回一行
    SELECT ID INTO 读者ID
    FROM 读者表
    WHERE 姓名 = 输入姓名
    LIMIT 1;

    -- 查询图书ID和库存量，确保只返回一行
    SELECT ID, 库存量 INTO 图书ID, 当前库存量
    FROM 图书表
    WHERE 书名 = 输入书名
    LIMIT 1;

    -- 检查库存量是否大于0
    IF 当前库存量 > 0 THEN
        -- 插入一条借阅记录
        INSERT INTO 借阅表 (读者ID, 图书ID, 借出日期, 租期, 可续借次数, 状态)
        VALUES (读者ID, 图书ID, CURDATE(), 30, 2, '未归还');

        -- 更新图书库存量
        UPDATE 图书表
        SET 库存量 = 库存量 - 1
        WHERE ID = 图书ID;

        -- 提示借书成功
        SELECT CONCAT('借阅成功！读者 "', 输入姓名, '" 借阅了图书 "', 输入书名, '"。') AS 借阅信息;
    ELSE
        -- 提示库存不足
        SELECT CONCAT('借阅失败！图书 "', 输入书名, '" 当前库存量不足。') AS 借阅信息;
    END IF;
END$$

DELIMITER ;

CALL borrow_bk('宋正非', '操作系统导论');
CALL borrow_bk('宋正非', '机器学习');
CALL borrow_bk('宋正非', '人工智能：现代方法');

DELIMITER $$

CREATE PROCEDURE update_status()
BEGIN
    -- 更新超期未归还的借阅记录
    SET SQL_SAFE_UPDATES = 0;
    UPDATE 借阅表
    SET 状态 = '超期未归还'
    WHERE (CURDATE() > DATE_ADD(借出日期, INTERVAL 租期 DAY)
    AND 归还日期 IS NULL
    AND 状态 = '未归还');

    -- 查询超期未归还的读者和图书信息
    SELECT DISTINCT 读者表.姓名 AS 读者姓名, 图书表.书名 AS 图书名称
    FROM 借阅表
    JOIN 读者表 ON 借阅表.读者ID = 读者表.ID
    JOIN 图书表 ON 借阅表.图书ID = 图书表.ID
    WHERE CURDATE() > DATE_ADD(借阅表.借出日期, INTERVAL 借阅表.租期 DAY)
    AND 借阅表.归还日期 IS NULL
    AND 借阅表.状态 = '超期未归还';
END$$

DELIMITER ;

CALL update_status();

DELIMITER $$

CREATE PROCEDURE renew_borrow (
    IN 输入姓名 VARCHAR(50),
    IN 输入书名 VARCHAR(100)
)
BEGIN
    -- 定义临时变量存储读者ID、图书ID、借阅ID、可续借次数、租期和状态
    DECLARE 读者ID INT;
    DECLARE 图书ID INT;
    DECLARE 借阅ID INT;
    DECLARE 可续借次数 INT;
    DECLARE 租期 INT;
    DECLARE 借阅状态 ENUM('按期归还', '未归还', '超期归还', '超期未归还');
    
    -- 查询读者ID，确保只返回一行
    SELECT ID INTO 读者ID
    FROM 读者表
    WHERE 姓名 = 输入姓名
    LIMIT 1;
    
    -- 查询图书ID，确保只返回一行
    SELECT ID INTO 图书ID
    FROM 图书表
    WHERE 书名 = 输入书名
    LIMIT 1;
    
    -- 查询借阅记录，获取可续借次数、租期和状态
    SELECT 借阅表.ID, 借阅表.可续借次数, 借阅表.租期, 借阅表.状态 
    INTO 借阅ID, 可续借次数, 租期, 借阅状态
    FROM 借阅表
    JOIN 读者表 ON 借阅表.读者ID = 读者表.ID
    JOIN 图书表 ON 借阅表.图书ID = 图书表.ID
    WHERE 读者表.ID = 读者ID AND 图书表.ID = 图书ID 
    AND 借阅表.状态 = '未归还' 
    AND CURDATE() <= DATE_ADD(借阅表.借出日期, INTERVAL 借阅表.租期 DAY)
    LIMIT 1;

    -- 如果借阅记录存在并且符合续借条件
    IF 借阅ID IS NOT NULL AND 可续借次数 > 0 THEN
        -- 更新借阅记录，续借租期并减少续借次数
        UPDATE 借阅表
        SET 租期 = 租期 + 15, 可续借次数 = 可续借次数 - 1
        WHERE ID = 借阅ID;
        
        -- 提示续借成功
        SELECT CONCAT('续借成功！读者 "', 输入姓名, '" 续借了图书 "', 输入书名, '"，新的租期为 ', 租期 + 15, ' 天。') AS 续借信息;
    ELSE
        -- 提示续借失败
        SELECT CONCAT('续借失败！图书 "', 输入书名, '" 当前不可续借。') AS 续借信息;
    END IF;
END$$

DELIMITER ;

CALL renew_borrow('宋正非', '操作系统导论');

DELIMITER $$

CREATE PROCEDURE return_book (
    IN 输入姓名 VARCHAR(50),
    IN 输入书名 VARCHAR(100)
)
BEGIN
    -- 定义临时变量存储读者ID、图书ID、借阅ID、借出日期、租期和当前状态
    DECLARE 读者ID INT;
    DECLARE 图书ID INT;
    DECLARE 借阅ID INT;
    DECLARE 借出日期 DATE;
    DECLARE 租期 INT;
    DECLARE 归还日期 DATE;
    DECLARE 当前日期 DATE;
    DECLARE 借阅状态 ENUM('按期归还', '未归还', '超期归还', '超期未归还');
    
    -- 获取当前日期
    SET 当前日期 = CURDATE();

    -- 查询读者ID，确保只返回一行
    SELECT ID INTO 读者ID
    FROM 读者表
    WHERE 姓名 = 输入姓名
    LIMIT 1;

    -- 查询图书ID，确保只返回一行
    SELECT ID INTO 图书ID
    FROM 图书表
    WHERE 书名 = 输入书名
    LIMIT 1;

    -- 查询借阅记录，获取借出日期、租期、状态和借阅ID
    SELECT 借阅表.ID, 借阅表.借出日期, 借阅表.租期, 借阅表.状态, 借阅表.归还日期
    INTO 借阅ID, 借出日期, 租期, 借阅状态, 归还日期
    FROM 借阅表
    WHERE 借阅表.读者ID = 读者ID AND 借阅表.图书ID = 图书ID
    AND 借阅表.状态 IN ('未归还', '超期未归还') 
    LIMIT 1;

    -- 判断借阅记录是否存在
    IF 借阅ID IS NOT NULL THEN
        -- 如果归还日期为 NULL，说明还书操作未完成
        IF 归还日期 IS NULL THEN
            -- 判断是否超期
            IF 当前日期 > DATE_ADD(借出日期, INTERVAL 租期 DAY) THEN
                -- 超期归还
                UPDATE 借阅表
                SET 归还日期 = 当前日期, 状态 = '超期归还'
                WHERE ID = 借阅ID;
                
                -- 更新图书库存量
                UPDATE 图书表
                SET 库存量 = 库存量 + 1
                WHERE ID = 图书ID;

                -- 提示超期归还
                SELECT CONCAT('图书 "', 输入书名, '" 已超期归还。') AS 还书信息;
            ELSE
                -- 正常归还
                UPDATE 借阅表
                SET 归还日期 = 当前日期, 状态 = '按期归还'
                WHERE ID = 借阅ID;
                
                -- 更新图书库存量
                UPDATE 图书表
                SET 库存量 = 库存量 + 1
                WHERE ID = 图书ID;

                -- 提示按期归还
                SELECT CONCAT('图书 "', 输入书名, '" 按期归还。') AS 还书信息;
            END IF;
        ELSE
            -- 已经归还，不需要重复归还
            SELECT CONCAT('图书 "', 输入书名, '" 已经归还。') AS 还书信息;
        END IF;
    ELSE
        -- 未找到借阅记录
        SELECT CONCAT('借阅记录未找到，无法归还图书 "', 输入书名, '"。') AS 还书信息;
    END IF;
END$$

DELIMITER ;

CALL return_book('宋正非', '机器学习');
CALL return_book('李四', 'Python编程：从入门到实践');
CALL return_book('李四', '算法导论');

SELECT 图书表.书名, 图书表.出版社
FROM 图书表
LEFT JOIN 借阅表 ON 图书表.ID = 借阅表.图书ID
WHERE 图书表.库存量 = 0
GROUP BY 图书表.书名, 图书表.出版社
HAVING COUNT(借阅表.ID) > 0;

SELECT 读者表.姓名, COUNT(借阅表.ID) AS 借阅总数
FROM 读者表
LEFT JOIN 借阅表 ON 读者表.ID = 借阅表.读者ID
GROUP BY 读者表.姓名
ORDER BY 借阅总数 DESC;

INSERT INTO `图书表` (`书名`, `作者`, `ISBN`, `出版社`, `出版日期`, `分类`, `价格`, `库存量`, `简介`) VALUES
('深度学习', 'Ian Goodfellow', '9787111613032', '机械工业', '2018-07-01', '人工智能', 199.00, 0, '深度学习经典教材'),
('计算机组成原理', '唐朔飞', '9787121357685', '电子工业', '2019-05-01', '计算机', 89.00, 0, '计算机硬件基础');

UPDATE 图书表
SET 分类 = '待补货'
WHERE 库存量 = 0
AND ID NOT IN (
    SELECT DISTINCT 图书ID
    FROM 借阅表
    WHERE 借阅表.归还日期 IS NULL
);

DELETE FROM 借阅表
WHERE 归还日期 IS NOT NULL;

ALTER TABLE 读者表
DROP COLUMN 信用分;

ALTER TABLE 读者表
ADD COLUMN 信用分 INT DEFAULT 100;

CREATE TABLE IF NOT EXISTS 信用分变动表 (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    读者ID INT NOT NULL,
    变动类型 ENUM('扣分', '加分') NOT NULL,
    变动分值 INT NOT NULL,
    变动时间 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    借阅ID INT NOT NULL,
    FOREIGN KEY (读者ID) REFERENCES 读者表(ID),
    FOREIGN KEY (借阅ID) REFERENCES 借阅表(ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELIMITER $$

CREATE PROCEDURE deduct_credit()
BEGIN
    -- 声明所有变量和游标（必须放在 BEGIN 后的最前面）
    DECLARE 读者ID INT;
    DECLARE 借阅ID INT;
    DECLARE 当前信用分 INT;
    DECLARE 已扣分 INT;
    DECLARE done INT DEFAULT FALSE;

    -- 声明游标
    DECLARE cur CURSOR FOR 
        SELECT 读者ID, 借阅表.ID
        FROM 借阅表
        JOIN 读者表 ON 借阅表.读者ID = 读者表.ID
        WHERE 借阅表.状态 = '超期归还';

    -- 声明异常处理
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- 执行更新操作（在 DECLARE 之后）
    UPDATE 借阅表
    SET 状态 = '超期归还'
    WHERE 归还日期 > DATE_ADD(借出日期, INTERVAL 租期 DAY)
    AND 归还日期 IS NOT NULL
    AND 状态 = '未归还';

    -- 遍历游标处理扣分逻辑
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO 读者ID, 借阅ID;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT 信用分 INTO 当前信用分
        FROM 读者表
        WHERE ID = 读者ID;

        UPDATE 读者表
        SET 信用分 = 当前信用分 - 5
        WHERE ID = 读者ID;

        INSERT INTO 信用分变动表 (读者ID, 变动类型, 变动分值, 借阅ID)
        VALUES (读者ID, '扣分', -5, 借阅ID);
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE add_credit()
BEGIN
    -- 声明所有变量和游标
    DECLARE 读者ID INT;
    DECLARE 借阅ID INT;
    DECLARE 当前信用分 INT;
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR 
        SELECT 读者ID, 借阅表.ID
        FROM 借阅表
        JOIN 读者表 ON 借阅表.读者ID = 读者表.ID
        WHERE 借阅表.状态 = '按期归还';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- 执行更新操作
    UPDATE 借阅表
    SET 状态 = '按期归还'
    WHERE 归还日期 <= DATE_ADD(借出日期, INTERVAL 租期 DAY)
    AND 归还日期 IS NOT NULL
    AND 状态 = '未归还';

    -- 遍历游标处理加分逻辑
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO 读者ID, 借阅ID;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT 信用分 INTO 当前信用分
        FROM 读者表
        WHERE ID = 读者ID;

        UPDATE 读者表
        SET 信用分 = 当前信用分 + 2
        WHERE ID = 读者ID;

        INSERT INTO 信用分变动表 (读者ID, 变动类型, 变动分值, 借阅ID)
        VALUES (读者ID, '加分', 2, 借阅ID);
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;