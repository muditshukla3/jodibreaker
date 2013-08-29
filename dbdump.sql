/*
SQLyog Community Edition- MySQL GUI v7.0  
MySQL - 5.0.17-nt : Database - jodibreaker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`jodibreaker` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jodibreaker`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_message` */

DROP TABLE IF EXISTS `auth_message`;

CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `auth_message_403f60f` (`user_id`),
  CONSTRAINT `user_id_refs_id_650f49a6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_message` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add facebook user',8,'add_facebookuser'),(23,'Can change facebook user',8,'change_facebookuser'),(24,'Can delete facebook user',8,'delete_facebookuser'),(25,'Can add facebook like',9,'add_facebooklike'),(26,'Can change facebook like',9,'change_facebooklike'),(27,'Can delete facebook like',9,'delete_facebooklike'),(28,'Can add facebook profile',10,'add_facebookprofile'),(29,'Can change facebook profile',10,'change_facebookprofile'),(30,'Can delete facebook profile',10,'delete_facebookprofile'),(31,'Can add open graph share',11,'add_opengraphshare'),(32,'Can change open graph share',11,'change_opengraphshare'),(33,'Can delete open graph share',11,'delete_opengraphshare'),(34,'Can add facebook invite',12,'add_facebookinvite'),(35,'Can change facebook invite',12,'change_facebookinvite'),(36,'Can delete facebook invite',12,'delete_facebookinvite'),(37,'Can add facebook user profile',13,'add_facebookuserprofile'),(38,'Can change facebook user profile',13,'change_facebookuserprofile'),(39,'Can delete facebook user profile',13,'delete_facebookuserprofile'),(40,'Can add jodi',14,'add_jodi'),(41,'Can change jodi',14,'change_jodi'),(42,'Can delete jodi',14,'delete_jodi'),(43,'Can add user jodi',15,'add_userjodi'),(44,'Can change user jodi',15,'change_userjodi'),(45,'Can delete user jodi',15,'delete_userjodi'),(46,'Can add log entry',16,'add_logentry'),(47,'Can change log entry',16,'change_logentry'),(48,'Can delete log entry',16,'delete_logentry');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`username`,`first_name`,`last_name`,`email`,`password`,`is_staff`,`is_active`,`is_superuser`,`last_login`,`date_joined`) values (1,'admin','','','admin@gmail.com','sha1$959e9$220fb2ad778c0a17d6a13f55c5d0d1c9e3df11f7',1,1,1,'2013-08-29 09:08:10','2013-08-18 05:46:00');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`),
  CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) default NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`user_id`,`content_type_id`,`object_id`,`object_repr`,`action_flag`,`change_message`) values (1,'2013-08-18 06:48:39',1,14,'1','Santa & Banta',1,''),(2,'2013-08-18 06:48:53',1,14,'2','Chai & Samosa',1,''),(3,'2013-08-18 06:49:19',1,14,'3','iPod and iTunes',1,''),(4,'2013-08-18 06:49:33',1,14,'4','Bread & Jam',1,''),(5,'2013-08-18 06:49:41',1,14,'5','Rabari & Jalebi',1,''),(6,'2013-08-29 09:08:39',1,14,'6','Mac & Notebook',1,''),(7,'2013-08-29 09:09:02',1,14,'7','Temple Run & Subway Surf',1,''),(8,'2013-08-29 09:27:50',1,7,'1','http://mudit.com:8000/',2,'Changed domain and name.');

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`name`,`app_label`,`model`) values (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'facebook user','django_facebook','facebookuser'),(9,'facebook like','django_facebook','facebooklike'),(10,'facebook profile','django_facebook','facebookprofile'),(11,'open graph share','django_facebook','opengraphshare'),(12,'facebook invite','django_facebook','facebookinvite'),(13,'facebook user profile','jodibreakerapp','facebookuserprofile'),(14,'jodi','jodibreakerapp','jodi'),(15,'user jodi','jodibreakerapp','userjodi'),(16,'log entry','admin','logentry');

/*Table structure for table `django_facebook_facebook_invite` */

DROP TABLE IF EXISTS `django_facebook_facebook_invite`;

