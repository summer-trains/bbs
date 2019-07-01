/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.5.58 : Database - bbs_test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bbs_test` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bbs_test`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `AdId` int(11) NOT NULL AUTO_INCREMENT,
  `AdName` varchar(20) DEFAULT NULL,
  `AdMailBox` varchar(20) DEFAULT NULL,
  `AdPassword` char(10) DEFAULT NULL,
  `AdArea` char(30) DEFAULT NULL,
  `AdSex` char(2) DEFAULT NULL,
  `AdPhoto` char(120) DEFAULT NULL,
  PRIMARY KEY (`AdId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`AdId`,`AdName`,`AdMailBox`,`AdPassword`,`AdArea`,`AdSex`,`AdPhoto`) values (1,'admin',NULL,'admin','安徽安庆',NULL,NULL);

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `ArId` int(11) NOT NULL AUTO_INCREMENT,
  `ThId` int(11) DEFAULT NULL,
  `UsId` int(11) DEFAULT NULL,
  `ArContent` varchar(2048) DEFAULT NULL,
  `ArTag` char(50) DEFAULT NULL,
  `ArTitle` char(50) DEFAULT NULL,
  `ArPhoto` char(120) DEFAULT NULL,
  PRIMARY KEY (`ArId`),
  KEY `FK_Relationship_2` (`ThId`),
  KEY `FK_Wtire` (`UsId`),
  CONSTRAINT `FK_Wtire` FOREIGN KEY (`UsId`) REFERENCES `user` (`UsId`),
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`ThId`) REFERENCES `theme` (`ThemeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `article` */

insert  into `article`(`ArId`,`ThId`,`UsId`,`ArContent`,`ArTag`,`ArTitle`,`ArPhoto`) values (1,2,1,'c++面向对象的特性不是很好，c++面向对象的特性难以理解。。。。。lolololololoololololoolool','c++批斗大会','c++菜鸟自述',NULL),(2,1,2,'C#可视化做的很好，但是界面要做的很美观有点困难（好吧其实只是我自己做做不好)','c#从入门到放弃','C#可视化',NULL),(3,3,3,'你在context中没有配置path属性，所以你的工程文件就是在根目录下，相当于path=\"\";即是你直接在 浏览器中输入你的服务器ip就会到你的jsp页面，而不是tomcat的默认页面；所以你通过request.getContextPath()得到的字 符串是为空的；它是获得虚目录的；','vever','verver',NULL),(4,3,1,'然后右击该项目 - Build Path - Add Library， 选择JRE System Library，选择Workspace defaulr JRE(jdk1.6)(此前JDK已成功安装并配置好)， 然后 Finish.','vefdvre','verewfef',NULL),(5,3,4,'先安装jdk，再安装Eclipse，成功后开始建立py_java项目，在这个项目的存储目录SRC下建立test包，在test包中New-Class，新建MyDemo类，建好完成后就可以在MyDemo中写代码了','veveref','wqef1fe',NULL);

/*Table structure for table `collect` */

DROP TABLE IF EXISTS `collect`;

CREATE TABLE `collect` (
  `UserId` int(11) NOT NULL,
  `ArticleId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`ArticleId`),
  KEY `FK_Collect2` (`ArticleId`),
  CONSTRAINT `FK_Collect2` FOREIGN KEY (`ArticleId`) REFERENCES `article` (`ArId`),
  CONSTRAINT `FK_Collect` FOREIGN KEY (`UserId`) REFERENCES `user` (`UsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `collect` */

insert  into `collect`(`UserId`,`ArticleId`) values (1,2);

/*Table structure for table `foucstheme` */

DROP TABLE IF EXISTS `foucstheme`;

CREATE TABLE `foucstheme` (
  `UsId` int(11) NOT NULL,
  `ThId` int(11) NOT NULL,
  PRIMARY KEY (`UsId`,`ThId`),
  KEY `FK_FoucsTheme2` (`ThId`),
  CONSTRAINT `FK_FoucsTheme2` FOREIGN KEY (`ThId`) REFERENCES `theme` (`ThemeId`),
  CONSTRAINT `FK_FoucsTheme` FOREIGN KEY (`UsId`) REFERENCES `user` (`UsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `foucstheme` */

insert  into `foucstheme`(`UsId`,`ThId`) values (1,2),(1,3);

/*Table structure for table `foucsuser` */

DROP TABLE IF EXISTS `foucsuser`;

CREATE TABLE `foucsuser` (
  `OrgUserId` int(11) NOT NULL,
  `DestUserId` int(11) NOT NULL,
  PRIMARY KEY (`OrgUserId`,`DestUserId`),
  KEY `FK_FoucsDestUser` (`DestUserId`),
  CONSTRAINT `FK_FoucsSrcUser` FOREIGN KEY (`OrgUserId`) REFERENCES `user` (`UsId`),
  CONSTRAINT `FK_FoucsDestUser` FOREIGN KEY (`DestUserId`) REFERENCES `user` (`UsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `foucsuser` */

insert  into `foucsuser`(`OrgUserId`,`DestUserId`) values (3,1),(1,2);

/*Table structure for table `mark` */

DROP TABLE IF EXISTS `mark`;

CREATE TABLE `mark` (
  `UsId` int(11) NOT NULL,
  `ArId` int(11) NOT NULL,
  PRIMARY KEY (`UsId`,`ArId`),
  KEY `FK_Mark2` (`ArId`),
  CONSTRAINT `FK_Mark2` FOREIGN KEY (`ArId`) REFERENCES `article` (`ArId`),
  CONSTRAINT `FK_Mark` FOREIGN KEY (`UsId`) REFERENCES `user` (`UsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mark` */

insert  into `mark`(`UsId`,`ArId`) values (1,1),(2,1);

/*Table structure for table `secretcontet` */

DROP TABLE IF EXISTS `secretcontet`;

CREATE TABLE `secretcontet` (
  `Content` varchar(1024) DEFAULT NULL,
  `SecConId` int(11) NOT NULL AUTO_INCREMENT,
  `SecId` int(11) DEFAULT NULL,
  `SecConTime` time DEFAULT NULL,
  PRIMARY KEY (`SecConId`),
  KEY `FK_SecMessage_Content` (`SecId`),
  CONSTRAINT `FK_SecMessage_Content` FOREIGN KEY (`SecId`) REFERENCES `secretmessage` (`SecId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `secretcontet` */

insert  into `secretcontet`(`Content`,`SecConId`,`SecId`,`SecConTime`) values ('你好',1,1,'08:00:00'),('你好？',2,1,'09:00:00'),('请问您是？',3,1,'09:01:00'),('this is....',4,2,'09:01:00'),('that is????',5,2,'09:01:10');

/*Table structure for table `secretmessage` */

DROP TABLE IF EXISTS `secretmessage`;

CREATE TABLE `secretmessage` (
  `SecId` int(11) NOT NULL AUTO_INCREMENT,
  `SendUserId` int(11) DEFAULT NULL,
  `ReceiveUserId` int(11) DEFAULT NULL,
  PRIMARY KEY (`SecId`),
  KEY `FK_ReceiveId` (`ReceiveUserId`),
  KEY `FK_SendUser` (`SendUserId`),
  CONSTRAINT `FK_SendUser` FOREIGN KEY (`SendUserId`) REFERENCES `user` (`UsId`),
  CONSTRAINT `FK_ReceiveId` FOREIGN KEY (`ReceiveUserId`) REFERENCES `user` (`UsId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `secretmessage` */

insert  into `secretmessage`(`SecId`,`SendUserId`,`ReceiveUserId`) values (1,2,1),(2,3,1);

/*Table structure for table `theme` */

DROP TABLE IF EXISTS `theme`;

CREATE TABLE `theme` (
  `ThemeId` int(11) NOT NULL AUTO_INCREMENT,
  `Content` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ThemeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `theme` */

insert  into `theme`(`ThemeId`,`Content`) values (1,'c#'),(2,'c++'),(3,'java'),(4,'github'),(5,'python');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `UsId` int(11) NOT NULL AUTO_INCREMENT,
  `UsName` varchar(20) DEFAULT NULL,
  `UsMailBox` varchar(20) DEFAULT NULL,
  `UsPassword` char(10) DEFAULT NULL,
  `UsArea` char(30) DEFAULT NULL,
  `UsSex` char(2) DEFAULT NULL,
  `UsPhoto` char(120) DEFAULT NULL,
  `UsScore` int(11) DEFAULT NULL,
  PRIMARY KEY (`UsId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`UsId`,`UsName`,`UsMailBox`,`UsPassword`,`UsArea`,`UsSex`,`UsPhoto`,`UsScore`) values (1,'张三',NULL,'123','安徽安庆','男',NULL,0),(2,'李四',NULL,'123','湖北武汉','男',NULL,0),(3,'王五',NULL,'123','河南郑州','男',NULL,0),(4,'路人甲',NULL,'123','湖北武汉','女',NULL,NULL),(5,'土匪丁',NULL,'123','浙江宁波','男',NULL,NULL);

/*Table structure for table `usercomment` */

DROP TABLE IF EXISTS `usercomment`;

CREATE TABLE `usercomment` (
  `UsId` int(11) NOT NULL,
  `ArId` int(11) NOT NULL,
  `CoId` int(11) NOT NULL AUTO_INCREMENT,
  `CoContent` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`CoId`),
  KEY `FK_UserComment` (`UsId`),
  KEY `FK_UserComment2` (`ArId`),
  CONSTRAINT `FK_UserComment` FOREIGN KEY (`UsId`) REFERENCES `user` (`UsId`),
  CONSTRAINT `FK_UserComment2` FOREIGN KEY (`ArId`) REFERENCES `article` (`ArId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `usercomment` */

insert  into `usercomment`(`UsId`,`ArId`,`CoId`,`CoContent`) values (1,1,1,'评论测试数据'),(1,1,2,'评论测试数据'),(2,1,3,'评论测试数据'),(3,1,4,'评论测试数据'),(4,1,5,'评论测试数据'),(2,2,6,'评论测试数据'),(3,2,7,'评论测试数据'),(4,2,8,'评论测试数据');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
