
insert  into `dlayer_module_tool`(`id`,`module_id`,`name`,`model`,`base`,`destructive`,`group_id`,`sort_order`,`enabled`) values
    (1,1,'Cancel','Cancel',1,0,1,1,1),
    (2,1,'Create rows','SplitHorizontal',1,1,2,1,1),
    (3,1,'Split vertical','SplitVertical',1,1,2,2,0),
    (6,1,'Resize','Resize',0,1,2,3,0),
    (7,1,'Background colour','BackgroundColor',1,0,3,1,0),
    (8,1,'Border','Border',1,0,3,2,0),
    (9,4,'Cancel','Cancel',2,0,1,1,1),
    (10,4,'Text','Text',0,0,4,2,1),
    (11,4,'Heading','Heading',0,0,4,1,1),
    (12,3,'Text','Text',0,0,4,1,1),
    (13,3,'Text area','Textarea',0,0,4,2,1),
    (14,3,'Cancel','Cancel',2,0,1,1,1),
    (15,3,'Password','Password',0,0,4,4,1),
    (16,4,'Form','Form',0,0,5,1,1),
    (17,5,'Cancel','Cancel',0,0,1,1,1),
    (18,5,'New page','NewPage',0,0,2,2,1),
    (19,5,'Move page','MovePage',0,0,2,1,1),
    (20,3,'Email','PresetEmail',0,0,3,2,1),
    (21,3,'Name','PresetName',0,0,3,1,1),
    (22,4,'Text','ImportText',0,0,99,2,0),
    (23,4,'Heading','ImportHeading',0,0,99,3,0),
    (25,8,'Add image to library','Add',1,0,2,1,1),
    (26,8,'Cancel / Back to library','Cancel',0,0,1,1,1),
    (27,8,'Categories','Category',1,0,3,1,1),
    (28,8,'Sub categories','SubCategory',1,0,3,2,1),
    (29,8,'Clone image','Copy',0,0,4,3,1),
    (30,8,'Crop image','Crop',0,0,4,2,1),
    (31,8,'Edit image','Edit',0,0,4,1,1),
    (32,4,'Add row(s)','AddRow',1,0,3,2,1),
    (34,4,'Jumbotron','Jumbotron',0,0,4,3,1),
    (35,4,'Jumbotron','ImportJumbotron',0,0,99,4,0),
    (36,4,'Move row','MoveRow',1,0,99,99,0),
    (37,4,'Move item','MoveItem',1,0,99,99,0),
    (38,4,'Row','Row',1,0,3,1,1),
    (39,4,'Image','Image',0,0,5,2,1),
    (40,4,'Carousel','ImageCarousel',0,0,99,6,0),
    (41,4,'Select parent','Select',1,0,99,99,0),
    (42,3,'Layout','FormLayout',1,0,2,1,1),
    (43,3,'Actions','FormActions',1,0,2,2,1),
    (44,3,'Options','FormSettings',1,0,2,3,1),
    (45,3,'Email','Email',0,0,4,3,1),
    (46,4,'Content area','ContentArea',1,0,99,99,0),
    (47,3,'Comment','PresetComment',0,0,3,3,1),
    (48,3,'Password','PresetPassword',0,0,3,4,1),
    (49,4,'Page','Page',1,0,99,1,1),
    (50,4,'Column','Column',1,0,3,3,1),
    (51,4,'Add column(s)','AddColumn',1,0,3,4,1),
    (52,4,'HTML','Html',0,0,4,4,1);