CREATE TABLE `django_facebook_facebook_invite` (
  `id` int(11) NOT NULL auto_increment,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_invited` varchar(255) NOT NULL,
  `message` longtext,
  `type` varchar(255) default NULL,
  `wallpost_id` varchar(255) default NULL,
  `error` tinyint(1) NOT NULL,
  `error_message` longtext,
  `last_attempt` datetime default NULL,
  `reminder_wallpost_id` varchar(255) default NULL,
  `reminder_error` tinyint(1) NOT NULL,
  `reminder_error_message` longtext,
  `reminder_last_attempt` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`user_invited`),
  KEY `django_facebook_facebook_invite_403f60f` (`user_id`),
  CONSTRAINT `user_id_refs_id_2487fc6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_facebook_facebook_invite` */

/*Table structure for table `django_facebook_facebooklike` */

DROP TABLE IF EXISTS `django_facebook_facebooklike`;

CREATE TABLE `django_facebook_facebooklike` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `facebook_id` bigint(20) NOT NULL,
  `name` longtext,
  `category` longtext,
  `created_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_facebook_facebooklike` */

/*Table structure for table `django_facebook_facebookprofile` */

DROP TABLE IF EXISTS `django_facebook_facebookprofile`;

CREATE TABLE `django_facebook_facebookprofile` (
  `id` int(11) NOT NULL auto_increment,
  `about_me` longtext,
  `facebook_id` bigint(20) default NULL,
  `access_token` longtext,
  `facebook_name` varchar(255) default NULL,
  `facebook_profile_url` longtext,
  `website_url` longtext,
  `blog_url` longtext,
  `date_of_birth` date default NULL,
  `gender` varchar(1) default NULL,
  `raw_data` longtext,
  `facebook_open_graph` tinyint(1) default NULL,
  `new_token_required` tinyint(1) NOT NULL,
  `image` varchar(255) default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `facebook_id` (`facebook_id`),
  CONSTRAINT `user_id_refs_id_169a9575` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_facebook_facebookprofile` */

/*Table structure for table `django_facebook_facebookuser` */

DROP TABLE IF EXISTS `django_facebook_facebookuser`;

CREATE TABLE `django_facebook_facebookuser` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `facebook_id` bigint(20) NOT NULL,
  `name` longtext,
  `gender` varchar(1) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_facebook_facebookuser` */

/*Table structure for table `django_facebook_open_graph_share` */

DROP TABLE IF EXISTS `django_facebook_open_graph_share`;

CREATE TABLE `django_facebook_open_graph_share` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `action_domain` varchar(255) NOT NULL,
  `facebook_user_id` bigint(20) NOT NULL,
  `share_dict` longtext,
  `content_type_id` int(11) default NULL,
  `object_id` int(10) unsigned default NULL,
  `error_message` longtext,
  `last_attempt` datetime default NULL,
  `retry_count` int(11) default NULL,
  `share_id` varchar(255) default NULL,
  `completed_at` datetime default NULL,
  `removed_at` datetime default NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_facebook_open_graph_share_403f60f` (`user_id`),
  KEY `django_facebook_open_graph_share_1bb8f392` (`content_type_id`),
  KEY `django_facebook_open_graph_share_3b1c9c31` (`created_at`),
  CONSTRAINT `content_type_id_refs_id_5c3b7c3e` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_40192e2e` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_facebook_open_graph_share` */

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('00e681bf6556a066e9cdbf79669ea924','ZTA3ODk2NWM1NGRiNWM0YTIwOTY1NjdhNmViMjA5ZWVjYjAyMGViNTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuAAAAENBQUlCMkoxOWZUQUJBS3I1NDZaQkJaQTd6cmhFQWVqT3cxc3JYSDQyZ2Z4V3FaQTg5SU81\naEZ3T0tnd3Z3STRxRUR3VkNndGZMTEhCOFFubUJUVDA1OFlhcWNsN2ZyU25kUE5ZU1dVb3BrWkN3\na3FTODA4SUdrWTRCWXpaQUgwSmw0UG9iZ0wyWkNGc3E2bEJSSjlaQnQ4enJId0lTVVZ6QlJETTFL\ncGduTFI4Y1RqNnM0VHNiZDZVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgz\nMjIzVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:46:26'),('1ec5f4a652d0839fa9177972c4eac2ad','NGRkZDIwMjNjNmJkODhlNTY0ZDNmMGM5YWE0YmE5OTRmMjA2OGY3MjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nyQAAAENBQUlCMkoxOWZUQUJBRFJySVlCTTNkS3FZUk1WUDZ6NjMwRFI4QkV4RVpDUnlmVlpBVWZ5\nWkFvWkF2TjN0VDB4OUhmeDhVTVZDeHJ2Q1JQaTdzcDlVNTljQjBYYmxwbG5qWkFaQllBc1FiUHBp\nSmJzUVJBUEd1V0xXQld5UVR3MmhnWkMyU2FpYVgyamhKWkE1S0VXWkN6NjNoTlN1Mk1yR0Q3NFpD\nR3B5S3laQ1Bxc1BVc1ZHSEoxQlZjamJPVmJ4MVNTV29aRFUPY3VycmVudF91c2VyX2lkcQdOVQdl\neHBpcmVzcQhYBwAAADUxODM5NTFVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:34:18'),('246081d602c3cfa21411b378aa127e88','MDkzNDZjN2NhN2ZlODk5ZWJiMDlkMTM3ZjZjYmEwZDg1NmY3YmUyNDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuQAAAENBQUlCMkoxOWZUQUJBRzh4UFpBWDAyYTZTS2RLNm9USVVsVHgwc05xRVBzUElaQmp6dWtD\nNVl0Yk05U2JvWkM5MVZqMjVqQUQyWHlxOTRtcGdGTlhWeUNaQllqZ3FtNlJUekV5ZHNBdFdOUzZy\nQlpCaVFCWkJUMEl2YWlIQUpja2VhV3RjaDRoajlpNmQ1RDFIVzlVVVJNQjJGczFzeFh2a1pCejNO\nWEJnWHhaQnZza0hCVHdwNE1zVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4\nMzM4M1UPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:43:42'),('2e70220230268102516b22aab6ecf03c','NThmNmNkZWFlMTc5NGM5ZWE2NjYzYjQ2OGQxMmE4Yjg5MDI0M2Y2MTqAAn1xAVUFZ3JhcGhjb3Bl\nbl9mYWNlYm9vay5hcGkKT3BlbkZhY2Vib29rCnECKYFxA31xBChVDGFjY2Vzc190b2tlbnEFWMAA\nAABDQUFJQjJKMTlmVEFCQU1LZEFFRlFpdjY0eEJWanhZeGNWT1VrRExJcnIyWDcyenVpbG1CeWV0\nZkZyN20wVGhEb1hnNmN5YUJEaVljb1VIc3ZpUlhRYUswSjhIOWQ3SmNQbTJmM2VON3ZsNlRMTDly\nOHBCZHZpbklsOEhmVEZCSHBrN0dpSEVtY2RVcGsyS3BhWXpFVW53NDh5aVVoU1dBeG8xUTljemVV\nNEswWkNaQU8zMlA2Qnp2eHVWQ0cwWkRVD2N1cnJlbnRfdXNlcl9pZHEGTlUHZXhwaXJlc3EHWAcA\nAAA1MTgzOTgwVQ9wcmVmZXRjaGVkX2RhdGFxCE51YnMu\n','2013-09-12 09:34:35'),('3c58261038ac5d686fceba5c4499175b','ZTg1N2U2MTkxMzM4NGQzZjRkODdkMWQ1ZDY3NTgzZDhmNmNkMTZkODqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nwgAAAENBQUlCMkoxOWZUQUJBSjNaQ096cEx6a0hsa2dmU2N1N0ZnenFlNWYzWDR4Uzg0d2JNQ0Fx\nRVZUY1dhazhUZ0pBVXU1TkY3c1U2eWk4OG1nN09TMjg5dm1lYlFpMjdSMWhwdGd0d3huUjY1STZq\nRFlqRGQyYjQ5cXNxbWFaQUViQTFvVktPVTU5YVRxV3RkbmN3UUZ3V1pBQU51Mjg0SHk1TFZiV3NC\nU2VjSHJQWkJ4M2VSbllneDdFdWEyeVdpd1pEVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNx\nCFgHAAAANTE4Mzk4M1UPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:33:48'),('4237a4a175c5ff66fef22f62fc918be8','Y2I2NmU4OTE2NjBiNmZiNzE2YzYwZmM2ZWEwY2E2YTBkODY1MWNhYjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntgAAAENBQUlCMkoxOWZUQUJBR0h2WkNpQWhiN0pHODF3Nm5xazBOMzZPc0pZTmwycU44TUdVMWRn\neHYxSUk1MnlLSmtaQ0VvM1ZVZ2E3d3pWWkF5TUlWQnRpSTZuUjNmbk5uQ3hweG9QZGdLN2FJdzJL\naFl5ajJqZ25zZ2RIZEFoczJYWkNZOTNHY2J5SFhUdThOQjNnWkF5NlhXamNXRzlJZUwzZFRBOTdt\nY2pVS2h2UXJnRVBsRGlnVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4MzM3\nMFUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:43:56'),('430dfb0ffdc2e5d20a8c6b4db2551f08','NTVlYmI5NWJhYzY3ZDE5NWRhZDQzM2JlYzNiNDI0NGMyMWNkNjZjZDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuQAAAENBQUlCMkoxOWZUQUJBSUZPMTN1TWhMWkJBQ1hNRXRPTnV4UFQyWFl3dDJRUzlNbUpWM1R0\nWkNjWEUxWkNKc01NVW1HcUVUNFpBWHVXT1JpcHV2MFhhOE9VWkExamdsWFVIMG5kRkhMWkJVSkV3\nSzR0N0F5SDk3ZUc3ck5OaWpaQ1U2M3lCSUdmVE9KQzR1UGh3czhhUUk2MVhzRlZ6MW1HYVlxaURR\ndWUwblJPTnRPeVdMWkNsZW9rVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4\nMzM1MFUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:44:14'),('4536adc837432699681418b9f15b02c5','Zjg5OWNkMWE2MjJhMzgwODk5NWQ1YTc3NmRjMzg4M2QzNWU4YWQ0NjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nowAAAENBQUlCMkoxOWZUQUJBSjc3SFFCRHlXSVpCbnpUOWw1R2c4d2xxSE5XRkJaQ2c5RzFwSFdR\nRFFKQlhWTUNSeW5PSDhWalJ0RGpZSVN6b1BaQ0dpVENXWkFmbEZRaU5IWGJ1STR6YnZvYTF6MGVX\nd1RCalJCZ3kxWTB4czEyTkY4WWpjSUZjMDlsMlVlS3FrWkFObVd6RXA5S1dJYmM0TFc0WkRVD2N1\ncnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgzOTk5VQ9wcmVmZXRjaGVkX2RhdGFx\nCU51YnMu\n','2013-09-01 06:04:25'),('4e1980fe7962840337202bab978a06e6','NTA0OTM1ZmNjZWNkOWU0MzAwYmQ1N2ZkMjBhNGRlMzFjNWI0MDcxNTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nxgAAAENBQUlCMkoxOWZUQUJBT3F2ejhhUEdNZEY2U01jaEZTVkhkZTl3YWlDb1NSTkxEaE9yUDZt\nRHk2QVZQRGI5RU9UTjNiMUIyY2c2ZFdaQmg4OE1kSndra0xIM1pDU3A2M01pb1l2eTA5YlpBQlM3\nRGFPMElNVXFyYzV1NlpCalJtZHFPdXkyYUMxQ0M3WkJuOWliYmdKS0J1cnVLWkJaQ3FscnNxUlpB\nNjk2YnE4bUxJWTlHMEFEbnFkelBXTkE0bVc5eWtaRFUPY3VycmVudF91c2VyX2lkcQdOVQdleHBp\ncmVzcQhYBwAAADUxODM5ODhVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:33:37'),('685ba83f48c1143af9059f805bde1132','MjRmYzkyMjNjYWU2NjA1MzMyYTU2YTQ4NGY3Yjg2N2M0ZDU2YTE3NzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntgAAAENBQUlCMkoxOWZUQUJBUEJCak9pUXl6cVkxR3M5bEdYODRJZUtPVXp4Vk03NkY5WkNIbVdM\nUEZtYThKTFlpWkF0MHZ5N3hIdUhXUGlaQXZYaGtaQ2FHeldzWEg1Z29hVkxMSDBRd0Y2RVY4dUQ4\nelFnZlhGWW94b29FTm93U0J3YnpIckxPNEJNOWxUU2lhQjFGT0tmUDJFdjhDRU9sM1VyRzVGNTlK\nNGxZZkt2WkJxRVRxVnh3VQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4MzMy\nMlUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:44:45'),('6a54a2b5b9b5b8dd9ef674c1c852ab8b','YjA3MWM3MTA0ZTI4ODEyODU2Yjc4YmQ5NDIzN2RjYzU0NWZjNTYwNzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntwAAAENBQUlCMkoxOWZUQUJBT3FPbEhBTmVZNVc2QVBaQUFuUFdBbEtWZkdNbEtKdjZocndtRG9W\ndkN2OFk4bmttc1JTblQzNVh2bDZrRVJOOGlsdlhIakZRUzRaQ0p3UmtJY1FlOVpDd2ZZOG13eWJM\ndFl4OGRQY2R2RGhXYzZ0VndXTGxkcXE2bHRaQ1pCQkY1N1czbmxLUVBhclBMRkxjTmhIRmJpNDI0\nYUxmM01TVFpDZElMRE91UVUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUxODMx\nNDdVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:47:46'),('7bc165e2a6fb138ed3df71a888b03acc','OWE4ODgxOTA2NjEwMGQ3ZjYzNjgxY2I5NmU0MDQ5NzQ0NzMyMWE2NTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuAAAAENBQUlCMkoxOWZUQUJBRktXQlNGZnFPVldaQlZWU21hSmFMVndmdTJoUHZHNzdWZVZpMGhi\nUGdJcm9YNExjWFRIMmZUR01uOEduUkdFS2ZocUNZQ0l6SzdFbVRCakpLd0NpMHQ2ZW4wd3BqY3Na\nQ080TUdGMnBaQk15VzdQR215WVpCWkJIMXBVSVZKZEQxU2tNS2drNXc0TU1OUFpCdjVQTzJkVUha\nQ0hNejlOUVFzRTRKMG5zVGdVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgz\nMzc5VQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:43:51'),('84587397d0752262b151ebd6ae1e7169','MzA0MjA0OTVhZTY5OGZkYzM1OTI4OWJmZTQ1ZmRmOGMxNzk1NTc5YTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nxAAAAENBQUlCMkoxOWZUQUJBS05GRWVEWkJUTkVIcG83bU1WR1UyWVVrdUQ0YjRtWkFUcjZwcnZo\neDVWTjdxcWVYZ2NnVFIxMXhmeU1wVnJrTWE0eGkzVmozM3RTZ0pvT3pudWYyWVpCRTJQRlpCMzRZ\nWkNJeHIxYWJCaXNzUTVndXFmdW5Yc3Z4MXpQbUR4UnhXSUFwZkxjeGpBQW1ySVpBaERUak9ydklu\nTER5a3R5ZnVkZkwwY3RBc25jc1A5enVrRGxvWkRVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJl\nc3EIWAcAAAA1MTgzOTQyVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:34:24'),('8595b529cdce89c47812d1b8e0f81566','YmRkNzdlMzFjZGFjNDRlMDY5Y2UwNjIyZGZmNDI5ZWNlZDM2OTZiZjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntQAAAENBQUlCMkoxOWZUQUJBQUJYZk5oeEhCa2NaQkljRDBCRkFKczBqZlJzQk51bFNKdzhZT2Y5\nc3dESDlxUkk1cno2cTQwbWM0Tjd2Mk5FNTNsOUZOR29XaW1aQ3F4ZW13dTJaQXZMU3VMYURMSWxO\nQlRmdURuTHcwNDhxNm82TVpCY0RENURJS1hvR3U1dUhIblhvMEtlZ1Q4ZnJBS0syYUFyR3FtSnlq\nbUJEcXRxVnFjSlVhQlhVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTcwNjUz\nVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 20:45:58'),('8efe5f26cae332b7fbe3308cbfd0eb09','OTg2ZmI2YTVlYWE4NTFmZjVjOTg0Mzg5MjdjMGFlM2EwODNhYzlmMjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\npgAAAENBQUlCMkoxOWZUQUJBSVliamxVTzJpQVQzMkplV3dIWkFaQ0lQTURINnlVM1pDWFpCTUVp\nMzFncU50RFg5Y1FaQ0dJUlFqNVpCVTZhYXdzSlpDcFNEc0xXVlg3b2h2bjV3dnlQTGhjeDRSSzc3\nSmVJZk90OUpRUGlDU25oREdZQWxDdTc0bHFVUDFQa01aQ2NuUkcxeFk5VU8wbjVrenJWZ2t3WkRV\nD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgzOTMyVQ9wcmVmZXRjaGVkX2Rh\ndGFxCU51YnMu\n','2013-09-01 13:01:44'),('9114a5472a80b9f4a9e890fcc6e71977','OWFkNmJjNjE5NmFiYzc4ZDRmODU5YWU0NDQxNDEwNTkzOGVmZWNmMzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nvQAAAENBQUlCMkoxOWZUQUJBTjdORVVVeEFaQXpiWkFLN1pCTUo2UW1ZVkg2bGcyMnBCT0c0cFBT\nN01KdjRCSGJ6dk8xRWN0bnM4TjBvajc1QVZ1T252WkJmRXhQaTI2b1pCWkMzczc2RVpCRzdXRkxz\nVDlaQnNVUmpFcVM0STd2WkNISTRaQUNMYU5RUXNSdDhKUzF1V3prM1dBdFV5OFh6WWdmZVVqWkFz\nQVNwRFA4Q0FVOWloTFQzWVIyUlhaQVUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAA\nADUxODM0MjVVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:43:06'),('9208c4e75cbb42c48f4bfac98a60ffb0','NGQ5NDUzYTk0MzBlYTNhNDI3NjQ1YjNiN2ZjYTNlMzI4ZDgyZTkzZTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntgAAAENBQUlCMkoxOWZUQUJBSlB0d2toQklybVpDNmhWbmRPN0t4amZuZkp4aklic2pUTlc4dUZ0\nN0FFWGhTMlpBNlB5eXk3Qk1EM0oyS2VjeGViRnBSTXpWTlUyV1JRNnkzVXl3N0xKREtXOE5zSE5U\neGNlN3hwZWdtRHlSSVRZWkJJQVlpMDlJWWpVT1pDMnVaQzZFQmx5YU9jNTJqVENKTnROVnNxbEx4\neWhObW9Vcm5sVjBTTlVwVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4MzI1\nOVUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:45:53'),('95ae20e70024c7ed7043b2f677ecc616','ZGExMGMyZDM3MDNkNDEwZTgyNDYyM2YzMDc4NmIzYTBhMDY1YTliMjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nygAAAENBQUlCMkoxOWZUQUJBTFpCQWxkWkF4bTRDaGEyd1pCZDJuMjNOWkNEM0hudzlNM2N0M1pB\nZGJ2aG9qWkE3dDl4bDlGMmw5WkFuSkw3NEYwaThoMVpDTlg3T2Q3M3ZqQ1VTOGJvY3FLeXpxSGtH\nTENVQ1pDeVpBNTVySVVPSHNlR0YyMTZyY0lqYzdGd01JdFVKOXFNRkVRc24wZFVyWFZ1VFk0Y2Jo\nVlpBODNSZkhCZUZheEt0VlI1dzRPWkF0NE05RVRZbkpBWkRVD2N1cnJlbnRfdXNlcl9pZHEHTlUH\nZXhwaXJlc3EIWAcAAAA1MTgzOTkzVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:33:31'),('96dc7c04bd6a6fc2099879717487f377','MDg1ZGZhZGFmMmU2NWVlZDFkZTNmYTdlZDM0ZDA3NzAxZjhlMGNlOTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nyQAAAENBQUlCMkoxOWZUQUJBSzFRQ1dGSW5BNXRpVDdVZVVaQ0FaQkhOTlBNVnhHbjhQbVpCRmtU\nWkM4MUx4Z3VzQnpLeE4wcVZYdkVFY0Y5alpDRUY1Tm1PVTl4a1V1eml5ODZHSW5SWkMyaXVwYVpC\nc3V3Vk5Eb0l4NVhPQVJmM2RVVmFJdVpCc1cwQTFwbndQaG52NXJheDc4dlg1VGE0UWlaQmhUVFM0\nYTgwalpBWWdnNHRZUTNGUDV3RENjbklHQWpzelpDNzhaRFUPY3VycmVudF91c2VyX2lkcQdOVQdl\neHBpcmVzcQhYBwAAADUxODM5OTlVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:33:25'),('9aad30932a9d3d51a4f6802e519f1303','ZmI4YmJkYTM4ZGFlNzc0MTQxOGZmM2IzNTlkYzMzMGI4NjRjMzRhNDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntgAAAENBQUlCMkoxOWZUQUJBRFhFU2V2T3pwWVZTYTVNTGwydHVCbTFlc3ZRT2F4dUpaQWN4TWgz\nUjVjbkdEQ3dMS0NtaVJGeEpWbnBNM2dwYTBxYlJYT1UxMTVUbk85WkFidUdWNFdBNTJKVmVET00z\nUnhLNmJvTXV4NUZ3MWxpcm1TdWFIQ0RjOVpBd2JrVzJMak05cThuWXFKWExHdkpaQ244ZTRmMm9W\nUnltVmJBbXVaQmJqcDlLVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4MzQz\nNlUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:42:54'),('b73c0caf922ce6cc3e2d33501c6e1fc4','NjY5NDIyNzNjMTk3ZDJkNmMyOTU0ZWM4M2Y4MjU3MDY2ZTI1MTFiZDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntAAAAENBQUlCMkoxOWZUQUJBR04yMURvMkh6UVpDMGdDREpZWkJxV1dZUm5vRHJyN1VpVFU5ajVY\nV1Z2WGtiY0JwOWdUb1I1UjJNbVRGc1RzT0JTTzVtOHRpV0k4OEJ4Q25iamVybkxrYVluV29QTE5D\nc2lpcXdnbjkyYTdJZEtNWWlBdlBDN2Exa1hvbVNtVGVOMUt1enBmZU4yMGZHR1lvUmpJb21qWkIy\nb3pjUmxseklsTTNBdlUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUxODMzMjZV\nD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:44:39'),('b9b2452e83d305f85ba94d71f90ae7e0','YzEzNDhkMGZkM2U2NDlkMjM2YjBjNzc5OTY4ZmFjNjE0MjIyYWVjOTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuAAAAENBQUlCMkoxOWZUQUJBRTVvUW1QbkY0bVF4emtmT0xwYmFDNnBLWkE2TXVTWVRRSjJxYTdu\nTnAyVXE3aG5rcmRzYzlTa0xEWkFiM3RxVHpDUHhqTVhHWVlRNFE1aUZERVRVWkF5VkNZZGRmeTA4\nSkJ5SlpBRkhZbklpR1RhQzRhM2tDbEhUbnpjNjhnZGpFZ1hhZ3VzN1Z3ZFJNSzRXOUpNbE9aQzdL\nbk54NFpCNFpBZzdSZ3Y0T2FVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgz\nMzY0VQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:44:06'),('ba0fce69361d7b188260705df7c47823','MTNkNjBjODEyN2JmNzlmM2MwYTczZDQ2NjI1YmQ2MmM5YmU3MWQ1YzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nugAAAENBQUlCMkoxOWZUQUJBQUxHUWp0bWpJSThINUdxMmVaQmdCcElLaTJwRk1zcjN3VkRqQjVa\nQlVSNnd5VEtUVHg4RWpVak42c1Q3Z1pDUnY1Z0l2c1RnSVVwTDhiak9KemNvbGF6WkJsc2xCQTJa\nQ2RobXJudzJoN3ZQWkNucFpCcjBIWkFGVzFZeDZUTHRsejZuNm1mMGpkSjVJVUljUm9rRDZBNnhN\ndWU3RlpDRWtIMzRZRmM3emhKOVUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUx\nODMzMDhVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:44:58'),('c09c892877a8a0fda7a50a8f235d4bf4','MzA0YmZlNWQ5NTlkMzIyZDkyYWFiNjI1ZDVjY2Q1MGQwNGQ5YWQxYjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntQAAAENBQUlCMkoxOWZUQUJBTlBqRXh5aGh0a1VJY2Vhb1FzQ1Rjc2VWR0FVOXlaQ045aHVEcTFa\nQXNkU3FYTU5sRnM3ejI2OW5mR3hISmt1Y0lBSnkzN3ZWYnBqUlRIMmhhT3BhN3ZwY2VMaUNzeldt\nTG11SWFoTHdoMWUzTkdXU1JKck9kWE9mSDZza0V6SXJyNkNQOUtxTnJsWkJMRGZuQ083SGE1OVF0\neXM4TW5oTU1CNlpBR2VVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgzMjQy\nVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:46:04'),('c33382fb4dd9f532c1965b6bfc077c63','YWZlMTQ5MjhiMzRlNGZhMzhhYjQ0YzlhZDI1YTNiZjUyZDBjODg3NDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuAAAAENBQUlCMkoxOWZUQUJBSWgzN3RlZGZ3N1pBZXhqRGdIeDFNN2U0WWFFc2ZCZUttTEQ5YUc0\nVzd0VHNMWkFvT2dhdXNaQUpWRnk0MURzQnFQWDQ0T0Y0d28zVzV6WkNaQ09EWUx0aE53ckQyMmk1\ncDEzTVg3ZW9EYmR6T2FEa1dFV2YwalVLVWFqTmhWeUNQTFY1RlY5MDhLTTlsUkduc1pDRGFNM3Za\nQnRPSlExRzAwaFI3SDFwVWRVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgz\nMzE2VQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:44:52'),('cab1b59908c789f06a788912a856f67d','MWQ1ZmIwOTI4N2MzNzg2OWJkOTA1Y2FjMmIzM2UyYzY3ZTE1OTczNjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nugAAAENBQUlCMkoxOWZUQUJBTmlMVmpHWDg2UVNaQzZiMkpkUXBQTFJaQm04N2VYZldMYmlEb3pr\nazhHZUI3ZjFSWkJQemt3aEdjQmZaQ3ExWkIwVG52S1VNaUJ2ZHR6QVdndmZ3enpDRTRaQjk1MTBZ\nZzhYbndzWFpCZjdDZnYzNmhPOFVvWkJVQWFyaTBwNzBodVI0c3FPMVM3V2Q2cDZpS1RiVFllekVt\nR245YzNROEFYVTB3dVpDVVRtU1UPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUx\nODMzOTVVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:43:37'),('ccbec1def1e3ffd82b31a830dcf51431','MWQyMmYyZDhiN2E5NmFmNWRhYzE0MzlkOGFiMjcwZDlhYWU4YWNlNjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nwwAAAENBQUlCMkoxOWZUQUJBRlVYNnN6bVhmSlpBUnNXUTlvWFFtSllnN1hSTFgxYmdVeEhhYWxr\nbWJITm1PMVdkblgxanU2Z0dzVWNCdVJtOWgzSTMzREs5S05rNlFYY2RQMkswZTc3ZndRT0FaQnFa\nQ1FHclZYNDFpZjRpSDdkOFhqb2x3Z2hqWThoNU9KT2xYSTJNOEY0YW1aQUxaQ3QyY2VSY3dGamlI\nMXJJYk9RWHpwTGRDOUY4VDVyMUM4OUdPNlFaRFUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVz\ncQhYBwAAADUxODM5NjdVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:33:57'),('d9b81e1b31817889e4ee32d666a297ad','OTg3MDk1MDcwNWZmNjFiMDVlODIxNmY5ZWU0MGMzNzI5NjgwMjdmYzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntwAAAENBQUlCMkoxOWZUQUJBRExEMGZtMDFWUHlTMXJVZkpIQ2l0MFpCTElzV2dMb3Z4eG5ya3E3\nR3BEenowQXZtRlpCcTJLRnBsb2FIczVaQXZsSDZZYWM2T2ZzOGlqTzFkTUhaQThiZkR0QVRJeThV\nMUpjRVJjNVNOMkZTNzRESkxzZzhEVXVybHBVaUFyaWlaQ0JRV2R3OFZwUlR2WkE0bVNRMUdBSTRV\nc3dQTmx5elZkRkd4SVFBR1UPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUxODMz\nNTVVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:44:11'),('db178a32e1dee0f9c1aaa4fca2ab4d8c','NGIyNjJhNmZlODEyYTcyNjYyNWJhYzk5N2QyMmJlODQzOTVlMTI2MzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntAAAAENBQUlCMkoxOWZUQUJBRnRjN3NNYWg4a1N2aG8wc1c2U1VISzFPY0lQdDFXQ2hDWkFxS3ZP\nZDdzaXp4WFdoWkNtWU91V0M1dW50dHp2R0JxektHQ3FNYk41cjBqRzdpbHdBaXZwTUdkSmE0V0hr\ncjk0bUs3dWxsbUJkVldtZDdRUVBoSXlRUTg5cUY3WXBLekl1NDVkRUx5MUxzODlmRnlIMU54eUVz\namhaQ2dQcllOWFYwNFUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUxODMzMzVV\nD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:44:31'),('db7dfb2e5728119bd6676d0391950a26','MWE5YjQ4ZDEyMjdmZjQ5YjEwMTI2MWEyNmVlZTk0NDE2ZmE4OGE5NDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nwAAAAENBQUlCMkoxOWZUQUJBRzk1cFlvQXZXME4zRllqeGF2U1pDSFpCdnB5YmVNclN4RnZJS0la\nQmp1RjVKRnBKOWs5bVpBS09aQkMzRHBxTUkxWkJRY3J3RGVpQkE1ZTgwbFRudkpkYTY4b2pMWkFa\nQVpCMHFzUVRaQkJiRTNwWkJDYm9aQWF3SWtVUW53cFVSRHJwSXFaQXQ1Vm05RG1YUEdnbE8wdGpx\nN0RQWkM4VzNFWkNEQW9tVlhlZzJVMlZ5OVUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhY\nBwAAADUxODMyMzdVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:46:18'),('dc2910c80f2ba1366f6c0f57224c7bf0','M2NhYmE5M2I0YmFmMTM5MTA5ODg5NzI4ZWU2MzU5ZDdiMWQxNzU2MjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nugAAAENBQUlCMkoxOWZUQUJBQ2lqNkVwVU1KYjdLZFpBZFdTWkNSZVZGZnBUNEY0WkMyTEM5Q21Y\nVFA2VVJUR3pEdG43OVpBWTlEY3pPV2ZVaWZqWkFwMGF2NE5sQzlKc2R2dnJjc08xNjdvQXkyc0lS\nTDVJYjBHTUZWajlYUHlKNFpDeENXUWlBc2d2WkNrdGVKbVV1NVVqcTdOVlZvT1RmWHI4WkJOQUtG\nclBUUFJVMlJ4UGJvUlpDZ1dNTlUPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUx\nODM0MTRVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 06:43:15'),('e46206a57000c7daa630ebbb60f66fa3','NTI4ZTc3NThkODA4OGNiZWU1ZDE4OWFmMGQyNDMxNDRkZGJmOGIzYTqAAn1xAS4=\n','2013-09-01 13:00:57'),('e46c3bf64ffb518141cb6d946a12a28a','NjU2NGIxM2QxZmJhMzM0MWIyYjIyOGI3YWMwNDExYjZkNzRhOTllZDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\ntwAAAENBQUlCMkoxOWZUQUJBTnF2ZFNRR1ZSSjZaQ1AzQjdXcFA3YkFEeFhqSU5BM2JWUDlDWkJI\nWkIxTmE1Z2E4WkJKcEhwa0VQTG1JRlQ2OG1LQnJqRnNyZ1haQm5ZZ3hMSUg3RW1MMExGR1FRemJ0\nSXhpOEh5YXJGam9hVFJBbzlzM1Q0T2s0RU9YeEsxZ2diYVk2TWpqU0lWVFpBb1hoWTdpNW55OHBS\nNjVpSmZ0bjZjd0Y4YVZ4S1UPY3VycmVudF91c2VyX2lkcQdOVQdleHBpcmVzcQhYBwAAADUxNzA2\nNTFVD3ByZWZldGNoZWRfZGF0YXEJTnVicy4=\n','2013-09-10 20:46:00'),('eebc1aec9e35587dd071b5a6d7df34bc','Y2FkM2UxYWMyMzk3Y2JmNTZkYzY4M2RjZmI1MmJjZTA3Y2U3OWVlZjqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuQAAAENBQUlCMkoxOWZUQUJBRVFaQ3lNckFSRTRYbThaQkV1SjdhbkdMZHhrM1gwQTNSUkxocXF2\nZFFRMTRkSjNpWkFHVmRqWG1HektiZGdxMjQzN1gyTHV4YW5YcUR3TERaQVFwWkFyQTFVV0Y3RmxJ\nN25XcGsxVnNLMGJzRHNOUmZ2ZVlPTEM1Y3h5MEhLTGk0V0hlMmNzcmRMT0hYUEVaQ1k2Um04aHZq\nVzVvWkNaQXlqS1N0NFhpTnZ6VQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAANTE4\nMzM0MVUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:44:25'),('f66abc28b8a219d27bf9494274a5ea9e','MTdlOTg3YTI1NjQ3MDZiYjhiYTUyN2E3YzE4ZWU4YWY3NmQ4YzU4ZDqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nxQAAAENBQUlCMkoxOWZUQUJBSnpLUktnOHZxREhrdnhMblFqV1FURlA2NnFtWTV6Um1vcVlJYmZa\nQm1sUnZvS0xldlcyY3lTVWpNbkFOdUxKSEpYbm1aQ1lOTDFjYXAxMXhFTDlPNGNyVE93SVpCR2xu\nNlA0cTEyQUVNdnRzd2Rzd1MyRjRmZGgzWEhHTDBLRjM1S096WGlKZXRxSW9DbG02WkNlTVZEdW5Q\nTGpiTkxQUDFIWFBJWkJGcVpDa3paQTN3ejRJd1pEVQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGly\nZXNxCFgHAAAANTE4Mzk1OVUPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:34:10'),('ff58bea65c41912717dee7c9baffcdeb','MWY2MWE3NjNmZWZkZTQxZDc4ODI0MjhhZWM1MGI1NTg4YjRjNDZmMzqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nuAAAAENBQUlCMkoxOWZUQUJBSHc2WkEybW42MGRNYlh5WHZaQWM2RFdPMXhPT0U1OU9zdVBnYXFO\nZjJocElpSENrS1AyWWVJWkFxSVc0M1IwbW92cTVkOEhpdlJ3R0FIdTdVRFZENzRvWkFGeVNuOWRV\nZjdGTDFjRHN4N2drQ2JkZWFVUDBQSU81cjlCWkFwU1pBYmFId1R1c2s5N0taQ1hpQU5rY2pCcXZQ\nQmswb0RGN21XQThXa2c1N2RVD2N1cnJlbnRfdXNlcl9pZHEHTlUHZXhwaXJlc3EIWAcAAAA1MTgz\nMzMwVQ9wcmVmZXRjaGVkX2RhdGFxCU51YnMu\n','2013-09-10 06:44:35'),('ffcf27a911b243c1e3096de08b7a4403','OGE1N2Q4Y2Y4ZGVlMGFkYmVkZjEwYzhhNDk5ZDkzNmIzY2QzZmU2MTqAAn1xAVUFZ3JhcGhxAmNv\ncGVuX2ZhY2Vib29rLmFwaQpPcGVuRmFjZWJvb2sKcQMpgXEEfXEFKFUMYWNjZXNzX3Rva2VucQZY\nvAAAAENBQUlCMkoxOWZUQUJBUGY3ZlA5R0prczY3YWVpQ09CS1pBZ0syRUUxclllbWtLa3dVbEZa\nQVpDZWtvV3JWN3MySmVmYnNxQkpCOXgweGJ0eFVaQ3ZRb05jclpDZVg0UnVqQUF2ZWJsUTIxTEFF\nWkFybHpNRmtVZzdmZEtySENWdEpyUUFTVUlvMmNaQVFaQmtjVk52a2dvWDZseDNCNGlMWkE2WkJw\nZG9Rd0xGMTlXcnVhMVYyaFpDS3V0VQ9jdXJyZW50X3VzZXJfaWRxB05VB2V4cGlyZXNxCFgHAAAA\nNTE4MzI0N1UPcHJlZmV0Y2hlZF9kYXRhcQlOdWJzLg==\n','2013-09-10 06:45:59');

/*Table structure for table `django_site` */

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_site` */

insert  into `django_site`(`id`,`domain`,`name`) values (1,'http://mudit.com:8000/','http://mudit.com:8000/');

/*Table structure for table `jodibreakerapp_facebookuserprofile` */

DROP TABLE IF EXISTS `jodibreakerapp_facebookuserprofile`;

CREATE TABLE `jodibreakerapp_facebookuserprofile` (
  `id` int(11) NOT NULL auto_increment,
  `facebook_id` bigint(20) default NULL,
  `facebook_username` varchar(255) default NULL,
  `facebook_firstname` varchar(255) default NULL,
  `email` varchar(75) NOT NULL,
  `city` varchar(100) default NULL,
  `mobile_no` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `facebook_id` (`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `jodibreakerapp_facebookuserprofile` */

insert  into `jodibreakerapp_facebookuserprofile`(`id`,`facebook_id`,`facebook_username`,`facebook_firstname`,`email`,`city`,`mobile_no`) values (1,100001994540148,'aakansha.joshii','Akanksha','aakansha.joshii@gmail.com','Gurgaon, Haryana',9871035556),(2,100001197541242,'muditshukla88','Mudit','mudit_shukla3@yahoo.co.in','New Delhi, India',9871299556);

/*Table structure for table `jodibreakerapp_jodi` */

DROP TABLE IF EXISTS `jodibreakerapp_jodi`;

CREATE TABLE `jodibreakerapp_jodi` (
  `id` int(11) NOT NULL auto_increment,
  `jodi` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `jodi` (`jodi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `jodibreakerapp_jodi` */

insert  into `jodibreakerapp_jodi`(`id`,`jodi`) values (4,'Bread & Jam'),(2,'Chai & Samosa'),(3,'iPod and iTunes'),(6,'Mac & Notebook'),(5,'Rabari & Jalebi'),(1,'Santa & Banta'),(7,'Temple Run & Subway Surf');

/*Table structure for table `jodibreakerapp_userjodi` */

DROP TABLE IF EXISTS `jodibreakerapp_userjodi`;

CREATE TABLE `jodibreakerapp_userjodi` (
  `id` int(11) NOT NULL auto_increment,
  `jodi_custom` varchar(50) default NULL,
  `profile_id` int(11) NOT NULL,
  `counter` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `jodibreakerapp_userjodi` */

insert  into `jodibreakerapp_userjodi`(`id`,`jodi_custom`,`profile_id`,`counter`) values (1,'Mac & Notebook',2,0),(2,'Temple Run & Subway Surf',1,0),(3,'Mac & Notebook',1,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
