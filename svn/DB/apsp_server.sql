/*
MySQL Data Transfer
Source Host: localhost
Source Database: apsp_server
Target Host: localhost
Target Database: apsp_server
Date: 17.04.2009 19:55:21
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for channel
-- ----------------------------
DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel` (
  `Channel_ID` int(3) NOT NULL,
  `Channel_Name` varchar(50) NOT NULL,
  `MinAccessLevel` int(1) NOT NULL,
  `Server_ID` int(10) NOT NULL,
  `PvP` int(10) NOT NULL,
  `KS` int(10) NOT NULL,
  `enable_Shop` int(10) NOT NULL,
  `use_itemcooldown` int(10) NOT NULL,
  `use_itemcast` int(10) NOT NULL,
  `MOTD` varchar(255) NOT NULL,
  `GuildBank` int(10) NOT NULL,
  `Duel` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for channel_users
-- ----------------------------
DROP TABLE IF EXISTS `channel_users`;
CREATE TABLE `channel_users` (
  `Channel_ID` int(10) NOT NULL,
  `Max_Users` int(10) NOT NULL,
  `Current_Users` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for flyff.a
-- ----------------------------
DROP TABLE IF EXISTS `flyff.a`;
CREATE TABLE `flyff.a` (
  `Use Flyff.a` int(1) NOT NULL DEFAULT '0' COMMENT '0 = Dont Use 1 = Use',
  `Flyff.a Hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for npc_shops
-- ----------------------------
DROP TABLE IF EXISTS `npc_shops`;
CREATE TABLE `npc_shops` (
  `NPC_ID` int(10) NOT NULL,
  `Tab1_Items` varchar(800) NOT NULL COMMENT 'Example: ItemID,ItemID,ItemID',
  `Tab2_Items` varchar(800) NOT NULL,
  `Tab3_Items` varchar(800) NOT NULL,
  `Tab4_Items` varchar(800) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for rates
-- ----------------------------
DROP TABLE IF EXISTS `rates`;
CREATE TABLE `rates` (
  `EXP` int(10) NOT NULL DEFAULT '1',
  `FXP` int(10) NOT NULL DEFAULT '0',
  `Penya` int(10) NOT NULL,
  `Drop` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for secrurity_system
-- ----------------------------
DROP TABLE IF EXISTS `secrurity_system`;
CREATE TABLE `secrurity_system` (
  `use_secrurity_system` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for server
-- ----------------------------
DROP TABLE IF EXISTS `server`;
CREATE TABLE `server` (
  `Server_ID` int(10) NOT NULL,
  `Server_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for upgrade_rates
-- ----------------------------
DROP TABLE IF EXISTS `upgrade_rates`;
CREATE TABLE `upgrade_rates` (
  `from_0_to_1` int(3) NOT NULL DEFAULT '100' COMMENT 'Upgrade rate from 0 to 1',
  `from_1_to_2` int(3) NOT NULL DEFAULT '95' COMMENT 'Upgrade rate from 1 to 2',
  `from_2_to_3` int(3) NOT NULL DEFAULT '90' COMMENT 'Upgrade rate from 2 to 3',
  `from_3_to_4` int(3) NOT NULL DEFAULT '50' COMMENT 'Upgrade rate from 4 to 5',
  `from_4_to_5` int(3) NOT NULL DEFAULT '40',
  `from_5_to_6` int(3) NOT NULL DEFAULT '30',
  `from_6_to_7` int(3) NOT NULL DEFAULT '20',
  `from_7_to_8` int(3) NOT NULL DEFAULT '10',
  `from_8_to_9` int(3) NOT NULL DEFAULT '5',
  `from_9_to_10` int(3) NOT NULL DEFAULT '3',
  `from_10_and_higher` int(3) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for weather
-- ----------------------------
DROP TABLE IF EXISTS `weather`;
CREATE TABLE `weather` (
  `allow_weather` int(10) NOT NULL,
  `random` int(10) NOT NULL,
  `interval` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `channel` VALUES ('1', 'APSP Test Channel', '1', '1', '0', '0', '0', '0', '0', 'Willkommen auf dem Test Channel', '0', '0');
INSERT INTO `channel_users` VALUES ('1', '100', '0');
INSERT INTO `flyff.a` VALUES ('0', '0');
INSERT INTO `rates` VALUES ('30', '20', '20', '20');
INSERT INTO `server` VALUES ('1', 'APSP');
INSERT INTO `upgrade_rates` VALUES ('100', '95', '90', '50', '40', '30', '20', '10', '5', '3', '1');
INSERT INTO `weather` VALUES ('1', '1', '200');
