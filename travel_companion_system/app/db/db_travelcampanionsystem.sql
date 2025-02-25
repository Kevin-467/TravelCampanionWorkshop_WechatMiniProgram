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

 Date: 26/02/2025 02:09:36
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '后台管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户登录信息表' ROW_FORMAT = Dynamic;

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
-- Table structure for route
-- ----------------------------
DROP TABLE IF EXISTS `route`;
CREATE TABLE `route`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '路线id',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `destination` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '旅游目的地',
  `travel_days` int UNSIGNED NULL DEFAULT NULL COMMENT '计划旅游天数',
  `budget` int UNSIGNED NULL DEFAULT NULL COMMENT '预算',
  `preference` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '旅游偏好',
  `route_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '路线描述',
  `route_spots` json NULL COMMENT '景点id数组',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '路线生成时间',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '组队表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户个人信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Procedure structure for process_route_spots
-- ----------------------------
DROP PROCEDURE IF EXISTS `process_route_spots`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_route_spots`(route_id INT UNSIGNED, route_spots JSON)
BEGIN 
  DECLARE spot_id INT;
  DECLARE `index` INT DEFAULT 0;
  DECLARE spot_count INT;

  SET spot_count = JSON_LENGTH(route_spots);
  
  WHILE `index` < spot_count DO
    SET spot_id = JSON_UNQUOTE(JSON_EXTRACT(route_spots, CONCAT('$[', `index`, ']')));
    INSERT INTO route_spots_mapping (route_id, spot_id) VALUES (route_id, spot_id);
    SET `index` = `index` + 1;
  END WHILE;
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
-- Triggers structure for table route
-- ----------------------------
DROP TRIGGER IF EXISTS `after_route_insert`;
delimiter ;;
CREATE TRIGGER `after_route_insert` AFTER INSERT ON `route` FOR EACH ROW BEGIN
  CALL process_route_spots(NEW.id,NEW.route_spots);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table route
-- ----------------------------
DROP TRIGGER IF EXISTS `after_route_spots_update`;
delimiter ;;
CREATE TRIGGER `after_route_spots_update` AFTER UPDATE ON `route` FOR EACH ROW BEGIN
  IF NEW.route_spots != OLD.route_spots THEN
    DELETE FROM route_spots_mapping WHERE route_id = NEW.id;
    CALL process_route_spots(NEW.id, NEW.route_spots);
  END IF;  
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
