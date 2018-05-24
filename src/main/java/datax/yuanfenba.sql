-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: 192.168.2.83    Database: yuanfenba_www
-- ------------------------------------------------------
-- Server version	5.5.37-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` char(200) NOT NULL,
  `activity_img` char(200) NOT NULL,
  `activity_layaway` int(11) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `charge_money` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_detail`
--

DROP TABLE IF EXISTS `activity_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_detail` (
  `receive_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL COMMENT '活动id',
  `uid` int(11) NOT NULL COMMENT '领取人的id',
  `receive_date` datetime NOT NULL COMMENT '领取时间',
  `receive_month` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '领取年月',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '录取的状态',
  `is_handle` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1已经处理 0未处理',
  `handel_date` int(11) DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`receive_id`),
  UNIQUE KEY `uid_2` (`uid`,`receive_month`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `is_handle` (`is_handle`),
  KEY `receive_month` (`receive_month`)
) ENGINE=MyISAM AUTO_INCREMENT=67814 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_user_list`
--

DROP TABLE IF EXISTS `activity_user_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_user_list` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID，一个用户只能一次返回话费的机会',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `paymoney` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成功支付金额（分）',
  `activity_month` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '返还月数',
  `change_tm` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '充值成功时间',
  `receive_first_tm` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第一次领取时间，充值时间+1个月',
  `receive_last_tm` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后次领取时间，充值时间加12个月',
  `charge_log_id` int(11) NOT NULL DEFAULT '0' COMMENT '充值记录ID',
  `platform` int(11) NOT NULL DEFAULT '0' COMMENT '充值平台',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`,`receive_first_tm`,`receive_last_tm`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='可以返回话费的用户列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adview_bid`
--

DROP TABLE IF EXISTS `adview_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adview_bid` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '竞价ID',
  `title` varchar(255) DEFAULT NULL COMMENT '广告名称',
  `st` int(11) DEFAULT '0' COMMENT '结算方式',
  `price` int(11) DEFAULT '0' COMMENT '出价， 单位为 0.0001  元，如 CPC 出价 0.212',
  `instl` int(11) DEFAULT '0' COMMENT '广告位类型0-横幅广告1-插屏或全插屏广告4- 开屏6- 原生广告',
  `attr` int(11) DEFAULT '0' COMMENT '广告类型',
  `admt` int(11) DEFAULT '0' COMMENT '广告形式',
  `adm` varchar(500) DEFAULT NULL COMMENT '广告物料，HTML 代码片段',
  `adi` varchar(255) DEFAULT NULL COMMENT '图片物料 URL',
  `adicon` varchar(255) DEFAULT NULL COMMENT '图文广告 ICON URL',
  `adt` varchar(255) DEFAULT NULL COMMENT '文本物料标题',
  `ads` varchar(255) DEFAULT NULL COMMENT '文本物料副标题',
  `cat` varchar(10) DEFAULT NULL COMMENT '广告行业分类',
  `h` int(11) DEFAULT NULL COMMENT '创意高度，单位 px',
  `w` int(11) DEFAULT NULL COMMENT '创意宽度，单位 px',
  `adct` int(11) DEFAULT '0' COMMENT '广告点击行为类型',
  `bundle` varchar(255) DEFAULT NULL COMMENT '点击后下载 App 的包名，仅当 adct 为 0（下载应用）时有效',
  `adtm` int(11) DEFAULT '0' COMMENT '广告播放需要的时长，针对插屏和开屏，单位为',
  `adcurl` varchar(255) DEFAULT NULL COMMENT '广告点击URL',
  `adomain` varchar(255) DEFAULT NULL COMMENT '广告主域名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adview_bid_data`
--

DROP TABLE IF EXISTS `adview_bid_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adview_bid_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bidid` int(11) NOT NULL DEFAULT '0',
  `impid` varchar(100) NOT NULL,
  `click_num` int(11) NOT NULL DEFAULT '0',
  `view_num` int(11) NOT NULL DEFAULT '0',
  `report_date` int(11) NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `bidid` (`bidid`,`impid`,`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adview_bid_price`
--

DROP TABLE IF EXISTS `adview_bid_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adview_bid_price` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bidid` varchar(100) NOT NULL,
  `impid` varchar(100) NOT NULL,
  `wp` varchar(100) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `an_custom_pkg`
--

DROP TABLE IF EXISTS `an_custom_pkg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `an_custom_pkg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soft_title` varchar(60) DEFAULT '' COMMENT '软件名称',
  `pkg_name` varchar(200) DEFAULT '' COMMENT '包名',
  `push_auth` varchar(100) NOT NULL DEFAULT '' COMMENT '推送秘钥',
  `version_code` int(11) DEFAULT '0' COMMENT '版本值',
  `c_uid` int(11) DEFAULT '0' COMMENT '主渠道id',
  `c_sid` int(11) DEFAULT '0' COMMENT '子渠道id',
  `bd_id` int(11) DEFAULT '0' COMMENT '所属商务',
  `create_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '审核状态: 1等待审核 2审核通过 3审核不通过 4删除',
  `remarks` varchar(1000) DEFAULT '',
  `template` varchar(150) DEFAULT '',
  `customer_service` varchar(200) DEFAULT '' COMMENT '客服',
  `website` varchar(100) DEFAULT '' COMMENT '官网',
  `company` varchar(100) DEFAULT '' COMMENT '公司',
  `qq_appip` varchar(100) DEFAULT '' COMMENT 'qq登陆appip',
  `qq_appkey` varchar(100) DEFAULT '' COMMENT 'qq登陆appkey',
  `wx_appid` varchar(100) DEFAULT '' COMMENT '微信登陆AppID',
  `wx_appsecret` varchar(100) DEFAULT '' COMMENT '微信登陆AppSecret',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `an_custom_pkg_log`
--

DROP TABLE IF EXISTS `an_custom_pkg_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `an_custom_pkg_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `pkg_id` int(11) NOT NULL DEFAULT '0' COMMENT '定制包id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作类型: 1修改状态 2删除  3修改内容 4添加记录',
  `op_content` varchar(2000) DEFAULT '' COMMENT '操作内容',
  `ip` varchar(50) DEFAULT '' COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_spread`
--

DROP TABLE IF EXISTS `api_spread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_spread` (
  `spread_id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(25) DEFAULT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `photo1` varchar(50) DEFAULT NULL,
  `photo2` varchar(50) DEFAULT NULL,
  `photo3` varchar(50) DEFAULT NULL,
  `photo4` varchar(50) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` char(8) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `sign` varchar(25) DEFAULT NULL,
  `add_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`spread_id`),
  KEY `spread_id` (`spread_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_active`
--

DROP TABLE IF EXISTS `app_active`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_active` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(255) DEFAULT NULL,
  `hash_0` bigint(22) DEFAULT NULL,
  `hash_1` bigint(22) DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `soft_id` varchar(20) DEFAULT NULL,
  `imsi` varchar(40) DEFAULT NULL,
  `mac` varchar(40) DEFAULT NULL,
  `cell_phone` varchar(20) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `v` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=415437 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_list`
--

DROP TABLE IF EXISTS `app_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_list` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '类型，1为男性APP，2为女性APP',
  `app_name` varchar(100) DEFAULT NULL COMMENT '软件名称',
  `percent` float(10,2) DEFAULT NULL COMMENT '占百分比',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_new_ver`
--

DROP TABLE IF EXISTS `app_new_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_new_ver` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `platform` tinyint(1) NOT NULL DEFAULT '1' COMMENT '平台类型 1 android 2 ios',
  `newpackname` varchar(100) NOT NULL DEFAULT '' COMMENT '新包名',
  `ver` int(11) NOT NULL DEFAULT '0' COMMENT '版本号(android)',
  `ver_text` varchar(20) NOT NULL DEFAULT '' COMMENT '版本号，显示',
  `domains` varchar(400) NOT NULL DEFAULT '' COMMENT '域名(adroid用，逗号分割轮询)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '下载地址(android拼接域名 ，IOS不变)',
  `summary` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `force` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否强制升级 1是 2否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2 关闭',
  `start_uid` int(11) NOT NULL DEFAULT '0' COMMENT '开始UID',
  `end_uid` int(11) NOT NULL DEFAULT '0' COMMENT '结束UID',
  `isvip` tinyint(1) NOT NULL DEFAULT '1' COMMENT '指定vip用户升级 1 不限vip 2 vip 3 非vip',
  `province` int(6) NOT NULL DEFAULT '0' COMMENT '省ID',
  `regdays` int(8) NOT NULL DEFAULT '0' COMMENT '注册时间天数限制',
  `scheme` varchar(255) NOT NULL DEFAULT '' COMMENT 'IOS scheme',
  PRIMARY KEY (`auto_id`),
  KEY `package` (`platform`) USING BTREE,
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `ver` (`ver`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_new_ver_channel`
--

DROP TABLE IF EXISTS `app_new_ver_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_new_ver_channel` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `vid` int(11) NOT NULL DEFAULT '0' COMMENT '版本ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `packname` varchar(100) NOT NULL DEFAULT '' COMMENT '包名',
  `app_key` varchar(100) NOT NULL DEFAULT '' COMMENT '签名',
  `platform` tinyint(1) NOT NULL DEFAULT '1' COMMENT '平台类型 1 android 2 ios',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道子ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2 关闭',
  PRIMARY KEY (`auto_id`),
  KEY `package` (`packname`,`app_key`,`platform`) USING BTREE,
  KEY `cuid` (`c_uid`,`c_sid`) USING BTREE,
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `vid` (`vid`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_new_ver_uid`
--

DROP TABLE IF EXISTS `app_new_ver_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_new_ver_uid` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `vid` int(11) NOT NULL DEFAULT '0' COMMENT '升级配置ID',
  `platform` tinyint(1) NOT NULL DEFAULT '0' COMMENT '平台 1android 2ios',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`) USING BTREE,
  KEY `platform` (`platform`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25970 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_ping`
--

DROP TABLE IF EXISTS `app_ping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_ping` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `ping_date` date DEFAULT NULL,
  `install_time` datetime DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `hash_0` bigint(22) DEFAULT NULL,
  `hash_1` bigint(22) DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `soft_id` varchar(255) DEFAULT NULL,
  `v` int(11) DEFAULT NULL,
  `ver` varchar(40) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `hash_0` (`hash_0`,`hash_1`),
  KEY `uid` (`uid`),
  KEY `ping_date` (`ping_date`),
  KEY `uid_2` (`uid`,`ping_date`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=851604 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_user_active`
--

DROP TABLE IF EXISTS `app_user_active`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_user_active` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `soft_id` varchar(20) DEFAULT NULL,
  `imsi` varchar(40) DEFAULT NULL,
  `mac` varchar(40) DEFAULT NULL,
  `cell_phone` varchar(20) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=484979 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_ver`
--

DROP TABLE IF EXISTS `app_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_ver` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `app_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'app类型，0缘分吧，1恋恋',
  `ver` int(11) unsigned NOT NULL COMMENT '版本,int',
  `ver_text` varchar(20) NOT NULL COMMENT '版本号，显示',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `url` varchar(255) DEFAULT NULL COMMENT '下载地址',
  `summary` varchar(500) DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remove_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`auto_id`),
  KEY `ver` (`ver`),
  KEY `app_type` (`app_type`)
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_ver_channel`
--

DROP TABLE IF EXISTS `app_ver_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_ver_channel` (
  `c_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '渠道子ID',
  `app_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型，0为缘分吧，1为恋恋',
  `ver` int(11) NOT NULL COMMENT '版本,int',
  `ver_text` varchar(20) NOT NULL COMMENT '版本号，显示',
  `force` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否强制升级',
  PRIMARY KEY (`c_uid`,`c_sid`,`app_type`),
  UNIQUE KEY `c_uid` (`c_uid`,`c_sid`,`app_type`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_ver_new`
--

DROP TABLE IF EXISTS `app_ver_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_ver_new` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `packname` varchar(100) NOT NULL DEFAULT '' COMMENT '包名',
  `app_key` varchar(100) NOT NULL DEFAULT '' COMMENT '签名',
  `platform` tinyint(1) NOT NULL DEFAULT '1' COMMENT '平台类型 1 android 2 ios',
  `newpackname` varchar(100) NOT NULL DEFAULT '' COMMENT '新包名',
  `ver` int(11) NOT NULL DEFAULT '0' COMMENT '版本号(android)',
  `ver_text` varchar(20) NOT NULL DEFAULT '' COMMENT '版本号，显示',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道子ID',
  `domains` varchar(400) NOT NULL DEFAULT '' COMMENT '域名(adroid用，逗号分割轮询)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '下载地址(android拼接域名 ，IOS不变)',
  `summary` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `force` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否强制升级 1是 2否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2 关闭',
  `start_uid` int(11) NOT NULL DEFAULT '0' COMMENT '开始UID',
  `end_uid` int(11) NOT NULL DEFAULT '0' COMMENT '结束UID',
  `isvip` tinyint(1) NOT NULL DEFAULT '1' COMMENT '指定vip用户升级 1 不限vip 2 vip 3 非vip',
  `regdays` int(8) NOT NULL DEFAULT '0' COMMENT '注册时间天数限制',
  `scheme` varchar(255) NOT NULL DEFAULT '' COMMENT 'IOS scheme',
  `province` int(6) NOT NULL DEFAULT '0' COMMENT '省ID',
  PRIMARY KEY (`auto_id`),
  KEY `package` (`packname`,`app_key`,`platform`) USING BTREE,
  KEY `cuid` (`c_uid`,`c_sid`) USING BTREE,
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_version`
--

DROP TABLE IF EXISTS `app_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_version` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `app_type` tinyint(1) DEFAULT '1' COMMENT 'app类型，1安卓，2 IOS',
  `c_uid` int(11) NOT NULL COMMENT '渠道ID',
  `c_sid` int(11) DEFAULT NULL,
  `download_count` int(11) DEFAULT '0' COMMENT '下载次数',
  `install_count` int(11) DEFAULT '0' COMMENT '安装次数',
  `ver` int(11) NOT NULL COMMENT '版本',
  `ver_text` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `url` varchar(255) DEFAULT NULL COMMENT '下载地址',
  `summary` text,
  `k1` int(11) DEFAULT '0' COMMENT '次日服务激活数(昨天安装，第二天打开才统计，public/tj?k=1&ver=xxx）',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remove_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`auto_id`,`c_uid`,`ver`),
  KEY `check_key` (`app_type`,`c_uid`,`ver`) USING BTREE,
  KEY `c_uid` (`c_uid`,`c_sid`)
) ENGINE=MyISAM AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `areaID` varchar(50) DEFAULT NULL,
  `area` varchar(60) DEFAULT NULL,
  `father` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areaID` (`areaID`),
  KEY `father` (`father`)
) ENGINE=MyISAM AUTO_INCREMENT=3145 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `article_info`
--

DROP TABLE IF EXISTS `article_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_info` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) NOT NULL COMMENT '文章标题',
  `desp` text NOT NULL COMMENT '文章内容',
  `imgUrl` varchar(255) NOT NULL COMMENT '图片地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发表时间',
  `status` tinyint(255) NOT NULL DEFAULT '0' COMMENT '状态，1为正常',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `back_domain`
--

DROP TABLE IF EXISTS `back_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `back_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '备用域名ID',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '域名分类1.app中间页域名、2.app下载域名、3.app微信访问域名、4.app入口域名、5.app 大v域名',
  `domain_url` varchar(30) NOT NULL COMMENT '域名',
  `url_describe` varchar(50) DEFAULT NULL COMMENT '域名描述',
  `bd_id` int(11) NOT NULL COMMENT '当前商务ID',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '记录状态，1正常，2删除，3禁用',
  `changenum` int(255) NOT NULL DEFAULT '0' COMMENT '修改次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `back_domain_history`
--

DROP TABLE IF EXISTS `back_domain_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `back_domain_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分配ID',
  `bid` int(11) NOT NULL COMMENT '域名ID',
  `bd_id` int(11) NOT NULL COMMENT '商务ID',
  `distribute_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '分配时间',
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `baidu_bid`
--

DROP TABLE IF EXISTS `baidu_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baidu_bid` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '竞价ID',
  `title` varchar(255) DEFAULT NULL COMMENT '广告名称',
  `st` int(11) DEFAULT '0' COMMENT '结算方式',
  `price` int(11) DEFAULT '0' COMMENT '出价， 单位为 0.000001  元，如 CPC 出价 0.212',
  `attr` int(11) DEFAULT '0' COMMENT '广告类型',
  `admt` int(11) DEFAULT '0' COMMENT '广告形式',
  `adm` varchar(500) DEFAULT NULL COMMENT '广告物料，HTML 代码片段',
  `adi` varchar(255) DEFAULT NULL COMMENT '图片物料 URL',
  `adicon` varchar(255) DEFAULT NULL COMMENT '图文广告 ICON URL',
  `adt` varchar(255) DEFAULT NULL COMMENT '文本物料标题',
  `ads` varchar(255) DEFAULT NULL COMMENT '文本物料副标题',
  `cat` int(11) DEFAULT NULL COMMENT '广告行业分类',
  `h` int(11) DEFAULT NULL COMMENT '创意高度，单位 px',
  `w` int(11) DEFAULT NULL COMMENT '创意宽度，单位 px',
  `adct` int(11) DEFAULT '0' COMMENT '广告点击行为类型',
  `bundle` varchar(255) DEFAULT NULL COMMENT '点击后下载 App 的包名，仅当 adct 为 0（下载应用）时有效',
  `adtm` int(11) DEFAULT '0' COMMENT '广告播放需要的时长，针对插屏和开屏，单位为',
  `adcurl` varchar(255) DEFAULT NULL COMMENT '广告点击URL',
  `adomain` varchar(255) DEFAULT NULL COMMENT '广告主域名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `baidu_bid_data`
--

DROP TABLE IF EXISTS `baidu_bid_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baidu_bid_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bidid` int(11) NOT NULL DEFAULT '0',
  `impid` varchar(100) NOT NULL,
  `click_num` int(11) NOT NULL DEFAULT '0',
  `view_num` int(11) NOT NULL DEFAULT '0',
  `report_date` int(11) NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `bidid` (`bidid`,`impid`,`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `baidu_bid_price`
--

DROP TABLE IF EXISTS `baidu_bid_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baidu_bid_price` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bidid` varchar(100) NOT NULL,
  `impid` varchar(100) NOT NULL,
  `wp` varchar(100) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `baidu_login`
--

DROP TABLE IF EXISTS `baidu_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baidu_login` (
  `bid` bigint(20) NOT NULL COMMENT '百度id',
  `uid` int(11) NOT NULL COMMENT 'uid',
  `pass` varchar(255) NOT NULL COMMENT '密码',
  PRIMARY KEY (`bid`),
  KEY `baidu_id_index` (`bid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='百度ID和UID的绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `behavior`
--

DROP TABLE IF EXISTS `behavior`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `behavior` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '行为名称',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `belle_group`
--

DROP TABLE IF EXISTS `belle_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `belle_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL COMMENT '美女组名称',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1.正常 2.关闭 3.删除',
  `accountname` varchar(20) NOT NULL DEFAULT '' COMMENT '帐户姓名',
  `accountnum` varchar(50) NOT NULL DEFAULT '' COMMENT '帐户号码',
  `bank` varchar(50) NOT NULL DEFAULT '' COMMENT '开户行',
  `subbank` varchar(50) NOT NULL DEFAULT '' COMMENT '开户支行',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公会类型 1自提 2工会提',
  `salary` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否发工会底薪 1 发 2不发',
  `fapiao` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开发票  1否 2 是 不开发票扣税20%',
  `belle_salary` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否发美女底薪  1 发 2不发',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=839 DEFAULT CHARSET=utf8 COMMENT='美女组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `belle_group_report`
--

DROP TABLE IF EXISTS `belle_group_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `belle_group_report` (
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '组ID',
  `belle_num` int(10) NOT NULL DEFAULT '0' COMMENT '体验师人数',
  `android_server_num` int(10) NOT NULL DEFAULT '0' COMMENT '安卓 服务在线总人数',
  `ios_server_num` int(10) NOT NULL DEFAULT '0' COMMENT 'IOS 服务在线总人数',
  `server_num` int(10) NOT NULL DEFAULT '0' COMMENT '服务在线总人数',
  `android_app_num` int(10) NOT NULL DEFAULT '0' COMMENT '安卓 APP在线总人数',
  `ios_app_num` int(10) NOT NULL DEFAULT '0' COMMENT 'IOS APP在线总人数',
  `app_num` int(10) NOT NULL DEFAULT '0' COMMENT 'app在线总数',
  `t_1` int(10) NOT NULL DEFAULT '0' COMMENT '群发信(只是Y币用户)',
  `t_2` int(10) NOT NULL DEFAULT '0' COMMENT '群发信(VIP与Y币用户)',
  `t_3` int(10) NOT NULL DEFAULT '0' COMMENT '群发信(有钻石用户)',
  `t_4` int(10) NOT NULL DEFAULT '0' COMMENT '群发信(非付费用户 )',
  `g_1` int(10) NOT NULL DEFAULT '0' COMMENT '群索礼(只是Y币用户)',
  `g_2` int(10) NOT NULL DEFAULT '0' COMMENT '群索礼(VIP与Y币用户)',
  `g_3` int(10) NOT NULL DEFAULT '0' COMMENT '群发信(有钻石用户)',
  `g_4` int(10) NOT NULL DEFAULT '0' COMMENT '群索礼(非付费用户 )',
  `view_t_1` int(10) NOT NULL DEFAULT '0' COMMENT '用户查看数(只是Y币用户)',
  `view_t_2` int(10) NOT NULL DEFAULT '0' COMMENT '用户查看数(VIP与Y币用户)',
  `view_t_3` int(10) NOT NULL DEFAULT '0' COMMENT '用户查看数(有钻石用户)',
  `view_t_4` int(10) NOT NULL DEFAULT '0' COMMENT '用户查看数(非付费用户 )',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `belle_group_to_user`
--

DROP TABLE IF EXISTS `belle_group_to_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `belle_group_to_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `groupsalary` tinyint(1) NOT NULL DEFAULT '0' COMMENT '工会佣金状态 0未结 1已结',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=73826 DEFAULT CHARSET=utf8 COMMENT='美女组用户关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `belle_report`
--

DROP TABLE IF EXISTS `belle_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `belle_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '美女组',
  `chat_redbag_num` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '聊天所得红包数',
  `chat_redbag_money` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聊天红包金额',
  `gift_redbag_num` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '礼物所得红包数',
  `gift_redbag_num_unreceive` int(8) NOT NULL DEFAULT '0' COMMENT '未领礼物数量',
  `gift_redbag_num_receiveed` int(8) NOT NULL DEFAULT '0' COMMENT '已领礼物数量',
  `gift_redbag_money` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '礼物所得红包金额',
  `gift_redbag_money_unreceive` int(10) NOT NULL DEFAULT '0' COMMENT '未领礼物红包金额',
  `gift_redbag_money_receiveed` int(8) NOT NULL DEFAULT '0' COMMENT '已领礼物数量',
  `status` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '是否结算-1不能结算  0未结算 1已结算',
  `add_time` date NOT NULL DEFAULT '2017-01-01' COMMENT '添加日期',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `salary` int(11) NOT NULL DEFAULT '0' COMMENT '每日底薪',
  `paystatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '结算状态 1未结算 2已结算',
  `tax` int(11) NOT NULL DEFAULT '0' COMMENT '税金',
  `paymoney` int(11) NOT NULL DEFAULT '0' COMMENT '支付金额',
  `groupdivide` int(11) NOT NULL DEFAULT '0' COMMENT '工会分成',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`add_time`),
  KEY `uid` (`uid`),
  KEY `status` (`status`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4508424 DEFAULT CHARSET=utf8 COMMENT='美女库系统美女统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `block_type` tinyint(1) NOT NULL DEFAULT '0',
  `block_name` varchar(255) NOT NULL DEFAULT '',
  `block_title` text NOT NULL,
  `summary` text NOT NULL,
  `ext_fields` text NOT NULL COMMENT '扩展项目',
  `shownum` smallint(6) unsigned NOT NULL DEFAULT '0',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '0',
  `page` int(10) unsigned NOT NULL DEFAULT '0',
  `area` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `picwidth` smallint(6) unsigned NOT NULL DEFAULT '0',
  `picheight` smallint(6) unsigned NOT NULL DEFAULT '0',
  `target` varchar(255) NOT NULL DEFAULT '',
  `cachetime` int(10) unsigned NOT NULL DEFAULT '0',
  `param` text NOT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=MyISAM AUTO_INCREMENT=433 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_item`
--

DROP TABLE IF EXISTS `block_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `idtype` varchar(255) NOT NULL DEFAULT '',
  `itemtype` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `pic` varchar(255) NOT NULL DEFAULT '',
  `picflag` tinyint(1) NOT NULL DEFAULT '0',
  `makethumb` tinyint(1) NOT NULL DEFAULT '0',
  `summary` text NOT NULL,
  `showstyle` text NOT NULL,
  `related` text NOT NULL,
  `fields` text NOT NULL,
  `sort` smallint(6) NOT NULL DEFAULT '0',
  `startdate` int(10) unsigned NOT NULL DEFAULT '0',
  `enddate` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `note` text NOT NULL COMMENT '注释',
  `position` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `bid` (`bid`)
) ENGINE=MyISAM AUTO_INCREMENT=3304 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `channel_filter`
--

DROP TABLE IF EXISTS `channel_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_filter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1为完全屏蔽渠道 2为允许1000 自渠道消息',
  PRIMARY KEY (`id`),
  KEY `cid` (`channel_uid`)
) ENGINE=MyISAM AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COMMENT='渠道屏蔽表 用于机器人模块';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_angelpay_user`
--

DROP TABLE IF EXISTS `charge_angelpay_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_angelpay_user` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `pan` varchar(255) DEFAULT NULL COMMENT '卡号',
  `idcard` varchar(255) DEFAULT NULL COMMENT '身份证',
  `real_name` varchar(255) DEFAULT NULL COMMENT '开户名',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=11483 DEFAULT CHARSET=utf8 COMMENT='银联语音支付用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_log`
--

DROP TABLE IF EXISTS `charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `order_subject` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `trade_no` varchar(255) DEFAULT NULL COMMENT '淘宝交易号',
  `order_body` text COMMENT '订单描述',
  `productid` int(11) DEFAULT NULL COMMENT '商品ID',
  `money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `money_real` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '真实充值数据，如298的为136',
  `credit` int(11) NOT NULL COMMENT '获得积分',
  `platform` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值平台 1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `user_client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为web\r\n2为android\r\n3为iphone\r\n4为PC端',
  `error_code` varchar(255) DEFAULT NULL COMMENT '错误信息代码',
  `robotid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '机器人UID',
  `tplid` int(11) NOT NULL DEFAULT '0' COMMENT '回复模板ID',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `order_no` (`order_no`),
  KEY `productid` (`productid`),
  KEY `status` (`status`),
  KEY `create_time` (`create_time`),
  KEY `total` (`create_time`,`status`,`uid`) USING BTREE,
  KEY `uid_2` (`productid`,`status`,`uid`) USING BTREE,
  KEY `update_time` (`update_time`,`status`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=49705411 DEFAULT CHARSET=utf8 COMMENT='充值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_log_order`
--

DROP TABLE IF EXISTS `charge_log_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_log_order` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_no` varchar(255) NOT NULL DEFAULT '' COMMENT '订单号',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '记录状态，0为没有处理，1为已处理',
  PRIMARY KEY (`auto_id`),
  KEY `order_no` (`order_no`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7344 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_log_second`
--

DROP TABLE IF EXISTS `charge_log_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_log_second` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL DEFAULT '' COMMENT '订单号',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '充值次数，2次已上才会在这里记录',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=MyISAM AUTO_INCREMENT=4235 DEFAULT CHARSET=utf8 COMMENT='二次以上的充值记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_sp_log`
--

DROP TABLE IF EXISTS `charge_sp_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_sp_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `order_subject` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `trade_no` varchar(255) DEFAULT NULL COMMENT '淘宝交易号',
  `order_body` text COMMENT '订单描述',
  `productid` int(11) DEFAULT NULL COMMENT '商品ID',
  `money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `credit` int(11) NOT NULL COMMENT '获得积分',
  `platform` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值平台 1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `user_client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为web\r\n2为android\r\n3为iphone\r\n4为PC端',
  `error_code` varchar(255) DEFAULT NULL COMMENT '错误信息代码',
  `robotid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '机器人UID',
  `tplid` int(11) NOT NULL DEFAULT '0' COMMENT '回复模板ID',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `order_no` (`order_no`),
  KEY `productid` (`productid`),
  KEY `status` (`status`),
  KEY `create_time` (`create_time`),
  KEY `total` (`uid`,`create_time`,`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1407 DEFAULT CHARSET=utf8 COMMENT='充值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_user_first`
--

DROP TABLE IF EXISTS `charge_user_first`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_user_first` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `date_time` int(11) NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`date_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=44886 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_user_log`
--

DROP TABLE IF EXISTS `charge_user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_user_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `date_time` int(11) unsigned NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  KEY `date_time` (`date_time`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_user_second`
--

DROP TABLE IF EXISTS `charge_user_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_user_second` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `date_time` int(11) NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`date_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7980 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cityID` varchar(6) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `father` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cityID` (`cityID`),
  KEY `father` (`father`)
) ENGINE=MyISAM AUTO_INCREMENT=441 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city_map`
--

DROP TABLE IF EXISTS `city_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(40) NOT NULL DEFAULT '',
  `province` varchar(30) NOT NULL DEFAULT '',
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `bCity` varchar(60) NOT NULL DEFAULT '' COMMENT '百度地图中的城市名称',
  `bProvince` varchar(30) NOT NULL DEFAULT '' COMMENT '百度地图中省的名称',
  `flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=498 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code`
--

DROP TABLE IF EXISTS `code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL DEFAULT '0' COMMENT '二维码ID',
  `code_url` varchar(500) NOT NULL COMMENT '二维码地址',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，1正常，2删除，5禁用',
  PRIMARY KEY (`auto_id`),
  KEY `type` (`code_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `complain`
--

DROP TABLE IF EXISTS `complain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '投诉的id',
  `complainant` int(11) NOT NULL DEFAULT '0' COMMENT '投诉人',
  `item` int(11) NOT NULL DEFAULT '0' COMMENT '投诉内容id',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态 1已通过 2已封号',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=267754 DEFAULT CHARSET=utf8 COMMENT='举报列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `complain_item`
--

DROP TABLE IF EXISTS `complain_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complain_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `constellation`
--

DROP TABLE IF EXISTS `constellation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `constellation` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '星座ID',
  `name` varchar(10) NOT NULL COMMENT '星座名称',
  `icon` varchar(200) NOT NULL COMMENT '星座图标,上传',
  `starttime` int(11) NOT NULL DEFAULT '0' COMMENT '星座起始时间month(aa)*100 + day(aa)',
  `endtime` int(11) NOT NULL DEFAULT '0' COMMENT '星座结束时间month(aa)*100 + day(aa)',
  `character` text NOT NULL COMMENT '星座性格',
  `love` text NOT NULL COMMENT '星座爱情',
  `keyword` varchar(200) NOT NULL DEFAULT '' COMMENT '性格关健词',
  PRIMARY KEY (`auto_id`),
  KEY `starttime` (`starttime`,`endtime`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `constellation_luck`
--

DROP TABLE IF EXISTS `constellation_luck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `constellation_luck` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型，1为日，2为周，3为月，4为年',
  `c_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '星座ID',
  `career` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '事业运势，0~5',
  `job` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '工作运势，0~5',
  `love` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '爱情运势，0~5',
  `health` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '健康指数，0~100',
  `discuss` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商谈指数，0~100',
  `lucky` varchar(50) NOT NULL DEFAULT '0' COMMENT '幸运数字，多个用“，”分隔',
  `luck_content` text NOT NULL COMMENT '运势内容',
  `time` int(10) unsigned NOT NULL COMMENT '时间，日：20150602,周：201501，月：201506，年：2015',
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`,`c_id`,`time`)
) ENGINE=MyISAM AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deduction_money`
--

DROP TABLE IF EXISTS `deduction_money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deduction_money` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto_id',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `d_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '扣费金额',
  `d_datetime` date NOT NULL COMMENT '扣费日期',
  `d_reason` varchar(500) NOT NULL DEFAULT '' COMMENT '扣费原因',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，1正常，2删除',
  `create_time` datetime NOT NULL DEFAULT '0000-01-01 00:00:00' COMMENT '时间',
  `is_chuli` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否处理，1已处理，0未处理',
  `chuli_time` datetime NOT NULL DEFAULT '0000-01-01 00:00:00' COMMENT '处理时间',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `is_chuli` (`is_chuli`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dev_user_wechat_list`
--

DROP TABLE IF EXISTS `dev_user_wechat_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dev_user_wechat_list` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `openid` varchar(50) NOT NULL COMMENT '微信openid',
  `isSubscribe` tinyint(1) NOT NULL DEFAULT '0' COMMENT '当前是否关注',
  `lastdate` int(11) NOT NULL DEFAULT '0' COMMENT '最后交互时间',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '推广子ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '推广子ID',
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`)
) ENGINE=MyISAM AUTO_INCREMENT=1822 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diamand_log`
--

DROP TABLE IF EXISTS `diamand_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diamand_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '钻石数',
  `type` tinyint(1) NOT NULL COMMENT '类型 1充值 2购买 ',
  `cid` int(11) DEFAULT NULL COMMENT '充值ID',
  `glid` int(11) DEFAULT NULL COMMENT '礼物记录ID',
  `to_uid` int(11) DEFAULT NULL COMMENT '赠送UID',
  `giftid` int(11) DEFAULT NULL COMMENT '礼物ID',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1035 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `down_count`
