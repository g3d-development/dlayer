<?php
/**
* A text block is simple a string of text enclosed with p tags
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_View_ContentText extends Zend_View_Helper_Abstract
{
	/**
	* Override the hinting for the view property so that we can see the view
	* helpers that have been defined
	*
	* @var Dlayer_View_Codehinting
	*/
	public $view;

	/**
	* Data array for the text item
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
	* A text block is simple a string of text enclosed with p tags
	*
	* @param array $data Content data array. containns all the data required 
	* 	to generate the html for the text content item
	* @param boolean $selectable Should the selectable class be applied to the 
	* 	content item, a content item is selectable when its content row has 
	* 	been selected
	* @param boolean $selected Shoudl the selected class be applied to the 
	* 	content item, as item is selected when in either mode, either by being 
	* 	selectable directly or after addition
	* @param integer $items The total number of content items within the 
	* 	content row, this is to help with the addition of the visual movment 
	* 	controls
	* @return Dlayer_View_ContentText
	*/
	public function contentText(array $data, $selectable=FALSE,
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
	* @return Dlayer_View_ContentText
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
		$styles = "width:{$this->view->escape($this->data['width'])}px;";
		if($this->data['padding'] > 0) {
			$styles .= " padding:{$this->view->escape(
				$this->data['padding'])}px;";
			$styles .= $this->view->contentStyles()->contentItem(
				$this->data['content_id']);

		}

		$class = NULL;
		$id = 'text:text:' . $this->view->escape($this->data['content_id']);
		$html = '';

		if($this->selectable == TRUE) {

			if($this->selected == TRUE) {
				$class = 'c_selected';
			} else {
				$class = 'c_selectable';
			}

			$container_width = intval($this->data['width']) + 
			(intval($this->data['padding']) * 2) + 
			$this->data['container_margin'];

			$mover_width = $container_width - 2;

			$html .= '<div class="content_item ' . $class . 
			'" style="width:' . $container_width . 'px;">';

			$mover = $this->view->moverContentItem($this->data['content_id'], 
				$this->data['div_id'], $this->data['page_id'], 'text', 
				$mover_width);

			if($this->data['sort_order'] != 1) {
				$html .= $mover->up();
			}
		}

		$html .= '<div style="' . $styles . '" class="item c_item_' . 
		$this->view->escape($this->data['content_id']) . 
		'" id="' . $id . '">' . nl2br($this->data['content']) . '</div>';

		if($this->selectable == TRUE) {
			if($this->items != $this->data['sort_order']) {                
				$html .= $mover->down();
			}
			$html .= '</div>';
		}

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