
CREATE TABLE `user_site_content_jumbotron` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`site_id` int(11) unsigned NOT NULL,
	`name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	`content` text COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
