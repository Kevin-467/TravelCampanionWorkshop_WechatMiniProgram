/*
 Navicat Premium Dump SQL

 Source Server         : DESKTOP-SUMMER
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : db_travelcampanionsystem

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 01/03/2025 00:14:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名，最大长度15个字符，且唯一',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码，最大长度255个字符，存储加密后的值，且不可反解',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '后台管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------

-- ----------------------------
-- Table structure for arrange
-- ----------------------------
DROP TABLE IF EXISTS `arrange`;
CREATE TABLE `arrange`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '行程id',
  `plan_id` int UNSIGNED NULL DEFAULT NULL COMMENT '方案id',
  `day` int UNSIGNED NULL DEFAULT NULL COMMENT '第几天',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '行程概述',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '详细行程',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `plan_id`(`plan_id` ASC) USING BTREE,
  CONSTRAINT `arrange_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `arrange_chk_1` CHECK (`day` > 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '行程安排表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of arrange
-- ----------------------------

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '登录记录id',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `openid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '微信用户唯一标识',
  `session_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话密钥',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户token',
  `token_expiration` datetime NOT NULL COMMENT 'token过期时间',
  `last_login_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后登录时间',
  `login_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'wechat' COMMENT '登录来源',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid` ASC) USING BTREE,
  UNIQUE INDEX `session_key`(`session_key` ASC) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `user_id_2`(`user_id` ASC) USING BTREE,
  INDEX `token_2`(`token` ASC) USING BTREE,
  CONSTRAINT `login_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户登录信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `cover_image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '封面图片url',
  `type` enum('系统公告','活动公告') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `expired_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `author_id` int UNSIGNED NULL DEFAULT NULL COMMENT '发布者ID (仅限于管理员发布)',
  `status` enum('已发布','已归档') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '已发布' COMMENT '公告状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `author_id`(`author_id` ASC) USING BTREE,
  INDEX `author_id_2`(`author_id` ASC) USING BTREE,
  INDEX `type`(`type` ASC) USING BTREE,
  CONSTRAINT `notice_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for notice_attachments
-- ----------------------------
DROP TABLE IF EXISTS `notice_attachments`;
CREATE TABLE `notice_attachments`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `notice_id` int UNSIGNED NOT NULL COMMENT '所属公告ID',
  `file_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名称',
  `file_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件URL',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件描述',
  `upload_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notice_id`(`notice_id` ASC) USING BTREE,
  CONSTRAINT `notice_attachments_ibfk_1` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice_attachments
-- ----------------------------

-- ----------------------------
-- Table structure for plan
-- ----------------------------
DROP TABLE IF EXISTS `plan`;
CREATE TABLE `plan`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '旅游方案id',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `personality` enum('探索未知、寻找独特的旅行体验','选择热门景点、享受热闹氛围','依赖朋友/家人的建议、避免过多选择') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户性格',
  `hobbies` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户兴趣爱好',
  `time` enum('短途旅行（1-3天）','中长途旅行（4-7天）','长途旅行（超过7天）') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '计划旅游天数',
  `budget` enum('0-1000元','1000-3000元','3000-5000元','5000-10000元','10000元以上') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预算范围',
  `preference` enum('登山徒步','越野冒险','探索历史遗迹','参观名胜古迹','体验当地习俗文化','品尝美食') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '旅游偏好',
  `total_spending` int UNSIGNED NULL DEFAULT NULL COMMENT '方案预计花费',
  `arrange` json NULL COMMENT '行程安排，具体见arrange表',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '方案生成时间',
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '可用状态，0：可用，1：被占用/不可用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `personality`(`personality` ASC, `hobbies` ASC, `time` ASC, `budget` ASC, `preference` ASC) USING BTREE,
  INDEX `total_spending`(`total_spending` ASC) USING BTREE,
  CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '个性化旅游方案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plan
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子id',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `img_Url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '封面图Url',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('草稿','已发布','已删除') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '已发布',
  `views` int UNSIGNED NULL DEFAULT 0,
  `likes` int UNSIGNED NULL DEFAULT 0,
  `comments_count` int UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------

-- ----------------------------
-- Table structure for route
-- ----------------------------
DROP TABLE IF EXISTS `route`;
CREATE TABLE `route`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '路线id',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `destination` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '旅游目的地',
  `travel_days` int UNSIGNED NOT NULL COMMENT '计划旅游天数',
  `budget` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '预算',
  `preference` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '旅游偏好',
  `route_description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '暂无描述' COMMENT '路线描述',
  `route_spots` json NOT NULL COMMENT '景点id数组',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '路线生成时间',
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '可用状态，0：可用，1：被占用/不可用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `destination`(`destination` ASC, `travel_days` ASC, `budget` ASC, `preference` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_chk_1` CHECK (`travel_days` > 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生成旅游路线表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route
-- ----------------------------

-- ----------------------------
-- Table structure for route_spots_mapping
-- ----------------------------
DROP TABLE IF EXISTS `route_spots_mapping`;
CREATE TABLE `route_spots_mapping`  (
  `route_id` int UNSIGNED NOT NULL,
  `spot_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`route_id`, `spot_id`) USING BTREE,
  INDEX `spot_id`(`spot_id` ASC) USING BTREE,
  CONSTRAINT `route_spots_mapping_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_spots_mapping_ibfk_2` FOREIGN KEY (`spot_id`) REFERENCES `spots` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '旅游路线景点关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route_spots_mapping
-- ----------------------------

-- ----------------------------
-- Table structure for spots
-- ----------------------------
DROP TABLE IF EXISTS `spots`;
CREATE TABLE `spots`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '景点id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '景点名称',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '景点地址',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '景点描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `location`(`location` ASC) USING BTREE,
  FULLTEXT INDEX `description`(`description`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '景点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spots
-- ----------------------------

-- ----------------------------
-- Table structure for teamup
-- ----------------------------
DROP TABLE IF EXISTS `teamup`;
CREATE TABLE `teamup`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '组队ID',
  `initator_id` int UNSIGNED NULL DEFAULT NULL COMMENT '发起者ID 仅限于用户',
  `nickname` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发起者昵称 可不与用户本身的昵称相同',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发起者性别',
  `travel_days` int UNSIGNED NULL DEFAULT NULL COMMENT '计划旅游天数',
  `budget` int UNSIGNED NULL DEFAULT NULL COMMENT '预算',
  `preference` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '旅游偏好',
  `picUrl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '组队封面',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '组队发起时间',
  `participant_id` int UNSIGNED NULL DEFAULT NULL COMMENT '搭子ID',
  `teamup_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '组队成功时间',
  `status` enum('正在组队中','已组队成功') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '正在组队中' COMMENT '组队状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `initator_id`(`initator_id` ASC) USING BTREE,
  INDEX `participant_id`(`participant_id` ASC) USING BTREE,
  FULLTEXT INDEX `preference`(`preference`),
  CONSTRAINT `teamup_ibfk_1` FOREIGN KEY (`initator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teamup_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '组队表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teamup
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `nickname` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '微信用户' COMMENT '昵称',
  `avatar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '头像url',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `hobby` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '兴趣爱好',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  INDEX `gender`(`gender` ASC) USING BTREE,
  FULLTEXT INDEX `hobby`(`hobby`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户个人信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Procedure structure for process_arrange
-- ----------------------------
DROP PROCEDURE IF EXISTS `process_arrange`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_arrange`(
  IN plan_id INT UNSIGNED, 
  IN arrange JSON,
  OUT exec_status INT
)
BEGIN 

DECLARE `day` INT UNSIGNED;
DECLARE title VARCHAR(50);
DECLARE detail TEXT;
DECLARE arrange_length INT UNSIGNED;
DECLARE `index` INT DEFAULT 0;
DECLARE existing_arranges JSON;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN 
  ROLLBACK;
  SET exec_status = 2;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'SQL语句有误，执行失败！';
END;

SET exec_status = 0;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

UPDATE plan SET status = '1' WHERE id = plan_id AND `status` = '0';
IF ROW_COUNT() = 0 THEN
  SET exec_status = 1;
  ROLLBACK;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '当前操作的方案被占用！';
END IF;

SELECT 1 FROM plan WHERE id = plan_id FOR UPDATE;
SELECT 1 FROM arrange WHERE plan_id = plan_id FOR UPDATE;

SET arrange_length = JSON_LENGTH(arrange);

SELECT JSON_ARRAYAGG(JSON_OBJECT('id', id, 'day', day, 'title', title, 'detail', detail))
INTO existing_arranges
FROM arrange WHERE plan_id = plan_id;

WHILE `index` < arrange_length DO
  SET title = JSON_UNQUOTE(JSON_EXTRACT(arrange, CONCAT('$[', `index`, '].title')));
  SET detail = JSON_UNQUOTE(JSON_EXTRACT(arrange, CONCAT('$[', `index`, '].detail')));
  SET `day` = `index` + 1;
  
  IF NOT JSON_CONTAINS(existing_arranges, JSON_OBJECT('day', `day`)) THEN
    INSERT INTO arrange (plan_id, day, title, detail) VALUES (plan_id, `day`, title, detail);
  ELSE
    UPDATE arrange 
    SET title = title, detail = detail 
    WHERE plan_id = plan_id AND day = `day`;
  END IF;
  
  SET `index` = `index` + 1;
END WHILE;

DELETE FROM arrange WHERE plan_id = plan_id AND day NOT IN (SELECT day FROM arrange WHERE plan_id = plan_id);

COMMIT;

UPDATE plan SET status = '0' WHERE id = plan_id;
SET exec_status = 0;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for process_route_spots
-- ----------------------------
DROP PROCEDURE IF EXISTS `process_route_spots`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_route_spots`( 
IN route_id INT UNSIGNED, 
IN route_spots JSON,
OUT exec_status INT
)
BEGIN 

DECLARE spot_id INT;
DECLARE `index` INT DEFAULT 0;
DECLARE spot_count INT;
DECLARE exist_spot_ids JSON;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN 
  ROLLBACK;
  SET exec_status = 2;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'SQL语句有误，执行失败！';
END;

SET exec_status = 0;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

UPDATE route SET status = '1' WHERE id = route_id AND `status` = '0';
IF ROW_COUNT() = 0 THEN
  SET exec_status = 1;
  ROLLBACK;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '当前操作的路线被占用！';
END IF;

SELECT 1 FROM route WHERE id = route_id FOR UPDATE;
SELECT 1 FROM route_spots_mapping WHERE route_id = route_id FOR UPDATE;

SET spot_count = JSON_LENGTH(route_spots);

SELECT JSON_ARRAYAGG(id) INTO exist_spot_ids FROM route_spots_mapping WHERE route_id = route_id;

WHILE `index` < spot_count DO
  SET spot_id = JSON_UNQUOTE(JSON_EXTRACT(route_spots, CONCAT('$[', `index`, ']')));
  
  IF NOT JSON_CONTAINS(exist_spot_ids, CAST(spot_id AS JSON)) THEN
    INSERT INTO route_spots_mapping (route_id, spot_id) VALUES (route_id, spot_id);
  END IF;
  
  SET `index` = `index` + 1;
END WHILE;

COMMIT;

UPDATE route SET status = '0' WHERE id = route_id;
SET exec_status = 0;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for check_expired_notices
-- ----------------------------
DROP EVENT IF EXISTS `check_expired_notices`;
delimiter ;;
CREATE EVENT `check_expired_notices`
ON SCHEDULE
EVERY '1' HOUR STARTS '2025-02-23 22:56:06'
DO UPDATE notice
  SET status = '已归档'
  WHERE expired_time < NOW() AND status = '已发布'
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table plan
-- ----------------------------
DROP TRIGGER IF EXISTS `set_default_plan_arrange`;
delimiter ;;
CREATE TRIGGER `set_default_plan_arrange` BEFORE INSERT ON `plan` FOR EACH ROW BEGIN
    IF NEW.arrange IS NULL THEN
        SET NEW.arrange = '[]';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table plan
-- ----------------------------
DROP TRIGGER IF EXISTS `before_insert_plan`;
delimiter ;;
CREATE TRIGGER `before_insert_plan` BEFORE INSERT ON `plan` FOR EACH ROW BEGIN
  CALL process_arrange(NEW.id,NEW.arrange);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table plan
-- ----------------------------
DROP TRIGGER IF EXISTS `before_update_plan`;
delimiter ;;
CREATE TRIGGER `before_update_plan` BEFORE UPDATE ON `plan` FOR EACH ROW BEGIN
    DECLARE exec_status INT;
    DECLARE done INT DEFAULT 0;
    DECLARE start_time DATETIME;
    DECLARE timeout INT DEFAULT 10;
    
    SET start_time = NOW();
    REPEAT
      SET exec_status = process_arrange(NEW.id,NEW.arrange);
      
      IF exec_status = 1 THEN
        DO SLEEP(2);
      ELSE
        SET done = 1;
      END IF;
      
      IF TIMESTAMPDIFF(SECOND,start_time,NOW()) > timeout THEN
        SET done = 1;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '请求超时，请稍后重试！';
       END IF;
    UNTIL done = 1
    END REPEAT;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table route
-- ----------------------------
DROP TRIGGER IF EXISTS `set_default_route_spots`;
delimiter ;;
CREATE TRIGGER `set_default_route_spots` BEFORE INSERT ON `route` FOR EACH ROW BEGIN
    IF NEW.route_spots IS NULL THEN
        SET NEW.route_spots = '[]';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table route
-- ----------------------------
DROP TRIGGER IF EXISTS `before_route_insert`;
delimiter ;;
CREATE TRIGGER `before_route_insert` BEFORE INSERT ON `route` FOR EACH ROW BEGIN
  CALL process_route_spots(NEW.id,NEW.route_spots);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table route
-- ----------------------------
DROP TRIGGER IF EXISTS `before_route_spots_update`;
delimiter ;;
CREATE TRIGGER `before_route_spots_update` BEFORE UPDATE ON `route` FOR EACH ROW BEGIN
    DECLARE exec_status INT;
    DECLARE done INT DEFAULT 0;
    DECLARE start_time DATETIME;
    DECLARE timeout INT DEFAULT 15;
    
    SET start_time = NOW();
    REPEAT
      SET exec_status =  process_route_spots(NEW.id, NEW.route_spots);
      
      IF exec_status = 1 THEN
        DO SLEEP(2);
      ELSE
        SET done = 1;
      END IF;
      
      IF TIMESTAMPDIFF(SECOND,start_time,NOW()) > timeout THEN
        SET done = 1;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '请求超时，请稍后重试！';
       END IF;
    UNTIL done = 1
    END REPEAT;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teamup
-- ----------------------------
DROP TRIGGER IF EXISTS `before_update_participantID`;
delimiter ;;
CREATE TRIGGER `before_update_participantID` BEFORE UPDATE ON `teamup` FOR EACH ROW BEGIN
  -- 检查更新的 participant_id 是否与 initator_id 相同
  IF NEW.participant_id = OLD.initator_id THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '搭子与发起者不能是同一个人';
  END IF;
  IF OLD.participant_id = NEW.initator_id THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '搭子与发起者不能是同一个人';
  END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
