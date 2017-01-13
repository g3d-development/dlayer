
ALTER TABLE `dlayer`.`user_site_page_styling_page_background_color`
    ADD CONSTRAINT `user_site_page_styling_page_background_color_fk1` FOREIGN KEY (`site_id`) REFERENCES `user_site` (`id`),
    ADD CONSTRAINT `user_site_page_styling_page_background_color_fk2` FOREIGN KEY (`page_id`) REFERENCES `user_site_page` (`id`);
