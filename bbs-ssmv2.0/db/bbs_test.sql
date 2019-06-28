/*
 Navicat Premium Data Transfer

 Source Server         : baiduyun
 Source Server Type    : MySQL
 Source Server Version : 50614
 Source Host           : 182.61.136.218:3666
 Source Schema         : bbs_test

 Target Server Type    : MySQL
 Target Server Version : 50614
 File Encoding         : 65001

 Date: 14/05/2019 22:06:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
use bbs_test_new;
-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS 'admin';
CREATE TABLE 'admin' (
  'aid'int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  'aname'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员姓名',
  'apassword'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员密码',
  'atime'timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  PRIMARY KEY ('aid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO 'admin'VALUES (1, 'admin', 'admin', '2018-04-12 01:33:06');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS 'article';
CREATE TABLE 'article' (
  'fid'int(11) NOT NULL AUTO_INCREMENT COMMENT '帖子id',
  'titles'varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子标题',
  'fcontent'varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '帖子内容',
  'photo'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帖子图片',
  'bname'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属板块名字',
  'time'timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '发帖时间',
  'userid'int(11) NOT NULL COMMENT '发帖人id',
  'username'varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发帖人姓名',
  'status'int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT 00000000000 COMMENT '帖子审核状态(0为待审核，1为通过审核，2为未通过审核，默认为0)',
  PRIMARY KEY ('fid') USING BTREE,
  INDEX 'userid'('userid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发帖表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO 'article'VALUES (40, 'java集合框架', 'Map\n映射表（也称为关联数组）的基本思想是它维护的是键-值（对）关联，因此你可以使用键来查找值。标准的java类库中包含了Map的几种基本实现。\nHashMap\nMap基于散列表的实现（它实现了HashTable）。插入和查询“键值对”的开销是固定的。可以通过构造器设置容量和负载因子。以调整容器的性能。\nTreeMap\n基于红黑树的实现。查看“键”或者“键值对”时，它们会被排序（次序由Comparable或Comparator决定）。TreeMap的特点在于，所得到的结果是经过排序的。TreeMap是唯一的带有subMap()方法的Map，它可以返回一个子树。', '387c3a86-fd76-48ec-b16a-91a2adc127f54be57d50d7eb0ef7bac518d2e417c5b0.jpg', 'java', '2019-05-08 19:22:49', 26, '马亮', 00000000001);
INSERT INTO 'article'VALUES (45, 'FACEBOOK 的系统架构', 'Web 前端是由 PHP 写的。Facebook 的 HipHop [1] 会把PHP转成 C++ 并用 g++编译，这样就可以为模板和Web逻贺业务层提供高的性能。\r\n业务逻辑以Service的形式存在，其使用Thrift [2]。这些Service根据需求的不同由PHP，C++或Java实现（也可以用到了其它的一些语言……）\r\n用Java写的Services没有用到任何一个企业级的应用服务器，但用到了Facebook自己的定制的应用服务器。看上去好像是重新发明轮子，但是这些Services只被暴露给Thrift使用（绝大所数是这样），Tomcat太重量级了，即使是Jetty也可能太过了点，其附加值对Facebook所需要的没有意义。\r\n持久化由MySQL, Memcached [3], Facebook 的 Cassandra [4], Hadoop 的 HBase [5] 完成。Memcached 使用了MySQL的内存Cache。Facebook 工程师承认他们的Cassandra 使用正在减少，因为他们更喜欢HBase，因为它的更简单的一致性模型，以到其MapReduce能力。', 'b644fea0-862b-44ff-b335-5c7f798e6ce22017_9_1_16_57_31_id7_814f253234a906a1d422f3c4fe832fa1.jpg', '架构', '2019-05-13 22:47:02', 29, '古天乐', 00000000001);
INSERT INTO 'article'VALUES (66, '新配图-修改', '测试hdiohaoshvh mklcmksadmnfkmnasknKNNIKNIKN就没看了奇偶及农我害你和你你可能打击是的纳税方面 看了大家四点上课了能打卡啥都没你看那是多难看到哪门口打死你看吧的奶爸开了的哪款是你的', '3219b13d-9f25-4054-b1d7-73470a8aa870ae1ad9585f84e52765599dc06c9f7891.jpg', '人工智能', '2019-05-08 19:24:06', 28, '陈意涵', 00000000001);

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS 'attention';
CREATE TABLE 'attention' (
  'gid'int(11) NOT NULL AUTO_INCREMENT COMMENT '关注表id',
  'userid'int(11) NOT NULL COMMENT '主动关注者的id',
  'beuserid'int(11) NOT NULL COMMENT '被动关注者的id',
  PRIMARY KEY ('gid') USING BTREE,
  INDEX 'userid'('userid') USING BTREE,
  INDEX 'beuserid'('beuserid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '关注表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of attention
-- ----------------------------
INSERT INTO 'attention'VALUES (110, 26, 28);
INSERT INTO 'attention'VALUES (111, 26, 29);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS 'collect';
CREATE TABLE 'collect' (
  'sid'int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏表id',
  'userid'int(11) NOT NULL COMMENT '收藏者id',
  'fid'int(11) NOT NULL COMMENT '被收藏帖子id',
  PRIMARY KEY ('sid') USING BTREE,
  INDEX 'userid'('userid') USING BTREE,
  INDEX 'fid'('fid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收藏表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO 'collect'VALUES (76, 26, 45);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS 'comment';
CREATE TABLE 'comment' (
  'pid'int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  'pcontent'varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  'userid'int(11) NOT NULL COMMENT '评论者',
  'fid'int(11) NOT NULL COMMENT '被评论帖子id',
  'time'timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '评论时间',
  PRIMARY KEY ('pid') USING BTREE,
  INDEX 'userid'('userid') USING BTREE,
  INDEX 'fid'('fid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO 'comment'VALUES (32, '非常感谢！写的很好呢，收藏了！', 26, 40, '2018-04-17 21:37:31');
INSERT INTO 'comment'VALUES (40, 'Map 映射表（也称为关联数组）的基本思想是它维护的是键-值（对）关联，因此你可以使用键来查找值。', 29, 40, '2018-06-03 23:08:44');
INSERT INTO 'comment'VALUES (54, '我也是程序猿，每天整得脑壳疼，出了这碗饭感觉其他的都莫法???', 26, 57, '2018-10-19 12:18:36');
INSERT INTO 'comment'VALUES (160, '个地方郭德纲的', 28, 40, '2019-04-21 14:30:52');
INSERT INTO 'comment'VALUES (164, '来了类似', 28, 45, '2019-04-24 00:23:23');
INSERT INTO 'comment'VALUES (171, '<a href=\"www.baidu.com\">连接测试</a>', 28, 66, '2019-04-24 00:43:57');
INSERT INTO 'comment'VALUES (172, '啦啦啦', 28, 45, '2019-04-30 00:22:26');
INSERT INTO 'comment'VALUES (174, '熱熱', 28, 57, '2019-04-30 11:31:27');
INSERT INTO 'comment'VALUES (175, '撒旦画嘎哈说过的话管哈', 26, 66, '2019-05-08 19:33:22');

-- ----------------------------
-- Table structure for plate
-- ----------------------------
DROP TABLE IF EXISTS 'plate';
CREATE TABLE 'plate' (
  'bid'int(11) NOT NULL AUTO_INCREMENT COMMENT '板块id',
  'bname'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '板块名字',
  'btime'timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '板块创建时间',
  PRIMARY KEY ('bid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '板块表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of plate
-- ----------------------------
INSERT INTO 'plate'VALUES (1, 'java', '2018-03-30 18:08:51');
INSERT INTO 'plate'VALUES (2, 'C++', '2018-03-30 18:55:29');
INSERT INTO 'plate'VALUES (3, 'Python', '2018-04-17 20:00:42');
INSERT INTO 'plate'VALUES (19, '人工智能', '2018-04-17 20:01:55');
INSERT INTO 'plate'VALUES (20, '移动开发', '2018-04-17 20:03:56');
INSERT INTO 'plate'VALUES (21, '程序人生', '2018-04-17 20:04:25');
INSERT INTO 'plate'VALUES (22, '前端', '2018-04-17 20:05:00');
INSERT INTO 'plate'VALUES (23, '运维', '2018-04-17 20:05:05');
INSERT INTO 'plate'VALUES (24, '架构', '2018-04-17 20:05:10');
INSERT INTO 'plate'VALUES (26, 'github', '2018-06-04 10:09:34');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS 'user';
CREATE TABLE 'user' (
  'userid'int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  'name'varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  'age'int(11) NULL DEFAULT NULL COMMENT '年龄',
  'sex'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  'password'varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  'email'varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户email',
  'family'varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户住址',
  'intro'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人简介',
  'time'timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  PRIMARY KEY ('userid') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO 'user'VALUES (26, '马亮', 23, '男', '123', '924818949@qq.com', '四川省广元市青川县', '克己复礼，始于兴趣，勤于专研。', '2018-10-19 12:12:27');
INSERT INTO 'user'VALUES (28, '陈意涵', 36, '男', '123', '6755656565@qq.com', '中国台湾', '元气女神', '2019-04-24 00:36:16');
INSERT INTO 'user'VALUES (29, '古天乐', 48, '男', '888999', 'maliangnansheng@gmail.com', '中国香港', '无', '2018-06-03 22:58:12');

-- ----------------------------
-- Table structure for via
-- ----------------------------
DROP TABLE IF EXISTS 'via';
CREATE TABLE 'via' (
  'userid'int(11) NOT NULL COMMENT '用户id',
  'photo'varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户头像',
  PRIMARY KEY ('userid') USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '头像表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of via
-- ----------------------------
INSERT INTO 'via'VALUES (26, 'a9666fef-d613-4374-89ac-855a0158836d1517883884441.jpg');
INSERT INTO 'via'VALUES (28, 'e70f656b-596e-444e-8c93-a1fa59f6bff4156e36861bcbe7ccd83b9bada2e99322.jpg');
INSERT INTO 'via'VALUES (29, 'd4981200-aded-4c66-9731-c15607a0de66TIM截图20180901103719.png');

-- ----------------------------
-- Table structure for visit
-- ----------------------------
DROP TABLE IF EXISTS 'visit';
CREATE TABLE 'visit' (
  'VisitID'int(11) NOT NULL AUTO_INCREMENT COMMENT '访问记录编号',
  'VisitURL'varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问页地址',
  'VisitIP'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问者ip',
  'VisitCountry'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问者所在国家',
  'VisitProvince'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问者省份',
  'VisitCity'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问者城市',
  'VisitHostName'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主机名',
  'VisitOS'varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问者操作系统',
  'VisitTime'timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '访问时间',
  PRIMARY KEY ('VisitID') USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1498 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '访问记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of visit
-- ----------------------------
INSERT INTO 'visit'VALUES (139, '', '104.194.83.112', '加拿大', '', '', 'instance-sznooi4f', 'Linux', '2018-11-08 14:02:31');
INSERT INTO 'visit'VALUES (144, '', '104.194.83.112', '加拿大', '', '', 'instance-sznooi4f', 'Linux', '2018-11-11 11:01:32');
INSERT INTO 'visit'VALUES (145, '', '104.194.83.112', '加拿大', '', '', 'instance-sznooi4f', 'Linux', '2018-11-12 09:42:36');
INSERT INTO 'visit'VALUES (146, '', '104.194.83.112', '加拿大', '', '', 'instance-sznooi4f', 'Linux', '2018-11-12 14:24:57');
INSERT INTO 'visit'VALUES (176, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2018-11-18 02:15:06');
INSERT INTO 'visit'VALUES (197, '', '66.249.80.52', '美国', '', '', 'instance-sznooi4f', 'Linux', '2018-11-26 17:41:30');
INSERT INTO 'visit'VALUES (273, '', '143.248.90.63', '韩国', '', '', 'instance-sznooi4f', 'Linux', '2018-12-21 13:45:56');
INSERT INTO 'visit'VALUES (302, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2018-12-25 18:45:51');
INSERT INTO 'visit'VALUES (334, '', '176.193.84.65', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2018-12-29 03:58:08');
INSERT INTO 'visit'VALUES (349, '', '37.145.186.209', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-01-02 05:57:27');
INSERT INTO 'visit'VALUES (444, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-01-17 16:45:18');
INSERT INTO 'visit'VALUES (467, '', '128.69.160.92', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-01-18 21:29:40');
INSERT INTO 'visit'VALUES (526, '', '46.242.75.66', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-02-02 20:06:44');
INSERT INTO 'visit'VALUES (528, '', '128.69.166.41', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-02-03 18:30:35');
INSERT INTO 'visit'VALUES (529, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-04 07:23:28');
INSERT INTO 'visit'VALUES (531, '', '128.69.166.41', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-02-06 19:27:13');
INSERT INTO 'visit'VALUES (534, '', '194.66.246.28', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-08 02:12:53');
INSERT INTO 'visit'VALUES (535, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-08 07:12:09');
INSERT INTO 'visit'VALUES (536, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-08 09:18:53');
INSERT INTO 'visit'VALUES (540, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 00:54:31');
INSERT INTO 'visit'VALUES (542, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 05:28:59');
INSERT INTO 'visit'VALUES (543, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 06:19:14');
INSERT INTO 'visit'VALUES (544, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 07:40:42');
INSERT INTO 'visit'VALUES (545, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 09:46:00');
INSERT INTO 'visit'VALUES (546, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 10:48:51');
INSERT INTO 'visit'VALUES (548, '', '194.66.246.1', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-10 23:12:59');
INSERT INTO 'visit'VALUES (549, '', '194.66.243.28', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-11 02:20:54');
INSERT INTO 'visit'VALUES (550, '', '194.66.243.30', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-11 19:05:15');
INSERT INTO 'visit'VALUES (551, '', '194.66.243.24', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-11 19:36:26');
INSERT INTO 'visit'VALUES (552, '', '194.66.243.31', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-11 22:22:42');
INSERT INTO 'visit'VALUES (554, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-12 07:57:25');
INSERT INTO 'visit'VALUES (562, '', '194.66.243.29', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-12 18:40:09');
INSERT INTO 'visit'VALUES (563, '', '194.66.243.21', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-12 20:17:44');
INSERT INTO 'visit'VALUES (569, '', '37.203.186.178', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-14 08:03:35');
INSERT INTO 'visit'VALUES (578, '', '171.221.42.20', '中国', '四川', '成都', 'instance-sznooi4f', 'Linux', '2019-02-14 21:54:39');
INSERT INTO 'visit'VALUES (579, '', '112.96.198.246', '中国', '广东', '广州', 'instance-sznooi4f', 'Linux', '2019-02-15 00:02:19');
INSERT INTO 'visit'VALUES (580, '', '42.120.161.83', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-15 00:55:32');
INSERT INTO 'visit'VALUES (581, '', '182.138.233.120', '中国', '四川', '成都', 'instance-sznooi4f', 'Linux', '2019-02-15 10:08:07');
INSERT INTO 'visit'VALUES (582, '', '115.156.157.56', '中国', '湖北', '武汉', 'instance-sznooi4f', 'Linux', '2019-02-15 15:11:39');
INSERT INTO 'visit'VALUES (583, '', '171.212.177.32', '中国', '四川', '成都', 'instance-sznooi4f', 'Linux', '2019-02-15 17:33:46');
INSERT INTO 'visit'VALUES (584, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-15 20:59:23');
INSERT INTO 'visit'VALUES (585, '', '182.39.152.229', '中国', '山东', '枣庄', 'instance-sznooi4f', 'Linux', '2019-02-15 22:05:09');
INSERT INTO 'visit'VALUES (586, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-15 22:14:00');
INSERT INTO 'visit'VALUES (587, '', '112.240.25.244', '中国', '山东', '淄博', 'instance-sznooi4f', 'Linux', '2019-02-16 09:48:06');
INSERT INTO 'visit'VALUES (588, '', '220.115.30.182', '中国', '天津', '天津', 'instance-sznooi4f', 'Linux', '2019-02-16 10:24:30');
INSERT INTO 'visit'VALUES (589, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-16 12:49:18');
INSERT INTO 'visit'VALUES (590, '', '120.204.17.73', '中国', '上海', '普陀', 'instance-sznooi4f', 'Linux', '2019-02-16 12:50:18');
INSERT INTO 'visit'VALUES (591, '', '113.111.6.247', '中国', '广东', '广州', 'instance-sznooi4f', 'Linux', '2019-02-16 14:16:45');
INSERT INTO 'visit'VALUES (592, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-16 14:25:26');
INSERT INTO 'visit'VALUES (593, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-16 14:36:26');
INSERT INTO 'visit'VALUES (594, '', '61.151.207.205', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-16 14:37:26');
INSERT INTO 'visit'VALUES (595, '', '183.193.160.238', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-16 15:58:39');
INSERT INTO 'visit'VALUES (596, '', '219.132.117.89', '中国', '广东', '揭阳', 'instance-sznooi4f', 'Linux', '2019-02-17 22:16:31');
INSERT INTO 'visit'VALUES (597, '', '202.102.180.149', '中国', '山东', '淄博', 'instance-sznooi4f', 'Linux', '2019-02-18 10:06:20');
INSERT INTO 'visit'VALUES (598, '', '223.167.135.131', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-18 14:25:34');
INSERT INTO 'visit'VALUES (599, '', '223.166.151.191', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-18 14:26:34');
INSERT INTO 'visit'VALUES (600, '', '223.167.135.131', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-18 17:28:16');
INSERT INTO 'visit'VALUES (601, '', '42.156.136.38', '中国', '北京', '北京', 'instance-sznooi4f', 'Linux', '2019-02-18 18:31:48');
INSERT INTO 'visit'VALUES (602, '', '118.112.108.213', '中国', '四川', '成都', 'instance-sznooi4f', 'Linux', '2019-02-19 11:05:27');
INSERT INTO 'visit'VALUES (603, '', '58.59.122.4', '中国', '山东', '滨州', 'instance-sznooi4f', 'Linux', '2019-02-19 11:36:52');
INSERT INTO 'visit'VALUES (604, '', '182.48.101.194', '中国', '北京', '海淀', 'instance-sznooi4f', 'Linux', '2019-02-19 13:16:27');
INSERT INTO 'visit'VALUES (605, '', '117.107.158.126', '中国', '北京', '海淀', 'instance-sznooi4f', 'Linux', '2019-02-19 14:58:49');
INSERT INTO 'visit'VALUES (606, '', '115.213.73.18', '中国', '浙江', '宁波', 'instance-sznooi4f', 'Linux', '2019-02-19 15:20:28');
INSERT INTO 'visit'VALUES (607, '', '183.193.141.235', '中国', '上海', '上海', 'instance-sznooi4f', 'Linux', '2019-02-19 17:45:39');
INSERT INTO 'visit'VALUES (608, '', '183.14.17.167', '中国', '广东', '深圳', 'instance-sznooi4f', 'Linux', '2019-02-19 17:55:14');
INSERT INTO 'visit'VALUES (609, '', '118.112.108.213', '中国', '四川', '成都', 'instance-sznooi4f', 'Linux', '2019-02-19 18:01:40');
INSERT INTO 'visit'VALUES (610, '', '27.155.238.30', '中国', '福建', '福州', 'instance-sznooi4f', 'Linux', '2019-02-19 21:35:11');
INSERT INTO 'visit'VALUES (611, '', '118.29.236.29', '中国', '天津', '天津', 'instance-sznooi4f', 'Linux', '2019-02-20 09:10:50');
INSERT INTO 'visit'VALUES (612, '', '27.155.238.30', '中国', '福建', '福州', 'instance-sznooi4f', 'Linux', '2019-02-20 09:43:08');
INSERT INTO 'visit'VALUES (623, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-21 16:31:29');
INSERT INTO 'visit'VALUES (627, '', '132.145.36.9', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-21 23:36:05');
INSERT INTO 'visit'VALUES (632, '', '212.112.124.98', '吉尔吉斯', '', '', 'instance-sznooi4f', 'Linux', '2019-02-22 11:36:11');
INSERT INTO 'visit'VALUES (634, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-02-23 10:34:28');
INSERT INTO 'visit'VALUES (655, '', '118.240.242.50', '日本', '', '', 'instance-sznooi4f', 'Linux', '2019-02-24 13:26:32');
INSERT INTO 'visit'VALUES (690, '', '116.66.184.188', '新加坡', '', '', 'instance-sznooi4f', 'Linux', '2019-03-01 11:52:20');
INSERT INTO 'visit'VALUES (691, '', '116.66.184.173', '新加坡', '', '', 'instance-sznooi4f', 'Linux', '2019-03-01 13:37:15');
INSERT INTO 'visit'VALUES (717, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-03-05 16:55:15');
INSERT INTO 'visit'VALUES (726, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-03-06 19:08:55');
INSERT INTO 'visit'VALUES (777, '', '8.208.13.33', '英国', '英格兰', '伦敦', 'instance-sznooi4f', 'Linux', '2019-03-14 14:55:39');
INSERT INTO 'visit'VALUES (781, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-03-15 15:03:15');
INSERT INTO 'visit'VALUES (811, '', '149.129.127.39', '马来西亚', '', '', 'instance-sznooi4f', 'Linux', '2019-03-19 18:42:42');
INSERT INTO 'visit'VALUES (827, '', '5.3.152.128', '俄罗斯', '', '', 'instance-sznooi4f', 'Linux', '2019-03-21 08:57:11');
INSERT INTO 'visit'VALUES (836, '', '66.249.82.94', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-03-23 08:11:06');
INSERT INTO 'visit'VALUES (1022, '', '40.77.167.173', '美国', '弗吉尼亚', '', 'instance-sznooi4f', 'Linux', '2019-04-10 19:46:30');
INSERT INTO 'visit'VALUES (1057, '', '157.55.39.173', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-12 05:58:58');
INSERT INTO 'visit'VALUES (1060, '', '46.188.31.24', '俄罗斯', '莫斯科', '', 'instance-sznooi4f', 'Linux', '2019-04-12 10:45:55');
INSERT INTO 'visit'VALUES (1151, '', '40.77.188.214', '美国', '伊利诺斯', '芝加哥', 'instance-sznooi4f', 'Linux', '2019-04-17 18:50:59');
INSERT INTO 'visit'VALUES (1157, '', '157.55.39.82', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-18 06:36:00');
INSERT INTO 'visit'VALUES (1162, '', '157.55.39.153', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-18 15:17:41');
INSERT INTO 'visit'VALUES (1217, '', '157.55.39.80', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-21 06:43:47');
INSERT INTO 'visit'VALUES (1246, '', '207.46.13.158', '美国', '华盛顿', '', 'instance-sznooi4f', 'Linux', '2019-04-23 20:12:22');
INSERT INTO 'visit'VALUES (1247, '', '199.241.123.13', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-23 21:59:50');
INSERT INTO 'visit'VALUES (1248, '', '104.243.17.233', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-23 22:07:18');
INSERT INTO 'visit'VALUES (1338, '', '40.77.167.205', '美国', '弗吉尼亚', '', 'instance-sznooi4f', 'Linux', '2019-04-27 02:38:32');
INSERT INTO 'visit'VALUES (1373, '', '144.34.146.210', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-29 00:21:31');
INSERT INTO 'visit'VALUES (1374, '', '157.55.39.158', '美国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-29 02:09:19');
INSERT INTO 'visit'VALUES (1387, '', '194.66.243.21', '英国', '', '', 'instance-sznooi4f', 'Linux', '2019-04-29 22:20:52');
INSERT INTO 'visit'VALUES (1402, '', '40.77.167.115', '美国', '弗吉尼亚', '', 'instance-sznooi4f', 'Linux', '2019-05-09 01:44:26');
INSERT INTO 'visit'VALUES (1462, '', '13.66.139.0', '美国', '华盛顿', '昆西', 'instance-sznooi4f', 'Linux', '2019-05-12 05:09:55');
INSERT INTO 'visit'VALUES (1490, '', '144.34.146.210', '美国', '加利福尼亚', '洛杉矶', 'host.localdomain', 'Linux', '2019-05-13 19:54:19');
INSERT INTO 'visit'VALUES (1495, '', '144.34.146.210', '美国', '加利福尼亚', '洛杉矶', 'host.localdomain', 'Linux', '2019-05-13 20:05:08');
INSERT INTO 'visit'VALUES (1497, '', '144.34.146.210', '美国', '加利福尼亚', '洛杉矶', 'host.localdomain', 'Linux', '2019-05-13 20:09:32');

SET FOREIGN_KEY_CHECKS = 1;
