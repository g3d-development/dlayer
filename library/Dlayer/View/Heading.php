<?php

/**
 * Heading content item view helper, a heading item is a string with an optional sub heading in a smaller, lighter 
 * font off to the right
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Dlayer_View_Heading extends Zend_View_Helper_Abstract
{
	/**
	 * Override the hinting for the view property so that we can see the view
	 * helpers that have been defined
	 *
	 * @var Dlayer_View_Codehinting
	 */
	public $view;

	/**
	 * @var array Data array for the content item
	 */
	private $data;

	/**
	 * Constructor for view helper, data is set via the setter methods
	 *
	 * @param array $data Content item data array
	 * @return Dlayer_View_Heading
	 */
	public function heading(array $data)
	{
		$this->resetParams();

		$this->data = $data;

		return $this;
	}

	/**
	 * Reset any internal params, we do this because the view helper could be called many times within the view script
	 *
	 * @return void
	 */
	private function resetParams()
	{
		$this->data = array();
	}

	/**
	 * Generate the html for the content item
	 *
	 * @return string
	 */
	private function render()
	{
		$tag = $this->view->escape($this->data['tag']);

		// The id of a content item is defined as follows [tool]:[item_type]:[id]
		$id = 'heading:heading:' . $this->view->escape($this->data['content_id']);
		$html = "<{$tag}>" . $this->view->escape($this->data['heading']);

		if(strlen($this->data['sub_heading']) > 0)
		{
			$html .= ' <small>' . $this->view->escape($this->data['sub_heading']) . '</small>';
		}

		$html .= "</{$tag}>";

		return $html;
	}

	/**
	 * The view helper can be output directly, there is no need to call the render method, simply echo or print
	 *
	 * @return string
	 */
	public function __toString()
	{
		return $this->render();
	}
}