<?php
/**
* Base designer class for the image library, brings together all the data 
* required to generated the html for the Image library designer view
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_Designer_ImageLibrary
{
    private $site_id;

    private $image_id = NULL;
    private $category_id = NULL;
    private $sub_category_id = NULL;

    /**
    * Initialise the object, run setup methods and set initial properties
    *
    * @param integer $site_id
    * @param integer|NULL $image_id Id of the selected library image
    * @param integer|NULL $category_id Id of the selected filter category
    * @param integer|NULL $sub_category_id Id of the selected filter 
    *                                      sub category
    * @return void
    */
    public function __construct($site_id, $image_id=NULL, $category_id=NULL, 
    $sub_category_id=NULL)
    {
        $this->site_id = $site_id;
        $this->image_id = $image_id;
        $this->category_id = $category_id;
        $this->sub_category_id = $sub_category_id;
    }
}