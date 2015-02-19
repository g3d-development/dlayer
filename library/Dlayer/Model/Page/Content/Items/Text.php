<?php
/**
* Content text item data model, all the methods required to manage a text 
* content item
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_Model_Page_Content_Items_Text 
extends Dlayer_Model_Page_Content_Item
{
	/**
	* Add a new text content item
	*
	* @param integer $site_id
	* @param integer $page_id
	* @param integer $div_id
	* @param integer $content_row_id
	* @param integer $content_id
	* @param array $params The data for the heading content item
	* @return void
	*/
	public function addContentItemData($site_id, $page_id, $div_id, 
		$content_row_id, $content_id, array $params)
	{
		$data_id = $this->contentDataExists($site_id, $params['text']);
		
		if($data_id == FALSE) {
			$data_id = $this->addToDataTable($site_id, $params['name'], 
			$params['text']);
		}
		
		$sql = "INSERT INTO user_site_page_content_item_text 
				(site_id, page_id, content_id, data_id)
				VALUES
				(:site_id, :page_id, :content_id, :data_id)";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':page_id', $page_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_id', $content_id, PDO::PARAM_INT);
		$stmt->bindValue(':data_id', $data_id, PDO::PARAM_INT);
		$stmt->execute();
	}
	
	/**
	* Check to see if the text content exists in the text data table, if 
	* it does we can use the id for the previously stored value
	* 
	* @param integer $site_id
	* @param string $content The text content to check the system for
	* @return integer|FALSE Either return the id for the existing text content 
	* 	string or FALSE if the test is a new string
	*/
	private function contentDataExists($site_id, $content) 
	{
		$sql = "SELECT usct.id 
				FROM user_site_content_text usct 
				WHERE usct.site_id = :site_id 
				AND UPPER(usct.content) = :content 
				LIMIT 1";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':content', trim(strtoupper($content)), 
			PDO::PARAM_STR);
		$stmt->execute();
		
		$result = $stmt->fetch();
		
		if($result != FALSE) {
			return intval($result['id']);
		} else {
			return FALSE;
		}
	}
	
	/** 
	* Add the content into the content data table and return the id for the 
	* newly stored string
	* 
	* @param integer $site_id
	* @param string $name 
	* @param string $content
	* @return integer Id of the text in the content data table
	*/
	private function addToDataTable($site_id, $name, $content) 
	{
		$sql = "INSERT INTO user_site_content_text 
				(site_id, `name`, content) 
				VALUES 
				(:site_id, :name, :content)";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':name', $name, PDO::PARAM_STR);
		$stmt->bindValue(':content', $content, PDO::PARAM_STR);
		$stmt->execute();
		
		return $this->_db->lastInsertId('user_site_content_text');
	}
	
	/**
	* Fetch the content data id used by an existing content item
	* 
	* @param integer $site_id
	* @param integer $page_id
	* @param integer $content_id
	* @return integer Id for the updated content
	*/
	private function updateContentData($site_id, $page_id, $content_id, 
	$name, $content) 
	{
		$sql = "UPDATE user_site_content_text 
				SET `name` = :name, content = :content 
				WHERE site_id = :site_id 
				AND id = (SELECT uspct.data_id 
				FROM user_site_page_content_text uspct 
				WHERE uspct.content_id = :content_id 
				AND uspct.site_id = :site_id 
				AND uspct.page_id = :page_id 
				LIMIT 1)";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_id', $content_id, PDO::PARAM_INT);
		$stmt->bindValue(':page_id', $page_id, PDO::PARAM_INT);
		$stmt->bindValue(':name', $name, PDO::PARAM_STR);
		$stmt->bindValue(':content', $content, PDO::PARAM_LOB);
		$stmt->execute();
		
		return $this->contentDataExists($site_id, $content);
	}

	/**
	* Edit the data for the selected text content item
	*
	* @param integer $site_id
	* @param integer $page_id
	* @param integer $div_id
	* @param integer $content_row_id
	* @param integer $content_id
	* @param array $params The data for the new content item
	* @return void
	*/
	public function editContentItemData($site_id, $page_id, $div_id, 
		$content_row_id, $content_id, array $params)
	{
		if($text['instances'] == FALSE) {
			$data_id = $this->contentDataExists($site_id, $text['content']);
			
			if($data_id == FALSE) {
				$data_id = $this->addToDataTable($site_id, $text['name'], 
				$text['content']);
			}
		} else {
			$data_id = $this->updateContentData($site_id, $page_id, 
			$content_id, $text['name'], $text['content']);
		}
		
		$sql = "UPDATE user_site_page_content_text
				SET width = :width, padding = :padding,
				data_id = :data_id 
				WHERE site_id = :site_id
				AND page_id = :page_id
				AND content_id = :content_id
				LIMIT 1";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':width', $text['width'], PDO::PARAM_INT);
		$stmt->bindValue(':padding', $text['padding'], PDO::PARAM_INT);
		$stmt->bindValue(':data_id', $data_id, PDO::PARAM_INT);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':page_id', $page_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_id', $content_id, PDO::PARAM_STR);
		$stmt->execute();
	}

	/**
	* Fetch the data for the content item being edited
	*
	* @param integer $site_id
	* @param integer $page_id
	* @param integer $div_id
	* @param integer $content_row_id
	* @param integer $content_id
	* @return array|FALSE Returns either the data array or FALSE if no data 
	* 	can be found
	*/
	public function formData($site_id, $page_id, $div_id, $content_row_id, 
		$content_id)
	{
		$sql = "SELECT uspci.id, usct.`name`, usct.content AS `text`
				FROM user_site_page_content_item_text uspcit 
				JOIN user_site_page_content_item uspci 
					ON uspcit.content_id = uspci.id 
					AND uspci.site_id = :site_id 
					AND uspci.page_id = :page_id 
					AND uspci.row_id = :content_row_id 
					AND uspci.id = :content_id 
				JOIN user_site_content_text usct 
					ON uspcit.data_id = usct.id 
					AND usct.site_id = :site_id 
				WHERE uspcit.site_id = :site_id 
				AND uspcit.page_id = :page_id
				AND uspcit.content_id = :content_id";
		$stmt = $this->_db->prepare($sql);		
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':page_id', $page_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_row_id', $content_row_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_id', $content_id, PDO::PARAM_INT);
		$stmt->execute();
		
		$result = $stmt->fetch();
		
		if($result != FALSE) {
			$result['instances'] = $this->contentDataInstances(
				$site_id, $content_id);
			
			return $result;
		} else {
			return FALSE;
		}
	}
	
	/**
	* Calculate the number of instances of the text content item text within 
	* the entire site
	* 
	* @param integer $site_id
	* @param integer $content_id 
	* @return integer Returns the count of the number of times the text has 
	* 	been used within the site
	*/
	private function contentDataInstances($site_id, $content_id) 
	{
		$sql = "SELECT COUNT(uspcth.id) AS instances 
				FROM user_site_page_content_item_text uspcth 
				WHERE uspcth.site_id = :site_id 
				AND uspcth.data_id = (SELECT ref_data.data_id 
				FROM user_site_page_content_item_text ref_data 
				WHERE ref_data.content_id = :content_id 
				AND ref_data.site_id = :site_id)";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':content_id', $content_id, PDO::PARAM_INT);
		$stmt->execute();
		
		$result = $stmt->fetch();
		
		if($result != FALSE) {
			return intval($result['instances']);
		} else {
			return 0;
		}
	}
	
	/**
	* Fetch import data from the text data tabe
	* 
	* @param integer $site_id
	* @param integer $data_id
	* @return array|FALSE
	*/
	public function importData($site_id, $data_id) 
	{
		$sql = "SELECT `name`, content 
				FROM user_site_content_text 
				WHERE site_id = :site_id 
				AND id = :data_id";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->bindValue(':data_id', $data_id, PDO::PARAM_INT);
		$stmt->execute();
		
		return $stmt->fetch();
	}
	
	/**
	* Fetch options form the import data select
	* 
	* @param integer $site_id
	* @return array
	*/
	public function importDataOptions($site_id)
	{
		$sql = "SELECT id, `name` 
				FROM user_site_content_text 
				WHERE site_id = :site_id
				ORDER BY `name` ASC";
		$stmt = $this->_db->prepare($sql);
		$stmt->bindValue(':site_id', $site_id, PDO::PARAM_INT);
		$stmt->execute();
		
		return $stmt->fetchAll();
	}
}