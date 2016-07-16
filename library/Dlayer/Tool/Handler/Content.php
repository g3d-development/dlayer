<?php

/**
 * Base class for the content module tools. All tool classes need to define the abstract methods of this class and
 * the Dlayer_Tool class
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
abstract class Dlayer_Tool_Handler_Content extends Dlayer_Tool
{
	protected $site_id = NULL;
	protected $page_id = NULL;
	protected $row_id = NULL;
	protected $column_id = NULL;
	protected $content_id = NULL;

	/**
	 * Validate the posted params, checks to ensure the correct params exists and then checks to ensure that the values
	 * are of the correct format and if necessary within the acceptable range. If the data is valid it is written to
	 * the class properties so we don't need to pass the data in again, the process method can called directly if
	 * validation was successful
	 *
	 * @param array $params
	 * @param integer $site_id
	 * @param integer $page_id
	 * @param integer|NULL $row_id
	 * @param integer|NULL $column_id
	 * @param integer|NULL $content_id
	 * @return boolean
	 */
	public function validate(array $params, $site_id, $page_id, $row_id = NULL, $column_id = NULL,
		$content_id = NULL)
	{
		if($this->paramsExist($params) === TRUE && $this->paramsValid($params))
		{
			$this->site_id = $site_id;
			$this->page_id = $page_id;
			$this->row_id = $row_id;
			$this->column_id = $column_id;
			$this->content_id = $content_id;

			$this->paramsAssign($params);

			$this->validated = TRUE;

			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}

	/**
	 * Validate the posted params, checks to ensure the correct params exists and then checks to ensure that the values
	 * are of the correct format and if necessary within the acceptable range. If the data is valid it is written to
	 * the class properties so we don't need to pass the data in again, the process method can called directly if
	 * validation was successful
	 *
	 * The auto methods are used for structural changes to the page, the validateAuto function writes the params to
	 * $this->params_auto once validated
	 *
	 * @param array $params
	 * @param integer $site_id
	 * @param integer $page_id
	 * @param integer|NULL $row_id
	 * @param integer|NULL $column_id
	 * @param integer|NULL $content_id
	 * @return boolean
	 */
	public function validateAuto(array $params, $site_id, $page_id, $row_id = NULL, $column_id = NULL,
		$content_id = NULL)
	{
		if($this->paramsExist($params) === TRUE && $this->paramsValid($params))
		{
			$this->site_id = $site_id;
			$this->page_id = $page_id;
			$this->row_id = $row_id;
			$this->column_id = $column_id;
			$this->content_id = $content_id;

			$this->paramsAssign($params, FALSE);

			$this->validated_auto = TRUE;

			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}

	/**
	 * Check that the required params have been submitted, check the keys in the params array
	 *
	 * @param array $params
	 * @return boolean
	 */
	abstract protected function paramsExist(array $params);

	/**
	 * Check to ensure the posted params are of the correct type and optionally within range
	 *
	 * @param array $params
	 * @return boolean
	 */
	abstract protected function paramsValid(array $params);

	/**
	 * Prepare the posted params, convert them to the required types and assign to the $this->params property
	 *
	 * @param array $params
	 * @param boolean $manual_tool Are the values to be assigned to $this->params or $this->params_auto
	 * @return void
	 */
	abstract protected function paramsAssign(array $params, $manual_tool = TRUE);

	/**
	 * Process the request for a manual tool, this will either add a new item/setting or edit the details for an
	 * existing item/setting, the method will check the value of $this->validated before processing the request
	 *
	 * @return integer|FALSE Id of the content id or FALSE upon failure
	 */
	public function process()
	{
		if($this->validated === TRUE)
		{
			if($this->content_id === NULL)
			{
				$this->content_id = $this->add();
			}
			else
			{
				$this->edit();
			}

			return $this->content_id;
		}
		else
		{
			return FALSE;
		}
	}

	/**
	 * Process the request for the auto tools, auto tools handle structural changes to the content page
	 *
	 * @return array|FALSE An array of the environment vars to set or FALSE upon failure
	 */
	public function processAuto()
	{
		if($this->validated_auto === TRUE)
		{
			$ids = $this->structure();

			return $ids;
		}
		else
		{
			return FALSE;
		}
	}

	/**
	 * Add a new content item or setting
	 *
	 * @return integer|FALSE Id of the content item created or id of the content item setting belongs to
	 */
	abstract protected function add();

	/**
	 * Edit a new content item or setting
	 *
	 * @return integer|FALSE Id of the content item being edited or id of the content item the changed setting
	 * belongs to
	 */
	abstract protected function edit();

	/**
	 * Make a structural change to the page
	 *
	 * @return array|FALSE An array of the environment vars to set or FALSE upon error
	 */
	abstract protected function structure();
}