--

DROP TABLE IF EXISTS `down_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `down_count` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_uid` int(11) NOT NULL DEFAULT '0',
  `c_sid` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `c_uid` (`c_uid`,`c_sid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `user_nickname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `ip` varchar(30) DEFAULT NULL COMMENT 'IP',
  `user_agent` varchar(200) DEFAULT NULL COMMENT 'user agent',
  `cell_phone` bigint(22) DEFAULT NULL COMMENT '手机号',
  `user_client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为web\r\n2为android\r\n3为iphone\r\n4为PC端',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `content` text,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `title` varchar(255) NOT NULL,
  `qq` int(25) NOT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=163098 DEFAULT CHARSET=utf8 COMMENT='用户反馈表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `film` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `pic` varchar(150) DEFAULT NULL,
  `pic_big` varchar(150) DEFAULT NULL,
  `playUrl` varchar(50) DEFAULT NULL COMMENT '播放地址ID，优酷的',
  `type` varchar(150) DEFAULT NULL COMMENT '分类，伦理，动作，人妻，校园，学生',
  `slide` int(11) NOT NULL DEFAULT '0' COMMENT '是否首页轮播，1是',
  `slide_pic` varchar(150) DEFAULT NULL COMMENT '轮播图片',
  `play_times` varchar(10) DEFAULT NULL,
  `cate` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0为推广，1为申请',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `slide` (`slide`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forbid_user_mac`
--

DROP TABLE IF EXISTS `forbid_user_mac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forbid_user_mac` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `hash_0` bigint(20) NOT NULL DEFAULT '0' COMMENT 'hash_1',
  `hash_1` bigint(20) NOT NULL DEFAULT '0' COMMENT 'hash_2',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `hash_0` (`hash_0`,`hash_1`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=272178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_fruit_redbag`
--

DROP TABLE IF EXISTS `game_fruit_redbag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_fruit_redbag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '金额',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型  1红包,2 排名奖励',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  1未提取  2已提取',
  `rank` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排名',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1973547 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_fruit_withdraw`
--

DROP TABLE IF EXISTS `game_fruit_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_fruit_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '提现id',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `money` int(11) DEFAULT NULL COMMENT '提现金额',
  `accountname` varchar(20) DEFAULT NULL COMMENT '帐户姓名',
  `accountnum` varchar(50) DEFAULT NULL COMMENT '帐户号码',
  `bank` varchar(50) DEFAULT NULL COMMENT '开户行',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态1未处理2已完成',
  `create_time` datetime DEFAULT NULL COMMENT '申请时间',
  `handling_time` datetime DEFAULT NULL COMMENT '处理时间',
  `sendnum` int(11) NOT NULL DEFAULT '0' COMMENT '提交次数',
  `deduct_money` int(11) NOT NULL DEFAULT '0' COMMENT '扣款金额',
  `taxes` int(3) DEFAULT '0' COMMENT '税收百分比',
  `taxmoney` int(11) DEFAULT '0' COMMENT '收税之后的金额',
  `subbank` varchar(255) DEFAULT NULL COMMENT '开户支行',
  `bankstatus` tinyint(1) DEFAULT '0' COMMENT '银行更改状态 0未更改 1后台更改 2打回更改',
  `paytype` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付类型 1银行 2支付宝',
  PRIMARY KEY (`id`,`uid`),
  KEY `id` (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `bankstatus` (`bankstatus`) USING BTREE,
  KEY `paytype` (`paytype`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=20184 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_prize_data`
--

DROP TABLE IF EXISTS `game_prize_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_prize_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '奖品ID',
  `prize_title` varchar(50) NOT NULL COMMENT '奖品名称',
  `prize_cate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '奖品类型，1为话费，2为实物',
  `prize_imgUrl` varchar(255) DEFAULT NULL COMMENT '奖品图片',
  `prize_num` int(11) NOT NULL DEFAULT '0' COMMENT '奖品数量',
  `win_num` int(11) NOT NULL DEFAULT '0' COMMENT '已中奖数量',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '奖品类型，1为木质海盗船，2为黄金海盗船，3为钻石海盗船',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`,`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_prize_win_log`
--

DROP TABLE IF EXISTS `game_prize_win_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_prize_win_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto_id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `prize_id` int(11) NOT NULL COMMENT '奖品ID',
  `time` int(11) unsigned NOT NULL COMMENT '中奖时间',
  `ip` varchar(15) NOT NULL COMMENT 'IP',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态，1为已兑换',
  `exchange_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '兑换时间',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号，领取话费用的',
  `express_company` varchar(20) DEFAULT NULL COMMENT '快递公司',
  `express_id` varchar(20) DEFAULT NULL COMMENT '快递公司编码，对应快递100的',
  `express_no` varchar(20) DEFAULT NULL COMMENT '快递单号',
  `express_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快递状态，0为未处理，1为已处理，2为已发货,3为已完成',
  `express_txt` varchar(255) DEFAULT NULL COMMENT '操作说明',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `auto_id` (`auto_id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_share_data`
--

DROP TABLE IF EXISTS `game_share_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_share_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT 'uid',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '分享次数,第个应用每天10次',
  `time` int(11) NOT NULL COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`task_id`,`time`),
  KEY `uid_2` (`uid`,`time`)
) ENGINE=MyISAM AUTO_INCREMENT=37485 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_share_log`
--

DROP TABLE IF EXISTS `game_share_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_share_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto_id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  `paodan` int(11) NOT NULL DEFAULT '0' COMMENT '获取炮弹',
  `time` int(11) NOT NULL COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=37535 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_task_data`
--

DROP TABLE IF EXISTS `game_task_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_task_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_title` varchar(50) NOT NULL COMMENT '任务标题',
  `task_iconUrl` varchar(255) NOT NULL COMMENT '任务图标',
  `text_desc` varchar(255) NOT NULL DEFAULT '0' COMMENT '文字描述',
  `button_desc` varchar(255) NOT NULL DEFAULT '0' COMMENT '按钮描述',
  `link_url` varchar(255) NOT NULL COMMENT '分享url',
  `share_describe` varchar(255) NOT NULL COMMENT '分享描述',
  `paodan` int(11) NOT NULL DEFAULT '0' COMMENT '得炮弹数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_user_data`
--

DROP TABLE IF EXISTS `game_user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_user_data` (
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `free_paodan` int(11) NOT NULL DEFAULT '0' COMMENT '赠送炮弹',
  `paodan` int(11) NOT NULL DEFAULT '0' COMMENT '非赠送炮弹',
  `xiaohao_paodan` int(11) NOT NULL DEFAULT '0' COMMENT '消耗炮弹',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid` (`uid`),
  KEY `free_paodan` (`free_paodan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '游戏ID',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '游戏类型，1为大图，2为精选推荐',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '游戏名称',
  `stitle` varchar(100) NOT NULL DEFAULT '' COMMENT '游戏描述',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '游戏图片',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '游戏下载地址',
  `indexnum` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '激情指数0~5',
  `ordernum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID，越大越在前',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`),
  KEY `ordernum` (`ordernum`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift`
--

DROP TABLE IF EXISTS `gift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '礼物ID',
  `name` varchar(20) NOT NULL COMMENT '礼品名称',
  `img` varchar(255) DEFAULT NULL COMMENT '礼物图片',
  `cost` int(10) NOT NULL COMMENT '礼物花费钻石值',
  `packet` varchar(255) DEFAULT NULL COMMENT '特效包',
  `send_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '赠送次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1正常 2关闭 3删除',
  `sort` mediumint(5) DEFAULT NULL COMMENT '排序',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '礼物类型 1普通礼物 2 打招呼礼物',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='礼物表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gpay_charge_log`
--

DROP TABLE IF EXISTS `gpay_charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gpay_charge_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tp` tinyint(1) unsigned NOT NULL COMMENT '支付平台ID，1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `order_no` varchar(64) NOT NULL COMMENT '订单号',
  `money` float(20,0) NOT NULL DEFAULT '0' COMMENT '金额 成功充值的钱数 以分为单位',
  `status` tinyint(1) unsigned NOT NULL COMMENT '1充值成功 2 充值失败 （3 超时）',
  `create_time` datetime NOT NULL COMMENT '充值成功时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14293 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h5_click_time`
--

DROP TABLE IF EXISTS `h5_click_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `h5_click_time` (
  `uid` int(10) unsigned NOT NULL COMMENT 'uid',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击时间',
  PRIMARY KEY (`uid`),
  KEY `time` (`time`) USING BTREE
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='记录用户点击微缩链接时间，作为是否发短信拉回的依据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h5_login_tpl`
--

DROP TABLE IF EXISTS `h5_login_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `h5_login_tpl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_uid` int(10) NOT NULL COMMENT '渠道id',
  `c_sid` int(10) NOT NULL COMMENT '下线渠道id',
  `tpl` varchar(50) NOT NULL COMMENT '模板名称',
  `oper` int(10) DEFAULT NULL COMMENT '操作员',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `c_uid,c_sid` (`c_uid`,`c_sid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='h5登录模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horoscopes`
--

DROP TABLE IF EXISTS `horoscopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horoscopes` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `female` int(11) NOT NULL DEFAULT '0' COMMENT '女性星座ID',
  `male` int(11) NOT NULL DEFAULT '0' COMMENT '男性星座ID',
  `pairingIndex` int(11) NOT NULL DEFAULT '0' COMMENT '配对指数',
  PRIMARY KEY (`auto_id`),
  KEY `female` (`female`,`male`)
) ENGINE=MyISAM AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iccid_list`
--

DROP TABLE IF EXISTS `iccid_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iccid_list` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `imsi` varchar(50) NOT NULL,
  `iccid` varchar(50) NOT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=51962900 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_md5`
--

DROP TABLE IF EXISTS `image_md5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_md5` (
  `md5` varchar(32) NOT NULL DEFAULT '' COMMENT '图片md5值',
  `sexy_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '色情等级， 0：色情； 1：性感； 2：正常；',
  `ad_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '广告兴致 0：正常； 1：二维码； 2：带文字图片；',
  PRIMARY KEY (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户图片md5值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `importData_log`
--

DROP TABLE IF EXISTS `importData_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `importData_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `importData` text NOT NULL,
  `userAgent` varchar(500) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=277 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integral_app`
--

DROP TABLE IF EXISTS `integral_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integral_app` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分墙应用ID',
  `name` varchar(20) NOT NULL DEFAULT '1' COMMENT '应用名称',
  `pkgname` varchar(100) NOT NULL COMMENT '包名',
  `shorttitle` varchar(50) NOT NULL COMMENT '一句话描述',
  `size` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '应用大小，单位M',
  `ycoin` int(10) NOT NULL DEFAULT '0' COMMENT '能获取多少个Y币',
  `url` varchar(255) NOT NULL COMMENT '下载地址',
  `imgurl` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `summary` varchar(500) DEFAULT NULL COMMENT '获取金币方式描述',
  `bdid` int(11) NOT NULL DEFAULT '0' COMMENT '所属商务ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remove_time` datetime DEFAULT NULL,
  `sort` int(11) unsigned DEFAULT '1000' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态,1为正常，2为删除，5为禁用',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integral_app_log`
--

DROP TABLE IF EXISTS `integral_app_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integral_app_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分墙应用ID',
  `appid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '应用ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ycoin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '获取多少个Y币',
  `create_time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `appid` (`appid`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=575 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integral_new_app`
--

DROP TABLE IF EXISTS `integral_new_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integral_new_app` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分墙应用ID',
  `name` varchar(20) NOT NULL DEFAULT '1' COMMENT '应用名称',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '适用性别，0为所有，1为男性，2为女性',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '任务类型，1为时间类型，2为唯一类型',
  `open_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT ' ''1'' => ''down'',''2'' => ''share_qq'',''3'' => ''share_weibo'',''4'' => ''share_weixin'',''5'' => ''open_web''',
  `per_hour` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型的间隔，单位为天,如果为周写7天，为月写30天',
  `pkgname` varchar(100) NOT NULL COMMENT '包名',
  `shorttitle` varchar(50) NOT NULL COMMENT '一句话描述',
  `size` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '应用大小，单位M',
  `ycoin` int(10) NOT NULL DEFAULT '0' COMMENT '能获取多少个Y币',
  `url` varchar(255) NOT NULL COMMENT '下载地址',
  `imgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '图片地址',
  `summary` varchar(500) NOT NULL DEFAULT '' COMMENT '获取金币方式描述',
  `bdid` int(11) NOT NULL DEFAULT '0' COMMENT '所属商务ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL,
  `remove_time` datetime DEFAULT NULL,
  `sort` int(11) unsigned NOT NULL DEFAULT '1000' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1为正常，2为删除，5为禁用',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `sort` (`sort`),
  KEY `gender` (`gender`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ios_custom_pkg`
--

DROP TABLE IF EXISTS `ios_custom_pkg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ios_custom_pkg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soft_title` varchar(60) DEFAULT NULL COMMENT '软件名称',
  `pkg_name` varchar(200) DEFAULT NULL COMMENT '包名',
  `push_auth` varchar(100) NOT NULL DEFAULT '' COMMENT '推送秘钥',
  `tg_type` varchar(20) NOT NULL COMMENT '推广包类型',
  `version_name` varchar(20) DEFAULT NULL COMMENT '版本号',
  `version_code` int(11) DEFAULT '0' COMMENT '版本值',
  `c_uid` int(11) DEFAULT '0' COMMENT '主渠道id',
  `c_sid` int(11) DEFAULT NULL COMMENT '子渠道id',
  `deduction` float(10,2) DEFAULT NULL COMMENT '扣量比例，扣40%填写0.4',
  `d_c_uid` int(11) DEFAULT NULL COMMENT '扣量后主渠道id',
  `d_c_sid` int(11) DEFAULT NULL COMMENT '扣量后子渠道id',
  `bd_id` int(11) DEFAULT NULL COMMENT '所属商务',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '审核状态: 1等待审核 2审核通过 3审核不通过 4删除',
  `remarks` varchar(1000) DEFAULT NULL,
  `template` varchar(150) DEFAULT NULL,
  `customer_service` varchar(200) DEFAULT '' COMMENT '客服',
  `website` varchar(100) DEFAULT '' COMMENT '官网',
  `company` varchar(100) DEFAULT '' COMMENT '公司',
  `qq_appip` varchar(100) DEFAULT '' COMMENT 'qq登陆appip',
  `qq_appkey` varchar(100) DEFAULT '' COMMENT 'qq登陆appkey',
  `wx_appid` varchar(100) DEFAULT '' COMMENT '微信登陆AppID',
  `wx_appsecret` varchar(100) DEFAULT '' COMMENT '微信登陆AppSecret',
  `three_login` tinyint(1) DEFAULT '0' COMMENT '第三方登陆: 1关 2开',
  `account_type` tinyint(1) DEFAULT '0' COMMENT '账号类型: 1自由 2渠道',
  `payset` varchar(100) DEFAULT '' COMMENT '支付方式控制，示例：wechat,alipay 写在前面就排序在前面',
  `market_version_code` int(11) DEFAULT '0' COMMENT '市场版本值',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`pkg_name`),
  KEY `status_2` (`status`,`tg_type`)
) ENGINE=MyISAM AUTO_INCREMENT=256 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ios_custom_pkg_log`
--

DROP TABLE IF EXISTS `ios_custom_pkg_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ios_custom_pkg_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `pkg_id` int(11) NOT NULL DEFAULT '0' COMMENT '定制包id',
  `type` tinyint(1) NOT NULL COMMENT '操作类型: 1修改状态 2删除  3修改内容 4添加记录',
  `op_content` varchar(2000) DEFAULT NULL COMMENT '操作内容',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2890 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_address_lib`
--

DROP TABLE IF EXISTS `ip_address_lib`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_address_lib` (
  `ip` varchar(11) NOT NULL,
  `country` varchar(20) NOT NULL DEFAULT '',
  `country_id` varchar(10) NOT NULL DEFAULT '',
  `area` varchar(20) NOT NULL DEFAULT '',
  `area_id` varchar(6) NOT NULL DEFAULT '',
  `region` varchar(20) NOT NULL DEFAULT '',
  `region_id` varchar(6) NOT NULL DEFAULT '',
  `city` varchar(20) NOT NULL DEFAULT '',
  `city_id` varchar(6) NOT NULL DEFAULT '',
  `isp_id` varchar(6) NOT NULL DEFAULT '',
  `isp` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `joke`
--

DROP TABLE IF EXISTS `joke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `joke` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '笑话ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '笑话标题',
  `imgUrl` varchar(200) DEFAULT '' COMMENT '图片地址',
  `content` varchar(500) DEFAULT '' COMMENT '内容',
  `time` int(10) unsigned NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keep_url`
--

DROP TABLE IF EXISTS `keep_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keep_url` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL DEFAULT '',
  `baseurl` varchar(100) NOT NULL DEFAULT '',
  `checkurl` varchar(100) NOT NULL DEFAULT '',
  `backupurl` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kf`
--

DROP TABLE IF EXISTS `kf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kf` (
  `kf_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客服ID',
  `kf_user` varchar(20) DEFAULT NULL COMMENT '客服名',
  `kf_pwd` varchar(32) DEFAULT NULL COMMENT '客服密码',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`kf_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_anchor`
--

DROP TABLE IF EXISTS `live_anchor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_anchor` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `kuplay_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '直播主播id',
  `call` varchar(120) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='主播表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_banner`
--

DROP TABLE IF EXISTS `live_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_banner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `describe` varchar(80) DEFAULT NULL COMMENT '描述',
  `img` varchar(255) NOT NULL COMMENT '图片地址',
  `link` varchar(255) NOT NULL COMMENT '链接',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1.正常 2.关闭',
  `create_time` date NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='直播广告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_key_value`
--

DROP TABLE IF EXISTS `live_key_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_key_value` (
  `key` varchar(50) NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='键值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_equipment_log`
--

DROP TABLE IF EXISTS `login_equipment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_equipment_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto_id',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `imei` char(50) NOT NULL DEFAULT '' COMMENT 'IMEI',
  `imsi` char(50) NOT NULL DEFAULT '' COMMENT 'IMSI',
  `mac` char(20) NOT NULL DEFAULT '' COMMENT 'MAC',
  `ip` char(20) NOT NULL COMMENT 'IP',
  `create_time` datetime NOT NULL COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=43058976 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lucky`
--

DROP TABLE IF EXISTS `lucky`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucky` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '奖品ID',
  `name` varchar(500) NOT NULL DEFAULT '' COMMENT '奖品名称',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '奖品缩略图片',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '描述',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '总份数',
  `sort` int(3) NOT NULL DEFAULT '1000' COMMENT '排序',
  `flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，0为实物，1为话费',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,1为正常',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`,`num`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lucky_log`
--

DROP TABLE IF EXISTS `lucky_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucky_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `luckyid` int(11) NOT NULL COMMENT '奖品ID',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,0为默认，1为已领取',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未处理 1已经处理',
  `gender` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1男2女',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `luckyid` (`luckyid`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lucky_user`
--

DROP TABLE IF EXISTS `lucky_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucky_user` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1为正常，0为已用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL,
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别',
  `gid` tinyint(1) DEFAULT '0' COMMENT '用户组',
  `question` varchar(50) DEFAULT '',
  `answer` varchar(50) DEFAULT '',
  `sign` varchar(250) DEFAULT '' COMMENT '签名',
  `qq` varchar(12) DEFAULT '',
  `cell_phone` varchar(50) DEFAULT '' COMMENT '手机号',
  `avatar` varchar(50) NOT NULL DEFAULT '' COMMENT '头像',
  `birthday` date NOT NULL COMMENT '生日',
  `login_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '登录类型，1 账户，2 ＱＱ登录，3 新浪登录',
  `reg_time` datetime NOT NULL COMMENT '注册时间',
  `last_login_time` datetime NOT NULL COMMENT '上次登录时间',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `comment` text,
  `index` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商务首页显示',
  `zuzhang_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属商务组长ID',
  `iszuzhang` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为组长，1为组长',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `gid` (`gid`),
  KEY `index` (`index`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_action_log`
--

DROP TABLE IF EXISTS `manager_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_action_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别，1为男性，2为女性',
  `action` int(11) NOT NULL DEFAULT '0' COMMENT '操作类型，审核头像对应的类型，再外加一个禁号，89是禁号，88是恢复',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT '操作IP',
  PRIMARY KEY (`auto_id`),
  KEY `mid` (`mid`),
  KEY `uid` (`uid`),
  KEY `action` (`action`)
) ENGINE=MyISAM AUTO_INCREMENT=7162565 DEFAULT CHARSET=utf8 COMMENT='审核 头像记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_group`
--

DROP TABLE IF EXISTS `manager_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_group` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `permits` text COLLATE utf8_unicode_ci NOT NULL,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_login_log`
--

DROP TABLE IF EXISTS `manager_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_login_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '登录用户名',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(15) NOT NULL COMMENT '登录IP',
  `result` tinyint(1) DEFAULT NULL COMMENT '登录结果',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=205496 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_operate_log`
--

DROP TABLE IF EXISTS `manager_operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_operate_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `manager_id` mediumint(8) NOT NULL COMMENT '管理员id',
  `operate_ip` varchar(15) NOT NULL COMMENT 'ip',
  `operate_time` datetime NOT NULL COMMENT '操作时间',
  `module_name` varchar(50) NOT NULL COMMENT '操作模块名称',
  `target_id` int(11) NOT NULL COMMENT '操作目标id',
  `data` text COMMENT '修改数据字段',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`),
  KEY `target_id` (`target_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29133 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `money_tree_cheater`
--

DROP TABLE IF EXISTS `money_tree_cheater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money_tree_cheater` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_date` date NOT NULL COMMENT '日期',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'UID',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '零钱',
  `tree_money` int(11) NOT NULL DEFAULT '0' COMMENT '树上金额',
  `share_num` int(11) NOT NULL DEFAULT '0' COMMENT '分享用户数',
  `charge_money` int(11) NOT NULL DEFAULT '0' COMMENT '充值金额',
  `withdraw_sum` int(11) NOT NULL DEFAULT '0' COMMENT '提现总额',
  `share_pay` int(11) NOT NULL COMMENT '分享充值量',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '日期',
  PRIMARY KEY (`id`),
  KEY `uid` (`report_date`,`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mp_company`
--

DROP TABLE IF EXISTS `mp_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mp_company` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '公司ID',
  `company_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公司名',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='公司表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mp_domain`
--

DROP TABLE IF EXISTS `mp_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mp_domain` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '域名ID',
  `domain` varchar(50) NOT NULL DEFAULT '' COMMENT '域名',
  `domain_key` varchar(32) NOT NULL DEFAULT '' COMMENT '主域名md5值，用来查询主域名的',
  `beian` varchar(50) NOT NULL DEFAULT '' COMMENT '备案号',
  `beian_company` int(11) NOT NULL DEFAULT '0' COMMENT '备案公司ID',
  `iplist` varchar(500) NOT NULL DEFAULT '' COMMENT 'ip列表，多个用英文“,”分隔',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1为使用中，2为备用中，3为可疑，4为已封',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `domain_key` (`domain_key`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='域名管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mp_options`
--

DROP TABLE IF EXISTS `mp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mp_options` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bd_id` int(11) NOT NULL DEFAULT '0' COMMENT '0为公共，其他是选择商务ID',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户推广主ID',
  `wap_c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '微信wap推广主ID',
  `company` int(11) NOT NULL DEFAULT '0' COMMENT '所属公司ID',
  `master_domain` int(11) NOT NULL DEFAULT '0' COMMENT '主域名ID，微信接口用',
  `default_domain` int(11) NOT NULL DEFAULT '0' COMMENT '默认域名ID，直接关注用户用，如1000号',
  `formal_domain` int(11) NOT NULL DEFAULT '0' COMMENT '正式域名ID，推广用',
  `robots_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认ID机器人回复标志，1为回复，0为不回复',
  `push_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认ID微信推送标志，1为推送，0为不推送',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '公众号名称',
  `wechat_id` varchar(50) NOT NULL DEFAULT '' COMMENT '微信号',
  `mchid` varchar(20) NOT NULL DEFAULT '' COMMENT '支付商户号',
  `prefix` varchar(50) NOT NULL DEFAULT '' COMMENT '公众号前缀',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT '服务token',
  `appid` varchar(50) NOT NULL DEFAULT '' COMMENT 'appid',
  `appsecret` varchar(32) NOT NULL DEFAULT '' COMMENT 'appsecret',
  `templateid` varchar(100) NOT NULL DEFAULT '' COMMENT '模板消息ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1为正常，2为备用中，3为回收，4为已封',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `master_domain` (`master_domain`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公众号配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mp_options_child`
--

DROP TABLE IF EXISTS `mp_options_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mp_options_child` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '子账号ID',
  `mp_options_id` int(11) NOT NULL COMMENT 'mp_options_id',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '推广子ID',
  `bd_id` int(11) NOT NULL DEFAULT '0' COMMENT '如果mp_options里的bd_id为公共，这里必填,否则为mp_options里的bd_id',
  `robots_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '机器人回复标志，1为回复，0为不回复',
  `push_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '微信推送标志，1为推送，0为不推送',
  PRIMARY KEY (`auto_id`),
  KEY `mp_options_id` (`mp_options_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='公众号子账号配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpay_charge_log`
--

DROP TABLE IF EXISTS `mpay_charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpay_charge_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tp` tinyint(1) unsigned NOT NULL COMMENT '支付平台ID，1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `order_no` varchar(64) NOT NULL COMMENT '订单号',
  `money` float(20,0) NOT NULL DEFAULT '0' COMMENT '金额 成功充值的钱数 以分为单位',
  `status` tinyint(1) unsigned NOT NULL COMMENT '1充值成功 2 充值失败 （3 超时）',
  `create_time` datetime NOT NULL COMMENT '充值成功时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8011 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpay_charge_log_1`
--

DROP TABLE IF EXISTS `mpay_charge_log_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpay_charge_log_1` (
  `order_no` varchar(64) NOT NULL COMMENT '订单号',
  `money` float(20,0) NOT NULL DEFAULT '0' COMMENT '金额 成功充值的钱数 以分为单位',
  PRIMARY KEY (`order_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl`
--

DROP TABLE IF EXISTS `msg_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1为文字，2为语音，3为视频',
  `to_gender` tinyint(1) DEFAULT NULL,
  `msg` varchar(255) DEFAULT '',
  `rel_id` tinyint(1) DEFAULT NULL,
  `msg_reply` text,
  `ver` int(11) DEFAULT '0' COMMENT '版本，10号为回复语音，11为打招呼语音，12为回复视频，13为打招呼视频',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `hour_start` int(11) DEFAULT NULL,
  `hour_end` int(11) DEFAULT NULL,
  `voice_url` varchar(255) DEFAULT '' COMMENT '语音链接',
  `voice_time` int(11) NOT NULL DEFAULT '0' COMMENT '语音时长',
  `voice_userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '几号用户ID,如1号填1',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '视频url',
  `video_img` varchar(255) NOT NULL DEFAULT '' COMMENT '视频缩略图',
  `video_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长，单位为秒',
  `video_size` int(11) NOT NULL DEFAULT '0' COMMENT '视频大小，单位：字节',
  `video_width` int(11) NOT NULL DEFAULT '0' COMMENT '视频宽',
  `video_height` int(11) NOT NULL DEFAULT '0' COMMENT '视频高',
  `video_userid` int(11) NOT NULL DEFAULT '0' COMMENT '视频机器人UID',
  `video_title` varchar(255) NOT NULL DEFAULT '' COMMENT '视频描述语句，方便查看对应视频',
  PRIMARY KEY (`msg_id`),
  KEY `to_gender` (`to_gender`),
  KEY `ver` (`ver`),
  KEY `ver_2` (`ver`,`status`,`hour_start`,`hour_end`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=2448 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_new`
--

DROP TABLE IF EXISTS `msg_tpl_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_new` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `msg_tpl_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应的tplID',
  `ver` int(11) NOT NULL DEFAULT '0' COMMENT '版本，11锁前1，12锁前2，13锁前3，21锁后1，22锁后2',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '模板类型1为文字，2为语音，3为视频,4为图片',
  `text_msg` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容，文字',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音链接',
  `voice_time` int(11) NOT NULL DEFAULT '0' COMMENT '语音时长',
  `voice_title` varchar(255) NOT NULL DEFAULT '' COMMENT '语音描述文字，方便后台查看',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '视频url',
  `video_img` varchar(255) NOT NULL DEFAULT '' COMMENT '视频缩略图',
  `video_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长，单位为秒',
  `video_size` int(11) NOT NULL DEFAULT '0' COMMENT '视频大小，单位：字节',
  `video_width` int(11) NOT NULL DEFAULT '0' COMMENT '视频宽',
  `video_height` int(11) NOT NULL DEFAULT '0' COMMENT '视频高',
  `video_title` varchar(255) NOT NULL DEFAULT '' COMMENT '视频描述语句，方便查看对应视频',
  `img_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `img_title` varchar(255) NOT NULL DEFAULT '' COMMENT '图片描述文字，方便后台查看',
  `create_time` datetime NOT NULL DEFAULT '2016-08-01 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`auto_id`),
  KEY `ver` (`ver`),
  KEY `type` (`type`),
  KEY `msg_tpl_id` (`msg_tpl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2095 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_new_cp`
--

DROP TABLE IF EXISTS `msg_tpl_new_cp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_new_cp` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `msg_tpl_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应的tplID',
  `ver` int(11) NOT NULL DEFAULT '0' COMMENT '版本，11锁前1，12锁前2，13锁前3，21锁后1，22锁后2',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '模板类型1为文字，2为语音，3为视频,4为图片',
  `text_msg` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容，文字',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音链接',
  `voice_time` int(11) NOT NULL DEFAULT '0' COMMENT '语音时长',
  `voice_title` varchar(255) NOT NULL DEFAULT '' COMMENT '语音描述文字，方便后台查看',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '视频url',
  `video_img` varchar(255) NOT NULL DEFAULT '' COMMENT '视频缩略图',
  `video_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长，单位为秒',
  `video_size` int(11) NOT NULL DEFAULT '0' COMMENT '视频大小，单位：字节',
  `video_width` int(11) NOT NULL DEFAULT '0' COMMENT '视频宽',
  `video_height` int(11) NOT NULL DEFAULT '0' COMMENT '视频高',
  `video_title` varchar(255) NOT NULL DEFAULT '' COMMENT '视频描述语句，方便查看对应视频',
  `img_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `img_title` varchar(255) NOT NULL DEFAULT '' COMMENT '图片描述文字，方便后台查看',
  `create_time` datetime NOT NULL DEFAULT '2016-08-01 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`auto_id`),
  KEY `ver` (`ver`),
  KEY `type` (`type`),
  KEY `msg_tpl_id` (`msg_tpl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_new_en`
--

DROP TABLE IF EXISTS `msg_tpl_new_en`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_new_en` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `msg_tpl_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应的tplID',
  `ver` int(11) NOT NULL DEFAULT '0' COMMENT '版本，11锁前1，12锁前2，13锁前3，21锁后1，22锁后2',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '模板类型1为文字，2为语音，3为视频,4为图片',
  `text_msg` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容，文字',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音链接',
  `voice_time` int(11) NOT NULL DEFAULT '0' COMMENT '语音时长',
  `voice_title` varchar(255) NOT NULL DEFAULT '' COMMENT '语音描述文字，方便后台查看',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '视频url',
  `video_img` varchar(255) NOT NULL DEFAULT '' COMMENT '视频缩略图',
  `video_time` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长，单位为秒',
  `video_size` int(11) NOT NULL DEFAULT '0' COMMENT '视频大小，单位：字节',
  `video_width` int(11) NOT NULL DEFAULT '0' COMMENT '视频宽',
  `video_height` int(11) NOT NULL DEFAULT '0' COMMENT '视频高',
  `video_title` varchar(255) NOT NULL DEFAULT '' COMMENT '视频描述语句，方便查看对应视频',
  `img_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `img_title` varchar(255) NOT NULL DEFAULT '' COMMENT '图片描述文字，方便后台查看',
  `create_time` datetime NOT NULL DEFAULT '2016-08-01 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`auto_id`),
  KEY `ver` (`ver`),
  KEY `type` (`type`),
  KEY `msg_tpl_id` (`msg_tpl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2096 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_show_date`
--

DROP TABLE IF EXISTS `msg_tpl_show_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_show_date` (
  `auto_id` int(11) NOT NULL,
  `show_date` date NOT NULL DEFAULT '2016-10-13' COMMENT '显示日期',
  `show_date_type` int(11) NOT NULL DEFAULT '0' COMMENT '显示节日类型',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `show_date` (`show_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_show_date_type`
--

DROP TABLE IF EXISTS `msg_tpl_show_date_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_show_date_type` (
  `show_date_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '显示节日名称',
  PRIMARY KEY (`show_date_type`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user`
--

DROP TABLE IF EXISTS `msg_tpl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '10' COMMENT '权重 初始权重10',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人，4定点推送',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP，3为ios',
  `hour_str` varchar(255) NOT NULL DEFAULT '' COMMENT '时间选择，“,”分隔，如0,1,2',
  `show_date_type` int(11) NOT NULL DEFAULT '0' COMMENT '节日显示类型',
  `week_str` varchar(255) NOT NULL DEFAULT '' COMMENT '星期选择，0~6，周日-周六，用“，”分隔',
  `isChannel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为渠道专用',
  `channel_list` text NOT NULL COMMENT '渠道列表，格式1000_1001,1002_1001',
  `weight_lock` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定权重(0不锁定，1锁定且不按充值比导入)',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`),
  KEY `weight` (`weight`),
  KEY `show_date_type` (`show_date_type`)
) ENGINE=MyISAM AUTO_INCREMENT=438 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user_`
--

DROP TABLE IF EXISTS `msg_tpl_user_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user_` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '100' COMMENT '权重 初始权重100 ',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人，4定点推送',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=266 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user_copy`
--

DROP TABLE IF EXISTS `msg_tpl_user_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user_copy` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '100' COMMENT '权重 初始权重100 ',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人，4定点推送',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=266 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user_cp`
--

DROP TABLE IF EXISTS `msg_tpl_user_cp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user_cp` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '100' COMMENT '权重 初始权重100 ',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user_cp_copy`
--

DROP TABLE IF EXISTS `msg_tpl_user_cp_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user_cp_copy` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '100' COMMENT '权重 初始权重100 ',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_user_en`
--

DROP TABLE IF EXISTS `msg_tpl_user_en`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_user_en` (
  `msg_tpl_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '机器人用户ID',
  `hour_start` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `hour_end` tinyint(4) NOT NULL DEFAULT '23' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `weight` int(10) unsigned NOT NULL DEFAULT '10' COMMENT '权重 初始权重10',
  `weight_lock_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权重锁定时间戳',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示类型，1为一键打招呼，2为首页，3为附近的人，4定点推送',
  `client_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户端类型，0为通用，1为微信公众号，2为APP，3为ios',
  `hour_str` varchar(255) NOT NULL DEFAULT '' COMMENT '时间选择，“,”分隔，如0,1,2',
  `show_date_type` int(11) NOT NULL DEFAULT '0' COMMENT '节日显示类型',
  `week_str` varchar(255) NOT NULL DEFAULT '' COMMENT '星期选择，0~6，周日-周六，用“，”分隔',
  `isChannel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为渠道专用',
  `channel_list` text NOT NULL COMMENT '渠道列表，格式1000_1001,1002_1001',
  `weight_lock` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定权重(0不锁定，1锁定且不按充值比导入)',
  PRIMARY KEY (`msg_tpl_id`),
  KEY `type` (`type`),
  KEY `weight` (`weight`),
  KEY `show_date_type` (`show_date_type`)
) ENGINE=MyISAM AUTO_INCREMENT=438 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msg_tpl_wy`
--

DROP TABLE IF EXISTS `msg_tpl_wy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msg_tpl_wy` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `to_gender` tinyint(1) DEFAULT NULL,
  `msg` varchar(255) DEFAULT NULL,
  `rel_id` tinyint(1) DEFAULT NULL,
  `msg_reply` text,
  `ver` int(11) DEFAULT '0' COMMENT '版本',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `hour_start` int(11) DEFAULT NULL,
  `hour_end` int(11) DEFAULT NULL,
  PRIMARY KEY (`msg_id`),
  KEY `to_gender` (`to_gender`),
  KEY `ver` (`ver`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mumu_user`
--

DROP TABLE IF EXISTS `mumu_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mumu_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '用户密码',
  `gender` tinyint(1) NOT NULL COMMENT '性别',
  `reg_time` int(10) unsigned NOT NULL COMMENT '注册时间',
  `reg_ip` varchar(20) NOT NULL COMMENT '注册IP',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `myapp_keyword`
--

DROP TABLE IF EXISTS `myapp_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myapp_keyword` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL COMMENT '关键词名称',
  `money` decimal(6,2) DEFAULT '0.30' COMMENT '金额',
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='应用商店关键词表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `novel`
--

DROP TABLE IF EXISTS `novel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `novel` (
  `uid` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '书城用户ID',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '书城用户账号',
  `balance` decimal(15,2) DEFAULT '0.00' COMMENT '书城用户账户余额',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `novel_charge_log`
--

DROP TABLE IF EXISTS `novel_charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `novel_charge_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `order_subject` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `trade_no` varchar(255) DEFAULT NULL COMMENT '淘宝交易号',
  `order_body` text COMMENT '订单描述',
  `productid` int(11) DEFAULT NULL COMMENT '商品ID',
  `money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `money_real` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '真实充值数据，如298的为136',
  `credit` int(11) NOT NULL COMMENT '获得积分',
  `platform` int(11) NOT NULL DEFAULT '0' COMMENT '充值平台 1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `user_client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为web\r\n2为android\r\n3为iphone\r\n4为PC端',
  `error_code` varchar(255) DEFAULT NULL COMMENT '错误信息代码',
  `robotid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '机器人UID',
  `tplid` int(11) NOT NULL DEFAULT '0' COMMENT '回复模板ID',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `order_no` (`order_no`),
  KEY `productid` (`productid`),
  KEY `status` (`status`),
  KEY `create_time` (`create_time`),
  KEY `total` (`create_time`,`status`,`uid`) USING BTREE,
  KEY `uid_2` (`productid`,`status`,`uid`) USING BTREE,
  KEY `update_time` (`update_time`,`status`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=40399856 DEFAULT CHARSET=utf8 COMMENT='充值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `novel_wechat_user`
--

DROP TABLE IF EXISTS `novel_wechat_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `novel_wechat_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT 'openid',
  `reg_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '注册IP',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '主渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `openid` (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phone_info`
--

DROP TABLE IF EXISTS `phone_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_info` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `osbuild` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '职位标题',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级ID',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '等级分类',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1为正常，2为删除',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `flag` (`level`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precious`
--

DROP TABLE IF EXISTS `precious`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precious` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '宝藏ID',
  `name` varchar(500) NOT NULL DEFAULT '' COMMENT '宝藏名称',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '所值Y币，如果为0就不加Y币',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '宝藏缩略图片',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '总份数',
  `usenum` int(11) NOT NULL DEFAULT '0' COMMENT '已放出份数',
  `proportion` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '挖出比例',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `content` text,
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `sort` int(3) NOT NULL DEFAULT '1000' COMMENT '排序',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `num` (`num`,`usenum`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precious_day`
--

DROP TABLE IF EXISTS `precious_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precious_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '领取人的id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12702 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize`
--

DROP TABLE IF EXISTS `prize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '奖品ID',
  `name` varchar(500) NOT NULL DEFAULT '' COMMENT '奖品名称',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型：1为普通宝箱，2为大宝箱',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '宝藏缩略图片',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '描述',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '总份数',
  `zhuli` int(10) NOT NULL COMMENT '需要助力值',
  `top_hour` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '整点开启，9~22',
  `sort` int(3) NOT NULL DEFAULT '1000' COMMENT '排序',
  `flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，0为实物，1为话费',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,1为正常',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `type` (`type`),
  KEY `top_hour` (`top_hour`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize_log`
--

DROP TABLE IF EXISTS `prize_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'log ID',
  `prizeid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '奖品ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `top_hour` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '开启宝箱的整点',
  `prize_date` date NOT NULL COMMENT '日期',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机号,中奖后领取的时候填写',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '记录状态,0为默认已参与，1为已中奖',
  `express_company` varchar(20) DEFAULT NULL COMMENT '快递公司',
  `express_id` varchar(20) DEFAULT NULL COMMENT '快递公司编码，对应快递100的',
  `express_no` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `express_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快递状态，0为未领取，1为已领取，2为已发货,3为已完成',
  `get_time` datetime DEFAULT NULL COMMENT '领取时间',
  `del_time` datetime DEFAULT NULL COMMENT '发货时间',
  `win_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '中奖时间',
  `imei` char(50) NOT NULL DEFAULT '',
  `imsi` char(50) NOT NULL DEFAULT '',
  `ip` char(20) NOT NULL DEFAULT '',
  `mac` char(20) NOT NULL DEFAULT '',
  `hash_0` bigint(20) NOT NULL DEFAULT '0' COMMENT 'md5_hash_0',
  `hash_1` bigint(20) NOT NULL DEFAULT '0' COMMENT 'md5 hash_1',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `prizeid` (`prizeid`,`uid`,`prize_date`),
  KEY `status` (`status`),
  KEY `top_hour` (`top_hour`),
  KEY `hash_0` (`hash_0`,`hash_1`),
  KEY `prizeid_2` (`prizeid`),
  KEY `uid` (`uid`),
  KEY `prize_date` (`prize_date`)
) ENGINE=MyISAM AUTO_INCREMENT=4221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize_new`
--

DROP TABLE IF EXISTS `prize_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize_new` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '奖品ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '奖品名称',
  `recommended` int(11) NOT NULL DEFAULT '1' COMMENT '默认为0，1为推荐',
  `thumb` varchar(200) NOT NULL DEFAULT '' COMMENT '宝藏缩略图片',
  `pic` varchar(200) NOT NULL DEFAULT '' COMMENT '宝藏大图片',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `description` text NOT NULL COMMENT '描述',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '总份数',
  `zhuli` int(10) NOT NULL COMMENT '需要助力值',
  `top_hour` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '整点开启，9~22',
  `sort` int(3) NOT NULL DEFAULT '1000' COMMENT '排序',
  `flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，0为实物，1为话费',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,1为正常',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `recommended` (`recommended`),
  KEY `top_hour` (`top_hour`)
) ENGINE=MyISAM AUTO_INCREMENT=262 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize_new_log`
--

DROP TABLE IF EXISTS `prize_new_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prize_new_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'log ID',
  `prizeid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '奖品ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `top_hour` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '开启宝箱的整点',
  `prize_date` date NOT NULL COMMENT '日期',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机号,中奖后领取的时候填写',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '记录状态,0为默认已参与，1为已中奖',
  `express_company` varchar(20) DEFAULT NULL COMMENT '快递公司',
  `express_id` varchar(20) DEFAULT NULL COMMENT '快递公司编码，对应快递100的',
  `express_no` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `express_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快递状态，0为未领取，1为已领取，2为已发货,3为已完成',
  `get_time` datetime DEFAULT NULL COMMENT '领取时间',
  `del_time` datetime DEFAULT NULL COMMENT '发货时间',
  `win_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '中奖时间',
  `imei` char(50) NOT NULL DEFAULT '',
  `imsi` char(50) NOT NULL DEFAULT '',
  `ip` char(20) NOT NULL DEFAULT '',
  `mac` char(20) NOT NULL DEFAULT '',
  `hash_0` bigint(20) NOT NULL DEFAULT '0' COMMENT 'md5_hash_0',
  `hash_1` bigint(20) NOT NULL DEFAULT '0' COMMENT 'md5 hash_1',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `prizeid` (`prizeid`,`uid`,`prize_date`),
  KEY `status` (`status`),
  KEY `top_hour` (`top_hour`),
  KEY `hash_0` (`hash_0`,`hash_1`),
  KEY `prizeid_2` (`prizeid`),
  KEY `uid` (`uid`),
  KEY `prize_date` (`prize_date`)
) ENGINE=MyISAM AUTO_INCREMENT=474839 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provinceID` varchar(6) DEFAULT NULL,
  `province` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provinceID` (`provinceID`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_ad_config`
--

DROP TABLE IF EXISTS `push_ad_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_ad_config` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_time` int(11) NOT NULL DEFAULT '0' COMMENT '消息时间间隔（单位：分钟）',
  `screen_time` int(11) NOT NULL DEFAULT '0' COMMENT '弹屏时间间隔（单位：分钟）',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_ad_data`
--

DROP TABLE IF EXISTS `push_ad_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_ad_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `push_ad_id` int(11) NOT NULL COMMENT 'push广告ID',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `clicknum` int(11) NOT NULL DEFAULT '0' COMMENT '点击数',
  `report_date` int(11) unsigned NOT NULL COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `push_ad_id` (`push_ad_id`,`c_uid`,`c_sid`,`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=918 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_user_list`
--

DROP TABLE IF EXISTS `push_user_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_user_list` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_list` text COMMENT '用户列表',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `redbag_moneytree`
--

DROP TABLE IF EXISTS `redbag_moneytree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redbag_moneytree` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `money` int(11) NOT NULL COMMENT '金额',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `type` tinyint(1) NOT NULL DEFAULT '6' COMMENT '类型  6摇钱树红包',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  1未提取  2已提取',
  `fuid` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源ID',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `uid_2` (`uid`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=59527216 DEFAULT CHARSET=utf8 COMMENT='摇钱树红包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `redbag_ranking`
--

DROP TABLE IF EXISTS `redbag_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redbag_ranking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `money` int(11) NOT NULL COMMENT '金额',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '类型 2.切水果排行 4 聊天排名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  1未提取  2已提取',
  `rank` tinyint(1) NOT NULL DEFAULT '0' COMMENT '排行',
  `num` int(10) NOT NULL DEFAULT '0' COMMENT '聊天所得红包数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`,`create_time`) USING BTREE,
  KEY `uid_2` (`uid`,`status`) USING BTREE,
  KEY `date` (`num`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='排行红包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reply_keyword`
--

DROP TABLE IF EXISTS `reply_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply_keyword` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '关键词ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `keyword` varchar(2048) NOT NULL DEFAULT '' COMMENT '关键词',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reply_keyword_tpl`
--

DROP TABLE IF EXISTS `reply_keyword_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply_keyword_tpl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `key_id` int(11) NOT NULL DEFAULT '0' COMMENT '关键词id',
  `reply_id` int(11) NOT NULL DEFAULT '0' COMMENT '回复序号',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '模板类型1为文字，2为语音，3为视频,4为图片',
  `text_msg` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容，文字',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音/视频/图片链接',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '语音/视频时长',
  `size` int(11) NOT NULL DEFAULT '0' COMMENT '语音/视频大小，单位：字节',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '视频/图片描述语句',
  `width` int(11) NOT NULL DEFAULT '0' COMMENT '视频宽',
  `height` int(11) NOT NULL DEFAULT '0' COMMENT '视频高',
  `video_img` varchar(255) NOT NULL DEFAULT '' COMMENT '视频缩略图',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `key_id` (`key_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_date` date DEFAULT NULL COMMENT '报告日期',
  `user_client_type` int(11) DEFAULT NULL COMMENT '来源 1为web 2 为android 3 为iphone 4 为PC端',
  `c_uid` int(11) DEFAULT '0' COMMENT '渠道主ID',
  `c_sid` int(11) DEFAULT '0' COMMENT '渠道辅ID',
  `reg_count` int(11) DEFAULT NULL COMMENT '注册总数',
  `reg_1_count` int(11) DEFAULT '0' COMMENT '注册后走资料的',
  `reg_web` int(11) DEFAULT '0' COMMENT '注册人数',
  `reg_qq` int(11) DEFAULT '0' COMMENT 'QQ注册数',
  `reg_weibo` int(11) DEFAULT '0' COMMENT '微博注册数',
  `bind_cell_phone` int(11) DEFAULT '0' COMMENT '手机绑定',
  `online_time` int(11) DEFAULT '0' COMMENT '平均在线时长',
  `active_count` int(11) DEFAULT '0' COMMENT '每日有效活跃人数',
  `say_hi_user_count` int(11) DEFAULT '0' COMMENT '打招呼人数',
  `say_hi_count` int(11) DEFAULT '0' COMMENT '打招呼次数',
  `replay_user_count` int(11) DEFAULT '0' COMMENT '发信人数',
  `replay_count` int(11) DEFAULT '0' COMMENT '发信次数',
  `pay_user_count` int(11) DEFAULT '0' COMMENT '付费人数',
  `pay_amount` int(11) DEFAULT '0' COMMENT '付费金额',
  `sec_login` int(11) DEFAULT '0' COMMENT '次日留存',
  `reach_pay_page_user_count` int(11) DEFAULT '0' COMMENT '到达充值页面的人数',
  `today_reg_reach_pay_page_user_count` int(11) DEFAULT '0' COMMENT '当日注册到达充值页面的人数',
  `hit_pay_button_user_count` int(11) DEFAULT '0' COMMENT '点击了重置按钮的人数',
  `hit_pay_button_alipay_user_count` int(11) DEFAULT '0',
  `hit_pay_button_card_user_count` int(11) DEFAULT '0',
  `hit_pay_button_union_pay_user_count` int(11) DEFAULT '0',
  `hit_pay_button_alipay_wap_user_count` int(11) DEFAULT '0',
  `today_reg_hit_pay_button_user_count` int(11) DEFAULT '0' COMMENT '当日注册点击了重置按钮的人数',
  `want_replay_user_count` int(11) DEFAULT '0' COMMENT '没有回复成功的用户数',
  `today_reg_want_replay_user_count` int(11) DEFAULT '0' COMMENT '当日注册没有回复成功的用户数',
  `view_kf_replay_user_count` int(11) DEFAULT '0',
  `today_reg_view_kf_replay_user_count` int(11) DEFAULT '0' COMMENT '当日注册查看了客服回复',
  `click_online_kf_button_user_count` int(11) DEFAULT '0' COMMENT '点击了在线客服的用户数',
  `today_reg_user_active_user` int(11) DEFAULT '0' COMMENT '当日注册用户活跃用户数',
  `today_reg_user_say_hi_user_count` int(11) DEFAULT '0' COMMENT '今日注册用户打招呼用户数',
  `today_reg_user_say_hi_count` int(11) DEFAULT '0' COMMENT '当日注册用户打招呼数',
  `replay_first_user_count` int(11) DEFAULT '0',
  `today_reg_replay_first_user_count` int(11) DEFAULT '0' COMMENT '今日回复一条',
  `enter_index_page_user_count` int(11) DEFAULT '0' COMMENT '进入首页的人数',
  `today_reg_enter_index_page_user_count` int(11) DEFAULT '0' COMMENT '今日注册的进入首页的',
  `pay_success_alipay_user_count` int(11) DEFAULT '0' COMMENT '支付宝支付成功用户数',
  `pay_success_union_pay_user_count` int(11) DEFAULT '0' COMMENT '银联支付成功数',
  `pay_success_card_pay_user_count` int(11) DEFAULT '0' COMMENT '手机卡充值成功',
  `pay_success_alipay_wap_user_count` int(11) DEFAULT '0' COMMENT '支付宝 wap',
  `today_reg_pay_success_alipay_user_count` int(11) DEFAULT '0',
  `today_reg_pay_success_union_pay_user_count` int(11) DEFAULT '0',
  `today_reg_pay_success_card_pay_user_count` int(11) DEFAULT '0',
  `today_reg_pay_success_alipay_wap_user_count` int(11) DEFAULT '0',
  `pay_alipay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `pay_union_pay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `pay_card_pay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `pay_alipay_wap_amount` decimal(11,2) DEFAULT NULL,
  `service_ping` int(11) DEFAULT '0' COMMENT '服务留存',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `today_reg_pay_alipay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `today_reg_pay_union_pay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `today_reg_pay_card_pay_amount` decimal(11,2) DEFAULT NULL COMMENT '0',
  `today_reg_pay_alipay_wap_amount` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10079 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_activity`
--

DROP TABLE IF EXISTS `report_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_activity` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `k1` int(11) DEFAULT '0',
  `k2` int(11) DEFAULT '0',
  `k3` int(11) DEFAULT '0',
  `k4` int(11) DEFAULT '0',
  `k5` int(11) DEFAULT '0',
  `k6` int(11) DEFAULT '0',
  `k7` int(11) DEFAULT '0',
  `k8` int(11) DEFAULT '0',
  `k9` int(11) DEFAULT '0',
  `k10` int(11) DEFAULT '0',
  `k11` int(11) DEFAULT '0',
  `k12` int(11) DEFAULT '0',
  `k13` int(11) DEFAULT '0',
  `k14` int(11) DEFAULT '0',
  `k15` int(11) DEFAULT '0',
  `k16` int(11) DEFAULT '0',
  `k17` int(11) DEFAULT '0',
  `k18` int(11) DEFAULT '0',
  `k19` int(11) DEFAULT '0',
  `k20` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `uid` int(11) DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_amount`
--

DROP TABLE IF EXISTS `report_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_amount` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '软件ID',
  `upay` float(20,2) NOT NULL DEFAULT '0.00' COMMENT 'upay',
  `weiying` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '微赢',
  `sp` float(20,2) NOT NULL DEFAULT '0.00' COMMENT 'sp',
  `sp_s` float(20,2) NOT NULL DEFAULT '0.00' COMMENT 'sp成功金额',
  `soft` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '软件内点击',
  `desk` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '桌面图标',
  `push_1` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '短信',
  `push_2` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '彩信',
  `push_3` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '消息栏',
  `push_4` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '锁屏',
  `other_1` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '游戏',
  `other_2` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '主播',
  `other_3` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '成人交友',
  `amount` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '返量比',
  `report_date` int(11) NOT NULL DEFAULT '0' COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `report_date` (`app_id`,`report_date`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=404 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_app_user_action`
--

DROP TABLE IF EXISTS `report_app_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_app_user_action` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `enter_reg_page` int(11) DEFAULT '0' COMMENT '进入注册页',
  `active_install` int(11) DEFAULT '0' COMMENT '直接安装后打开',
  `active_notify` int(11) DEFAULT '0' COMMENT '信息栏',
  `active_desktop` int(11) DEFAULT '0' COMMENT '桌面图标',
  `active_net_wifi` int(11) DEFAULT '0',
  `active_net_3g` int(11) DEFAULT '0',
  `active_net_2g` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'active_desktop',
  `update_time` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `report_date` (`report_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_app_ver`
--

DROP TABLE IF EXISTS `report_app_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_app_ver` (
  `auto_id` int(11) NOT NULL,
  `report_date` date DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `v` int(11) DEFAULT NULL,
  `ver` varchar(255) DEFAULT NULL,
  `k1` int(11) DEFAULT NULL,
  `kk1` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `hash` varchar(255) DEFAULT NULL,
  `hash_0` bigint(22) DEFAULT NULL,
  `hash_1` bigint(22) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `report_date` (`report_date`),
  KEY `c_uid` (`c_uid`,`c_sid`),
  KEY `v` (`v`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_girl`
--

DROP TABLE IF EXISTS `report_girl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_girl` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_date` date DEFAULT NULL COMMENT '报告日期',
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `uct` int(11) DEFAULT NULL,
  `k1` int(11) DEFAULT '0',
  `k2` int(11) DEFAULT '0',
  `k3` int(11) DEFAULT '0',
  `k4` int(11) DEFAULT '0',
  `k5` int(11) DEFAULT '0',
  `k6` int(11) DEFAULT '0',
  `k7` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`report_id`),
  KEY `uct` (`uct`),
  KEY `report_date` (`report_date`),
  KEY `c_uid` (`c_uid`),
  KEY `c_sid` (`c_sid`)
) ENGINE=MyISAM AUTO_INCREMENT=269388 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_msg_10_user`
--

DROP TABLE IF EXISTS `report_msg_10_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_msg_10_user` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `report_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`report_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_shangxian_user`
--

DROP TABLE IF EXISTS `report_shangxian_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_shangxian_user` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `report_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=1811536 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_user_abnormal`
--

DROP TABLE IF EXISTS `report_user_abnormal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_user_abnormal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_date` date NOT NULL COMMENT '报表日期',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sayhello_total` int(10) NOT NULL DEFAULT '0' COMMENT '打招呼人数',
  `msg_total` int(10) NOT NULL DEFAULT '0' COMMENT '发消息人数',
  `msg_gay` int(10) NOT NULL DEFAULT '0' COMMENT '同性消息数',
  `msg_heterd` int(10) NOT NULL DEFAULT '0' COMMENT '异性消息数',
  `sayhello_gay` int(10) NOT NULL DEFAULT '0' COMMENT '同性招呼数量',
  `sayhello_heterd` int(10) NOT NULL DEFAULT '0' COMMENT '异性打招呼数',
  `online` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户是否上线,1上线,2未上线',
  `register_ip` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册IP',
  `login_ip` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态,1正常,2已封号',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `sayhello_total` (`sayhello_total`) USING BTREE,
  KEY `msg_total` (`msg_total`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `login_ip` (`login_ip`) USING BTREE,
  KEY `register_ip` (`register_ip`) USING BTREE,
  KEY `online` (`online`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=866255 DEFAULT CHARSET=utf8 COMMENT='异常用户数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_user_action`
--

DROP TABLE IF EXISTS `report_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_user_action` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `reach_pay_page_time` datetime DEFAULT NULL COMMENT '到达充值页面时间',
  `hit_pay_button_time` datetime DEFAULT NULL COMMENT '点击充值按钮时间',
  `hit_pay_button_alipay_time` datetime DEFAULT NULL,
  `hit_pay_button_alipay_wap_time` datetime DEFAULT NULL COMMENT '支付宝网页支付',
  `hit_pay_button_card_time` datetime DEFAULT NULL,
  `hit_pay_button_union_pay_time` datetime DEFAULT NULL,
  `hit_pay_button__time` datetime DEFAULT NULL,
  `want_replay_time` datetime DEFAULT NULL COMMENT '点了回复按钮时间',
  `view_kf_replay_time` datetime DEFAULT NULL COMMENT '查看了客服回复时间',
  `click_online_kf_button_time` datetime DEFAULT NULL COMMENT '点击了在线客服',
  `replay_first_time` datetime DEFAULT NULL COMMENT '回复一条',
  `enter_index_page_time` datetime DEFAULT NULL COMMENT '进入首页的人数',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `reach_pay_page_time` (`reach_pay_page_time`),
  KEY `hit_pay_button_time` (`hit_pay_button_time`),
  KEY `want_replay_time` (`want_replay_time`),
  KEY `view_kf_replay_time` (`view_kf_replay_time`),
  KEY `uid` (`uid`),
  KEY `report_date` (`report_date`),
  KEY `replay_first_time` (`replay_first_time`)
) ENGINE=MyISAM AUTO_INCREMENT=92623 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_user_free`
--

DROP TABLE IF EXISTS `report_user_free`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_user_free` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sayhello_total` int(10) NOT NULL DEFAULT '0' COMMENT '打招呼人数',
  `message_total` int(10) NOT NULL DEFAULT '0' COMMENT '发消息人数',
  `client_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT 'IP整型值',
  `gay_total` int(10) NOT NULL DEFAULT '0' COMMENT '对方性别:同性人数',
  `opposite_sex_total` int(10) NOT NULL DEFAULT '0' COMMENT '对方性别:异性人数',
  `client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '客户端类型,2:安卓,3:iOS',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间戳',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否封号,1:正常,2:封号,仅后台显示用',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作时间,后台显示用',
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`),
  KEY `client_type` (`client_type`),
  KEY `client_ip` (`client_ip`),
  KEY `update_time` (`update_time`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='封号用户数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_ver`
--

DROP TABLE IF EXISTS `report_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_ver` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_date` date DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `hash_0` bigint(22) DEFAULT NULL,
  `hash_1` bigint(22) DEFAULT NULL,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `ver` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1 注册 2 登陆',
  `uid` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=430254 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resume`
--

DROP TABLE IF EXISTS `resume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resume` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '简历ID',
  `t_id` int(10) NOT NULL DEFAULT '0' COMMENT '所属人才ID',
  `u_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `u_gender` mediumint(2) NOT NULL DEFAULT '1' COMMENT '性别，1男，2女',
  `u_birthday` date NOT NULL DEFAULT '1970-01-01' COMMENT '出生年月日',
  `u_edu` mediumint(2) NOT NULL DEFAULT '0' COMMENT '学历',
  `u_school` varchar(20) NOT NULL DEFAULT '' COMMENT '毕业院校',
  `work_year` mediumint(3) NOT NULL DEFAULT '0' COMMENT '工作年限',
  `u_industry` varchar(100) NOT NULL DEFAULT '' COMMENT '从事行业',
  `u_professional` varchar(100) NOT NULL DEFAULT '' COMMENT '从事专业',
  `u_srouce` mediumint(1) NOT NULL DEFAULT '0' COMMENT '来源，1.前程无忧，2.智联招聘，3.中华英才网，4.拉勾网，5.公司推荐，6.其它方式',
  `u_tel` varchar(11) NOT NULL DEFAULT '' COMMENT '联系电话',
  `u_qq` varchar(20) NOT NULL DEFAULT '' COMMENT '联系QQ',
  `work_experience` text NOT NULL COMMENT '工作履历，经验',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态，1正常，2删除，3禁用',
  `u_zhuanye` varchar(50) NOT NULL DEFAULT '' COMMENT '学校专业',
  `u_evaluation` varchar(1000) NOT NULL DEFAULT '' COMMENT '自我评价',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `u_email` varchar(50) NOT NULL DEFAULT '',
  `province` varchar(6) NOT NULL DEFAULT '' COMMENT '所在省',
  `city` varchar(6) NOT NULL DEFAULT '' COMMENT '所在市',
  `u_good_at_skills` varchar(255) NOT NULL DEFAULT '' COMMENT '擅长技能',
  `u_marry_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '婚姻状况',
  `u_native_place` varchar(20) NOT NULL DEFAULT '' COMMENT '籍贯',
  `u_rs_evaluation` text NOT NULL COMMENT '人事意见',
  `u_bm_evaluation` text NOT NULL COMMENT '用人部门意见',
  `u_home_address` varchar(100) NOT NULL DEFAULT '' COMMENT '家庭住址',
  `u_post_match` tinyint(2) NOT NULL DEFAULT '0' COMMENT '岗位匹配度，1★，2★★，3★★★，4★★★★，5★★★★★',
  `u_interview_time` date NOT NULL COMMENT '面试时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `robots_tpl_charge_log`
--

DROP TABLE IF EXISTS `robots_tpl_charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `robots_tpl_charge_log` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_no` varchar(255) NOT NULL DEFAULT '' COMMENT '订单号',
  `tpl_type` int(11) NOT NULL DEFAULT '0' COMMENT '模板mod ID如：11，12，13，21，22',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`auto_id`),
  KEY `order_no` (`order_no`),
  KEY `create_time` (`create_time`),
  KEY `tpl_type` (`tpl_type`)
) ENGINE=MyISAM AUTO_INCREMENT=12498021 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `root_data`
--

DROP TABLE IF EXISTS `root_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `root_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT 'root数',
  `report_date` int(11) unsigned NOT NULL COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `c_uid` (`c_uid`,`c_sid`,`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rose`
--

DROP TABLE IF EXISTS `rose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rose` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '红娘ID',
  `hn_pwd` varchar(32) DEFAULT NULL COMMENT '红娘登录密码',
  `weixin` varchar(50) NOT NULL COMMENT '微信号',
  `qq` bigint(20) NOT NULL COMMENT 'qq号',
  `rose_qr` varchar(50) DEFAULT NULL,
  `rose_avatar` varchar(50) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`weixin`),
  UNIQUE KEY `email` (`rose_qr`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sdk_active_data`
--

DROP TABLE IF EXISTS `sdk_active_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sdk_active_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sdk_id` int(11) NOT NULL COMMENT 'SDK ID',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `activenum` int(11) NOT NULL DEFAULT '0' COMMENT '激活ID',
  `report_date` int(11) NOT NULL DEFAULT '0' COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `sdk_id` (`sdk_id`,`c_uid`,`c_sid`,`report_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `online_time` int(11) DEFAULT '0' COMMENT '用户在线时长',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `remove_time` datetime NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_id` (`session_id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting` (
  `k` varchar(50) NOT NULL COMMENT 'key',
  `v` longtext NOT NULL COMMENT '数值',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`k`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share`
--

DROP TABLE IF EXISTS `share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share` (
  `share_id` int(11) NOT NULL AUTO_INCREMENT,
  `share_time` datetime NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `uid` int(11) NOT NULL,
  `share_expire_time` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`share_id`),
  KEY `type` (`type`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=88351 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `single_wechat_qrcode`
--

DROP TABLE IF EXISTS `single_wechat_qrcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `single_wechat_qrcode` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '二维码群名称',
  `qrcodeUrl` varchar(300) NOT NULL DEFAULT '' COMMENT '二维码链接',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `sms_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '短信类型 1 为验证信息 2 找回密码 3 为手机注册',
  `hash` varchar(32) DEFAULT NULL,
  `phone_num` bigint(22) unsigned NOT NULL,
  `verify_code` varchar(11) DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`sms_id`),
  KEY `type` (`type`),
  KEY `phone_num` (`phone_num`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3519553 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_verify`
--

DROP TABLE IF EXISTS `sms_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_verify` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `phone_num` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `sign` varchar(20) NOT NULL DEFAULT '' COMMENT '签名，如：缘分吧',
  `verify_code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生成时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间,生成时间+10分钟',
  PRIMARY KEY (`auto_id`),
  KEY `phone_num` (`phone_num`,`sign`,`end_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=758383 DEFAULT CHARSET=utf8 COMMENT='短信验证码，每个手机的验证码在10分钟之内有效';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_channel`
--

DROP TABLE IF EXISTS `sp_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_channel` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '通道ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '通道名称',
  `qq` varchar(20) NOT NULL COMMENT '对方的联系QQ',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '通道形式，1为url,2为短信',
  `simoperator` tinyint(1) NOT NULL DEFAULT '1' COMMENT '运营商，1为移动，2为联通，3为电信',
  `fun` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否限量，1为限量，默认为2不限量',
  `money` float NOT NULL DEFAULT '0' COMMENT '资费',
  `url` varchar(500) NOT NULL DEFAULT '' COMMENT 'url',
  `sms_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为普通，2为二次，3为发送后访问网络',
  `sms_no` varchar(50) NOT NULL DEFAULT '' COMMENT '短信号',
  `sms_content` varchar(255) NOT NULL COMMENT '短信内容',
  `sms_url` varchar(255) NOT NULL COMMENT '短信回发URL',
  `start_hour` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间点',
  `end_hour` tinyint(1) unsigned NOT NULL DEFAULT '23' COMMENT '结束时间点',
  `day_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日限次数',
  `month_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月限次数',
  `xx_num` varchar(255) NOT NULL COMMENT '下行号码，多个用'',''分隔',
  `xx_key` varchar(255) NOT NULL COMMENT '下行关键词，多个用'',''分隔',
  `xx_reply` varchar(255) NOT NULL COMMENT '下行回复规则,$$分隔',
  `xx_reply_key` varchar(255) NOT NULL COMMENT '要回复信息的关键词',
  `xx_reply_no` varchar(50) NOT NULL COMMENT '回复端口号',
  `sms_no_second` varchar(50) NOT NULL COMMENT '第二次发送号码',
  `sms_content_second` varchar(255) NOT NULL COMMENT '第二次发送短信内容',
  `second_time` int(11) NOT NULL DEFAULT '0' COMMENT '第二次发送时间间隔，单位为秒',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '通道状态，1为正常，2为删除，5为禁用',
  `orderNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID，这个值大，就排前面',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `fun` (`fun`,`auto_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1155 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_channel_config`
--

DROP TABLE IF EXISTS `sp_channel_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_channel_config` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sp_id` int(11) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1是开通，2是屏蔽',
  `province` varchar(20) NOT NULL DEFAULT '' COMMENT '开通省份',
  `no_city` varchar(255) NOT NULL DEFAULT '' COMMENT '屏蔽城市，多个用"，"',
  PRIMARY KEY (`auto_id`),
  KEY `sp_id` (`sp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17994 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_click_data`
--

DROP TABLE IF EXISTS `sp_click_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_click_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `clicknum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送数',
  `report_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日期时间戳',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `c_uid` (`c_uid`,`c_sid`,`report_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_click_log`
--

DROP TABLE IF EXISTS `sp_click_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_click_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sp_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'SPID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `imsi` varchar(20) NOT NULL DEFAULT '',
  `simoperator` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `money` float(20,0) NOT NULL DEFAULT '0' COMMENT '金额',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `time` (`time`),
  KEY `sp_id` (`sp_id`),
  KEY `c_uid` (`time`,`c_uid`,`c_sid`) USING BTREE,
  KEY `time_2` (`time`,`sp_id`),
  KEY `time_3` (`time`,`c_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_click_log_new`
--

DROP TABLE IF EXISTS `sp_click_log_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_click_log_new` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sp_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'SPID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `imsi` varchar(20) NOT NULL DEFAULT '',
  `simoperator` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `money` float(20,0) NOT NULL DEFAULT '0' COMMENT '金额',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `time` (`time`),
  KEY `sp_id` (`sp_id`),
  KEY `c_uid` (`time`,`c_uid`,`c_sid`) USING BTREE,
  KEY `time_2` (`time`,`sp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_click_sdk_log`
--

DROP TABLE IF EXISTS `sp_click_sdk_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_click_sdk_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sdk_id` int(11) NOT NULL COMMENT 'sdkID,1为up,2为大象',
  `uid` int(11) unsigned NOT NULL,
  `imsi` varchar(20) NOT NULL,
  `simoperator` tinyint(1) NOT NULL,
  `money` float(255,0) NOT NULL DEFAULT '0' COMMENT '金额',
  `time` int(10) unsigned NOT NULL COMMENT '时间',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '主渠道ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道',
  PRIMARY KEY (`auto_id`),
  KEY `time` (`time`,`sdk_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_dongman`
--

DROP TABLE IF EXISTS `sp_dongman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_dongman` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(64) NOT NULL,
  `contentcodes` varchar(64) NOT NULL,
  `appcode` varchar(64) NOT NULL,
  `transactionid` varchar(32) NOT NULL,
  `state` varchar(2) NOT NULL,
  `provincename` varchar(64) NOT NULL,
  `cityname` varchar(64) NOT NULL,
  `billingpoint` float(16,0) NOT NULL,
  `failurereason` varchar(192) NOT NULL,
  `exdata` int(11) unsigned NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `exdata` (`exdata`),
  KEY `phone` (`phone`) USING BTREE,
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_dongman_all_log`
--

DROP TABLE IF EXISTS `sp_dongman_all_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_dongman_all_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_dongman_imsi`
--

DROP TABLE IF EXISTS `sp_dongman_imsi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_dongman_imsi` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `imsi` varchar(16) NOT NULL COMMENT 'imsi',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型，1为动漫，2为SDK',
  `time` int(10) unsigned NOT NULL COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `imsi` (`imsi`,`time`,`type`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_dongman_log`
--

DROP TABLE IF EXISTS `sp_dongman_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_dongman_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_get_data`
--

DROP TABLE IF EXISTS `sp_get_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_get_data` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sp_id` int(11) NOT NULL COMMENT 'spid',
  `get_success` int(11) NOT NULL COMMENT '成功获取',
  `get_error` int(11) NOT NULL COMMENT '获取失败数',
  `send_data` int(11) NOT NULL DEFAULT '0' COMMENT '发送数',
  `send_success_data` int(11) NOT NULL DEFAULT '0' COMMENT '发送成功数据',
  `date_hour` int(11) NOT NULL DEFAULT '0' COMMENT '小时',
  `date_time` int(11) NOT NULL COMMENT '日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `sp_id` (`sp_id`,`date_hour`,`date_time`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='url类型的sp获取数据统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_user_info`
--

DROP TABLE IF EXISTS `sp_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_user_info` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `simoperator` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '运营商ID',
  `simoperatorNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '运营商ID，0为没有，1为移动，2为联通，3为电信',
  `region` varchar(20) NOT NULL COMMENT '省份名称',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `city` varchar(20) NOT NULL COMMENT '城市名',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `time` int(10) unsigned NOT NULL COMMENT '注册时间戳',
  PRIMARY KEY (`uid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sp_view_region_log`
--

DROP TABLE IF EXISTS `sp_view_region_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_view_region_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `region` varchar(20) NOT NULL,
  `imsi` varchar(20) NOT NULL,
  `simoperator` tinyint(1) NOT NULL,
  `time` int(10) unsigned NOT NULL COMMENT '时间',
  PRIMARY KEY (`auto_id`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '接收的用户ID，如果是通发此值为0',
  `type` tinyint(4) NOT NULL COMMENT '公告类型，1为通发，2为对用户发',
  `title` char(50) NOT NULL COMMENT '公告标题',
  `content` text NOT NULL COMMENT '公告内容',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,0为未读，1为已读',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2402022 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_session`
--

DROP TABLE IF EXISTS `sys_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_session` (
  `session_id` varchar(255) NOT NULL,
  `session_expire` int(11) NOT NULL,
  `session_data` blob,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_id` (`session_id`) USING BTREE,
  KEY `session_expire` (`session_expire`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `talent`
--

DROP TABLE IF EXISTS `talent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '人才ID',
  `u_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `u_gender` mediumint(2) NOT NULL DEFAULT '1' COMMENT '性别，1男，2女',
  `u_age` mediumint(4) NOT NULL DEFAULT '0' COMMENT '年龄',
  `u_edu` mediumint(2) NOT NULL DEFAULT '0' COMMENT '学历',
  `u_school` varchar(20) NOT NULL DEFAULT '' COMMENT '毕业院校',
  `work_year` mediumint(3) NOT NULL DEFAULT '0' COMMENT '工作年限',
  `u_industry` varchar(100) NOT NULL DEFAULT '' COMMENT '从事行业',
  `u_professional` varchar(100) NOT NULL DEFAULT '' COMMENT '从事专业',
  `u_level` mediumint(2) DEFAULT '0' COMMENT '人才星级，1一星，2一星半，3二星，4二星半，以此类推,最高5星',
  `gt_user` varchar(10) NOT NULL DEFAULT '' COMMENT '沟通专员',
  `u_srouce` varchar(50) NOT NULL DEFAULT '' COMMENT '人才来源',
  `u_tel` varchar(11) NOT NULL DEFAULT '' COMMENT '人才联系电话',
  `u_qq` varchar(20) NOT NULL DEFAULT '' COMMENT '人才联系QQ',
  `work_experience` text NOT NULL COMMENT '工作履历，经验',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `gt_time` datetime NOT NULL COMMENT '最近沟通时间',
  `is_gt` mediumint(2) NOT NULL DEFAULT '2' COMMENT '是否沟通，1沟通，2未沟通',
  `is_rz` mediumint(2) NOT NULL DEFAULT '2' COMMENT '是否入职，1是，2否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态，1正常，2删除，3禁用',
  `u_zhuanye` varchar(50) NOT NULL DEFAULT '' COMMENT '学校专业',
  `u_evaluation` varchar(500) NOT NULL DEFAULT '' COMMENT '人才评价',
  `u_word_url` varchar(255) NOT NULL DEFAULT '' COMMENT '上传的word文件路径',
  `u_birthday` date NOT NULL DEFAULT '1970-01-01' COMMENT '出生年月日',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `talent_new`
--

DROP TABLE IF EXISTS `talent_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_new` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '人才ID',
  `talent_num` varchar(50) DEFAULT '' COMMENT '人才编号',
  `position_id` int(10) NOT NULL DEFAULT '0' COMMENT '职位ID',
  `u_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `gt_user` varchar(10) NOT NULL DEFAULT '' COMMENT '沟通专员',
  `gt_status` text NOT NULL COMMENT '沟通情况',
  `gt_time` datetime NOT NULL COMMENT '最近沟通时间',
  `is_gt` mediumint(2) NOT NULL DEFAULT '2' COMMENT '是否沟通，1沟通，2未沟通',
  `job_search_intention` text NOT NULL COMMENT '求职意向',
  `remarks` text NOT NULL COMMENT '备注',
  `u_word_url` varchar(255) NOT NULL DEFAULT '' COMMENT '上传的word文件路径',
  `status` mediumint(1) NOT NULL DEFAULT '1' COMMENT '记录状态，1正常，2删除，3禁用',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_info`
--

DROP TABLE IF EXISTS `test_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_info` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `stitle` varchar(100) NOT NULL COMMENT '测试结果标题',
  `desp` varchar(255) NOT NULL COMMENT '描述',
  `imgUrl` varchar(255) NOT NULL COMMENT '图片地址',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '参与人数',
  `status` tinyint(255) NOT NULL DEFAULT '0' COMMENT '状态，1为正常',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_info_data`
--

DROP TABLE IF EXISTS `test_info_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_info_data` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NOT NULL COMMENT '测试ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `desp` varchar(100) NOT NULL COMMENT '描述',
  `imgUrl` varchar(255) NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`auto_id`),
  KEY `test_id` (`test_id`)
) ENGINE=MyISAM AUTO_INCREMENT=448 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_domain`
--

DROP TABLE IF EXISTS `tg_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT '域名',
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `url` (`url`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_peizhi`
--

DROP TABLE IF EXISTS `tg_peizhi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_peizhi` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `c_uid` varchar(2000) DEFAULT NULL COMMENT '主渠道ID',
  `imgurl` varchar(600) DEFAULT NULL COMMENT '背景图',
  `add_date` datetime DEFAULT NULL COMMENT '添加日期',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `goto_domain` varchar(300) DEFAULT NULL COMMENT '跳转域名',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态: 1待审核 2正在推广 3禁用',
  `bgimg_md5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_user`
--

DROP TABLE IF EXISTS `tg_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `c_sid` int(11) NOT NULL COMMENT '所属子渠道ID',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别: 1男性 2女性',
  `username` varchar(200) DEFAULT NULL COMMENT '用户昵称',
  `province` varchar(100) DEFAULT NULL COMMENT '所在省份',
  `city` varchar(100) DEFAULT NULL COMMENT '所在城市',
  `age` int(3) DEFAULT NULL COMMENT '年龄',
  `openid` varchar(100) DEFAULT NULL COMMENT '微信id',
  `status` tinyint(1) DEFAULT NULL COMMENT '用户状态，1为正常，2为删除，5为禁用',
  `create_date` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `img_md5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `c_sid` (`c_sid`),
  UNIQUE KEY `openid` (`openid`)
) ENGINE=MyISAM AUTO_INCREMENT=2662 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_user_acount`
--

DROP TABLE IF EXISTS `tg_user_acount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_user_acount` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `user_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_user_income`
--

DROP TABLE IF EXISTS `tg_user_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_user_income` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `tg_money` decimal(11,2) DEFAULT NULL COMMENT '推广金额',
  `money_total` decimal(11,2) DEFAULT NULL COMMENT '总利润',
  `report_date` date DEFAULT '0000-00-00' COMMENT '日期',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '结算状态: 1未结算 2已结算',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tg_user_withdraw`
--

DROP TABLE IF EXISTS `tg_user_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_user_withdraw` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `money` decimal(11,2) DEFAULT NULL COMMENT '提现金额',
  `pay_type` tinyint(1) DEFAULT NULL COMMENT '提现方式： 2支付宝  3银行卡',
  `alipay_account` varchar(200) DEFAULT NULL COMMENT '支付宝账号',
  `accountname` varchar(200) DEFAULT NULL COMMENT '账户姓名',
  `accountnum` varchar(100) DEFAULT NULL COMMENT '卡号',
  `bank` varchar(50) DEFAULT NULL COMMENT '开户行',
  `name` varchar(100) DEFAULT NULL COMMENT '联系姓名',
  `mobile` varchar(50) DEFAULT NULL COMMENT '联系电话',
  `create_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '申请时间',
  `handing_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '处理时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态： 1未处理 2完成',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `pay_type` (`pay_type`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tree_url`
--

DROP TABLE IF EXISTS `tree_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tree_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `url` varchar(1000) NOT NULL DEFAULT '' COMMENT '跳转域名或落地页域名，落地页域名可以多个，多个用,分开',
  `type` int(2) NOT NULL DEFAULT '1' COMMENT '类型:  1落地页域名 2跳转域名',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常，2为是已停用，3是备用',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_ad`
--

DROP TABLE IF EXISTS `union_ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_ad` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告ID',
  `ad_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '广告类型，1为弹出界面，2为直接下载',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '广告名称',
  `imgUrl` varchar(200) DEFAULT NULL COMMENT '广告图片',
  `link` varchar(255) DEFAULT NULL COMMENT '广告链接，下载链接',
  `day_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '日限点击量',
  `pkg_name` varchar(100) DEFAULT NULL COMMENT 'apk包名',
  `weight` float NOT NULL DEFAULT '0' COMMENT '权重，1，2，3 数字越高，广告展现优先级越高，跑完高的才跑低的',
  `price` float NOT NULL DEFAULT '0' COMMENT '广告单价,指安装一个多少钱',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0，1 表示，用户如果本地已经有这个软件了是否还是要展现广告，可以通过我们的软件打开他们，0表示不需要，1表示需要，如果不需要此广告就不显示了',
  `create_time` datetime NOT NULL COMMENT '添加广告时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0为未启用，1为正常，2为删除，5为禁用',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`),
  KEY `ad_type` (`ad_type`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_ad_config`
--

DROP TABLE IF EXISTS `union_ad_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_ad_config` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tg_type` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT '推广包，0为缘分吧，1为恋恋',
  `channel_list` varchar(255) NOT NULL DEFAULT '' COMMENT '哪些渠道和版本号ID屏蔽,如果为空就是不屏蔽，格式版本号_推广主ID_推广子ID',
  PRIMARY KEY (`auto_id`),
  KEY `tg_type` (`tg_type`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_ad_report`
--

DROP TABLE IF EXISTS `union_ad_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_ad_report` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_date` date NOT NULL COMMENT '日期',
  `tg_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推广包，0为缘分吧，1为恋恋',
  `ad_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告ID',
  `ver` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '版本号',
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道主ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道子ID',
  `install_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装数',
  `click_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `ip_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击IP数',
  `cast_num` float(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '广告金额',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `report_date` (`report_date`,`ad_id`,`ver`,`c_uid`,`c_sid`,`tg_type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=110996 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_ad_report_all`
--

DROP TABLE IF EXISTS `union_ad_report_all`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_ad_report_all` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_date` date NOT NULL COMMENT '日期',
  `tg_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推广包，0为缘分吧，1为恋恋',
  `ad_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告ID',
  `install_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装数',
  `click_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `ip_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击IP数',
  `cast_num` float(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '广告金额',
  `income_num` float(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '收入广告金额',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `report_date` (`report_date`,`ad_id`,`tg_type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=227 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_check_uid`
--

DROP TABLE IF EXISTS `union_check_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_check_uid` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(400) NOT NULL DEFAULT '' COMMENT 'uid: 多个uid使用逗号隔开',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '注册数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_desk`
--

DROP TABLE IF EXISTS `union_desk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_desk` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '名称',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '图标',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '打开链接',
  `channel_list` text COMMENT '渠道列表,多个渠道用，分隔',
  `create_time` datetime NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1为正常，0为未开户，2为删除，5为禁用',
  PRIMARY KEY (`auto_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_notice`
--

DROP TABLE IF EXISTS `union_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(4) NOT NULL COMMENT '公告类型，1为活动公告，2为财务公告',
  `title` char(50) NOT NULL COMMENT '公告标题',
  `content` text NOT NULL COMMENT '公告内容',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '记录状态,1为置顶，默认为0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_report`
--

DROP TABLE IF EXISTS `union_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_report` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `regnum` int(11) NOT NULL DEFAULT '0' COMMENT '完成注册数',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '结算数',
  `price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '结算单价',
  `summoney` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '结算金额',
  `add_time` date NOT NULL COMMENT '日期',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态，1为已结算，0为默认',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid_2` (`uid`,`sid`,`add_time`),
  KEY `uid` (`uid`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM AUTO_INCREMENT=288575 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_report_tmp`
--

DROP TABLE IF EXISTS `union_report_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_report_tmp` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `regnum` int(11) NOT NULL DEFAULT '0' COMMENT '完成注册数',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '结算数',
  `day_money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '当日充值',
  `old_money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '老用户充值',
  `summoney` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '结算金额',
  `add_time` date DEFAULT NULL COMMENT '日期',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态，1为已结算，0为默认',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid_2` (`uid`,`sid`,`add_time`),
  KEY `uid` (`uid`),
  KEY `sid` (`sid`),
  KEY `add_time` (`add_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1423301 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_settlement`
--

DROP TABLE IF EXISTS `union_settlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_settlement` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道ID',
  `income` float NOT NULL DEFAULT '0' COMMENT '收入',
  `tax` float NOT NULL DEFAULT '0' COMMENT '税',
  `poundage` float NOT NULL DEFAULT '0' COMMENT '手续费',
  `realincome` float NOT NULL DEFAULT '0' COMMENT '实际收入',
  `paymoney` float NOT NULL DEFAULT '0' COMMENT '实际付款金额',
  `settlementtime` datetime NOT NULL COMMENT '结算时间',
  `paytime` datetime DEFAULT NULL COMMENT '支付时间',
  `payinfo` varchar(255) DEFAULT NULL COMMENT '支付备注',
  `paystatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付状态，0为结算，1为支付，2为累计下次',
  `starttime` date NOT NULL COMMENT '开始时间',
  `endtime` date NOT NULL COMMENT '结束时间',
  `settlementstatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为预付，2为周结，3为月结，4为日结',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`sid`,`starttime`,`endtime`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=38280 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_sid_content`
--

DROP TABLE IF EXISTS `union_sid_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_sid_content` (
  `id` int(11) NOT NULL COMMENT 'id',
  `content` varchar(2000) DEFAULT NULL COMMENT 'sid内容',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '上传状态： 1最新 2上次 ',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_uid_manage`
--

DROP TABLE IF EXISTS `union_uid_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_uid_manage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '公众号主ID',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_user`
--

DROP TABLE IF EXISTS `union_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `userpwd` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `ctype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型，0为没有类型，1大联盟媒体，2流量交换，3站长，4联盟渠道，5APP投放',
  `mode` tinyint(1) NOT NULL COMMENT '合作模式：1交换，2包月，3按注册，4点击，5展现，6免费，7包天，8下载，9CPS',
  `mediadesp` varchar(255) DEFAULT NULL COMMENT '合作媒体说明,合作信息,请填写您的软件名称或网站地址',
  `price` float(10,2) DEFAULT NULL COMMENT '单价',
  `paymode` tinyint(1) DEFAULT NULL COMMENT '支付方式，1为预付，2为周付，3为月付',
  `deduction` float(10,2) DEFAULT NULL COMMENT '扣量比例，扣40%就填写0.4',
  `tg_url` text COMMENT '推广链接',
  `tg_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '推广包，0为缘分吧，1为恋恋',
  `contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `QQ` varchar(20) DEFAULT NULL COMMENT '联系QQ',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系方式 ，手机或电话',
  `bd` varchar(50) DEFAULT NULL COMMENT '所属商务,直接写用户名',
  `bd_qq` varchar(20) DEFAULT NULL COMMENT '客服专员QQ',
  `bd_id` int(10) unsigned DEFAULT '0' COMMENT '所属商务ID',
  `paytype` tinyint(1) DEFAULT '2' COMMENT '财务对象,1为公司，2为个人',
  `payee` varchar(20) DEFAULT NULL COMMENT '收款人',
  `idcard` varchar(20) DEFAULT NULL COMMENT '身份证',
  `bankno` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `bankname` varchar(100) DEFAULT NULL COMMENT '开户银行支行详细地址',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `sourceid` int(10) unsigned DEFAULT '0' COMMENT '推广渠道来源',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态，1为正常，2为删除，5为禁用',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `ctype` (`ctype`),
  KEY `mode` (`mode`),
  KEY `tg_type` (`tg_type`)
) ENGINE=MyISAM AUTO_INCREMENT=15209 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_user_table`
--

DROP TABLE IF EXISTS `union_user_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_user_table` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `userpwd` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `userpwd_m` varchar(255) DEFAULT NULL COMMENT '用户明文密码',
  `mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '合作模式：1交换，2包月，3按注册，4点击，5展现，6免费，7包天，8下载，9CPS',
  `sid_list` varchar(2000) DEFAULT NULL COMMENT '多个关联ID',
  `contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `QQ` varchar(20) DEFAULT NULL COMMENT '联系QQ',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系方式 ，手机或电话',
  `bd` varchar(50) DEFAULT NULL COMMENT '所属商务,直接写用户名',
  `bd_qq` varchar(20) DEFAULT NULL COMMENT '客服专员QQ',
  `bd_id` int(10) unsigned DEFAULT '0' COMMENT '所属商务ID',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态，1为正常，2为删除，5为禁用',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  KEY `uid` (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `union_user_xx`
--

DROP TABLE IF EXISTS `union_user_xx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_user_xx` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '所属用户ID',
  `sid` int(11) NOT NULL COMMENT '渠道ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `userpwd` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `mediadesp` varchar(255) DEFAULT NULL COMMENT '合作媒体说明',
  `deduction` float(10,2) DEFAULT NULL COMMENT '扣量比例，扣40%就填写0.4,如果这个填了就按这个',
  `mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '合作模式：1交换，2包月，3按注册，4点击，5展现，6免费，7包天，8下载，9CPS',
  `tg_url` text COMMENT '推广链接',
  `packaging` tinyint(1) DEFAULT '0' COMMENT '已打包为1',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态，1为正常，2为删除，5为禁用',
  `qrcode` varchar(2000) NOT NULL DEFAULT '' COMMENT '推广二维码',
  `qrcode_url` varchar(255) NOT NULL DEFAULT '' COMMENT '微信url',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid_2` (`uid`,`sid`),
  UNIQUE KEY `username` (`username`),
  KEY `uid` (`uid`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM AUTO_INCREMENT=1574303 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(50) NOT NULL COMMENT '登录用户名,QQ：wwwqq_{uid},微博:wwwwb_{uid},邮箱:{email}',
  `cell_phone` bigint(22) DEFAULT NULL COMMENT '手机号',
  `password` char(40) NOT NULL COMMENT '用户密码',
  `password_m` char(6) DEFAULT NULL COMMENT '用户密码,明文密码，系统生成',
  `kf_id` int(11) NOT NULL COMMENT '客服ID',
  `group` tinyint(2) NOT NULL COMMENT '用户所在的组，1 普通用户 2 包月',
  `reg_time` int(11) unsigned NOT NULL COMMENT '注册时间',
  `login_time` int(11) unsigned NOT NULL COMMENT '登录时间',
  `login_count` int(4) NOT NULL COMMENT '登录次数',
  `online_time` int(11) DEFAULT '0' COMMENT '用户在线时长，分钟为单位',
  `offline_ts` int(11) DEFAULT NULL COMMENT '下线时间，服务会 20分钟发一次心跳包，更新这个字段',
  `reg_ip` char(20) NOT NULL COMMENT '注册IP',
  `login_ip` char(20) NOT NULL COMMENT '登录IP',
  `upgrade_start` int(10) unsigned NOT NULL COMMENT '会员开始时间',
  `upgrade_end` int(10) unsigned NOT NULL COMMENT '会员结束时间,当时间结束后，把group改成普通会员',
  `credit` int(10) NOT NULL DEFAULT '0' COMMENT '会员积分',
  `money` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '会员总充值金额',
  `charge_count` int(10) NOT NULL DEFAULT '0' COMMENT '充值总次数',
  `channel_uid` int(10) NOT NULL DEFAULT '0' COMMENT '推广渠道主ID',
  `channel_sid` int(10) NOT NULL DEFAULT '0' COMMENT '推广渠道子ID',
  `openid` char(32) DEFAULT NULL COMMENT 'QQ登录openid',
  `token` char(32) DEFAULT NULL COMMENT '微博登录token',
  `user_client_type` tinyint(1) NOT NULL COMMENT '1为web\\r\\n2为android\\r\\n3为iphone\\r\\n4为PC端',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐，1为推荐，0为默认',
  `say_hi_recommended` tinyint(1) DEFAULT '2' COMMENT '打招呼推荐人',
  `isvip` tinyint(1) DEFAULT '0' COMMENT 'vip,1为vip',
  `vip_start` int(11) unsigned DEFAULT NULL COMMENT 'vip开始时间',
  `vip_end` int(11) unsigned DEFAULT NULL COMMENT 'vip结束时间',
  `ycoin` int(11) NOT NULL DEFAULT '0' COMMENT 'Y币',
  `real_reg_time` datetime DEFAULT NULL COMMENT '真实注册时间（选择性别的时间）',
  `create_time` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态，1为正常，2为删除，5为禁用',
  `is_bind_roes` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否绑定红娘',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `cell_phone` (`cell_phone`),
  KEY `uid` (`uid`),
  KEY `isvip` (`isvip`),
  KEY `login_time` (`login_time`),
  KEY `kf_id` (`kf_id`),
  KEY `group` (`group`) USING BTREE,
  KEY `channel_uid` (`channel_uid`) USING BTREE,
  KEY `channel_sid` (`channel_sid`) USING BTREE,
  KEY `say_hi_recommended` (`say_hi_recommended`),
  KEY `reg_time` (`reg_time`) USING BTREE,
  KEY `uid_2` (`channel_uid`,`channel_sid`,`reg_time`,`uid`) USING BTREE,
  KEY `uid_3` (`channel_uid`,`status`,`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=136218937 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_address` (
  `uid` int(11) unsigned NOT NULL,
  `phone` bigint(13) NOT NULL,
  `province` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `authid` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方authid',
  PRIMARY KEY (`id`),
  UNIQUE KEY `authid` (`authid`) USING BTREE,
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=3034895 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_avatar_verify`
--

DROP TABLE IF EXISTS `user_avatar_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_avatar_verify` (
  `auto_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '图片url',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `sex_result` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '色情识别结果 -1 表示无结果 0：色情； 1：性感； 2：正常',
  `sex_rate` float NOT NULL DEFAULT '0',
  `sex_review` tinyint(4) NOT NULL DEFAULT '0' COMMENT '色情需要回查 0不需要 1 需要',
  `ad_result` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '0：正常； 1：二维码|条形码； 2：带文字图片；',
  `ad_rate` float NOT NULL DEFAULT '0',
  `ad_review` tinyint(4) NOT NULL DEFAULT '0',
  `face_result` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：男人； 1：女人； 2：其他； 3：多人',
  `face_rate` float NOT NULL,
  `face_review` tinyint(4) NOT NULL DEFAULT '0',
  `beauti_result` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '0：好看； 1：普通； 2：难看； 3：其他',
  `beauti_rate` float NOT NULL DEFAULT '0' COMMENT '好看的百分比 结果为好看时（ 大于0.95为非常好看 小于为好看）',
  `beauti_review` tinyint(4) NOT NULL,
  `review_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '复审状态 0不需要复审已通过 1不需要复审已拒绝 2 需要复审还未复审 3 已复审 4 已忽略',
  `tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数据生成时间',
  `review_result` tinyint(4) NOT NULL DEFAULT '0' COMMENT '复审结果',
  `review_tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复审时间',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`url`),
  KEY `url` (`url`),
  KEY `review_status` (`review_status`)
) ENGINE=MyISAM AUTO_INCREMENT=27801466 DEFAULT CHARSET=utf8 COMMENT='头像机器审核结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_avatar_verify_status`
--

DROP TABLE IF EXISTS `user_avatar_verify_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_avatar_verify_status` (
  `uid` int(10) unsigned NOT NULL,
  `verify_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '关联user_avatar_verify 的主键',
  `verify_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1机器审核通过 2机器审核拒绝',
  `rstatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 待人工检验 1 已检验通过 2 已修改结果',
  `tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间 unix时间戳',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户头像审核状态';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_bribery`
--

DROP TABLE IF EXISTS `user_bribery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_bribery` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `from_uid` int(11) NOT NULL DEFAULT '0' COMMENT '充值用户UID',
  `charge_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '充值成功时间',
  `charge_money` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `base_bribery` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '基础红包',
  `rand_bribery` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '随机红包,上小时的总充值3%，上小时得红包人数做基数',
  `add_hour` int(11) NOT NULL DEFAULT '0' COMMENT '小时',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '获得红包时间',
  `status` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '-1未拆开（领取）,0为已拆（领取）未提现，1为已提现',
  PRIMARY KEY (`auto_id`),
  KEY `add_time` (`add_time`),
  KEY `uid` (`uid`),
  KEY `add_hour` (`add_hour`),
  KEY `status` (`status`),
  KEY `uid_stat` (`uid`,`status`),
  KEY `from_uid` (`from_uid`)
) ENGINE=MyISAM AUTO_INCREMENT=493150 DEFAULT CHARSET=utf8 COMMENT='红包记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_bribery_receive`
--

DROP TABLE IF EXISTS `user_bribery_receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_bribery_receive` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户UID',
  `receive_money` float NOT NULL DEFAULT '0' COMMENT '提现金额，大于50才能提现',
  `receive_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提现时间',
  `op_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '操作时间',
  `bribery_ids` varchar(2000) NOT NULL DEFAULT '' COMMENT 'user_bribery表的auto_id,多个用","分隔',
  `memo` varchar(500) NOT NULL DEFAULT '' COMMENT '操作说明',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0为未发放，1为已发放',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `receive_time` (`receive_time`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_broadcast`
--

DROP TABLE IF EXISTS `user_broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_broadcast` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `b_context` varchar(255) NOT NULL COMMENT '广播内容',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_complain`
--

DROP TABLE IF EXISTS `user_complain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_complain` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉ID',
  `from_uid` int(11) NOT NULL COMMENT '投诉人ID',
  `to_uid` int(11) NOT NULL COMMENT '被投诉人ID',
  `content` text NOT NULL COMMENT '投诉内容',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '投诉时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '处理状态 1未处理 2封号',
  PRIMARY KEY (`id`),
  KEY `to_id` (`to_uid`,`create_time`) USING BTREE,
  KEY `from_uid` (`from_uid`,`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_credit`
--

DROP TABLE IF EXISTS `user_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `credit` int(8) NOT NULL COMMENT '总积分',
  `bag` int(8) DEFAULT NULL COMMENT '口袋临时积分',
  `group` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_detail` (
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `nickname` char(20) NOT NULL COMMENT '昵称',
  `avatar` char(100) NOT NULL COMMENT '头像',
  `avatar_big` varchar(100) NOT NULL COMMENT '大头像',
  `avatarstatus` tinyint(1) NOT NULL DEFAULT '3' COMMENT '头像状态，0为未审核，1为通过，2为拒绝,3未上传',
  `avatar_refuse_reason` int(11) DEFAULT NULL,
  `gender` mediumint(2) NOT NULL COMMENT '性别,1为男性，2为女性',
  `province` mediumint(2) NOT NULL COMMENT '所在省',
  `city` mediumint(4) NOT NULL COMMENT '所在市',
  `birthday` date NOT NULL COMMENT '生日',
  `age` mediumint(3) NOT NULL COMMENT '年龄',
  `height` mediumint(3) NOT NULL COMMENT '身高',
  `weight` mediumint(3) NOT NULL COMMENT '体重',
  `star` mediumint(2) NOT NULL COMMENT '星座',
  `blood` mediumint(2) NOT NULL COMMENT '血型',
  `character` char(20) NOT NULL COMMENT '性格特征',
  `superiority` char(20) NOT NULL COMMENT '个人优势',
  `interest` char(20) NOT NULL COMMENT '兴趣爱好',
  `drinking` tinyint(1) NOT NULL COMMENT '饮酒习惯',
  `smoke` tinyint(1) NOT NULL COMMENT '是否吸烟',
  `edu` mediumint(2) NOT NULL COMMENT '学历',
  `job` mediumint(2) NOT NULL COMMENT '职业',
  `income` mediumint(5) NOT NULL COMMENT '收入',
  `house` mediumint(2) NOT NULL COMMENT '住宿条件',
  `marry` mediumint(2) NOT NULL DEFAULT '0' COMMENT '婚姻状况',
  `datingfor` char(10) NOT NULL COMMENT '交友意向',
  `concept` char(20) NOT NULL COMMENT '情性观念',
  `favplace` char(20) NOT NULL COMMENT '喜欢的幽会地点',
  `aboutme` text NOT NULL COMMENT '自我介绍,内心读白',
  `sayhello` varchar(255) DEFAULT NULL COMMENT '打招呼内容',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ',
  `qq_auth` tinyint(1) NOT NULL DEFAULT '0',
  `tel` varchar(12) NOT NULL COMMENT '电话',
  `mobile` varchar(11) NOT NULL COMMENT '手机',
  `mobile_auth` tinyint(1) NOT NULL DEFAULT '0',
  `mobile_validation` tinyint(1) NOT NULL DEFAULT '0' COMMENT '手机是否已验证',
  `email` char(30) NOT NULL COMMENT 'email',
  `email_validation` tinyint(1) NOT NULL DEFAULT '0' COMMENT '邮箱是否验证',
  `wechat` char(50) DEFAULT NULL COMMENT '微信号',
  `wechat_validation` tinyint(1) NOT NULL DEFAULT '0' COMMENT '微信认证，0为默认，1为已认证，2为拒绝',
  `realname` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `Idcard` varchar(255) DEFAULT NULL COMMENT '上传身份证照片',
  `Idcard_validation` tinyint(1) NOT NULL DEFAULT '0' COMMENT '身份证验证',
  `status` mediumint(2) NOT NULL DEFAULT '0' COMMENT '信息填写完成状态，完成几项就填写几',
  `complete` mediumint(3) NOT NULL DEFAULT '0' COMMENT '完成状态，完成几项就填写几',
  `hits` int(6) NOT NULL DEFAULT '0' COMMENT '被浏览次数',
  `looknums` int(11) NOT NULL COMMENT '已查看用户信息数',
  `updatetime` int(10) NOT NULL COMMENT '更新时间',
  `x` double(255,6) DEFAULT NULL COMMENT '纬度',
  `y` double(255,6) DEFAULT NULL COMMENT '经度',
  `photoNum` int(11) NOT NULL DEFAULT '0' COMMENT '相册数量(已审核)',
  `photoNum1` int(11) DEFAULT '0' COMMENT '上传头像数量（不包含拒绝的数量，即新上传未审核 + 通过的）',
  `real_sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户真实性别，1为男性，2为女性',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `wechat_auth` int(11) NOT NULL DEFAULT '0' COMMENT '其他人查看微信权限',
  `hot` int(11) NOT NULL DEFAULT '0',
  `ver` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '版本号',
  PRIMARY KEY (`uid`),
  KEY `city` (`city`),
  KEY `hits` (`hits`),
  KEY `x` (`x`,`y`),
  KEY `photoNum` (`photoNum`) USING BTREE,
  KEY `age` (`uid`) USING BTREE,
  KEY `age_2` (`age`),
  KEY `photoNum1` (`photoNum1`),
  KEY `mobile` (`mobile`,`mobile_validation`),
  KEY `update_time` (`update_time`),
  KEY `height` (`height`),
  KEY `create_time` (`create_time`),
  KEY `avatar` (`avatar`),
  KEY `nickname` (`nickname`),
  KEY `ver` (`ver`),
  KEY `gender` (`gender`) USING BTREE,
  KEY `avatarstatus` (`avatarstatus`) USING BTREE,
  KEY `province` (`province`) USING BTREE,
  KEY `ga2` (`province`,`gender`,`avatarstatus`,`uid`) USING BTREE,
  KEY `ga3` (`avatarstatus`,`gender`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_follow` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL COMMENT '关注用户ID',
  `to_uid` int(11) NOT NULL COMMENT '被关注用户ID',
  `follow_time` datetime NOT NULL COMMENT '关注时间',
  `follow_ip` varchar(15) NOT NULL COMMENT '关注IP',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为单方关注，1为双方关注',
  `view_time` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `follow` (`from_uid`,`to_uid`) USING BTREE,
  KEY `to_uid` (`to_uid`,`view_time`),
  KEY `to_uid_2` (`to_uid`),
  KEY `from_uid` (`from_uid`),
  KEY `to_uid_3` (`to_uid`),
  KEY `from_uid_2` (`from_uid`)
) ENGINE=MyISAM AUTO_INCREMENT=296096 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_gamekf_os`
--

DROP TABLE IF EXISTS `user_gamekf_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_gamekf_os` (
  `uid` int(10) unsigned NOT NULL,
  `wechat_os` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '微信账号的手机型号 0是其他，2为安卓，3为IOS 10 为APP',
  `game_kf_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏引导客服ID',
  `tm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`uid`),
  KEY `kf` (`wechat_os`,`game_kf_id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `groupid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组ID',
  `name` char(20) NOT NULL COMMENT '组名',
  `allowsendmessage` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '免费发私信',
  `allowvisit` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '免费看信',
  `allowmessagetop` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '私信消息置顶',
  `allowindexshow` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '更多首页展示机会',
  `allowsearchshow` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '更多搜索展示机会',
  `allowbroadcast` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '消息广播',
  `allowviewnums` mediumint(4) unsigned NOT NULL DEFAULT '6' COMMENT '查看访客数，不限填写99999',
  `price_y` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '年费',
  `price_3m` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '3个月费',
  `price_1m` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '一个月费',
  `description` mediumtext NOT NULL COMMENT '描述',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`groupid`),
  KEY `disabled` (`disabled`),
  KEY `listorder` (`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_heart`
--

DROP TABLE IF EXISTS `user_heart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_heart` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `imgUrl` varchar(255) NOT NULL COMMENT '照片链接',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，1为已审核，5为禁用，2为删除',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户发布心动列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_help_list`
--

DROP TABLE IF EXISTS `user_help_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_help_list` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别，1为男，2为女',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省份',
  `promise` char(50) NOT NULL COMMENT '承诺',
  `pub_time` int(10) unsigned NOT NULL COMMENT '发助力时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，为1的正常显示，0为助力墙不显示',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`) USING HASH,
  KEY `pub_time` (`pub_time`),
  KEY `gender` (`gender`),
  KEY `status` (`status`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_help_new_list`
--

DROP TABLE IF EXISTS `user_help_new_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_help_new_list` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `prizeid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `pub_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发助力时间',
  `pub_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布日期',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`,`prizeid`,`pub_date`),
  KEY `pub_time` (`pub_time`) USING BTREE,
  KEY `prizeid` (`prizeid`,`pub_date`)
) ENGINE=MyISAM AUTO_INCREMENT=1949969 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ip_ban`
--

DROP TABLE IF EXISTS `user_ip_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ip_ban` (
  `ip` varchar(30) NOT NULL,
  `tm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_kuplay`
--

DROP TABLE IF EXISTS `user_kuplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_kuplay` (
  `uid` int(11) unsigned NOT NULL,
  `kuplay_id` int(11) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `create_time` (`create_time`),
  KEY `kuplay` (`kuplay_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21721 DEFAULT CHARSET=utf8 COMMENT='直播用户关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_lang`
--

DROP TABLE IF EXISTS `user_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_lang` (
  `uid` int(10) unsigned NOT NULL,
  `lang` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户语言 默认为0中文 1为英文(美国)',
  PRIMARY KEY (`uid`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户语言和直播情况';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_login_log`
--

DROP TABLE IF EXISTS `user_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `login_type` tinyint(4) NOT NULL COMMENT '登录类型，1为web，2为android,3为iphone,4为PC端',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(15) NOT NULL COMMENT '登录IP',
  `login_result` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 为成功，2 为失败',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=75820132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_men_avatar`
--

DROP TABLE IF EXISTS `user_men_avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_men_avatar` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `scanstat` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未看过 1已看过',
  `tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '记录更新的unix时间戳',
  PRIMARY KEY (`uid`),
  KEY `tm` (`tm`),
  KEY `scanstat` (`scanstat`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='男用户后台审核扫描表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message`
--

DROP TABLE IF EXISTS `user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message` (
  `auto_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_id` int(11) NOT NULL COMMENT '发送用户ID',
  `to_id` int(11) NOT NULL COMMENT '接收用户ID',
  `m_title` char(100) NOT NULL COMMENT '发送的标题',
  `m_content` text NOT NULL COMMENT '发送的内容',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，1为打招呼，2为回信',
  `msg_id` int(11) DEFAULT '0' COMMENT '消息ID，对应 msg_tpl',
  `from` varchar(255) DEFAULT NULL COMMENT '从哪里打招呼的',
  `view_time` datetime DEFAULT NULL,
  `msg_ver` int(11) DEFAULT '0' COMMENT '消息版本，0 是真实招呼，1 为招呼消息固定',
  `create_time` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '状态，0为未读，1为已读',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`auto_id`),
  KEY `to` (`to_id`),
  KEY `from` (`from_id`),
  KEY `status` (`status`),
  KEY `create_time` (`create_time`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message_count`
--

DROP TABLE IF EXISTS `user_message_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message_count` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL COMMENT '发送用户ID',
  `to_uid` int(11) NOT NULL COMMENT '接收用户ID',
  `unreadnums` int(11) NOT NULL DEFAULT '0' COMMENT '未读条数',
  `readnums` int(11) NOT NULL DEFAULT '0' COMMENT '已读条数',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `visit` (`from_uid`,`to_uid`) USING BTREE,
  KEY `status` (`status`),
  KEY `unreadnums` (`unreadnums`,`readnums`),
  KEY `to_uid` (`to_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message_fail`
--

DROP TABLE IF EXISTS `user_message_fail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message_fail` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `content` text NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '时间',
  `status` tinyint(255) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1为正常，2为禁用',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `auto_id` (`auto_id`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=276495 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message_failed`
--

DROP TABLE IF EXISTS `user_message_failed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message_failed` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) DEFAULT NULL,
  `to_uid` int(11) DEFAULT NULL,
  `msg` text,
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '记录更新时间',
  `remove_time` datetime DEFAULT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22509 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message_female`
--

DROP TABLE IF EXISTS `user_message_female`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message_female` (
  `auto_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_id` int(11) NOT NULL COMMENT '发送用户ID',
  `to_id` int(11) NOT NULL COMMENT '接收用户ID',
  `m_content` text NOT NULL COMMENT '发送的内容',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，3为打招呼，2为回信',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`auto_id`),
  KEY `to` (`to_id`),
  KEY `from` (`from_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_msg_support`
--

DROP TABLE IF EXISTS `user_msg_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_msg_support` (
  `uid` int(10) unsigned NOT NULL,
  `support` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '支持的消息模板 1为支持语音',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户能支持的消息模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_nickname`
--

DROP TABLE IF EXISTS `user_nickname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_nickname` (
  `auto_id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` char(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `gender` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别，1为男，2为女',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `nickname` (`nickname`),
  KEY `gender` (`gender`)
) ENGINE=MyISAM AUTO_INCREMENT=2086 DEFAULT CHARSET=utf8 COMMENT='用户昵称收集表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_nickname_modify`
--

DROP TABLE IF EXISTS `user_nickname_modify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_nickname_modify` (
  `uid` int(10) unsigned NOT NULL,
  `nickname` char(20) NOT NULL DEFAULT '' COMMENT '用户设置昵称',
  `r_nickname` char(20) NOT NULL DEFAULT '' COMMENT '上一次通过过的昵称',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为未审核，1为审核，审核通过后就往user_detail 表里写,2为拒绝，通过后再拒绝要把user_detail表里的nickname用r_nickname换了',
  `refuse_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '拒绝原因',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid` (`uid`),
  KEY `add_time` (`add_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户设置昵称，待审核的';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_online`
--

DROP TABLE IF EXISTS `user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online` (
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `time` int(11) unsigned NOT NULL COMMENT '最后访问时间+20分种',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`),
  KEY `time` (`time`) USING BTREE
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_online_client`
--

DROP TABLE IF EXISTS `user_online_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online_client` (
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `time` int(11) unsigned NOT NULL COMMENT '最后访问时间+20分种',
  PRIMARY KEY (`uid`),
  KEY `time` (`time`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `time_2` (`time`,`uid`) USING BTREE
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_online_wechat`
--

DROP TABLE IF EXISTS `user_online_wechat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online_wechat` (
  `uid` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`) USING HASH,
  KEY `time` (`time`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='微信用户在线';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_orders`
--

DROP TABLE IF EXISTS `user_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_orders` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `o_id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `g_id` int(10) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `g_title` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `g_price` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `paynum` tinyint(3) NOT NULL DEFAULT '0' COMMENT '购买数量',
  `contact` varchar(10) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `courier_company` varchar(50) NOT NULL DEFAULT '' COMMENT '快递公司',
  `courier_num` varchar(100) NOT NULL DEFAULT '' COMMENT '快递单号',
  `order_note` varchar(500) NOT NULL DEFAULT '' COMMENT '用户备注',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订单状态，1待付款，2待发货，3待收货，4已完成',
  `create_time` datetime NOT NULL DEFAULT '2016-10-01 00:00:00' COMMENT '创建时间',
  `fh_time` datetime NOT NULL DEFAULT '2016-10-01 00:00:00' COMMENT '发货时间',
  PRIMARY KEY (`auto_id`),
  KEY `o_id` (`o_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_os`
--

DROP TABLE IF EXISTS `user_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_os` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `os` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作系统 安卓默认为0, 1为小米 ，2为华为,3为IOS,5为微信',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`) USING HASH,
  KEY `os` (`os`) USING HASH
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户的操作系统';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_photo_album`
--

DROP TABLE IF EXISTS `user_photo_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_photo_album` (
  `albumid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册ID',
  `albumname` varchar(50) NOT NULL DEFAULT '' COMMENT '相册名字',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属用户ID',
  `pic` varchar(100) NOT NULL DEFAULT '' COMMENT '图片链接',
  `picdesc` text NOT NULL COMMENT '图片描述',
  `viewtimes` mediumint(8) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0为未审核，1为正常，2为冻结',
  PRIMARY KEY (`albumid`),
  KEY `uid` (`uid`,`addtime`),
  KEY `addtime` (`addtime`) USING BTREE,
  KEY `uid_2` (`uid`),
  KEY `status` (`status`),
  KEY `uid_3` (`uid`,`status`),
  KEY `viewtimes` (`viewtimes`)
) ENGINE=MyISAM AUTO_INCREMENT=8951271 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_photo_album_verify`
--

DROP TABLE IF EXISTS `user_photo_album_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_photo_album_verify` (
  `albumid` int(10) unsigned NOT NULL,
  `sex_result` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '色情识别结果 -1 表示无结果 0：色情； 1：性感； 2：正常',
  `sex_rate` float NOT NULL DEFAULT '0',
  `sex_review` tinyint(4) NOT NULL DEFAULT '0' COMMENT '色情需要回查 0不需要 1 需要',
  `tm` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`albumid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片机器审核结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_pkgname`
--

DROP TABLE IF EXISTS `user_pkgname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_pkgname` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `pkgname` varchar(50) NOT NULL COMMENT '包名',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_precious_log`
--

DROP TABLE IF EXISTS `user_precious_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_precious_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `pid` int(11) NOT NULL COMMENT '宝藏ID',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未处理 1已经处理',
  `gender` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1男2女',
  `deliver_date` int(11) DEFAULT NULL COMMENT '发货时间',
  `deliver_no` varchar(25) DEFAULT NULL COMMENT '发货单号',
  `deliver_com` varchar(25) DEFAULT NULL COMMENT '快递公司',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1313412 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_require`
--

DROP TABLE IF EXISTS `user_require`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_require` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `rq_marry` mediumint(2) NOT NULL COMMENT '对方婚姻状态',
  `rq_age_min` mediumint(3) NOT NULL COMMENT '对方年龄开始',
  `rq_age_max` mediumint(3) NOT NULL,
  `rq_province` mediumint(2) NOT NULL COMMENT '对方地区',
  `rq_city` mediumint(2) NOT NULL COMMENT '对方地区',
  `rq_edu` mediumint(2) NOT NULL COMMENT '对方学历',
  `rq_income` mediumint(5) NOT NULL COMMENT '对方收入',
  `rq_height_min` mediumint(3) NOT NULL COMMENT '对方身高开始',
  `rq_height_max` mediumint(3) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_rose`
--

DROP TABLE IF EXISTS `user_rose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_rose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `roseid` int(11) NOT NULL,
  `bind_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_2` (`uid`,`roseid`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `roseid` (`roseid`),
  KEY `bind_time` (`bind_time`)
) ENGINE=MyISAM AUTO_INCREMENT=10740 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sayHi`
--

DROP TABLE IF EXISTS `user_sayHi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sayHi` (
  `uid` int(10) unsigned NOT NULL,
  `sayHi` varchar(50) NOT NULL DEFAULT '' COMMENT '打招呼语句',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为未审核，1为审核，审核通过后就往user_detail 表里写,2为拒绝',
  `refuse_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '拒绝原因',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid` (`uid`),
  KEY `add_time` (`add_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户设置打招呼语句，待审核的';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sayHi_config`
--

DROP TABLE IF EXISTS `user_sayHi_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sayHi_config` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sayHi` varchar(50) NOT NULL DEFAULT '' COMMENT '打招呼语句',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '性别，1为男性，2为女性',
  PRIMARY KEY (`auto_id`),
  KEY `gender` (`gender`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='打招呼语句配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_smspush_list`
--

DROP TABLE IF EXISTS `user_smspush_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_smspush_list` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `phone` varchar(20) NOT NULL DEFAULT '0' COMMENT '手机号',
  `regtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间加3个小时',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0为未推送，1为已推送用户',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为正常，2为退订用户',
  PRIMARY KEY (`uid`),
  KEY `regtime` (`regtime`,`flag`,`status`) USING BTREE,
  KEY `phone` (`phone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='短信推送用户列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_test`
--

DROP TABLE IF EXISTS `user_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_test` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `flag` int(11) DEFAULT '1' COMMENT '标志位',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_test_20170606`
--

DROP TABLE IF EXISTS `user_test_20170606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_test_20170606` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `flag` int(11) DEFAULT '1' COMMENT '标志位',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_three`
--

DROP TABLE IF EXISTS `user_three`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_three` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `wxid` varchar(50) DEFAULT NULL COMMENT '微信对应openid',
  `qqid` varchar(50) DEFAULT NULL COMMENT 'QQ对应openid',
  PRIMARY KEY (`uid`),
  KEY `wxid` (`wxid`) USING BTREE,
  KEY `qqid` (`qqid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_validation`
--

DROP TABLE IF EXISTS `user_validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_validation` (
  `uid` int(11) NOT NULL COMMENT 'UID',
  `id_num` varchar(30) NOT NULL DEFAULT '' COMMENT '身份证号码',
  `id_front_img` varchar(255) NOT NULL DEFAULT '' COMMENT '身份证正面照',
  `id_back_img` varchar(255) NOT NULL DEFAULT '' COMMENT '身份证背面照',
  `face_img` varchar(255) NOT NULL DEFAULT '' COMMENT '手持身份证照',
  `paytype` tinyint(1) NOT NULL DEFAULT '2' COMMENT '类型 1银行卡 2支付宝',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '认证状态  1 待审核 2 审核通过 3审核不通过 4打回',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `reason` varchar(255) DEFAULT '' COMMENT '拒绝原因',
  PRIMARY KEY (`uid`),
  KEY `paytype` (`paytype`),
  KEY `status` (`status`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_video`
--

DROP TABLE IF EXISTS `user_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_video` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '视频名称',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户UID',
  `video` varchar(255) NOT NULL DEFAULT '' COMMENT '视频地址',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `duration` int(5) NOT NULL COMMENT '时长 秒',
  `viewtimes` int(11) NOT NULL DEFAULT '0' COMMENT '播放次数',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '视频描述',
  `cost` int(10) NOT NULL DEFAULT '0' COMMENT '花费 钻石',
  `giftid` int(5) NOT NULL DEFAULT '0' COMMENT '所需礼物id',
  `giftnum` int(5) NOT NULL DEFAULT '0' COMMENT '所需礼物数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1禁用',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1600 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_visitors`
--

DROP TABLE IF EXISTS `user_visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_visitors` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `visit_uid` int(11) NOT NULL COMMENT '访客用户ID',
  `uid` int(11) NOT NULL COMMENT '被访用户ID',
  `visit_time` datetime NOT NULL COMMENT '访问时间',
  `visit_ip` varchar(15) NOT NULL COMMENT '访问IP',
  `view_time` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  `visit_avatarstatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '访问者的头像状态',
  PRIMARY KEY (`auto_id`),
  KEY `visit` (`visit_uid`,`uid`) USING BTREE,
  KEY `uid` (`uid`),
  KEY `uid_2` (`uid`,`view_time`),
  KEY `create_time` (`create_time`),
  KEY `create_time_2` (`create_time`),
  KEY `visit_avatarstatus` (`visit_avatarstatus`)
) ENGINE=MyISAM AUTO_INCREMENT=1314616 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wechat`
--

DROP TABLE IF EXISTS `user_wechat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_wechat` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `openid` varchar(50) NOT NULL COMMENT '微信对应openid',
  `country` varchar(20) DEFAULT '' COMMENT '国家',
  `province` varchar(20) DEFAULT '' COMMENT '省份',
  `city` varchar(20) DEFAULT '' COMMENT '城市',
  `isSubscribe` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否关注，1为关注',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `openid` (`openid`) USING HASH
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wechat_list`
--

DROP TABLE IF EXISTS `user_wechat_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_wechat_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `openid` varchar(50) NOT NULL COMMENT '微信对应openid',
  `tm` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后操作时间+47小时',
  `wap` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'wap类型，如wap2对应2，0为没有的时候',
  PRIMARY KEY (`id`),
  UNIQUE KEY `openid` (`openid`),
  KEY `tm` (`tm`),
  KEY `wap` (`tm`,`wap`,`openid`)
) ENGINE=MyISAM AUTO_INCREMENT=71535377 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wechat_os`
--

DROP TABLE IF EXISTS `user_wechat_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_wechat_os` (
  `uid` int(10) unsigned NOT NULL,
  `wechat_os` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '微信账号的手机型号 0是其他，2为安卓，3为IOS 10 为APP',
  `game_kf_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏引导客服ID',
  `tm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`uid`),
  KEY `kf` (`wechat_os`,`game_kf_id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wechat_scan`
--

DROP TABLE IF EXISTS `user_wechat_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_wechat_scan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `openid` varchar(50) NOT NULL COMMENT '微信对应openid',
  `sid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `tm` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '扫描时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `openid` (`openid`),
  KEY `tm` (`tm`)
) ENGINE=MyISAM AUTO_INCREMENT=62653723 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wish`
--

DROP TABLE IF EXISTS `user_wish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_wish` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT '心愿ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `credit` int(11) DEFAULT NULL COMMENT '用户积分',
  `url` char(200) NOT NULL COMMENT '心愿url',
  `name` varchar(200) DEFAULT NULL COMMENT '心愿名称',
  `price` decimal(8,2) DEFAULT NULL COMMENT '心愿价格',
  `checked` tinyint(1) unsigned DEFAULT '0' COMMENT '审核状态0未审核1审核通过2审核未通过',
  `reason` tinyint(1) unsigned DEFAULT NULL COMMENT '拒绝原因1商品链接失效 2 商品售罄 3非指定网',
  `close` tinyint(1) unsigned DEFAULT '0' COMMENT '关闭心愿0打开1关闭',
  `complete` tinyint(1) unsigned DEFAULT '0' COMMENT '是否完成0未完成1完成2取消',
  `website` tinyint(1) unsigned DEFAULT NULL COMMENT '来源网站类别',
  `o_id` varchar(50) DEFAULT NULL COMMENT '订单号',
  `g_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `contact` varchar(10) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `courier_company` varchar(50) DEFAULT NULL,
  `courier_num` varchar(100) DEFAULT NULL COMMENT '快递单号',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '订单状态，1待付款，2待发货，3待收货，4已完成',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`wid`),
  KEY `uid` (`uid`,`complete`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_yan_tmp`
--

DROP TABLE IF EXISTS `user_yan_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_yan_tmp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT 'uid',
  `avatar` varchar(200) NOT NULL DEFAULT '' COMMENT '头像',
  `BeautiResult` int(11) NOT NULL DEFAULT '0' COMMENT '颜值结果 0：好看； 1：普通； 2：难看； 3：其他',
  `BeautiRate` float NOT NULL DEFAULT '0' COMMENT '//颜值几率',
  `BeautiReview` int(11) NOT NULL DEFAULT '0' COMMENT '颜值是否需要人工复审 1为需要人工复核',
  `tm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `FaceResult` int(11) NOT NULL DEFAULT '0' COMMENT '颜值结果 1：普通； 4：好看； 5：非常好看',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4731 DEFAULT CHARSET=utf8 COMMENT='颜值校验临时表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ycoin_log`
--

DROP TABLE IF EXISTS `user_ycoin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ycoin_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `type` int(11) NOT NULL COMMENT 'YB类型，对应info_config ybType类型 1为充值，2为赠送,3为获取,4为消费',
  `coin` int(11) NOT NULL COMMENT 'Yb数，消费时为负值',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态,1为成功，3为没有Y币，4是余额不足',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=163776917 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '视频ID',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '视频类型，1为自拍，2为美女，3为高校',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '视频标题',
  `stitle` varchar(100) NOT NULL DEFAULT '' COMMENT '视频描述',
  `bigpic` varchar(255) NOT NULL COMMENT '首页大图',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '视频图片',
  `url` varchar(20) NOT NULL DEFAULT '' COMMENT '视频播放地址ID,如：XNTMwNzU2NTMy',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0为默认，1为推荐',
  `isBig` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为首页大图，1为是，0为默认',
  `times` varchar(20) NOT NULL COMMENT '播放时长',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`),
  KEY `flag` (`flag`),
  KEY `isBig` (`isBig`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_formal`
--

DROP TABLE IF EXISTS `video_formal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_formal` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '视频ID',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '视频类型，1为自拍，2为美女，3为高校',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '视频标题',
  `stitle` varchar(100) NOT NULL DEFAULT '' COMMENT '视频描述',
  `bigpic` varchar(255) NOT NULL COMMENT '首页大图',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '视频图片',
  `url` varchar(20) NOT NULL DEFAULT '' COMMENT '视频播放地址ID,如：XNTMwNzU2NTMy',
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0为默认，1为推荐',
  `isBig` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为首页大图，1为是，0为默认',
  `times` varchar(20) NOT NULL COMMENT '播放时长',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `type` (`type`),
  KEY `flag` (`flag`),
  KEY `isBig` (`isBig`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `softname` varchar(50) NOT NULL,
  `time` int(11) NOT NULL,
  `vote_num` int(11) NOT NULL DEFAULT '0' COMMENT '票数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `softname` (`softname`),
  KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wechat_count`
--

DROP TABLE IF EXISTS `wechat_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_count` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `report_date` int(11) unsigned NOT NULL,
  `sayHiAll` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '群打招呼次数',
  `sendMsg` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发信次数',
  `payClick` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点击解锁次数',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `report_date` (`report_date`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weixin`
--

DROP TABLE IF EXISTS `weixin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weixin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `weixin_id` varchar(50) NOT NULL COMMENT '微信号',
  `weixin_qrcode_url` varchar(255) DEFAULT NULL COMMENT '微信二维码图片',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1开启',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `weixin_id` (`weixin_id`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='微信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weixin_report`
--

DROP TABLE IF EXISTS `weixin_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weixin_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wid` int(11) NOT NULL COMMENT '微信号id',
  `send_num` int(11) NOT NULL DEFAULT '0' COMMENT '发送次数',
  `report_date` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wid_2` (`wid`,`report_date`) USING BTREE,
  KEY `wid` (`wid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信号统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wish_address`
--

DROP TABLE IF EXISTS `wish_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wish_address` (
  `auto_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `contact` varchar(10) NOT NULL COMMENT '联系人',
  `phone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(255) NOT NULL COMMENT '详细地址',
  `is_default` tinyint(1) NOT NULL DEFAULT '2' COMMENT '是否默认地址，1是，2否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1正常，2删除',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wish_charge_log`
--

DROP TABLE IF EXISTS `wish_charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wish_charge_log` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `order_subject` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `trade_no` varchar(255) DEFAULT NULL COMMENT '淘宝交易号',
  `order_body` text COMMENT '订单描述',
  `productid` int(11) DEFAULT NULL COMMENT '商品ID',
  `money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `credit` int(11) NOT NULL COMMENT '获得积分',
  `platform` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值平台 1 财付通 2 网银在线 3 银联，4支付宝,5手动,6手机充值卡,7支付宝wap,8微信,9银联语音',
  `user_client_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为web\r\n2为android\r\n3为iphone\r\n4为PC端',
  `error_code` varchar(255) DEFAULT NULL COMMENT '错误信息代码',
  `to_id` int(11) NOT NULL DEFAULT '0' COMMENT '被打赏ID',
  `tplid` int(11) NOT NULL DEFAULT '0' COMMENT '模板ID',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `remove_time` datetime NOT NULL COMMENT '记录删除时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '记录状态',
  PRIMARY KEY (`auto_id`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `order_no` (`order_no`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3291 DEFAULT CHARSET=utf8 COMMENT='充值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wish_credit`
--

DROP TABLE IF EXISTS `wish_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wish_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打赏id',
  `from_uid` int(11) NOT NULL COMMENT '打赏人',
  `to_uid` int(11) DEFAULT NULL COMMENT '被打赏人',
  `credit` int(11) NOT NULL COMMENT '打赏积分',
  `create_time` datetime DEFAULT NULL COMMENT '打赏时间',
  `type` tinyint(1) unsigned NOT NULL COMMENT '积分类型 1基础积分 2打赏积分',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否接收',
  `credit_ip` varchar(15) DEFAULT NULL COMMENT '打赏ip',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_filter`
--

DROP TABLE IF EXISTS `word_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_filter` (
  `keyword` char(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  KEY `keyword` (`keyword`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_filter_gift`
--

DROP TABLE IF EXISTS `word_filter_gift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_filter_gift` (
  `keyword` char(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  KEY `keyword` (`keyword`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_filter_msg`
--

DROP TABLE IF EXISTS `word_filter_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_filter_msg` (
  `keyword` char(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  UNIQUE KEY `keyword` (`keyword`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wy_active_imei`
--

DROP TABLE IF EXISTS `wy_active_imei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wy_active_imei` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(40) NOT NULL,
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `imei` (`imei`)
) ENGINE=MyISAM AUTO_INCREMENT=87805 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wy_active_imei_enter`
--

DROP TABLE IF EXISTS `wy_active_imei_enter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wy_active_imei_enter` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(40) NOT NULL,
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `imei` (`imei`)
) ENGINE=MyISAM AUTO_INCREMENT=1274 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wy_active_imei_sp`
--

DROP TABLE IF EXISTS `wy_active_imei_sp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wy_active_imei_sp` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(40) NOT NULL,
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `imei` (`imei`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wy_active_list`
--

DROP TABLE IF EXISTS `wy_active_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wy_active_list` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_uid` int(11) DEFAULT NULL,
  `c_sid` int(11) DEFAULT NULL,
  `imei` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`auto_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wy_active_report`
--

DROP TABLE IF EXISTS `wy_active_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wy_active_report` (
  `auto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `c_uid` int(11) NOT NULL DEFAULT '0' COMMENT '推广主ID',
  `c_sid` int(11) NOT NULL DEFAULT '0' COMMENT '推广子ID',
  `active_num` int(11) NOT NULL DEFAULT '0' COMMENT '激活人数',
  `click_num` int(11) NOT NULL DEFAULT '0' COMMENT '点击人数',
  `click_nocard_num` int(11) NOT NULL DEFAULT '0' COMMENT '无卡数',
  `click_real_num` int(11) NOT NULL DEFAULT '0' COMMENT '点击进入数（直接）',
  `reg_num` int(11) NOT NULL DEFAULT '0' COMMENT '注册人数',
  `charge_num` int(11) NOT NULL DEFAULT '0' COMMENT '充值人数',
  `charge_money` float NOT NULL DEFAULT '0' COMMENT '充值金额',
  `report_date` date NOT NULL COMMENT '日期',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0为午夜，1为激情,2为午夜PUSH',
  PRIMARY KEY (`auto_id`),
  UNIQUE KEY `c_uid` (`c_uid`,`c_sid`,`report_date`),
  KEY `report_date` (`report_date`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=166158 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yht_settlement_list`
--

DROP TABLE IF EXISTS `yht_settlement_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yht_settlement_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) DEFAULT '' COMMENT '代付订单号',
  `total_fee` float(10,2) DEFAULT '0.00' COMMENT '提现总金额',
  `srcReqSN` varchar(255) DEFAULT '' COMMENT '请求流水号',
  `responeSN` varchar(255) DEFAULT '' COMMENT '返回的系统流水号',
  `payAmount` float(10,2) DEFAULT '0.00' COMMENT '实际支付金额',
  `status` int(255) DEFAULT '1' COMMENT '提现状态,1:已创建,2:已提交,3:成功,4:失败',
  `create_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '提现创建时间',
  `callback_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '提现回调处理时间',
  `msg` varchar(255) DEFAULT '' COMMENT '游惠通返回信息',
  `merchant` varchar(100) DEFAULT '' COMMENT '游汇通商户号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-17 13:28:01
