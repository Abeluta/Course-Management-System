/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : ktp

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2020-06-22 08:42:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `tno` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cm_date` datetime NOT NULL,
  PRIMARY KEY (`tno`,`uid`,`cm_date`),
  KEY `uid` (`uid`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`tno`) REFERENCES `task` (`tno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('0094bb', '207b0043', '沙发', '2020-06-20 11:58:01');
INSERT INTO `comment` VALUES ('0094bb', '207b0043', 'djksfj \njisodjf\ndsjf', '2020-06-20 11:59:08');
INSERT INTO `comment` VALUES ('0094bb', '207b0043', '我觉得非常不错！', '2020-06-21 17:20:02');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `cno` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程号',
  `cname` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `admin` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `school_year` char(9) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学年(例2019-2020)',
  `semester` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学期',
  `snum` int(4) NOT NULL COMMENT '成员数量(学生)',
  `archive` int(1) NOT NULL COMMENT '归档状态',
  `cdelete` int(1) NOT NULL COMMENT '删除状态',
  PRIMARY KEY (`cno`),
  KEY `admin` (`admin`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`admin`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('4f782', 'C++', '207b0043', '2020-06-13 08:32:46', '2018-2019', '1', '3', '0', '0');
INSERT INTO `course` VALUES ('4f93b', 'Python程序设计', '207b0043', '2020-06-21 08:35:43', '2019-2020', '2', '1', '1', '1');
INSERT INTO `course` VALUES ('574cb', '35435', '207b0043', '2020-06-20 03:27:54', '2020-2021', '1', '0', '1', '1');
INSERT INTO `course` VALUES ('77613', '高级Java', '207b0043', '2020-06-13 02:45:57', '2019-2020', '1', '2', '0', '0');
INSERT INTO `course` VALUES ('da986', '234xx', '207b0043', '2020-06-18 13:41:42', '2019-2020', '1', '0', '1', '1');

-- ----------------------------
-- Table structure for course_member
-- ----------------------------
DROP TABLE IF EXISTS `course_member`;
CREATE TABLE `course_member` (
  `cno` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程号',
  `member` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '成员ID',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '课程状态,0->正常,1->归档,2->退课',
  PRIMARY KEY (`cno`,`member`),
  KEY `member` (`member`),
  CONSTRAINT `course_member_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_member_ibfk_2` FOREIGN KEY (`member`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_member
-- ----------------------------
INSERT INTO `course_member` VALUES ('4f782', '18847da7', '0');
INSERT INTO `course_member` VALUES ('4f782', '2c025bae', '0');
INSERT INTO `course_member` VALUES ('4f782', '5ddc9d7a', '0');
INSERT INTO `course_member` VALUES ('4f782', 'f4c5b7f9', '2');
INSERT INTO `course_member` VALUES ('77613', 'd1f7378b', '0');
INSERT INTO `course_member` VALUES ('77613', 'f4c5b7f9', '0');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `member` char(8) NOT NULL COMMENT '成员',
  `tno` char(6) NOT NULL COMMENT '作业号',
  `score` int(3) DEFAULT '-1' COMMENT '分数',
  `status` int(1) DEFAULT '0' COMMENT '批改状态',
  `answer` text,
  PRIMARY KEY (`member`,`tno`),
  KEY `tno` (`tno`),
  CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`member`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `grade_ibfk_3` FOREIGN KEY (`tno`) REFERENCES `task` (`tno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('18847da7', '0094bb', '78', '1', null);
INSERT INTO `grade` VALUES ('18847da7', '2d9513', '-1', '0', null);
INSERT INTO `grade` VALUES ('18847da7', '9f8070', '-1', '0', null);
INSERT INTO `grade` VALUES ('18847da7', 'ffba83', '-1', '0', null);
INSERT INTO `grade` VALUES ('2c025bae', '0094bb', '91', '1', null);
INSERT INTO `grade` VALUES ('2c025bae', '2d9513', '-1', '0', null);
INSERT INTO `grade` VALUES ('2c025bae', '9f8070', '-1', '0', null);
INSERT INTO `grade` VALUES ('2c025bae', 'ffba83', '-1', '0', null);
INSERT INTO `grade` VALUES ('5ddc9d7a', '0094bb', '78', '1', null);
INSERT INTO `grade` VALUES ('5ddc9d7a', '9f8070', '-1', '0', null);
INSERT INTO `grade` VALUES ('5ddc9d7a', 'ffba83', '-1', '0', null);
INSERT INTO `grade` VALUES ('d1f7378b', '9f9087', '-1', '0', null);
INSERT INTO `grade` VALUES ('d1f7378b', 'e20139', '-1', '0', null);
INSERT INTO `grade` VALUES ('f4c5b7f9', '0094bb', '78', '1', '123');
INSERT INTO `grade` VALUES ('f4c5b7f9', '9f8070', '-1', '0', null);
INSERT INTO `grade` VALUES ('f4c5b7f9', '9f9087', '0', '0', '提交本次的作业！');
INSERT INTO `grade` VALUES ('f4c5b7f9', 'e20139', '-1', '0', null);
INSERT INTO `grade` VALUES ('f4c5b7f9', 'ffba83', '20', '1', '提交测试');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `msg_id` char(11) NOT NULL COMMENT '消息id',
  `from_u` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送方',
  `to_u` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接收方',
  `msg` text NOT NULL COMMENT '消息内容',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '阅读状态',
  PRIMARY KEY (`msg_id`),
  KEY `message_ibfk_1` (`from_u`),
  KEY `message_ibfk_2` (`to_u`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`from_u`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`to_u`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('0c1566c6e4b', '207b0043', '5ddc9d7a', '课程: C, 修改了你的分数，新的分数: 20', '1');
INSERT INTO `message` VALUES ('404e0c0c4e3', '207b0043', 'f4c5b7f9', 'C发布了test22, 请注意查收。', '1');
INSERT INTO `message` VALUES ('658d2271a27', '207b0043', '2c025bae', '课程: C++, 修改了你的分数，新的分数: 91', '0');
INSERT INTO `message` VALUES ('7f4170c4ea1', '207b0043', '18847da7', '课程: C++, 修改了你的分数，新的分数: 78', '0');
INSERT INTO `message` VALUES ('938a04cccfc', '207b0043', 'f4c5b7f9', '这是一个测试用的消息', '1');
INSERT INTO `message` VALUES ('a6128c454c6', '207b0043', 'f4c5b7f9', '课程: C++, 修改了你的分数，新的分数: 0', '1');
INSERT INTO `message` VALUES ('c18d806bb1a', '207b0043', '5ddc9d7a', '课程: C++, 修改了你的分数，新的分数: 78', '0');
INSERT INTO `message` VALUES ('ccb4dac82de', '207b0043', 'f4c5b7f9', '课程: C++, 修改了你的分数，新的分数: 78', '0');
INSERT INTO `message` VALUES ('d66457a4c66', 'd1f7378b', 'f4c5b7f9', 'This is test too', '1');
INSERT INTO `message` VALUES ('f326a30b6cd', '207b0043', 'f4c5b7f9', '课程: C, 修改了你的分数，新的分数: 20', '0');
INSERT INTO `message` VALUES ('f8a83786368', '207b0043', '5ddc9d7a', 'C发布了test22, 请注意查收。', '0');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `pid` int(11) NOT NULL,
  `pname` varchar(16) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '学生');
INSERT INTO `permission` VALUES ('2', '教师');
INSERT INTO `permission` VALUES ('3', '管理员');

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `scl_id` int(11) NOT NULL,
  `scl_name` varchar(40) NOT NULL,
  PRIMARY KEY (`scl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of school
-- ----------------------------
INSERT INTO `school` VALUES ('1', '重庆理工大学');
INSERT INTO `school` VALUES ('2', '重庆大学');
INSERT INTO `school` VALUES ('3', '西南大学');
INSERT INTO `school` VALUES ('4', '重庆邮电大学');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `tno` char(6) NOT NULL COMMENT '作业号',
  `tname` varchar(30) NOT NULL COMMENT '作业名',
  `description` text COMMENT '作业的说明',
  `annex` varchar(255) DEFAULT NULL COMMENT '附件路径',
  `avg_score` float DEFAULT NULL COMMENT '平均分',
  `pass_rate` float DEFAULT NULL COMMENT '合格率',
  `highest_score` int(3) DEFAULT NULL COMMENT '最高分',
  `lowest_score` int(3) DEFAULT NULL COMMENT '最低分',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `end_date` datetime NOT NULL COMMENT '最迟提交时间',
  `submit_num` int(11) DEFAULT '0' COMMENT '提交人数',
  `cno` char(5) NOT NULL COMMENT '所属课程',
  `judge_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`tno`),
  KEY `cno` (`cno`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('0094bb', '1', '<p>1</p>', null, '0', '0', '0', '0', '2020-06-18 13:29:48', '2020-06-29 16:45:00', '1', '4f782', '0');
INSERT INTO `task` VALUES ('2d9513', '第一次作业：猜数游戏（新）', '<p>联系Servlet的使用，完成猜数游戏。</p>', 'ccc52440c9MyBatis.md', '0', '0', '0', '0', '2020-06-21 15:23:12', '2020-06-22 17:00:00', '0', '4f782', '0');
INSERT INTO `task` VALUES ('9f8070', 'test22', '<p>sfds</p><p><span style=\"font-weight: bold;\">正常完成作业</span></p>', '15d7cc9f17ktp数据字典.xlsx', '0', '0', '0', '0', '2020-06-20 06:51:04', '2020-06-21 16:30:00', '0', '4f782', '0');
INSERT INTO `task` VALUES ('9f9087', 'test', '<p>test</p><p>dfioh</p><p>sdf</p>', 'e1cf1fddceMyBatis.md', '0', '0', '0', '0', '2020-06-16 02:42:35', '2020-06-24 17:00:00', '0', '77613', '0');
INSERT INTO `task` VALUES ('e20139', 'test222', '<p>dsfdsg</p>', null, '0', '0', '0', '0', '2020-06-16 02:49:11', '2020-06-28 16:30:00', '0', '77613', '0');
INSERT INTO `task` VALUES ('ffba83', '123', '<p>123</p>', null, '0', '0', '0', '0', '2020-06-15 12:29:54', '2020-06-30 16:45:00', '1', '4f782', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `permission` int(1) NOT NULL COMMENT '身份',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `school` int(11) DEFAULT NULL COMMENT '学校',
  `i_no` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '学号or教师号',
  `u_id` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一身份识别号',
  `avatar` varchar(40) DEFAULT 'default.jpg',
  PRIMARY KEY (`account`),
  UNIQUE KEY `u_id` (`u_id`) USING BTREE,
  KEY `user_ibfk_1` (`permission`),
  KEY `user_ibfk_2` (`school`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`permission`) REFERENCES `permission` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`school`) REFERENCES `school` (`scl_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('111', 'Qpf0SxOVUjUkWySXOZ16kw==', '1', '斯内克', '4', '12784623782', '18847da7', 'default.jpg');
INSERT INTO `user` VALUES ('123123111', 'Qpf0SxOVUjUkWySXOZ16kw==', '2', '谭坤明', '2', '32489083425', '207b0043', 'default.jpg');
INSERT INTO `user` VALUES ('123456', 'Qpf0SxOVUjUkWySXOZ16kw==', '2', '张三', '1', '11823020220', 'd1f7378b', '0f9701f28averify4.jpg');
INSERT INTO `user` VALUES ('1234567', 'Qpf0SxOVUjUkWySXOZ16kw==', '1', '帅哥', '1', '11823020219', 'f4c5b7f9', '43869af9dbverify1.jpg');
INSERT INTO `user` VALUES ('222', 'Qpf0SxOVUjUkWySXOZ16kw==', '1', '正律协', '1', '12789473928', '5ddc9d7a', 'default.jpg');
INSERT INTO `user` VALUES ('333', 'Qpf0SxOVUjUkWySXOZ16kw==', '1', '艾瑞克', '1', '12789473284', '2c025bae', 'default.jpg');
