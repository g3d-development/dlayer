
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
	KEY `tool_id` (`tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
