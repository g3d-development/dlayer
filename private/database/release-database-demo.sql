/*
SQLyog Ultimate v12.3.3 (64 bit)
MySQL - 10.1.16-MariaDB : Database - dlayer
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dlayer` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `dlayer`;

/*Table structure for table `designer_color_palette` */

DROP TABLE IF EXISTS `designer_color_palette`;

CREATE TABLE `designer_color_palette` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `view_script` char(9) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_color_palette` */

insert  into `designer_color_palette`(`id`,`name`,`view_script`) values 
(1,'Palette 1','palette-1'),
(2,'Palette 2','palette-2');

/*Table structure for table `designer_color_palette_color` */

DROP TABLE IF EXISTS `designer_color_palette_color`;

CREATE TABLE `designer_color_palette_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `palette_id` int(11) unsigned NOT NULL,
  `color_type_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color_hex` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `palette_id` (`palette_id`),
  KEY `color_type_id` (`color_type_id`),
  CONSTRAINT `designer_color_palette_color_fk1` FOREIGN KEY (`palette_id`) REFERENCES `designer_color_palette` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_color_palette_color` */

insert  into `designer_color_palette_color`(`id`,`palette_id`,`color_type_id`,`name`,`color_hex`) values 
(1,1,1,'Black','#000000'),
(2,1,2,'Dark grey','#333333'),
(3,1,3,'Grey','#555555'),
(4,1,4,'Light grey','#777777'),
(5,1,5,'Off white','#EEEEEE'),
(6,2,1,'Blue','#337ab7'),
(7,2,2,'Green','#5cb85c'),
(8,2,3,'Light blue','#5bc0de'),
(9,2,4,'Amber','#f0ad4e'),
(10,2,5,'Red','#d9534f');

/*Table structure for table `designer_color_type` */

DROP TABLE IF EXISTS `designer_color_type`;

CREATE TABLE `designer_color_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_color_type` */

insert  into `designer_color_type`(`id`,`type`) values 
(1,'Primary'),
(2,'Secondary'),
(3,'Tertiary'),
(4,'Quaternary'),
(5,'Quinary');

/*Table structure for table `designer_column_type` */

DROP TABLE IF EXISTS `designer_column_type`;

CREATE TABLE `designer_column_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `column_type` char(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_column_type` */

insert  into `designer_column_type`(`id`,`column_type`) values 
(1,'xs'),
(2,'sm'),
(3,'md'),
(4,'lg');

/*Table structure for table `designer_content_heading` */

DROP TABLE IF EXISTS `designer_content_heading`;

CREATE TABLE `designer_content_heading` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tag` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_content_heading` */

insert  into `designer_content_heading`(`id`,`name`,`tag`,`sort_order`) values 
(1,'Page title','h1',1),
(2,'Content heading 1','h2',2),
(3,'Content heading 2','h3',3),
(4,'Content heading 3','h4',4),
(5,'Content heading 4','h5',5),
(6,'Content heading 5','h6',6);

/*Table structure for table `designer_content_type` */

DROP TABLE IF EXISTS `designer_content_type`;

CREATE TABLE `designer_content_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tool_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tool_id` (`tool_id`),
  CONSTRAINT `designer_content_type_fk1` FOREIGN KEY (`tool_id`) REFERENCES `dlayer_module_tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_content_type` */

insert  into `designer_content_type`(`id`,`name`,`description`,`tool_id`) values 
(1,'text','Text block',10),
(2,'heading','Heading',11),
(3,'form','Form',16),
(4,'jumbotron','Jumbotron',34),
(5,'image','Image',39),
(7,'html','Raw html',52);

/*Table structure for table `designer_css_border_style` */

DROP TABLE IF EXISTS `designer_css_border_style`;

CREATE TABLE `designer_css_border_style` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `style` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `style` (`style`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Border styles that can be used within the designers';

/*Data for the table `designer_css_border_style` */

insert  into `designer_css_border_style`(`id`,`name`,`style`,`sort_order`) values 
(1,'Solid','solid',2),
(2,'Dashed','dashed',3),
(3,'No border','none',1);

/*Table structure for table `designer_css_font_family` */

DROP TABLE IF EXISTS `designer_css_font_family`;

CREATE TABLE `designer_css_font_family` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_css_font_family` */

insert  into `designer_css_font_family`(`id`,`name`,`description`,`css`,`sort_order`) values 
(1,'Helvetica','Helvetica Neue, Helvetica, Arial','\"Helvetica Neue\", Helvetica, Arial, sans-serif',1),
(2,'Lucida Grande','Lucida Grande, Lucida Sans Unicode, Bitstream Vera Sans','\"Lucida Grande\", \"Lucida Sans Unicode\", \"Bitstream Vera Sans\", sans-serif',2),
(3,'Georgia','Georgia, URW Bookman L','Georgia, \"URW Bookman L\", serif',3),
(4,'Corbel','Corbel, Arial, Helvetica, Nimbus Sans L, Liberation Sans','Corbel, Arial, Helvetica, \"Nimbus Sans L\", \"Liberation Sans\", sans-serif',4),
(5,'Code','Consolas, Bitstream Vera Sans Mono, Andale Mono, Monaco, Lucida Console','Consolas, \"Bitstream Vera Sans Mono\", \"Andale Mono\", Monaco, \"Lucida Console\", monospace',5),
(6,'Verdana','Verdana, Geneva','Verdana, Geneva, sans-serif',6),
(7,'Tahoma','Tahoma, Geneva','Tahoma, Geneva, sans-serif',7),
(8,'Segoe','Segoe UI, Helvetica, Arial, Sans-Serif;','\"Segoe UI\", Helvetica, Arial, \"Sans-Serif\"',8);

/*Table structure for table `designer_css_text_decoration` */

DROP TABLE IF EXISTS `designer_css_text_decoration`;

CREATE TABLE `designer_css_text_decoration` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_css_text_decoration` */

insert  into `designer_css_text_decoration`(`id`,`name`,`css`,`sort_order`) values 
(1,'None','none',1),
(2,'Underline','underline',2),
(3,'Strike-through','line-through',3);

/*Table structure for table `designer_css_text_style` */

DROP TABLE IF EXISTS `designer_css_text_style`;

CREATE TABLE `designer_css_text_style` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_css_text_style` */

insert  into `designer_css_text_style`(`id`,`name`,`css`,`sort_order`) values 
(1,'Normal','normal',1),
(2,'Italic','italic',2),
(3,'Oblique','oblique',3);

/*Table structure for table `designer_css_text_weight` */

DROP TABLE IF EXISTS `designer_css_text_weight`;

CREATE TABLE `designer_css_text_weight` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_css_text_weight` */

insert  into `designer_css_text_weight`(`id`,`name`,`css`,`sort_order`) values 
(1,'Normal','400',2),
(2,'Bold','700',4),
(3,'Light','100',1),
(4,'Light bold','500',3);

/*Table structure for table `designer_form_field_attribute` */

DROP TABLE IF EXISTS `designer_form_field_attribute`;

CREATE TABLE `designer_form_field_attribute` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `field_type_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attribute` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attribute_type_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_type_id` (`field_type_id`),
  KEY `attribute_type_id` (`attribute_type_id`),
  CONSTRAINT `designer_form_field_attribute_fk1` FOREIGN KEY (`field_type_id`) REFERENCES `designer_form_field_type` (`id`),
  CONSTRAINT `designer_form_field_attribute_fk2` FOREIGN KEY (`attribute_type_id`) REFERENCES `designer_form_field_attribute_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_form_field_attribute` */

insert  into `designer_form_field_attribute`(`id`,`field_type_id`,`name`,`attribute`,`attribute_type_id`) values 
(1,1,'Size','size',1),
(2,1,'Max length','maxlength',1),
(3,2,'Columns','cols',1),
(4,2,'Rows','rows',1),
(5,3,'Size','size',1),
(6,3,'Max length','maxlength',1),
(7,1,'Placeholder','placeholder',2),
(8,2,'Placeholder','placeholder',2),
(9,3,'Placeholder','placeholder',2),
(10,4,'Size','size',1),
(11,4,'Max length','maxlength',1),
(12,4,'Placeholder','placeholder',2);

/*Table structure for table `designer_form_field_attribute_type` */

DROP TABLE IF EXISTS `designer_form_field_attribute_type`;

CREATE TABLE `designer_form_field_attribute_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_form_field_attribute_type` */

insert  into `designer_form_field_attribute_type`(`id`,`name`,`type`) values 
(1,'Integer','integer'),
(2,'String','string');

/*Table structure for table `designer_form_field_type` */

DROP TABLE IF EXISTS `designer_form_field_type`;

CREATE TABLE `designer_form_field_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_form_field_type` */

insert  into `designer_form_field_type`(`id`,`name`,`type`,`description`) values 
(1,'Text','text','A single line field'),
(2,'Textarea','textarea','A multiple line field'),
(3,'Password','password','A password field'),
(4,'Email','email','Email field');

/*Table structure for table `designer_form_layout` */

DROP TABLE IF EXISTS `designer_form_layout`;

CREATE TABLE `designer_form_layout` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `layout` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `designer_form_layout` */

insert  into `designer_form_layout`(`id`,`layout`,`class`) values 
(1,'Standard','form'),
(2,'Inline','form-inline'),
(3,'Horizontal','form-horizontal');

/*Table structure for table `dlayer_identity` */

DROP TABLE IF EXISTS `dlayer_identity`;

CREATE TABLE `dlayer_identity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identity` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `credentials` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logged_in` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_action` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`identity`),
  KEY `enabled` (`enabled`),
  KEY `logged_in` (`logged_in`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dlayer_identity` */

insert  into `dlayer_identity`(`id`,`identity`,`credentials`,`logged_in`,`last_login`,`last_action`,`enabled`) values 
(1,'user-1@dlayer.com','$6$rounds=5000$jks453yuyt55d$CZJCjaieFQghQ6MwQ1OUI5nVKDy/Fi2YXk7MyW2hcex9AdJ/jvZA8ulvjzK1lo3rRVFfmd10lgjqAbDQM4ehR1',0,'2017-01-08 23:57:46','2017-01-08 23:58:04',1),
(2,'user-2@dlayer.com','$6$rounds=5000$jks453yuyt55d$ZVEJgs2kNjxOxNEayqqoh2oJUiGbmxIKRqOTxVM05MP2YRcAjE9adCZfQBWCc.qe1nDjEM9.ioivNz3c/qyZ80',0,'2017-01-05 14:54:02','2017-01-05 15:01:34',1),
(3,'user-3@dlayer.com','$6$rounds=5000$jks453yuyt55d$NYF6yCvxXplefx7nr8vDe4cUGBEFtd3G5vuJ2utfqvPwEf3dSgNXNTcGbFO6WrJSn21CXHgZwNOQHy691E/Rm.',0,'2017-01-05 15:01:45','2017-01-05 15:27:24',1);

/*Table structure for table `dlayer_module` */

DROP TABLE IF EXISTS `dlayer_module`;

CREATE TABLE `dlayer_module` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dlayer_module` */

insert  into `dlayer_module`(`id`,`name`,`title`,`description`,`sort_order`,`enabled`) values 
(1,'template','Template designer','The Template designer lets you create page templates',7,0),
(2,'widget','Widget designer','The Widget designer lets you to develop reusable content items',4,0),
(3,'form','Form builder','The Form builder lets you build web forms',2,0),
(4,'content','Content manager','The Content manager lets you create and manage all your site content',1,1),
(5,'website','Web site manager (Preview)','The Web site manager lets you manage the relationships between all your site pages and data',5,0),
(6,'question','Question manager','Create quizzes, tests and polls. <span class=\"label label-default\">Planning</span>',99,0),
(7,'dlayer','Dlayer','Home',0,1),
(8,'image','Image library','Your Image and Media library',6,0),
(9,'data','Data manager','The Data manager lets you design datasets and then manage your data',3,0);

/*Table structure for table `dlayer_module_tool` */

DROP TABLE IF EXISTS `dlayer_module_tool`;

CREATE TABLE `dlayer_module_tool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `sort_order` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_id` (`module_id`,`model`),
  KEY `enabled` (`enabled`),
  CONSTRAINT `dlayer_module_tool_fk1` FOREIGN KEY (`module_id`) REFERENCES `dlayer_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dlayer_module_tool` */

insert  into `dlayer_module_tool`(`id`,`module_id`,`name`,`model`,`group_id`,`sort_order`,`enabled`) values 
(1,1,'Cancel','Cancel',1,1,1),
(2,1,'Create rows','SplitHorizontal',2,1,1),
(3,1,'Split vertical','SplitVertical',2,2,0),
(6,1,'Resize','Resize',2,3,0),
(7,1,'Background colour','BackgroundColor',3,1,0),
(8,1,'Border','Border',3,2,0),
(9,4,'Cancel','Cancel',1,1,1),
(10,4,'Text','Text',4,2,1),
(11,4,'Heading','Heading',4,1,1),
(12,3,'Text','Text',4,1,1),
(13,3,'Text area','Textarea',4,2,1),
(14,3,'Cancel','Cancel',1,1,1),
(15,3,'Password','Password',4,4,1),
(16,4,'Form','Form',5,1,1),
(17,5,'Cancel','Cancel',1,1,1),
(18,5,'New page','NewPage',2,2,1),
(19,5,'Move page','MovePage',2,1,1),
(20,3,'Email','PresetEmail',3,2,1),
(21,3,'Name','PresetName',3,1,1),
(22,4,'Text','ImportText',99,2,0),
(23,4,'Heading','ImportHeading',99,3,0),
(25,8,'Add image to library','Add',2,1,1),
(26,8,'Cancel / Back to library','Cancel',1,1,1),
(27,8,'Categories','Category',3,1,1),
(28,8,'Sub categories','SubCategory',3,2,1),
(29,8,'Clone image','Copy',4,3,1),
(30,8,'Crop image','Crop',4,2,1),
(31,8,'Edit image','Edit',4,1,1),
(32,4,'Add row(s)','AddRow',3,2,1),
(34,4,'Jumbotron','Jumbotron',4,3,1),
(35,4,'Jumbotron','ImportJumbotron',99,4,0),
(36,4,'Move row','MoveRow',19,99,0),
(37,4,'Move item','MoveItem',19,99,0),
(38,4,'Row','Row',3,1,1),
(39,4,'Image','Image',5,2,1),
(40,4,'Carousel','ImageCarousel',99,6,0),
(41,4,'Select parent','Select',19,99,0),
(42,3,'Layout','FormLayout',2,1,1),
(43,3,'Actions','FormActions',2,2,1),
(44,3,'Options','FormSettings',2,3,1),
(45,3,'Email','Email',4,3,1),
(46,4,'Content area','ContentArea',19,99,0),
(47,3,'Comment','PresetComment',3,3,1),
(48,3,'Password','PresetPassword',3,4,1),
(49,4,'Page','Page',99,1,1),
(50,4,'Column','Column',3,3,1),
(51,4,'Add column(s)','AddColumn',3,4,1),
(52,4,'HTML','Html',4,4,1);

/*Table structure for table `dlayer_module_tool_tab` */

DROP TABLE IF EXISTS `dlayer_module_tool_tab`;

CREATE TABLE `dlayer_module_tool_tab` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` tinyint(2) unsigned NOT NULL,
  `tool_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `script` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `glyph` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `glyph_style` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multi_use` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `edit_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_tool_model` (`module_id`,`tool_id`,`model`),
  KEY `enabled` (`enabled`),
  KEY `module_id` (`module_id`),
  KEY `tool_id` (`tool_id`),
  CONSTRAINT `dlayer_module_tool_tab_fk1` FOREIGN KEY (`module_id`) REFERENCES `dlayer_module` (`id`),
  CONSTRAINT `dlayer_module_tool_tab_fk2` FOREIGN KEY (`tool_id`) REFERENCES `dlayer_module_tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dlayer_module_tool_tab` */

insert  into `dlayer_module_tool_tab`(`id`,`module_id`,`tool_id`,`name`,`script`,`model`,`glyph`,`glyph_style`,`multi_use`,`edit_mode`,`default`,`sort_order`,`enabled`) values 
(1,1,2,'Quick','quick',NULL,NULL,NULL,0,0,1,1,1),
(2,1,2,'Custom','advanced',NULL,NULL,NULL,0,0,0,2,1),
(3,1,2,'?','help',NULL,NULL,NULL,0,0,0,3,1),
(4,1,3,'Quick','quick',NULL,NULL,NULL,0,0,1,1,1),
(5,1,3,'Mouse','advanced',NULL,NULL,NULL,0,0,0,2,1),
(6,1,3,'?','help',NULL,NULL,NULL,0,0,0,3,1),
(7,1,7,'#1','palette-1',NULL,NULL,NULL,0,0,1,1,1),
(8,1,7,'#2','palette-2',NULL,NULL,NULL,0,0,0,2,1),
(9,1,7,'#3','palette-3',NULL,NULL,NULL,0,0,0,3,1),
(10,1,7,'Custom','advanced',NULL,NULL,NULL,0,0,0,4,1),
(11,1,7,'?','help',NULL,NULL,NULL,0,0,0,5,1),
(12,1,6,'Custom','advanced',NULL,NULL,NULL,0,0,0,4,1),
(13,1,6,'?','help',NULL,NULL,NULL,0,0,0,5,1),
(14,1,6,'Push','expand',NULL,NULL,NULL,0,0,1,1,1),
(15,1,6,'Pull','contract',NULL,NULL,NULL,0,0,0,2,1),
(16,1,6,'Height','height',NULL,NULL,NULL,0,0,0,3,1),
(17,1,8,'Custom','advanced',NULL,NULL,NULL,0,0,0,2,1),
(18,1,8,'?','help',NULL,NULL,NULL,0,0,0,3,1),
(19,1,8,'Full border','full',NULL,NULL,NULL,0,0,1,1,1),
(20,4,10,'Text','text',NULL,'pencil',NULL,1,0,1,1,1),
(21,4,11,'Heading','heading',NULL,'pencil',NULL,1,0,1,1,1),
(22,4,10,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(23,4,11,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(24,3,12,'Field','text',NULL,'pencil',NULL,1,0,1,1,1),
(25,3,12,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(26,3,13,'Field','textarea',NULL,'pencil',NULL,1,0,1,1,1),
(27,3,13,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(28,3,15,'Field','password',NULL,'pencil',NULL,1,0,1,1,1),
(29,3,15,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(30,4,16,'Form','form',NULL,'pencil',NULL,1,0,1,1,1),
(31,4,16,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(32,5,18,'Page','new-page',NULL,'pencil',NULL,0,0,1,1,1),
(33,5,18,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(34,5,19,'Page','move-page',NULL,'transfer',NULL,0,0,1,1,1),
(35,5,19,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(36,4,10,'Styles','styling','Styling','tint',NULL,1,1,0,2,1),
(37,4,11,'Styles','styling','Styling_Heading',NULL,NULL,1,1,0,3,0),
(38,4,16,'Styles','styling','Styling_ImportForm',NULL,NULL,1,1,0,4,0),
(39,3,20,'Field','preset-email',NULL,'pencil',NULL,0,0,1,1,1),
(40,3,20,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(41,3,21,'Field','preset-name',NULL,'pencil',NULL,0,0,1,1,1),
(42,3,21,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(43,4,16,'Size & position','position','Position_ImportForm',NULL,NULL,1,1,0,3,0),
(44,4,10,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(45,4,11,'Size & position','position','Position_Heading',NULL,NULL,1,1,0,2,0),
(46,3,12,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(47,3,13,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(48,3,15,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(49,4,16,'Edit in Form builder','edit',NULL,NULL,NULL,0,1,0,2,0),
(50,4,22,'Import','import-text',NULL,NULL,NULL,1,0,1,1,0),
(51,4,22,'Help','help',NULL,NULL,NULL,0,0,0,2,0),
(52,4,23,'Import','import-heading',NULL,NULL,NULL,1,0,1,1,0),
(53,4,23,'Help','help',NULL,NULL,NULL,0,0,2,2,0),
(54,8,25,'Image','add',NULL,'upload',NULL,0,0,1,1,1),
(55,8,25,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(56,8,27,'Category','category',NULL,'pencil',NULL,0,0,1,1,1),
(57,8,27,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(58,8,28,'Sub Category','sub-category',NULL,'pencil',NULL,0,0,1,1,1),
(59,8,28,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(60,8,29,'Clone image','clone',NULL,'copy',NULL,0,0,1,1,1),
(61,8,29,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(62,8,30,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(63,8,31,'Edit image','edit',NULL,'pencil',NULL,0,0,1,1,1),
(64,8,31,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(65,8,30,'Crop image','crop',NULL,'resize-small',NULL,0,0,1,1,1),
(66,4,32,'Row','add-row',NULL,'align-justify',NULL,0,0,1,1,1),
(67,4,32,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(68,4,34,'Jumbotron','jumbotron',NULL,'pencil',NULL,1,0,1,1,1),
(69,4,34,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(70,4,34,'Styles','styling','Styling_Jumbotron',NULL,NULL,1,1,0,3,0),
(71,4,34,'Size & position','position','Position_Jumbotron',NULL,NULL,1,1,0,2,0),
(72,4,35,'Import','import-jumbotron',NULL,NULL,NULL,1,0,1,1,0),
(73,4,35,'Help','help',NULL,NULL,NULL,0,0,0,3,0),
(74,4,36,'Move','move-row',NULL,NULL,NULL,1,0,1,1,0),
(75,4,36,'Help','help',NULL,NULL,NULL,0,0,0,2,0),
(76,4,37,'Move','move-item',NULL,NULL,NULL,1,0,1,1,0),
(77,4,37,'Help','help',NULL,NULL,NULL,0,0,0,2,0),
(78,4,38,'Row','row',NULL,'align-justify',NULL,0,0,1,1,1),
(79,4,38,'Styles','styling','Styling_ContentRow',NULL,NULL,0,0,0,2,0),
(80,4,39,'Image','image',NULL,'pencil',NULL,1,0,1,1,1),
(81,4,39,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(82,4,40,'Carousel','carousel',NULL,NULL,NULL,1,0,1,1,0),
(83,4,40,'Help','help',NULL,NULL,NULL,0,0,0,2,0),
(84,4,39,'Size & position','position','Position_Image',NULL,NULL,1,1,0,2,0),
(85,4,39,'Styles','styling','Styling_Image',NULL,NULL,1,1,0,3,0),
(86,4,41,'Select','select',NULL,NULL,NULL,0,0,1,1,0),
(87,4,41,'Help','help',NULL,NULL,NULL,0,0,0,2,0),
(88,3,42,'Layout','form-layout',NULL,'wrench',NULL,1,0,1,1,1),
(89,3,42,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(90,3,45,'Field','email',NULL,'pencil',NULL,1,0,1,1,1),
(91,3,45,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(92,3,45,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(93,3,43,'Actions','form-actions',NULL,'wrench',NULL,1,0,1,1,1),
(94,3,43,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(95,3,44,'Options','form-settings',NULL,'wrench',NULL,1,0,1,1,1),
(96,3,44,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(97,4,38,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(98,4,46,'Area','content-area',NULL,NULL,NULL,0,0,1,1,0),
(99,4,46,'Styles','styling','Styling_ContentArea',NULL,NULL,0,0,0,2,0),
(100,4,46,'Help','help',NULL,NULL,NULL,0,0,0,3,0),
(101,3,47,'Field','preset-comment',NULL,'pencil',NULL,0,0,1,1,1),
(102,3,47,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(103,3,48,'Field','preset-password',NULL,'pencil',NULL,0,0,1,1,1),
(104,3,48,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(105,4,49,'Page','page',NULL,'file',NULL,0,0,1,1,1),
(106,4,49,'Help','help',NULL,'info-sign',NULL,0,0,0,3,1),
(107,4,50,'Column','column',NULL,'align-justify','transform: rotate(90deg);',0,0,1,1,1),
(108,4,50,'Help','help',NULL,'info-sign',NULL,0,0,0,5,1),
(109,4,51,'Add Column','add-column',NULL,'align-justify','transform: rotate(90deg);',0,0,1,1,1),
(110,4,51,'Help','help',NULL,'info-sign',NULL,0,0,0,2,1),
(111,4,11,'Styles','styling','Styling','tint',NULL,1,1,0,2,1),
(112,4,50,'Styles','styling','Styling','tint',NULL,1,0,0,4,1),
(113,4,38,'Styles','styling','Styling','tint',NULL,1,0,0,2,1),
(114,4,49,'Styles','styling','Styling','tint',NULL,1,0,0,2,1),
(115,4,16,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(116,4,39,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(117,4,34,'Styling','styling','Styling','tint',NULL,1,1,0,2,1),
(118,4,52,'HTML','html',NULL,'pencil',NULL,1,0,1,1,1),
(119,4,52,'Styles','styling','Styling','tint',NULL,1,1,0,2,1),
(120,4,52,'Help','help',NULL,'info-sign',NULL,0,0,0,4,1),
(121,4,11,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(122,4,34,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(123,4,39,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(124,4,16,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(125,4,52,'Typography','typography','Typography','font',NULL,1,1,0,3,1),
(126,4,50,'Settings','settings','Settings','cog',NULL,1,0,0,2,1),
(127,4,50,'Responsive','responsive','Responsive','equalizer','transform: rotate(90deg);',1,0,0,3,1);

/*Table structure for table `dlayer_session` */

DROP TABLE IF EXISTS `dlayer_session`;

CREATE TABLE `dlayer_session` (
  `session_id` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `save_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `session_data` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_id`,`save_path`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dlayer_session` */

/*Table structure for table `user_setting_color_history` */

DROP TABLE IF EXISTS `user_setting_color_history`;

CREATE TABLE `user_setting_color_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `color_hex` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_setting_color_history_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_setting_color_history` */

insert  into `user_setting_color_history`(`id`,`site_id`,`color_hex`) values 
(1,1,'#337ab7'),
(2,1,'#5cb85c'),
(3,1,'#555555'),
(4,1,'#EEEEEE'),
(5,1,'#f0ad4e'),
(6,2,'#337ab7'),
(7,2,'#5cb85c'),
(8,2,'#555555'),
(9,2,'#EEEEEE'),
(10,2,'#f0ad4e'),
(11,3,'#337ab7'),
(12,3,'#5cb85c'),
(13,3,'#555555'),
(14,3,'#EEEEEE'),
(15,3,'#f0ad4e'),
(16,1,'#d9534f'),
(17,1,'#5bc0de'),
(18,1,'#f0ad4e'),
(19,1,'#d9534f'),
(20,1,'#337ab7'),
(21,1,'#eeeeee'),
(22,1,'#5bc0de');

/*Table structure for table `user_setting_color_palette` */

DROP TABLE IF EXISTS `user_setting_color_palette`;

CREATE TABLE `user_setting_color_palette` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `view_script` char(9) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `view_script` (`view_script`),
  CONSTRAINT `user_setting_color_palette_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_setting_color_palette` */

insert  into `user_setting_color_palette`(`id`,`site_id`,`name`,`view_script`,`sort_order`) values 
(1,1,'Palette 1','palette-1',1),
(2,1,'Palette 2','palette-2',2),
(3,2,'Palette 1','palette-1',1),
(4,2,'Palette 2','palette-2',2),
(5,3,'Palette 1','palette-1',1),
(6,3,'Palette 2','palette-2',2);

/*Table structure for table `user_setting_color_palette_color` */

DROP TABLE IF EXISTS `user_setting_color_palette_color`;

CREATE TABLE `user_setting_color_palette_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `palette_id` int(11) unsigned NOT NULL,
  `color_type_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color_hex` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `palette_id` (`palette_id`),
  KEY `color_type_id` (`color_type_id`),
  CONSTRAINT `user_setting_color_palette_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_setting_color_palette_color_fk2` FOREIGN KEY (`color_type_id`) REFERENCES `designer_color_type` (`id`),
  CONSTRAINT `user_setting_color_palette_color_fk3` FOREIGN KEY (`palette_id`) REFERENCES `user_setting_color_palette` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_setting_color_palette_color` */

insert  into `user_setting_color_palette_color`(`id`,`site_id`,`palette_id`,`color_type_id`,`name`,`color_hex`) values 
(1,1,1,1,'Black','#000000'),
(2,1,1,2,'Dark grey','#333333'),
(3,1,1,3,'Grey','#555555'),
(4,1,1,4,'Light grey','#777777'),
(5,1,1,5,'Off white','#EEEEEE'),
(6,1,2,1,'Blue','#337ab7'),
(7,1,2,2,'Green','#5cb85c'),
(8,1,2,3,'Light blue','#5bc0de'),
(9,1,2,4,'Amber','#f0ad4e'),
(10,1,2,5,'Red','#d9534f'),
(11,2,3,1,'Black','#000000'),
(12,2,3,2,'Dark grey','#333333'),
(13,2,3,3,'Grey','#555555'),
(14,2,3,4,'Light grey','#777777'),
(15,2,3,5,'Off white','#EEEEEE'),
(16,2,4,1,'Blue','#337ab7'),
(17,2,4,2,'Green','#5cb85c'),
(18,2,4,3,'Light blue','#5bc0de'),
(19,2,4,4,'Amber','#f0ad4e'),
(20,2,4,5,'Red','#d9534f'),
(21,3,5,1,'Black','#000000'),
(22,3,5,2,'Dark grey','#333333'),
(23,3,5,3,'Grey','#555555'),
(24,3,5,4,'Light grey','#777777'),
(25,3,5,5,'Off white','#EEEEEE'),
(26,3,6,1,'Blue','#337ab7'),
(27,3,6,2,'Green','#5cb85c'),
(28,3,6,3,'Light blue','#5bc0de'),
(29,3,6,4,'Amber','#f0ad4e'),
(30,3,6,5,'Red','#d9534f');

/*Table structure for table `user_setting_font_and_text` */

DROP TABLE IF EXISTS `user_setting_font_and_text`;

CREATE TABLE `user_setting_font_and_text` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `module_id` tinyint(3) unsigned NOT NULL,
  `font_family_id` tinyint(3) unsigned NOT NULL,
  `text_weight_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `module_id` (`module_id`),
  KEY `font_family_id` (`font_family_id`),
  KEY `text_weight_id` (`text_weight_id`),
  CONSTRAINT `user_setting_font_and_text_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_setting_font_and_text_fk2` FOREIGN KEY (`module_id`) REFERENCES `dlayer_module` (`id`),
  CONSTRAINT `user_setting_font_and_text_fk3` FOREIGN KEY (`font_family_id`) REFERENCES `designer_css_font_family` (`id`),
  CONSTRAINT `user_setting_font_and_text_fk4` FOREIGN KEY (`text_weight_id`) REFERENCES `designer_css_text_weight` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_setting_font_and_text` */

insert  into `user_setting_font_and_text`(`id`,`site_id`,`module_id`,`font_family_id`,`text_weight_id`) values 
(1,1,3,1,1),
(2,1,4,1,1),
(3,2,3,1,1),
(4,2,4,1,1),
(5,3,3,1,1),
(6,3,4,1,1);

/*Table structure for table `user_setting_heading` */

DROP TABLE IF EXISTS `user_setting_heading`;

CREATE TABLE `user_setting_heading` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `heading_id` tinyint(3) unsigned NOT NULL,
  `style_id` tinyint(3) unsigned NOT NULL,
  `weight_id` tinyint(3) unsigned NOT NULL,
  `decoration_id` tinyint(3) unsigned NOT NULL,
  `size` tinyint(3) unsigned NOT NULL DEFAULT '12',
  `color_hex` char(7) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#000000',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `style_id` (`style_id`),
  KEY `weight_id` (`weight_id`),
  KEY `decoration_id` (`decoration_id`),
  KEY `heading_id` (`heading_id`),
  CONSTRAINT `user_setting_heading_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_setting_heading_fk2` FOREIGN KEY (`style_id`) REFERENCES `designer_css_text_style` (`id`),
  CONSTRAINT `user_setting_heading_fk3` FOREIGN KEY (`weight_id`) REFERENCES `designer_css_text_weight` (`id`),
  CONSTRAINT `user_setting_heading_fk4` FOREIGN KEY (`decoration_id`) REFERENCES `designer_css_text_decoration` (`id`),
  CONSTRAINT `user_setting_heading_fk5` FOREIGN KEY (`heading_id`) REFERENCES `designer_content_heading` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_setting_heading` */

insert  into `user_setting_heading`(`id`,`site_id`,`heading_id`,`style_id`,`weight_id`,`decoration_id`,`size`,`color_hex`,`sort_order`) values 
(1,1,1,1,2,1,22,'#000000',1),
(2,1,2,1,2,1,18,'#000000',2),
(3,1,3,1,2,1,16,'#000000',3),
(4,1,4,1,2,2,14,'#000000',4),
(5,1,5,2,2,1,14,'#000000',5),
(6,1,6,1,1,1,12,'#000000',6),
(7,2,1,1,2,1,22,'#000000',1),
(8,2,2,1,2,1,18,'#000000',2),
(9,2,3,1,2,1,16,'#000000',3),
(10,2,4,1,2,2,14,'#000000',4),
(11,2,5,2,2,1,14,'#000000',5),
(12,2,6,1,1,1,12,'#000000',6),
(13,3,1,1,2,1,22,'#000000',1),
(14,3,2,1,2,1,18,'#000000',2),
(15,3,3,1,2,1,16,'#000000',3),
(16,3,4,1,2,2,14,'#000000',4),
(17,3,5,2,2,1,14,'#000000',5),
(18,3,6,1,1,1,12,'#000000',6);

/*Table structure for table `user_site` */

DROP TABLE IF EXISTS `user_site`;

CREATE TABLE `user_site` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identity_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identity_id` (`identity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site` */

insert  into `user_site`(`id`,`identity_id`,`name`) values 
(1,1,'Sample site 1'),
(2,2,'Sample site 1'),
(3,3,'Sample site 1');

/*Table structure for table `user_site_content_heading` */

DROP TABLE IF EXISTS `user_site_content_heading`;

CREATE TABLE `user_site_content_heading` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name to identity content',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_content_heading_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_content_heading` */

insert  into `user_site_content_heading`(`id`,`site_id`,`name`,`content`) values 
(1,1,'Small heading','Small heading-:-Smaller'),
(2,1,'Footer','And now the footer'),
(3,2,'Side heading','Small heading-:-Smaller'),
(4,2,'Footer','And now the footer'),
(5,3,'Small heading','Small heading-:-Smaller'),
(6,3,'Footer','And now the footer');

/*Table structure for table `user_site_content_html` */

DROP TABLE IF EXISTS `user_site_content_html`;

CREATE TABLE `user_site_content_html` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name so user can identity content',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_content_html_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_content_html` */

insert  into `user_site_content_html`(`id`,`site_id`,`name`,`content`) values 
(1,1,'List','<ol>\r\n<li>Item one</li>\r\n<li>Item two</li>\r\n<li>Item three</li>\r\n<li>Item four</li>\r\n</ol>');

/*Table structure for table `user_site_content_jumbotron` */

DROP TABLE IF EXISTS `user_site_content_jumbotron`;

CREATE TABLE `user_site_content_jumbotron` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_content_jumbotron_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_content_jumbotron` */

insert  into `user_site_content_jumbotron`(`id`,`site_id`,`name`,`content`) values 
(1,1,'Site masthead','Welcome to your site-:-This is a Jumbotron, it is used to highlight the core content for a web page.'),
(2,2,'Site masthead','Welcome to your site-:-This is a Jumbotron, it is used to highlight the core content for a web page.'),
(3,3,'Site masthead','Welcome to your site-:-This is a Jumbotron, it is used to highlight the core content for a web page.');

/*Table structure for table `user_site_content_text` */

DROP TABLE IF EXISTS `user_site_content_text`;

CREATE TABLE `user_site_content_text` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name so user can identity content',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_content_text_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_content_text` */

insert  into `user_site_content_text`(`id`,`site_id`,`name`,`content`) values 
(1,1,'Content','Morbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.\r\n\r\nMorbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.'),
(2,1,'Left','Left footer'),
(3,1,'Middle','Middle footer'),
(4,1,'Right','Right footer'),
(5,2,'Text','Morbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.\r\n\r\nMorbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.'),
(6,2,'Left','Left footer'),
(7,2,'Middle','Middle footer'),
(8,2,'Right','Right footer'),
(9,3,'Text','Morbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.\r\n\r\nMorbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.\r\n\r\nMorbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.\r\n\r\nMorbi ultrices accumsan tortor, quis bibendum metus convallis eu. Phasellus in dictum dui. Cras bibendum viverra vestibulum. Fusce vel accumsan dui, at blandit sem. Aenean rutrum eu sapien vel viverra. Sed accumsan convallis tellus id mollis.'),
(10,3,'Left','Left footer'),
(11,3,'Middle','Middle footer'),
(12,3,'Right','Right footer');

/*Table structure for table `user_site_form` */

DROP TABLE IF EXISTS `user_site_form`;

CREATE TABLE `user_site_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form` */

insert  into `user_site_form`(`id`,`site_id`,`name`,`email`) values 
(1,1,'Feeback form','user-1@dlater.com'),
(2,2,'Feeback form','user-2@dlayer.com'),
(3,3,'Feeback form','user-3@dlayer.com');

/*Table structure for table `user_site_form_field` */

DROP TABLE IF EXISTS `user_site_form_field`;

CREATE TABLE `user_site_form_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  `field_type_id` tinyint(3) unsigned NOT NULL,
  `tool_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `form_id` (`form_id`),
  KEY `field_type_id` (`field_type_id`),
  KEY `tool_id` (`tool_id`),
  CONSTRAINT `user_site_form_field_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_form_field_fk2` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`),
  CONSTRAINT `user_site_form_field_fk3` FOREIGN KEY (`field_type_id`) REFERENCES `designer_form_field_type` (`id`),
  CONSTRAINT `user_site_form_field_fk4` FOREIGN KEY (`tool_id`) REFERENCES `dlayer_module_tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form_field` */

insert  into `user_site_form_field`(`id`,`site_id`,`form_id`,`field_type_id`,`tool_id`,`label`,`description`,`sort_order`) values 
(1,1,1,1,12,'Name','Your name',1),
(2,1,1,2,13,'Feedback','Your feedback',2),
(3,2,2,1,12,'Name','Your name',1),
(4,2,2,2,13,'Feeback','Your feedback',2),
(5,3,3,1,12,'Name','Your name',1),
(6,3,3,2,13,'Feedback','Your feedback',2);

/*Table structure for table `user_site_form_field_attribute` */

DROP TABLE IF EXISTS `user_site_form_field_attribute`;

CREATE TABLE `user_site_form_field_attribute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `attribute_id` tinyint(3) unsigned NOT NULL,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `form_id` (`form_id`),
  KEY `field_id` (`field_id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `user_site_form_field_attribute_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_form_field_attribute_fk2` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`),
  CONSTRAINT `user_site_form_field_attribute_fk3` FOREIGN KEY (`field_id`) REFERENCES `user_site_form_field` (`id`),
  CONSTRAINT `user_site_form_field_attribute_fk4` FOREIGN KEY (`attribute_id`) REFERENCES `designer_form_field_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form_field_attribute` */

insert  into `user_site_form_field_attribute`(`id`,`site_id`,`form_id`,`field_id`,`attribute_id`,`attribute`) values 
(1,1,1,1,7,'e.g. Joe bloggs'),
(2,1,1,1,1,'50'),
(3,1,1,1,2,'255'),
(4,1,1,2,3,'50'),
(5,1,1,2,4,'4'),
(6,1,1,2,8,'e.g. This is pretty limited :)'),
(7,2,2,3,7,'e.g. Joe Bloggs'),
(8,2,2,3,1,'50'),
(9,2,2,3,2,'255'),
(10,2,2,4,3,'50'),
(11,2,2,4,8,'e.g. This is pretty limited :)'),
(12,2,2,4,4,'4'),
(13,3,3,5,7,'e.g. Joe Bloggs'),
(14,3,3,5,1,'50'),
(15,3,3,5,2,'255'),
(16,3,3,6,3,'50'),
(17,3,3,6,4,'4'),
(18,3,3,6,8,'e.g. This is pretty limited :)');

/*Table structure for table `user_site_form_field_row_background_color` */

DROP TABLE IF EXISTS `user_site_form_field_row_background_color`;

CREATE TABLE `user_site_form_field_row_background_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `color_hex` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `form_id` (`form_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `user_site_form_field_row_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_form_field_row_background_color_fk2` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`),
  CONSTRAINT `user_site_form_field_row_background_color_fk3` FOREIGN KEY (`field_id`) REFERENCES `user_site_form_field` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form_field_row_background_color` */

/*Table structure for table `user_site_form_layout` */

DROP TABLE IF EXISTS `user_site_form_layout`;

CREATE TABLE `user_site_form_layout` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `submit_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reset_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `layout_id` tinyint(3) unsigned NOT NULL,
  `horizontal_width_label` tinyint(2) unsigned NOT NULL DEFAULT '2',
  `horizontal_width_field` tinyint(2) unsigned NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `form_id` (`form_id`),
  KEY `layout_id` (`layout_id`),
  CONSTRAINT `user_site_form_layout_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_form_layout_fk2` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`),
  CONSTRAINT `user_site_form_layout_fk3` FOREIGN KEY (`layout_id`) REFERENCES `designer_form_layout` (`id`),
  CONSTRAINT `user_site_form_setting_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_form_setting_fk2` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form_layout` */

insert  into `user_site_form_layout`(`id`,`site_id`,`form_id`,`title`,`sub_title`,`submit_label`,`reset_label`,`layout_id`,`horizontal_width_label`,`horizontal_width_field`) values 
(1,1,1,'Feedback',NULL,'Send',NULL,1,2,10),
(2,2,2,'Feedback',NULL,'Send',NULL,1,2,10),
(3,3,3,'Feedback',NULL,'Send',NULL,1,2,10);

/*Table structure for table `user_site_form_setting` */

DROP TABLE IF EXISTS `user_site_form_setting`;

CREATE TABLE `user_site_form_setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  `width` int(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Minimum form display width',
  `legend` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Fieldset legend text for form',
  `button` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Text for the submit button',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_form_setting` */

/*Table structure for table `user_site_history` */

DROP TABLE IF EXISTS `user_site_history`;

CREATE TABLE `user_site_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identity_id` int(11) unsigned NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `identity_id` (`identity_id`),
  CONSTRAINT `user_site_history_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_history_fk2` FOREIGN KEY (`identity_id`) REFERENCES `dlayer_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_history` */

/*Table structure for table `user_site_image_library` */

DROP TABLE IF EXISTS `user_site_image_library`;

CREATE TABLE `user_site_image_library` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `sub_category_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `category_id` (`category_id`),
  KEY `sub_category_id` (`sub_category_id`),
  CONSTRAINT `user_site_image_library_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_image_library_fk2` FOREIGN KEY (`category_id`) REFERENCES `user_site_image_library_category` (`id`),
  CONSTRAINT `user_site_image_library_fk3` FOREIGN KEY (`sub_category_id`) REFERENCES `user_site_image_library_sub_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library` */

insert  into `user_site_image_library`(`id`,`site_id`,`name`,`description`,`category_id`,`sub_category_id`) values 
(1,1,'Autumn path','Public domain image.',1,1),
(2,1,'Downtown Boston','Public domain image.',1,1),
(3,1,'Horses','Public domain image.',4,4),
(4,1,'Old lantern and brush','Public domain image.',1,1),
(5,1,'Robin','Public domain image.',4,4),
(6,1,'Signs','Public domain image.',1,1),
(7,1,'Spring coffee','Public domain image.',1,1),
(8,3,'Autumn path','Public domain image.',3,3),
(9,3,'Downtown Boston','Public domain image.',3,3),
(10,3,'Horses','Public domain image.',3,3),
(11,3,'Old lantern and brush','Public domain image.',3,3),
(12,3,'Robin','Public domain image.',3,3),
(13,3,'Signs','Public domain image.',3,3),
(14,3,'Spring coffee','Public domain image.',3,3),
(15,2,'Autumn path','Public domain image.',2,2),
(16,2,'Downtown Boston','Public domain image.',2,2),
(17,2,'Horses','Public domain image.',2,2),
(18,2,'Old lantern and brush','Public domain image.',2,2),
(19,2,'Robin','Public domain image.',2,2),
(20,2,'Signs','Public domain image.',2,2),
(21,2,'Spring coffee','Public domain image.',2,2),
(22,1,'Autumn path - Clone','Clone or original image.',1,1);

/*Table structure for table `user_site_image_library_category` */

DROP TABLE IF EXISTS `user_site_image_library_category`;

CREATE TABLE `user_site_image_library_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_image_library_category_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library_category` */

insert  into `user_site_image_library_category`(`id`,`site_id`,`name`) values 
(1,1,'Uncategorised'),
(2,2,'Uncategorised'),
(3,3,'Uncategorised'),
(4,1,'Animals');

/*Table structure for table `user_site_image_library_link` */

DROP TABLE IF EXISTS `user_site_image_library_link`;

CREATE TABLE `user_site_image_library_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `library_id` int(11) unsigned NOT NULL,
  `version_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `library_id` (`library_id`),
  KEY `version_id` (`version_id`),
  CONSTRAINT `user_site_image_library_link_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_image_library_link_fk2` FOREIGN KEY (`library_id`) REFERENCES `user_site_image_library` (`id`),
  CONSTRAINT `user_site_image_library_link_fk3` FOREIGN KEY (`version_id`) REFERENCES `user_site_image_library_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library_link` */

insert  into `user_site_image_library_link`(`id`,`site_id`,`library_id`,`version_id`) values 
(1,1,1,1),
(2,1,2,2),
(3,1,3,3),
(4,1,4,4),
(5,1,5,5),
(6,1,6,6),
(7,1,7,23),
(8,3,8,8),
(9,3,9,9),
(10,3,10,10),
(11,3,11,11),
(12,3,12,12),
(13,3,13,13),
(14,3,14,14),
(15,2,15,15),
(16,2,16,16),
(17,2,17,17),
(18,2,18,18),
(19,2,19,19),
(20,2,20,20),
(21,2,21,21),
(22,1,22,22);

/*Table structure for table `user_site_image_library_sub_category` */

DROP TABLE IF EXISTS `user_site_image_library_sub_category`;

CREATE TABLE `user_site_image_library_sub_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `user_site_image_library_sub_category_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_image_library_sub_category_fk2` FOREIGN KEY (`category_id`) REFERENCES `user_site_image_library_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library_sub_category` */

insert  into `user_site_image_library_sub_category`(`id`,`site_id`,`category_id`,`name`) values 
(1,1,1,'Misc.'),
(2,2,2,'Misc.'),
(3,3,3,'Misc.'),
(4,1,4,'Misc.');

/*Table structure for table `user_site_image_library_version` */

DROP TABLE IF EXISTS `user_site_image_library_version`;

CREATE TABLE `user_site_image_library_version` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `library_id` int(11) unsigned NOT NULL,
  `uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tool_id` int(11) unsigned NOT NULL DEFAULT '25' COMMENT 'Tool used to create version',
  `identity_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `identity_id` (`identity_id`),
  KEY `library_id` (`library_id`),
  KEY `tool_id` (`tool_id`),
  CONSTRAINT `user_site_image_library_version_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_image_library_version_fk2` FOREIGN KEY (`identity_id`) REFERENCES `dlayer_identity` (`id`),
  CONSTRAINT `user_site_image_library_version_fk3` FOREIGN KEY (`library_id`) REFERENCES `user_site_image_library` (`id`),
  CONSTRAINT `user_site_image_library_version_fk4` FOREIGN KEY (`tool_id`) REFERENCES `dlayer_module_tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library_version` */

insert  into `user_site_image_library_version`(`id`,`site_id`,`library_id`,`uploaded`,`tool_id`,`identity_id`) values 
(1,1,1,'2015-04-22 12:21:09',25,1),
(2,1,2,'2015-04-22 12:21:45',25,1),
(3,1,3,'2015-04-22 12:22:06',25,1),
(4,1,4,'2015-04-22 12:22:28',25,1),
(5,1,5,'2015-04-22 12:22:54',25,1),
(6,1,6,'2015-04-22 12:23:17',25,1),
(7,1,7,'2015-04-22 12:23:39',25,1),
(8,3,8,'2015-04-22 12:29:00',25,3),
(9,3,9,'2015-04-22 12:29:18',25,3),
(10,3,10,'2015-04-22 12:29:31',25,3),
(11,3,11,'2015-04-22 12:29:41',25,3),
(12,3,12,'2015-04-22 12:29:53',25,3),
(13,3,13,'2015-04-22 12:30:08',25,3),
(14,3,14,'2015-04-22 12:30:24',25,3),
(15,2,15,'2015-04-22 12:30:55',25,2),
(16,2,16,'2015-04-22 12:31:08',25,2),
(17,2,17,'2015-04-22 12:31:22',25,2),
(18,2,18,'2015-04-22 12:31:35',25,2),
(19,2,19,'2015-04-22 12:31:50',25,2),
(20,2,20,'2015-04-22 12:32:02',25,2),
(21,2,21,'2015-04-22 12:32:15',25,2),
(22,1,22,'2015-04-22 12:39:27',29,1),
(23,1,7,'2015-04-22 12:47:14',30,1);

/*Table structure for table `user_site_image_library_version_meta` */

DROP TABLE IF EXISTS `user_site_image_library_version_meta`;

CREATE TABLE `user_site_image_library_version_meta` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `library_id` int(11) unsigned NOT NULL,
  `version_id` int(11) unsigned NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.jpg',
  `type` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `width` smallint(5) NOT NULL DEFAULT '1',
  `height` smallint(5) NOT NULL DEFAULT '1',
  `size` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `library_id` (`library_id`),
  KEY `version_id` (`version_id`),
  CONSTRAINT `user_site_image_library_version_meta_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_image_library_version_meta_fk2` FOREIGN KEY (`library_id`) REFERENCES `user_site_image_library` (`id`),
  CONSTRAINT `user_site_image_library_version_meta_fk3` FOREIGN KEY (`version_id`) REFERENCES `user_site_image_library_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_image_library_version_meta` */

insert  into `user_site_image_library_version_meta`(`id`,`site_id`,`library_id`,`version_id`,`extension`,`type`,`width`,`height`,`size`) values 
(1,1,1,1,'.jpg','image/jpeg',615,453,173442),
(2,1,2,2,'.jpg','image/jpeg',615,461,124479),
(3,1,3,3,'.jpg','image/jpeg',615,389,42910),
(4,1,4,4,'.jpg','image/jpeg',615,410,51533),
(5,1,5,5,'.jpg','image/jpeg',615,407,32763),
(6,1,6,6,'.jpg','image/jpeg',615,461,49367),
(7,1,7,7,'.jpg','image/jpeg',615,410,47362),
(8,3,8,8,'.jpg','image/jpeg',615,453,173442),
(9,3,9,9,'.jpg','image/jpeg',615,461,124479),
(10,3,10,10,'.jpg','image/jpeg',615,389,42910),
(11,3,11,11,'.jpg','image/jpeg',615,410,51533),
(12,3,12,12,'.jpg','image/jpeg',615,407,32763),
(13,3,13,13,'.jpg','image/jpeg',615,461,49367),
(14,3,14,14,'.jpg','image/jpeg',615,410,47362),
(15,2,15,15,'.jpg','image/jpeg',615,453,173442),
(16,2,16,16,'.jpg','image/jpeg',615,461,124479),
(17,2,17,17,'.jpg','image/jpeg',615,389,42910),
(18,2,18,18,'.jpg','image/jpeg',615,410,51533),
(19,2,19,19,'.jpg','image/jpeg',615,407,32763),
(20,2,20,20,'.jpg','image/jpeg',615,461,49367),
(21,2,21,21,'.jpg','image/jpeg',615,410,47362),
(22,1,22,22,'.jpg','image/jpeg',615,453,173442),
(23,1,7,23,'.jpg','image/jpeg',561,367,42624);

/*Table structure for table `user_site_page` */

DROP TABLE IF EXISTS `user_site_page`;

CREATE TABLE `user_site_page` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `user_site_page_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page` */

insert  into `user_site_page`(`id`,`site_id`,`name`) values 
(1,1,'Sample web page'),
(2,2,'Sample web page'),
(3,3,'Sample web page');

/*Table structure for table `user_site_page_content_item_form` */

DROP TABLE IF EXISTS `user_site_page_content_item_form`;

CREATE TABLE `user_site_page_content_item_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `form_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `user_site_page_content_item_form_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_form_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_form_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_content_item_form_fk4` FOREIGN KEY (`form_id`) REFERENCES `user_site_form` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_form` */

insert  into `user_site_page_content_item_form`(`id`,`site_id`,`page_id`,`content_id`,`form_id`) values 
(1,1,1,3,1),
(2,2,2,14,2),
(3,3,3,23,3);

/*Table structure for table `user_site_page_content_item_heading` */

DROP TABLE IF EXISTS `user_site_page_content_item_heading`;

CREATE TABLE `user_site_page_content_item_heading` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `heading_id` tinyint(3) unsigned NOT NULL,
  `data_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `heading_id` (`heading_id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `user_site_page_content_item_heading_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_heading_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_heading_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_content_item_heading_fk4` FOREIGN KEY (`heading_id`) REFERENCES `designer_content_heading` (`id`),
  CONSTRAINT `user_site_page_content_item_heading_fk5` FOREIGN KEY (`data_id`) REFERENCES `user_site_content_heading` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_heading` */

insert  into `user_site_page_content_item_heading`(`id`,`site_id`,`page_id`,`content_id`,`heading_id`,`data_id`) values 
(1,1,1,5,2,1),
(2,1,1,9,3,2),
(3,2,2,13,3,3),
(4,2,2,15,3,4),
(5,3,3,20,3,5),
(6,3,3,24,3,6);

/*Table structure for table `user_site_page_content_item_html` */

DROP TABLE IF EXISTS `user_site_page_content_item_html`;

CREATE TABLE `user_site_page_content_item_html` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `data_id` int(11) unsigned NOT NULL COMMENT 'Id of content in data table',
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `site_id` (`site_id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `user_site_page_content_item_html_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_html_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_html_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_content_item_html_fk4` FOREIGN KEY (`data_id`) REFERENCES `user_site_content_html` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_html` */

insert  into `user_site_page_content_item_html`(`id`,`site_id`,`page_id`,`content_id`,`data_id`) values 
(1,1,1,28,1);

/*Table structure for table `user_site_page_content_item_image` */

DROP TABLE IF EXISTS `user_site_page_content_item_image`;

CREATE TABLE `user_site_page_content_item_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `version_id` int(11) unsigned NOT NULL,
  `expand` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `caption` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `version_id` (`version_id`),
  KEY `content_id` (`content_id`),
  CONSTRAINT `user_site_page_content_item_image_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_image_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_image_fk3` FOREIGN KEY (`version_id`) REFERENCES `user_site_image_library_version` (`id`),
  CONSTRAINT `user_site_page_content_item_image_fk4` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_image` */

insert  into `user_site_page_content_item_image`(`id`,`site_id`,`page_id`,`content_id`,`version_id`,`expand`,`caption`) values 
(1,1,1,4,5,1,'This is supposed to be a caption explaining the image'),
(2,2,2,12,19,1,'This is supposed to be a caption explaining the image'),
(3,3,3,22,12,0,'This is supposed to be a caption explaining the image');

/*Table structure for table `user_site_page_content_item_jumbotron` */

DROP TABLE IF EXISTS `user_site_page_content_item_jumbotron`;

CREATE TABLE `user_site_page_content_item_jumbotron` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `data_id` int(11) unsigned NOT NULL,
  `button_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `user_site_page_content_item_jumbotron_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_jumbotron_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_jumbotron_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_content_item_jumbotron_fk4` FOREIGN KEY (`data_id`) REFERENCES `user_site_content_jumbotron` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_jumbotron` */

insert  into `user_site_page_content_item_jumbotron`(`id`,`site_id`,`page_id`,`content_id`,`data_id`,`button_label`) values 
(1,1,1,1,1,'Learn more'),
(2,2,2,10,2,'Learn more'),
(3,3,3,19,3,'Learn more');

/*Table structure for table `user_site_page_content_item_text` */

DROP TABLE IF EXISTS `user_site_page_content_item_text`;

CREATE TABLE `user_site_page_content_item_text` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `data_id` int(11) unsigned NOT NULL COMMENT 'Id of content in data table',
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `site_id` (`site_id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `user_site_page_content_item_text_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_content_item_text_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_content_item_text_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_content_item_text_fk4` FOREIGN KEY (`data_id`) REFERENCES `user_site_content_text` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_content_item_text` */

insert  into `user_site_page_content_item_text`(`id`,`site_id`,`page_id`,`content_id`,`data_id`) values 
(1,1,1,2,1),
(2,1,1,6,2),
(3,1,1,7,3),
(4,1,1,8,4),
(5,2,2,11,5),
(6,2,2,16,6),
(7,2,2,17,7),
(8,2,2,18,8),
(9,3,3,21,9),
(10,3,3,25,10),
(11,3,3,26,11),
(12,3,3,27,12);

/*Table structure for table `user_site_page_meta` */

DROP TABLE IF EXISTS `user_site_page_meta`;

CREATE TABLE `user_site_page_meta` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`page_id`),
  KEY `page_id` (`page_id`),
  CONSTRAINT `user_site_page_meta_fk1` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_meta` */

insert  into `user_site_page_meta`(`id`,`page_id`,`title`,`description`) values 
(1,1,'Sample web page','Shows all the current content items'),
(2,2,'Sample web page','Shows all the current content items'),
(3,3,'Sample web page','Shows all the current content items');

/*Table structure for table `user_site_page_structure_column` */

DROP TABLE IF EXISTS `user_site_page_structure_column`;

CREATE TABLE `user_site_page_structure_column` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `row_id` int(11) unsigned DEFAULT NULL,
  `size` tinyint(2) unsigned NOT NULL DEFAULT '12',
  `column_type_id` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `offset` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sort_order` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `row_id` (`row_id`),
  KEY `sort_order` (`sort_order`),
  KEY `page_id` (`page_id`),
  KEY `column_type_id` (`column_type_id`),
  CONSTRAINT `user_site_page_structure_column_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_structure_column_fk2` FOREIGN KEY (`row_id`) REFERENCES `user_site_page_structure_row` (`id`),
  CONSTRAINT `user_site_page_structure_column_fk3` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_structure_column_fk4` FOREIGN KEY (`column_type_id`) REFERENCES `designer_column_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_structure_column` */

insert  into `user_site_page_structure_column`(`id`,`site_id`,`page_id`,`row_id`,`size`,`column_type_id`,`offset`,`sort_order`) values 
(1,1,1,1,12,3,0,1),
(2,1,1,2,6,3,0,1),
(3,1,1,2,6,3,0,2),
(4,1,1,3,4,3,0,1),
(5,1,1,3,4,3,0,3),
(6,1,1,3,4,3,0,2),
(7,1,1,4,12,3,0,1),
(8,2,2,5,12,3,0,1),
(9,2,2,6,6,3,0,2),
(10,2,2,6,6,3,0,1),
(11,2,2,7,12,3,0,1),
(12,2,2,8,4,3,0,1),
(13,2,2,8,4,3,0,2),
(14,2,2,8,4,3,0,3),
(15,3,3,9,12,3,0,1),
(16,3,3,10,6,3,0,1),
(17,3,3,10,6,3,0,2),
(18,3,3,11,12,3,0,1),
(19,3,3,12,4,3,0,1),
(20,3,3,12,4,3,0,2),
(21,3,3,12,4,3,0,3);

/*Table structure for table `user_site_page_structure_column_responsive` */

DROP TABLE IF EXISTS `user_site_page_structure_column_responsive`;

CREATE TABLE `user_site_page_structure_column_responsive` (
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `column_id` int(11) unsigned NOT NULL,
  `column_type_id` tinyint(3) unsigned NOT NULL,
  `size` tinyint(2) unsigned NOT NULL DEFAULT '12',
  PRIMARY KEY (`site_id`,`page_id`,`column_id`,`column_type_id`),
  KEY `user_site_page_structure_column_responsive_fk2` (`page_id`),
  KEY `user_site_page_structure_column_responsive_fk3` (`column_id`),
  KEY `user_site_page_structure_column_responsive_fk4` (`column_type_id`),
  CONSTRAINT `user_site_page_structure_column_responsive_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_structure_column_responsive_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_structure_column_responsive_fk3` FOREIGN KEY (`column_id`) REFERENCES `user_site_page_structure_column` (`id`),
  CONSTRAINT `user_site_page_structure_column_responsive_fk4` FOREIGN KEY (`column_type_id`) REFERENCES `designer_column_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_structure_column_responsive` */

/*Table structure for table `user_site_page_structure_content` */

DROP TABLE IF EXISTS `user_site_page_structure_content`;

CREATE TABLE `user_site_page_structure_content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `column_id` int(11) unsigned NOT NULL,
  `content_type` int(11) unsigned NOT NULL,
  `sort_order` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_type` (`content_type`),
  KEY `column_id` (`column_id`),
  CONSTRAINT `user_site_page_structure_content_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_structure_content_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_structure_content_fk3` FOREIGN KEY (`content_type`) REFERENCES `designer_content_type` (`id`),
  CONSTRAINT `user_site_page_structure_content_fk4` FOREIGN KEY (`column_id`) REFERENCES `user_site_page_structure_column` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_structure_content` */

insert  into `user_site_page_structure_content`(`id`,`site_id`,`page_id`,`column_id`,`content_type`,`sort_order`) values 
(1,1,1,1,4,1),
(2,1,1,2,1,1),
(3,1,1,2,3,2),
(4,1,1,3,5,2),
(5,1,1,3,2,1),
(6,1,1,4,1,1),
(7,1,1,5,1,1),
(8,1,1,6,1,1),
(9,1,1,7,2,1),
(10,2,2,8,4,1),
(11,2,2,9,1,1),
(12,2,2,9,5,2),
(13,2,2,10,2,1),
(14,2,2,10,3,2),
(15,2,2,11,2,1),
(16,2,2,12,1,1),
(17,2,2,13,1,1),
(18,2,2,14,1,1),
(19,3,3,15,4,1),
(20,3,3,16,2,1),
(21,3,3,16,1,2),
(22,3,3,17,5,1),
(23,3,3,17,3,2),
(24,3,3,18,2,1),
(25,3,3,19,1,1),
(26,3,3,20,1,1),
(27,3,3,21,1,1),
(28,1,1,3,7,3);

/*Table structure for table `user_site_page_structure_row` */

DROP TABLE IF EXISTS `user_site_page_structure_row`;

CREATE TABLE `user_site_page_structure_row` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `column_id` int(11) DEFAULT NULL,
  `sort_order` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `column_id` (`column_id`),
  KEY `site_id` (`site_id`),
  KEY `sort_order` (`sort_order`),
  CONSTRAINT `user_site_page_structure_row_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_structure_row_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_structure_row` */

insert  into `user_site_page_structure_row`(`id`,`site_id`,`page_id`,`column_id`,`sort_order`) values 
(1,1,1,0,1),
(2,1,1,0,2),
(3,1,1,0,4),
(4,1,1,0,3),
(5,2,2,0,1),
(6,2,2,0,2),
(7,2,2,0,3),
(8,2,2,0,4),
(9,3,3,0,1),
(10,3,3,0,2),
(11,3,3,0,3),
(12,3,3,0,4);

/*Table structure for table `user_site_page_styling_column_background_color` */

DROP TABLE IF EXISTS `user_site_page_styling_column_background_color`;

CREATE TABLE `user_site_page_styling_column_background_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `column_id` int(11) unsigned NOT NULL,
  `background_color` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `column_id` (`column_id`),
  CONSTRAINT `user_site_page_styling_column_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_styling_column_background_color_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_styling_column_background_color_fk3` FOREIGN KEY (`column_id`) REFERENCES `user_site_page_structure_column` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_styling_column_background_color` */

/*Table structure for table `user_site_page_styling_content_item_background_color` */

DROP TABLE IF EXISTS `user_site_page_styling_content_item_background_color`;

CREATE TABLE `user_site_page_styling_content_item_background_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `background_color` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  CONSTRAINT `user_site_page_styling_content_item_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_background_color_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_background_color_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_styling_content_item_background_color` */

/*Table structure for table `user_site_page_styling_content_item_typography` */

DROP TABLE IF EXISTS `user_site_page_styling_content_item_typography`;

CREATE TABLE `user_site_page_styling_content_item_typography` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `font_family_id` tinyint(3) unsigned DEFAULT NULL,
  `text_weight_id` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `content_id` (`content_id`),
  KEY `font_family_id` (`font_family_id`),
  KEY `text_weight_id` (`text_weight_id`),
  CONSTRAINT `user_site_page_styling_content_item_typography_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_typography_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_typography_fk3` FOREIGN KEY (`content_id`) REFERENCES `user_site_page_structure_content` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_typography_fk4` FOREIGN KEY (`font_family_id`) REFERENCES `designer_css_font_family` (`id`),
  CONSTRAINT `user_site_page_styling_content_item_typography_fk5` FOREIGN KEY (`text_weight_id`) REFERENCES `designer_css_text_weight` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_styling_content_item_typography` */

/*Table structure for table `user_site_page_styling_page_background_color` */

DROP TABLE IF EXISTS `user_site_page_styling_page_background_color`;

CREATE TABLE `user_site_page_styling_page_background_color` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(10) unsigned NOT NULL,
  `page_id` int(10) unsigned NOT NULL,
  `background_color` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  CONSTRAINT `user_site_page_styling_page_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_styling_page_background_color_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_styling_page_background_color` */

/*Table structure for table `user_site_page_styling_row_background_color` */

DROP TABLE IF EXISTS `user_site_page_styling_row_background_color`;

CREATE TABLE `user_site_page_styling_row_background_color` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `row_id` int(11) unsigned NOT NULL,
  `background_color` char(7) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `page_id` (`page_id`),
  KEY `row_id` (`row_id`),
  CONSTRAINT `user_site_page_styling_row_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
  CONSTRAINT `user_site_page_styling_row_background_color_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`),
  CONSTRAINT `user_site_page_styling_row_background_color_fk3` FOREIGN KEY (`row_id`) REFERENCES `user_site_page_structure_row` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_site_page_styling_row_background_color` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;