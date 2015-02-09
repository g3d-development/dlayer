<?php
/**
* A heading content item is simply a heading string enclosed within one of the 
* six standard heading types, H1 through H6. The styles for the headings will 
* have already been output in the top of the view script, only custom style 
* options will be added here
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_View_ContentHeading extends Zend_View_Helper_Abstract
{
	/**
	* Override the hinting for the view property so that we can see the view
	* helpers that have been defined
	*
	* @var Dlayer_View_Codehinting
	*/
	public $view;

	/**
	* Data array for the heading
	*
	* @var array
	*/
	private $data = array();

	/**
	* Is the content item currently selectable? 
	* 
	* @var boolean
	*/
	private $selectable;

	/**
	* Is the content item currently selected withing the designer view?
	*
	* @var boolean
	*/
	private $selected;

	/**
	* The number of content items in the content row
	* 
	* @param integer
	*/
	private $items;

	/**
	* A heading content item is simply a heading string enclosed within one 
	* of the six standard heading types, H1 through H6. The styles for the 
	* headings will have already been output in the top of the view script, 
	* only custom style options will be added here
	*
	* @param array $data Content data array. containns all the data required 
	* 	to generate the html for the heading content item
	* @param boolean $selectable Should the selectable class be applied to the 
	* 	content item, a content item is selectable when its content row has 
	* 	been selected
	* @param boolean $selected Shoudl the selected class be applied to the 
	* 	content item, as item is selected when in either mode, either by being 
	* 	selectable directly or after addition
	* @param integer $items The total number of content items within the 
	* 	content row, this is to help with the addition of the visual movment 
	* 	controls
	* @return Dlayer_View_ContentHeading
	*/
	public function contentHeading(array $data, $selectable=FALSE,
		$selected=FALSE, $items=1)
	{
		$this->resetParams();

		$this->data = $data;
		$this->selectable = $selectable;
		$this->selected = $selected;
		$this->items = $items;

		return $this;
	}

	/**
	* Reset any internal params, we need to reset the params for the view 
	* helper in case it is called multiple times within the same view
	*
	* @return Dlayer_View_ContentHeading
	*/
	private function resetParams()
	{
		$this->data = NULL;
		$this->selectable = FALSE;
		$this->selected = FALSE;
	}

	/**
	* THis is the worker method for the view helper, it generates the html 
	* for the content item and the html for the content item container and 
	* the movement controls
	*
	* @return string The generated html
	*/
	private function render()
	{
		$tag = $this->view->escape($this->data['tag']);

		$id = 'heading:heading:' . $this->view->escape(
			$this->data['content_id']);
		
		$html = '';
		
		$html .= '<div class="col-12-md">';
		$html .= '<' . $tag . ' class="item c_item_' . $this->view->escape(
			$this->data['content_id']) . '" id="' . $id . '">';
		$html .= $this->view->escape($this->data['content']);
		$html .= '</' . $tag . '>';
		$html .= '</div>';

		return $html;
	}

	/**
	* The view helpers can be output directly, no need to call and return the
	* render method, we define the __toString method so that echo and print
	* calls on the object return the html generated by the render method
	*
	* @return string The html generated by the render method
	*/
	public function __toString()
	{
		return $this->render();
	}
}