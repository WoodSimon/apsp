/*
MySQL Data Transfer
Source Host: localhost
Source Database: apsp_characters
Target Host: localhost
Target Database: apsp_characters
Date: 17.04.2009 19:55:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `AccountID` int(10) NOT NULL,
  `AccessLevel` int(1) NOT NULL,
  `Comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `ID` int(20) NOT NULL,
  `Accountname` varchar(16) NOT NULL,
  `Password` varchar(128) NOT NULL COMMENT 'Hashed in MD5',
  `last_login` datetime DEFAULT NULL,
  `last_ip` varchar(16) NOT NULL,
  `createdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL COMMENT 'If Offline Then 0 If Online Then 1',
  `ban_until` datetime NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bankitems
-- ----------------------------
DROP TABLE IF EXISTS `bankitems`;
CREATE TABLE `bankitems` (
  `accountid` int(11) NOT NULL,
  `bankslot` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `inventoryslot` int(11) NOT NULL,
  `durability` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `refine` int(11) NOT NULL,
  `element` int(11) NOT NULL,
  `refine_element` int(11) NOT NULL,
  `slotcount` int(11) NOT NULL,
  `slot1` int(11) NOT NULL,
  `slot2` int(11) NOT NULL,
  `slot3` int(11) NOT NULL,
  `slot4` int(11) NOT NULL,
  `slot5` int(11) NOT NULL,
  `stats` int(10) NOT NULL,
  `itemBonuses` bigint(20) NOT NULL,
  `lastUntil` bigint(20) NOT NULL,
  `pet_lives` int(10) NOT NULL,
  `addedByQuestID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for buffs
-- ----------------------------
DROP TABLE IF EXISTS `buffs`;
CREATE TABLE `buffs` (
  `charid` int(10) unsigned NOT NULL,
  `skillid` int(10) unsigned NOT NULL DEFAULT '0',
  `skilllvl` int(10) unsigned NOT NULL DEFAULT '0',
  `abilityType1` int(10) unsigned NOT NULL DEFAULT '0',
  `ability1` int(11) NOT NULL DEFAULT '0',
  `abilityType2` int(10) unsigned NOT NULL DEFAULT '0',
  `ability2` int(11) NOT NULL DEFAULT '0',
  `abilityType3` int(11) unsigned NOT NULL DEFAULT '0',
  `ability3` int(11) NOT NULL DEFAULT '0',
  `remainingTime` bigint(200) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `channelnum` varchar(255) NOT NULL,
  `charname` text NOT NULL,
  `level` int(10) NOT NULL,
  `class` int(10) NOT NULL,
  `sex` int(10) NOT NULL,
  `hair_style` int(10) NOT NULL,
  `hair_color` int(10) NOT NULL,
  `eye_style` int(10) NOT NULL,
  `stat_str` int(10) NOT NULL DEFAULT '15',
  `stat_sta` int(10) NOT NULL DEFAULT '15',
  `stat_dex` int(10) NOT NULL DEFAULT '15',
  `stat_int` int(10) NOT NULL,
  `charslot` int(10) NOT NULL,
  `ID` int(10) NOT NULL,
  `posX` float(20,0) NOT NULL,
  `posY` float(20,0) NOT NULL,
  `posZ` float(20,0) NOT NULL,
  `WorldID` int(10) NOT NULL DEFAULT '1',
  `accountname` text NOT NULL,
  `penya` int(9) DEFAULT NULL,
  `exp` int(12) NOT NULL,
  `current_healt_points` int(10) NOT NULL DEFAULT '10000',
  `current_mana_points` int(10) NOT NULL DEFAULT '10000',
  `current_force_points` int(10) NOT NULL DEFAULT '10000',
  `karma` int(10) NOT NULL,
  `duel` int(10) NOT NULL,
  `killpoints` int(10) DEFAULT NULL,
  `skills` varchar(800) NOT NULL,
  `skill_levels` varchar(800) DEFAULT NULL,
  `flying_level` int(10) NOT NULL DEFAULT '0',
  `flying_exp` int(11) NOT NULL,
  `skillpoints` int(3) NOT NULL,
  `statpoints` int(3) NOT NULL,
  `messenger_state` int(1) NOT NULL,
  `posAngle` int(10) NOT NULL,
  `sizeMod` int(10) NOT NULL DEFAULT '100',
  `party_id` int(10) NOT NULL,
  `buffpet_itemnum` int(10) DEFAULT NULL,
  `disposition` int(10) NOT NULL,
  `partyDefaultName` char(50) DEFAULT 'APSP Party',
  `canJoinGuildAt` int(10) DEFAULT '0',
  `viewEquipment` int(10) NOT NULL,
  `PVPDuelRequests` int(10) NOT NULL,
  `bag1_last_until` int(10) NOT NULL,
  `bag2_last_until` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for data_exp
-- ----------------------------
DROP TABLE IF EXISTS `data_exp`;
CREATE TABLE `data_exp` (
  `level` int(10) unsigned NOT NULL,
  `exp_to_reach_lvl` bigint(20) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for data_fxp
-- ----------------------------
DROP TABLE IF EXISTS `data_fxp`;
CREATE TABLE `data_fxp` (
  `fxp_to_reach_level` int(11) NOT NULL,
  `flying_level` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`flying_level`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for data_guild_exp
-- ----------------------------
DROP TABLE IF EXISTS `data_guild_exp`;
CREATE TABLE `data_guild_exp` (
  `nextlevel` int(10) unsigned NOT NULL DEFAULT '0',
  `req_contribution` int(10) unsigned NOT NULL DEFAULT '0',
  `req_penya` int(10) unsigned NOT NULL DEFAULT '0',
  `max_members` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `charid1` int(10) unsigned NOT NULL,
  `charid2` int(10) unsigned NOT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_members
-- ----------------------------
DROP TABLE IF EXISTS `guild_members`;
CREATE TABLE `guild_members` (
  `char_id` int(11) NOT NULL,
  `rank` int(1) NOT NULL DEFAULT '0',
  `nickname` varchar(32) NOT NULL DEFAULT 'test',
  `contrib` int(8) NOT NULL DEFAULT '0',
  `penya_contrib` int(10) NOT NULL DEFAULT '0',
  `rank_symbol_count` int(1) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`char_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guildbankitems
-- ----------------------------
DROP TABLE IF EXISTS `guildbankitems`;
CREATE TABLE `guildbankitems` (
  `guildID` int(11) NOT NULL DEFAULT '1',
  `bankslot` int(2) NOT NULL DEFAULT '1',
  `itemnumber` int(2) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '1',
  `durability` int(7) NOT NULL DEFAULT '0',
  `count` int(4) NOT NULL DEFAULT '1',
  `refine` int(2) NOT NULL DEFAULT '0',
  `element` int(1) NOT NULL DEFAULT '0',
  `refine_element` int(2) NOT NULL DEFAULT '0',
  `slotcount` int(1) NOT NULL DEFAULT '0',
  `slot_1` int(4) NOT NULL DEFAULT '0',
  `slot_2` int(4) NOT NULL DEFAULT '0',
  `slot_3` int(4) NOT NULL DEFAULT '0',
  `slot_4` int(4) NOT NULL DEFAULT '0',
  `slot_5` int(4) NOT NULL DEFAULT '0',
  `stats` int(5) NOT NULL DEFAULT '0',
  `addedByQuestID` int(1) NOT NULL DEFAULT '-1',
  `lastUntil` int(10) NOT NULL DEFAULT '0',
  `pet_lives` int(1) NOT NULL DEFAULT '0',
  `itemBonuses` bigint(20) NOT NULL DEFAULT '0',
  UNIQUE KEY `index` (`guildID`,`bankslot`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `founderCharID` int(11) NOT NULL DEFAULT '1',
  `name` text NOT NULL,
  `logo` int(2) NOT NULL DEFAULT '0',
  `expContrib` int(7) NOT NULL DEFAULT '1',
  `gwWon` int(4) NOT NULL DEFAULT '0',
  `gwLost` int(4) NOT NULL DEFAULT '0',
  `gwGivenUp` int(4) NOT NULL DEFAULT '0',
  `rightsMaster` int(3) NOT NULL DEFAULT '255',
  `rightsKingpin` int(3) NOT NULL DEFAULT '4',
  `rightsCaptain` int(3) NOT NULL DEFAULT '4',
  `rightsSupporter` int(3) NOT NULL DEFAULT '4',
  `rightsRookie` int(3) NOT NULL DEFAULT '4',
  `payMaster` int(10) NOT NULL DEFAULT '0',
  `payKingpin` int(10) NOT NULL DEFAULT '0',
  `payCaptain` int(10) NOT NULL DEFAULT '0',
  `paySupporter` int(10) NOT NULL DEFAULT '0',
  `payRookie` int(10) NOT NULL DEFAULT '0',
  `notice` text NOT NULL,
  `level` int(10) NOT NULL DEFAULT '1',
  `bank_penya` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `charid` int(20) NOT NULL,
  `backpack_number` int(20) NOT NULL DEFAULT '-1',
  `itemnumber` int(20) NOT NULL DEFAULT '0',
  `itemid` int(20) NOT NULL DEFAULT '0',
  `inventoryslot` int(20) NOT NULL DEFAULT '0',
  `durability` int(20) NOT NULL DEFAULT '0',
  `count` int(20) NOT NULL DEFAULT '0',
  `refine` int(20) NOT NULL DEFAULT '0',
  `element` int(20) NOT NULL DEFAULT '0',
  `refine_element` int(20) NOT NULL DEFAULT '0',
  `slotcount` int(20) NOT NULL DEFAULT '0',
  `slot_1` int(20) NOT NULL DEFAULT '0',
  `slot_2` int(20) NOT NULL DEFAULT '0',
  `slot_3` int(20) NOT NULL DEFAULT '0',
  `slot_4` int(20) NOT NULL DEFAULT '0',
  `slot_5` int(20) NOT NULL DEFAULT '0',
  `stats` int(20) unsigned NOT NULL DEFAULT '0',
  `itemBonuses` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastUntil` bigint(20) unsigned NOT NULL DEFAULT '0',
  `pet_lives` int(10) unsigned NOT NULL DEFAULT '0',
  `addedByQuestID` int(11) NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for mails
-- ----------------------------
DROP TABLE IF EXISTS `mails`;
CREATE TABLE `mails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `charID_from` int(10) unsigned NOT NULL,
  `charID_to` int(10) unsigned NOT NULL,
  `date_sent` bigint(20) unsigned NOT NULL,
  `hasBeenRead` tinyint(4) NOT NULL DEFAULT '0',
  `title` varchar(30) NOT NULL,
  `message` text NOT NULL,
  `penya` int(10) unsigned NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_durability` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  `item_refine` int(11) NOT NULL,
  `item_element` int(11) NOT NULL,
  `item_refine_element` int(11) NOT NULL,
  `item_slotcount` int(11) NOT NULL,
  `item_slot_1` int(11) NOT NULL,
  `item_slot_2` int(11) NOT NULL,
  `item_slot_3` int(11) NOT NULL,
  `item_slot_4` int(11) NOT NULL,
  `item_slot_5` int(11) NOT NULL,
  `item_stats` int(11) NOT NULL,
  `item_itemBonuses` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_lastUntil` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_pet_lives` int(11) NOT NULL,
  `item_addedByQuestID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=560 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for slots
-- ----------------------------
DROP TABLE IF EXISTS `slots`;
CREATE TABLE `slots` (
  `actionslot_opcodes` char(50) DEFAULT NULL,
  `actionslot_ids` char(50) DEFAULT NULL,
  `actionslot_text` char(50) DEFAULT NULL,
  `actionslot_cooldown` int(10) NOT NULL,
  `fslot1_opcodes` char(50) DEFAULT NULL,
  `fslot1_ids` char(50) DEFAULT NULL,
  `fslot1_text` char(50) DEFAULT NULL,
  `fslot2_opcodes` char(50) DEFAULT NULL,
  `fslot2_ids` char(50) DEFAULT NULL,
  `fslot2_text` char(50) DEFAULT NULL,
  `fslot3_opcodes` char(50) DEFAULT NULL,
  `fslot3_ids` char(50) DEFAULT NULL,
  `fslot3_text` char(50) DEFAULT NULL,
  `fslot4_opcodes` char(50) DEFAULT NULL,
  `fslot4_ids` char(50) DEFAULT NULL,
  `fslot4_text` char(50) DEFAULT NULL,
  `fslot5_opcodes` char(50) DEFAULT NULL,
  `fslot5_ids` char(50) DEFAULT NULL,
  `fslot5_text` char(50) DEFAULT NULL,
  `fslot6_opcodes` char(50) DEFAULT NULL,
  `fslot6_ids` char(50) DEFAULT NULL,
  `fslot6_text` char(50) DEFAULT NULL,
  `fslot7_opcodes` char(50) DEFAULT NULL,
  `fslot7_ids` char(50) DEFAULT NULL,
  `fslot7_text` char(50) DEFAULT NULL,
  `fslot8_opcodes` char(50) DEFAULT NULL,
  `fslot8_ids` char(50) DEFAULT NULL,
  `fslot8_text` char(50) DEFAULT NULL,
  `fslot9_opcodes` char(50) DEFAULT NULL,
  `fslot9_ids` char(50) DEFAULT NULL,
  `fslot9_text` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `data_exp` VALUES ('0', '0');
INSERT INTO `data_exp` VALUES ('1', '0');
INSERT INTO `data_exp` VALUES ('2', '14');
INSERT INTO `data_exp` VALUES ('3', '20');
INSERT INTO `data_exp` VALUES ('4', '36');
INSERT INTO `data_exp` VALUES ('5', '90');
INSERT INTO `data_exp` VALUES ('6', '152');
INSERT INTO `data_exp` VALUES ('7', '250');
INSERT INTO `data_exp` VALUES ('8', '352');
INSERT INTO `data_exp` VALUES ('9', '480');
INSERT INTO `data_exp` VALUES ('10', '591');
INSERT INTO `data_exp` VALUES ('11', '743');
INSERT INTO `data_exp` VALUES ('12', '973');
INSERT INTO `data_exp` VALUES ('13', '1290');
INSERT INTO `data_exp` VALUES ('14', '1632');
INSERT INTO `data_exp` VALUES ('15', '1928');
INSERT INTO `data_exp` VALUES ('16', '2340');
INSERT INTO `data_exp` VALUES ('17', '3480');
INSERT INTO `data_exp` VALUES ('18', '4125');
INSERT INTO `data_exp` VALUES ('19', '4995');
INSERT INTO `data_exp` VALUES ('20', '5880');
INSERT INTO `data_exp` VALUES ('21', '7840');
INSERT INTO `data_exp` VALUES ('22', '6875');
INSERT INTO `data_exp` VALUES ('23', '8243');
INSERT INTO `data_exp` VALUES ('24', '10380');
INSERT INTO `data_exp` VALUES ('25', '13052');
INSERT INTO `data_exp` VALUES ('26', '16450');
INSERT INTO `data_exp` VALUES ('27', '20700');
INSERT INTO `data_exp` VALUES ('28', '26143');
INSERT INTO `data_exp` VALUES ('29', '31950');
INSERT INTO `data_exp` VALUES ('30', '38640');
INSERT INTO `data_exp` VALUES ('31', '57035');
INSERT INTO `data_exp` VALUES ('32', '65000');
INSERT INTO `data_exp` VALUES ('33', '69125');
INSERT INTO `data_exp` VALUES ('34', '72000');
INSERT INTO `data_exp` VALUES ('35', '87239');
INSERT INTO `data_exp` VALUES ('36', '105863');
INSERT INTO `data_exp` VALUES ('37', '128694');
INSERT INTO `data_exp` VALUES ('38', '182307');
INSERT INTO `data_exp` VALUES ('39', '221450');
INSERT INTO `data_exp` VALUES ('40', '269042');
INSERT INTO `data_exp` VALUES ('41', '390368');
INSERT INTO `data_exp` VALUES ('42', '438550');
INSERT INTO `data_exp` VALUES ('43', '458137');
INSERT INTO `data_exp` VALUES ('44', '468943');
INSERT INTO `data_exp` VALUES ('45', '560177');
INSERT INTO `data_exp` VALUES ('46', '669320');
INSERT INTO `data_exp` VALUES ('47', '799963');
INSERT INTO `data_exp` VALUES ('48', '1115396');
INSERT INTO `data_exp` VALUES ('49', '1331100');
INSERT INTO `data_exp` VALUES ('50', '1590273');
INSERT INTO `data_exp` VALUES ('51', '2306878');
INSERT INTO `data_exp` VALUES ('52', '2594255');
INSERT INTO `data_exp` VALUES ('53', '2711490');
INSERT INTO `data_exp` VALUES ('54', '2777349');
INSERT INTO `data_exp` VALUES ('55', '3318059');
INSERT INTO `data_exp` VALUES ('56', '3963400');
INSERT INTO `data_exp` VALUES ('57', '4735913');
INSERT INTO `data_exp` VALUES ('58', '6600425');
INSERT INTO `data_exp` VALUES ('59', '7886110');
INSERT INTO `data_exp` VALUES ('60', '9421875');
INSERT INTO `data_exp` VALUES ('61', '13547310');
INSERT INTO `data_exp` VALUES ('62', '15099446');
INSERT INTO `data_exp` VALUES ('63', '15644776');
INSERT INTO `data_exp` VALUES ('64', '15885934');
INSERT INTO `data_exp` VALUES ('65', '18817757');
INSERT INTO `data_exp` VALUES ('66', '22280630');
INSERT INTO `data_exp` VALUES ('67', '26392968');
INSERT INTO `data_exp` VALUES ('68', '36465972');
INSERT INTO `data_exp` VALUES ('69', '43184958');
INSERT INTO `data_exp` VALUES ('70', '51141217');
INSERT INTO `data_exp` VALUES ('71', '73556918');
INSERT INTO `data_exp` VALUES ('72', '81991117');
INSERT INTO `data_exp` VALUES ('73', '84966758');
INSERT INTO `data_exp` VALUES ('74', '86252845');
INSERT INTO `data_exp` VALUES ('75', '102171368');
INSERT INTO `data_exp` VALUES ('76', '120995493');
INSERT INTO `data_exp` VALUES ('77', '143307208');
INSERT INTO `data_exp` VALUES ('78', '198000645');
INSERT INTO `data_exp` VALUES ('79', '234477760');
INSERT INTO `data_exp` VALUES ('80', '277716683');
INSERT INTO `data_exp` VALUES ('81', '381795797');
INSERT INTO `data_exp` VALUES ('82', '406848219');
INSERT INTO `data_exp` VALUES ('83', '403044458');
INSERT INTO `data_exp` VALUES ('84', '391191019');
INSERT INTO `data_exp` VALUES ('85', '442876559');
INSERT INTO `data_exp` VALUES ('86', '501408635');
INSERT INTO `data_exp` VALUES ('87', '567694433');
INSERT INTO `data_exp` VALUES ('88', '749813704');
INSERT INTO `data_exp` VALUES ('89', '849001357');
INSERT INTO `data_exp` VALUES ('90', '961154774');
INSERT INTO `data_exp` VALUES ('91', '1309582668');
INSERT INTO `data_exp` VALUES ('92', '1382799035');
INSERT INTO `data_exp` VALUES ('93', '1357505030');
INSERT INTO `data_exp` VALUES ('94', '1305632790');
INSERT INTO `data_exp` VALUES ('95', '1464862605');
INSERT INTO `data_exp` VALUES ('96', '1628695740');
INSERT INTO `data_exp` VALUES ('97', '1810772333');
INSERT INTO `data_exp` VALUES ('98', '2348583653');
INSERT INTO `data_exp` VALUES ('99', '2611145432');
INSERT INTO `data_exp` VALUES ('100', '2903009208');
INSERT INTO `data_exp` VALUES ('101', '3919352097');
INSERT INTO `data_exp` VALUES ('102', '4063358600');
INSERT INTO `data_exp` VALUES ('103', '3916810682');
INSERT INTO `data_exp` VALUES ('104', '4314535354');
INSERT INTO `data_exp` VALUES ('105', '4752892146');
INSERT INTO `data_exp` VALUES ('106', '5235785988');
INSERT INTO `data_exp` VALUES ('107', '5767741845');
INSERT INTO `data_exp` VALUES ('108', '6353744416');
INSERT INTO `data_exp` VALUES ('109', '6999284849');
INSERT INTO `data_exp` VALUES ('110', '7710412189');
INSERT INTO `data_exp` VALUES ('111', '8493790068');
INSERT INTO `data_exp` VALUES ('112', '9356759139');
INSERT INTO `data_exp` VALUES ('113', '10307405867');
INSERT INTO `data_exp` VALUES ('114', '11354638303');
INSERT INTO `data_exp` VALUES ('115', '12508269555');
INSERT INTO `data_exp` VALUES ('116', '13779109742');
INSERT INTO `data_exp` VALUES ('117', '15179067292');
INSERT INTO `data_exp` VALUES ('118', '16721260528');
INSERT INTO `data_exp` VALUES ('119', '18420140598');
INSERT INTO `data_exp` VALUES ('120', '20291626883');
INSERT INTO `data_exp` VALUES ('121', '22353256174');
INSERT INTO `data_fxp` VALUES ('81', '1');
INSERT INTO `data_fxp` VALUES ('94', '2');
INSERT INTO `data_fxp` VALUES ('112', '3');
INSERT INTO `data_fxp` VALUES ('166', '4');
INSERT INTO `data_fxp` VALUES ('228', '5');
INSERT INTO `data_fxp` VALUES ('326', '6');
INSERT INTO `data_fxp` VALUES ('428', '7');
INSERT INTO `data_fxp` VALUES ('556', '8');
INSERT INTO `data_fxp` VALUES ('666', '9');
INSERT INTO `data_fxp` VALUES ('818', '10');
INSERT INTO `data_fxp` VALUES ('1049', '11');
INSERT INTO `data_fxp` VALUES ('1366', '12');
INSERT INTO `data_fxp` VALUES ('1708', '13');
INSERT INTO `data_fxp` VALUES ('2004', '14');
INSERT INTO `data_fxp` VALUES ('2416', '15');
INSERT INTO `data_fxp` VALUES ('3556', '16');
INSERT INTO `data_fxp` VALUES ('4201', '17');
INSERT INTO `data_fxp` VALUES ('5071', '18');
INSERT INTO `data_fxp` VALUES ('5956', '19');
INSERT INTO `data_fxp` VALUES ('7916', '20');
INSERT INTO `data_fxp` VALUES ('6951', '21');
INSERT INTO `data_fxp` VALUES ('8318', '22');
INSERT INTO `data_fxp` VALUES ('10456', '23');
INSERT INTO `data_fxp` VALUES ('13127', '24');
INSERT INTO `data_fxp` VALUES ('16526', '25');
INSERT INTO `data_fxp` VALUES ('20776', '26');
INSERT INTO `data_fxp` VALUES ('26219', '27');
INSERT INTO `data_fxp` VALUES ('32026', '28');
INSERT INTO `data_fxp` VALUES ('38716', '29');
INSERT INTO `data_fxp` VALUES ('57111', '30');
INSERT INTO `data_fxp` VALUES ('65076', '31');
INSERT INTO `data_fxp` VALUES ('69201', '32');
INSERT INTO `data_fxp` VALUES ('72076', '33');
INSERT INTO `data_fxp` VALUES ('87315', '34');
INSERT INTO `data_fxp` VALUES ('105939', '35');
INSERT INTO `data_fxp` VALUES ('128770', '36');
INSERT INTO `data_fxp` VALUES ('182382', '37');
INSERT INTO `data_fxp` VALUES ('221526', '38');
INSERT INTO `data_fxp` VALUES ('269117', '39');
INSERT INTO `data_fxp` VALUES ('390443', '40');
INSERT INTO `data_fxp` VALUES ('438626', '41');
INSERT INTO `data_fxp` VALUES ('458212', '42');
INSERT INTO `data_fxp` VALUES ('469018', '43');
INSERT INTO `data_fxp` VALUES ('560252', '44');
INSERT INTO `data_fxp` VALUES ('669396', '45');
INSERT INTO `data_fxp` VALUES ('800039', '46');
INSERT INTO `data_fxp` VALUES ('1115471', '47');
INSERT INTO `data_fxp` VALUES ('1331176', '48');
INSERT INTO `data_fxp` VALUES ('1590349', '49');
INSERT INTO `data_fxp` VALUES ('2306953', '50');
INSERT INTO `data_fxp` VALUES ('2594331', '51');
INSERT INTO `data_fxp` VALUES ('2711566', '52');
INSERT INTO `data_fxp` VALUES ('2777425', '53');
INSERT INTO `data_fxp` VALUES ('3318153', '54');
INSERT INTO `data_fxp` VALUES ('3963476', '55');
INSERT INTO `data_fxp` VALUES ('4735988', '56');
INSERT INTO `data_fxp` VALUES ('6600501', '57');
INSERT INTO `data_fxp` VALUES ('7886186', '58');
INSERT INTO `data_fxp` VALUES ('9421951', '59');
INSERT INTO `data_fxp` VALUES ('13547386', '60');
INSERT INTO `data_fxp` VALUES ('15099521', '61');
INSERT INTO `data_fxp` VALUES ('15644851', '62');
INSERT INTO `data_fxp` VALUES ('15886010', '63');
INSERT INTO `data_fxp` VALUES ('18817832', '64');
INSERT INTO `data_fxp` VALUES ('22280706', '65');
INSERT INTO `data_fxp` VALUES ('26393044', '66');
INSERT INTO `data_fxp` VALUES ('36466047', '67');
INSERT INTO `data_fxp` VALUES ('43185033', '68');
INSERT INTO `data_fxp` VALUES ('51141292', '69');
INSERT INTO `data_fxp` VALUES ('73556993', '70');
INSERT INTO `data_fxp` VALUES ('81991192', '71');
INSERT INTO `data_fxp` VALUES ('84966834', '72');
INSERT INTO `data_fxp` VALUES ('86252921', '73');
INSERT INTO `data_fxp` VALUES ('102171444', '74');
INSERT INTO `data_fxp` VALUES ('120995568', '75');
INSERT INTO `data_fxp` VALUES ('143307283', '76');
INSERT INTO `data_fxp` VALUES ('198000721', '77');
INSERT INTO `data_fxp` VALUES ('234477836', '78');
INSERT INTO `data_fxp` VALUES ('277716758', '79');
INSERT INTO `data_fxp` VALUES ('381795872', '80');
INSERT INTO `data_fxp` VALUES ('406848295', '81');
INSERT INTO `data_fxp` VALUES ('403044533', '82');
INSERT INTO `data_fxp` VALUES ('391191095', '83');
INSERT INTO `data_fxp` VALUES ('442876635', '84');
INSERT INTO `data_fxp` VALUES ('501408711', '85');
INSERT INTO `data_fxp` VALUES ('567694509', '86');
INSERT INTO `data_fxp` VALUES ('749813780', '87');
INSERT INTO `data_fxp` VALUES ('849001432', '88');
INSERT INTO `data_fxp` VALUES ('961145850', '89');
INSERT INTO `data_fxp` VALUES ('1309582744', '90');
INSERT INTO `data_fxp` VALUES ('1382799111', '91');
INSERT INTO `data_fxp` VALUES ('1357505106', '92');
INSERT INTO `data_fxp` VALUES ('1305632866', '93');
INSERT INTO `data_fxp` VALUES ('1464862681', '94');
INSERT INTO `data_fxp` VALUES ('1628695816', '95');
INSERT INTO `data_fxp` VALUES ('1810772409', '96');
INSERT INTO `data_fxp` VALUES ('2147483647', '97');
INSERT INTO `data_fxp` VALUES ('2147483647', '98');
INSERT INTO `data_fxp` VALUES ('2147483647', '99');
INSERT INTO `data_guild_exp` VALUES ('1', '0', '0', '30');
INSERT INTO `data_guild_exp` VALUES ('2', '24', '5200', '30');
INSERT INTO `data_guild_exp` VALUES ('3', '205', '14625', '32');
INSERT INTO `data_guild_exp` VALUES ('4', '485', '34666', '32');
INSERT INTO `data_guild_exp` VALUES ('5', '1353', '58035', '34');
INSERT INTO `data_guild_exp` VALUES ('6', '2338', '100285', '34');
INSERT INTO `data_guild_exp` VALUES ('7', '4547', '139343', '36');
INSERT INTO `data_guild_exp` VALUES ('8', '6788', '208000', '36');
INSERT INTO `data_guild_exp` VALUES ('9', '11045', '263250', '38');
INSERT INTO `data_guild_exp` VALUES ('10', '15151', '361110', '38');
INSERT INTO `data_guild_exp` VALUES ('11', '22183', '432575', '40');
INSERT INTO `data_guild_exp` VALUES ('12', '28800', '561600', '40');
INSERT INTO `data_guild_exp` VALUES ('13', '39340', '649113', '42');
INSERT INTO `data_guild_exp` VALUES ('14', '49135', '810727', '42');
INSERT INTO `data_guild_exp` VALUES ('15', '63920', '914063', '44');
INSERT INTO `data_guild_exp` VALUES ('16', '71608', '1024000', '44');
INSERT INTO `data_guild_exp` VALUES ('17', '84365', '1064483', '46');
INSERT INTO `data_guild_exp` VALUES ('18', '91041', '1148727', '46');
INSERT INTO `data_guild_exp` VALUES ('19', '109698', '1238429', '48');
INSERT INTO `data_guild_exp` VALUES ('20', '115152', '1300000', '48');
INSERT INTO `data_guild_exp` VALUES ('21', '134545', '1443000', '49');
INSERT INTO `data_guild_exp` VALUES ('22', '156813', '1601730', '50');
INSERT INTO `data_guild_exp` VALUES ('23', '182351', '1777920', '51');
INSERT INTO `data_guild_exp` VALUES ('24', '211610', '1973491', '52');
INSERT INTO `data_guild_exp` VALUES ('25', '245099', '2190574', '53');
INSERT INTO `data_guild_exp` VALUES ('26', '283396', '2431537', '54');
INSERT INTO `data_guild_exp` VALUES ('27', '327152', '2699005', '55');
INSERT INTO `data_guild_exp` VALUES ('28', '377106', '2995896', '56');
INSERT INTO `data_guild_exp` VALUES ('29', '434090', '3325443', '57');
INSERT INTO `data_guild_exp` VALUES ('30', '499049', '3691241', '58');
INSERT INTO `data_guild_exp` VALUES ('31', '573046', '4097276', '59');
INSERT INTO `data_guild_exp` VALUES ('32', '657283', '4547976', '60');
INSERT INTO `data_guild_exp` VALUES ('33', '753119', '5048252', '61');
INSERT INTO `data_guild_exp` VALUES ('34', '862086', '5603559', '62');
INSERT INTO `data_guild_exp` VALUES ('35', '985913', '6219950', '63');
INSERT INTO `data_guild_exp` VALUES ('36', '1126550', '6904144', '64');
INSERT INTO `data_guild_exp` VALUES ('37', '1286198', '7663599', '65');
INSERT INTO `data_guild_exp` VALUES ('38', '1467338', '8506594', '66');
INSERT INTO `data_guild_exp` VALUES ('39', '1672765', '9442319', '67');
INSERT INTO `data_guild_exp` VALUES ('40', '1905631', '10480973', '68');
INSERT INTO `data_guild_exp` VALUES ('41', '2169488', '11633879', '69');
INSERT INTO `data_guild_exp` VALUES ('42', '2468335', '12913606', '70');
INSERT INTO `data_guild_exp` VALUES ('43', '2806677', '14334102', '71');
INSERT INTO `data_guild_exp` VALUES ('44', '3189588', '15910852', '72');
INSERT INTO `data_guild_exp` VALUES ('45', '3622778', '17661045', '73');
INSERT INTO `data_guild_exp` VALUES ('46', '4112677', '19603760', '74');
INSERT INTO `data_guild_exp` VALUES ('47', '4666517', '21760172', '75');
INSERT INTO `data_guild_exp` VALUES ('48', '5292439', '24153791', '76');
INSERT INTO `data_guild_exp` VALUES ('49', '5999599', '26810707', '77');
INSERT INTO `data_guild_exp` VALUES ('50', '7075777', '29759885', '80');
