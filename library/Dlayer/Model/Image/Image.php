<?php
/**
* Image library image model, handles everything relating to a single image
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_Model_Image_Image extends Zend_Db_Table_Abstract
{
    /**
    * Fetch the detail for the selected image
    * 
    * @param integer $site_id
    * @param integer $image_id 
    * @param integer $version_id 
    * @return array|FALSE Contains all the details required for the details 
    *                     column of the image detail page or FALSE if unable to 
    *                     select image
    */
    public function detail($site_id, $image_id, $version_id) 
    {
        $sql = "SELECT usil.`name`, usilc.`name` AS category, 
                usilsc.`name` AS sub_category, usil.description, 
                usilv.width, usilv.height, usilv.size, 
                DATE_FORMAT(usilv.uploaded, '%e %b %Y') AS uploaded, 
                di.identity AS email 
                FROM user_site_image_library_versions usilv 
                JOIN user_site_image_library usil 
                    ON usilv.library_id = usil.id 
                    AND usil.site_id = :site_id 
                JOIN dlayer_identities di 
                    ON usilv.identity_id = di.id 
                JOIN user_site_image_library_categories usilc 
                    ON usil.category_id = usilc.id 
                    AND usilc.site_id = :site_id 
                JOIN user_site_image_library_sub_categories usilsc 
                    ON usil.sub_category_id = usilsc.id 
                    AND usilsc.category_id = usilc.id 
                    AND usilsc.site_id = :site_id 
                WHERE usilv.site_id = :site_id 
                AND usilv.library_id = :image_id 
                AND usilv.id = :version_id";
        $stmt = $this->_db->prepare($sql);
        $stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
        $stmt->bindValue(':image_id', $image_id, PDO::PARAM_INT);
        $stmt->bindValue(':version_id', $version_id, PDO::PARAM_INT);
        $stmt->execute();
        
        return $stmt->fetch();
    }
    
    /**
    * Fetch the version info for the requested library images, data array 
    * contains all the versions of an image in chronological order, these 
    * include the shallow versions created each time an image is attached
    * to an item
    * 
    * @param integer $site_id
    * @param integer $image_id
    * @return array|FALSE There should always be at least 1 version, FALSE is 
    *                     returned if for somereason there isn't at least one 
    *                     row in the result set
    *                     The result array is indexed by version_id
    */
    public function versions($site_id, $image_id) 
    {
        $sql = "SELECT usilv.library_id AS image_id, usilv.id AS version_id, 
                usilv.width, usilv.height, 
                DATE_FORMAT(usilv.uploaded, '%e %b %Y') AS uploaded, 
                dmt.`name` AS tool, usilv.size 
                FROM user_site_image_library_versions usilv 
                JOIN dlayer_module_tools dmt 
                    ON usilv.tool_id = dmt.id 
                    AND dmt.module_id = 8 
                WHERE usilv.site_id = :site_id 
                AND usilv.library_id = :library_id 
                ORDER BY usilv.uploaded DESC";
        $stmt = $this->_db->prepare($sql);
        $stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
        $stmt->bindValue(':library_id', $image_id, PDO::PARAM_INT);#
        $stmt->execute();
        
        $result = $stmt->fetchAll();
        
        if(count($result) > 0) {
            $images = array();
            
            $n = count($result);
            
            foreach($result as $row) {
                $row['version'] = "Version " . $n;
                $row['size'] = Dlayer_Helper::readableFilesize($row['size']);
                $images[$row['version_id']] = $row;
                
                $n--;
            }
            
            return $images;
        } else {
            return FALSE;
        }
    }
    
    /**
    * Add image to database
    * 
    * @param integer $site_id
    * @param integer $tool_id
    * @param integer $identity_id
    * @param array $params Tool form params array
    * @return array Contains the image id and version id for the newly created 
    *               image
    */
    public function addImage($site_id, $tool_id, $identity_id, $params) 
    {
        $library_id = $this->addToLibrary($site_id, $params['name'], 
        $params['description'], $params['category_id'], 
        $params['sub_category_id']);
        
        $version_id = $this->addToVersions($site_id, $library_id, '.jpg', 
        960, 720, $size, $identity_id, $tool_id);
        
        $this->addToLinks($site_id, $library_id, $version_id);
        
        return array('image_id'=>$library_id, 'version_id'=>$version_id);
    }
    
    /**
    * Add to library table
    * 
    * @param integer $site_id
    * @param string $name
    * @param string $description
    * @param integer $category_id
    * @param integer $sub_category_id
    * @return integer Library id for new image
    */
    private function addToLibrary($site_id, $name, $description, $category_id, 
    $sub_category_id) 
    {
        $sql = "INSERT INTO user_site_image_library 
                (site_id, `name`, description, category_id, sub_category_id) 
                VALUES 
                (:site_id, :name, :description, :category_id, 
                :sub_category_id)";
        $stmt = $this->_db->prepare($sql);
        $stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
        $stmt->bindValue(':name', $name, PDO::PARAM_STR);
        $stmt->bindValue(':description', $description, PDO::PARAM_STR);
        $stmt->bindValue(':category_id', $category_id, PDO::PARAM_INT);
        $stmt->bindValue(':sub_category_id', $sub_category_id, PDO::PARAM_INT);
        $stmt->execute();
        
        return $this->_db->lastInsertId('user_site_image_library');
    }
    
    /**
    * Add to image data to the versions table
    * 
    * @param integer $site_id
    * @param integer $library_id
    * @param string $extension
    * @param integer $width
    * @param integer $height
    * @param integer $size
    * @param integer $identity_id
    * @param integer $tool_id
    * @return integer Versions id for new image
    */
    private function addToVersions($site_id, $library_id, $extension, $width, 
    $height, $size, $identity_id, $tool_id) 
    {
        $sql = "INSERT INTO user_site_image_library_versions 
                (site_id, library_id, extension, width, height, size, tool_id, 
                identity_id) 
                VALUES 
                (:site_id, :library_id, :extension, :width, :height, :size, 
                :tool_id, :identity_id)";
        $stmt = $this->_db->prepare($sql);
        $stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
        $stmt->bindValue(':library_id', $library_id, PDO::PARAM_INT);
        $stmt->bindValue(':extension', $extension, PDO::PARAM_STR);
        $stmt->bindValue(':width', $width, PDO::PARAM_INT);
        $stmt->bindValue(':height', $height, PDO::PARAM_INT);
        $stmt->bindValue(':size', $size, PDO::PARAM_INT);
        $stmt->bindValue(':tool_id', $tool_id, PDO::PARAM_INT);
        $stmt->bindValue(':identity_id', $identity_id, PDO::PARAM_INT);
        $stmt->execute();
        
        return $this->_db->lastInsertId('user_site_image_library_versions');
    }
    
    /**
    * Add to links table
    * 
    * @param integer $site_id
    * @param integer $library_id
    * @param integer $version_id
    * @return void
    */
    private function addToLinks($site_id, $library_id, $version_id) 
    {
        $sql = "INSERT INTO user_site_library_links 
                (site_id, library_id, version_id) 
                VALUES 
                (:site_id, :library_id, :version_id)";
        $stmt = $this->_db->prepare($sql);
        $stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
        $stmt->bindValue(':library_id', $library_id, PDO::PARAM_INT);
        $stmt->bindValue(':version_id', $version_id, PDO::PARAM_INT);
        $stmt->execute();
    }
}