<?php
/**
* View helper for HTML5 range input type
* 
* @author Dean Blackborough <dean@g3d-development.com>
* @version $Id: FormElementNumber.php 1458 2014-01-25 01:10:15Z Dean.Blackborough $
*/
class Dlayer_View_FormElementRange extends Zend_View_Helper_FormElement
{
	public function formElementRange($name, $value = null, $attribs = null)
	{
		$info = $this->_getInfo($name, $value, $attribs);
		extract($info); // name, value, attribs, options, listsep, disable

		// build the element
		$disabled = '';
		if ($disable) {
			// disabled
			$disabled = ' disabled="disabled"';
		}

		$xhtml = '<input type="range"'
				. ' name="' . $this->view->escape($name) . '"'
				. ' id="' . $this->view->escape($id) . '"'
				. ' value="' . $this->view->escape($value) . '"'
				. $disabled
				. $this->_htmlAttribs($attribs)
				. $this->getClosingBracket();

		return $xhtml;
	}
}