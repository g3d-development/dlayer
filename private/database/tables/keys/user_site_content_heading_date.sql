
ALTER TABLE `dlayer`.`user_site_content_heading_date`
    ADD CONSTRAINT `user_site_content_heading_date_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`);
