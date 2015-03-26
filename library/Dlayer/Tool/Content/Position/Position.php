<?php
/**
* Edit the size and position values for a content item
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_Tool_Content_Position_Position extends Dlayer_Tool_Module_Content
{
	/**
	* Check that all the required values have been posted as part of the 
	* params array. Another method will be called after this to ensure that 
	* the values are of the correct type, no point doing the mnore complex 
	* validation if the required values aren't provided
	* 
	* @param array $params 
	* @param integer|NULL $content_id
	* @return boolean Returns TRUE if all the expected values have been posted 
	* 	as part of the request
	*/
	protected function validateFields(array $params=array(), $content_id=NULL)
	{
		if(array_key_exists('size', $params) == TRUE && 
			array_key_exists('offset', $params) == TRUE) {
				
			return TRUE;
		} else {
			return FALSE;
		}
	}

	/**
	* Check to ensure that all the submitted data is valid, it has to be of 
	* the expected format or within an expected range
	* 
	* @param array $params Params array to validte
	* @param integer $site_id
	* @param integer $page_id
	* @param integer $div_id
	* @param integer|NULL $content_row_id
	* @param array $params Params array to validte
	* @param integer|NULL $content_id
	* @return boolean Returns TRUE if all the values are of the expected size 
	* 	twpe and within range
	*/
	protected function validateValues($site_id, $page_id, $div_id, 
		$content_row_id=NULL, array $params=array(), $content_id=NULL)
	{
		$valid = FALSE;
		
		if(intval($params['size']) >= 1 && 
			intval($params['size']) <= 12 && 
			intval($params['offset']) >= 0 && 
			intval($params['offset']) <= 12) {
			
			$valid = TRUE;
		}
		
		return $valid;
	}

	/**
	* Prepare the submitted data by converting the values into the correct 
	* data types for the tool
	*
	* @param array $params
	* @param integer|NULL $content_id
	* @return array THe prepared data array
	*/
	protected function prepare(array $params, $content_id=NULL)
	{
		$prepared = array(
			'size'=>intval($params['size']), 
			'offset'=>intval($params['offset']));

		return $prepared;
	}
	
	protected function addContentItem($site_id, $page_id, $div_id, 
		$content_row_id, $content_type)
	{
		 
	}

	/**
	* Update the size and positon values for the selected text content item
	* 		
	* @param mixed $site_id
	* @param mixed $page_id
	* @param mixed $div_id
	* @param mixed $content_row_id
	* @param mixed $content_id
	* @return void
	*/
	protected function editContentItem($site_id, $page_id, $div_id, 
		$content_row_id, $content_id)
	{
		$model_size = new Dlayer_Model_Page_Content_Size();
		$size_and_offset = $model_size->sizeAndOffset($site_id, $page_id, 
			$content_id);
			
		if($size_and_offset != FALSE) {
			if($size_and_offset['size'] != $this->params['size']) {
				$model_size->updateSize($site_id, $page_id, $content_id, 
					$this->params['size']);
			}
			
			if($size_and_offset['offset'] != $this->params['offset']) {
				$model_size->updateOffset($site_id, $page_id, $content_id, 
					$this->params['offset']);
			}
		} else {
			$model_size->setSizeAndOffset($site_id, $page_id, $content_id, 
				$this->params['size'], $this->params['offset']);
		}
	}
		
	protected function structure($site_id, $page_id, $div_id, 
		$content_row_id=NULL)
	{
		
	}
}