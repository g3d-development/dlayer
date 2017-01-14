
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
	KEY `tool_id` (`tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
