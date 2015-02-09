<?php
/**
* PHPed can't code hint for view helpers, they are dynamically invoked, in
* the viewscript and layout scripts we phpDoc hint $this to this class
* and then create methods for each of the vuie helpers, these methods will
* return the view helper class, the result being code completion
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
* @version $Id: Codehinting.php 1774 2014-04-30 16:17:34Z Dean.Blackborough $
*/
class Dlayer_View_Codehinting extends Zend_View_Helper_Abstract
{
	/**
	* Returns site's base url, or file with base url prepended
	*
	* $file is appended to the base url for simplicity
	*
	* @param  string|null $file
	* @return string
	*/
	public function baseUrl($file = null) { }

	/**
	* Set or retrieve doctype
	*
	* @param  string $doctype
	* @return Zend_View_Helper_Doctype
	*/
	public function doctype($doctype = null) { }

	/**
	* Encode data as JSON, disable layouts, and set response header
	*
	* If $keepLayouts is true, does not disable layouts.
	*
	* @param  mixed $data
	* @param  bool $keepLayouts
	* NOTE:   if boolean, establish $keepLayouts to true|false
	*         if array, admit params for Zend_Json::encode as enableJsonExprFinder=>true|false
	*         this array can contains a 'keepLayout'=>true|false
	*         that will not be passed to Zend_Json::encode method but will be used here
	* @return string|void
	*/
	public function json($data, $keepLayouts = false) { }

	/**
	* Escape var to protect from XSS
	*
	* @param string $string String to escape
	* @return string
	*/
	public function escape($string) { }

	/** 
	* Template styles view helper, generates the initial style attribute for 
	* each template div, width and height and then calls all the additional 
	* template style view helpers to generate the attributes for the rest of 
	* the styles that have been defined for each template div
	* 
	* @return Dlayer_View_TemplateStyles
	*/
	public function templateStyles() { }

	/** 
	* This is the base content view helper, it is called by the content row 
	* view helper and generates all the html the content items that have been 
	* added to the requested row, once all the html has been generated the 
	* string is passed back to the content row view helper.
	* 
	* The html for individual content items is handled by child view 
	* helpers, there is one for each content type, this helper passes the 
	* requests on and then concatenates the output
	* 
	* @return Dlayer_View_Content
	*/
	public function content() { }

	/** 
	* Template background color style view helper, generates the background 
	* color style attributes for each of the template divs
	* 
	* @return Dlayer_View_TemplateStylesBackgroundColors
	*/
	public function templateStylesBackgroundColors() { }

	/** 
	* Border style view helper, generates the border styling for each of the 
	* template divs
	* 
	* @return Dlayer_View_TemplateStylesBorders
	*/
	public function templateStylesBorders() { }

	/** 
	* Template layout view helper, generates the html for the selected template,
	* essentially it just loops through the divs that make up the template
	* adding the styles as necessary
	* 
	* @param array $template Div template data array
	* @param array $styles Styles data array for template
	* @param integer|NULL $div_id Selected element in designer
	* @return Dlayer_View_Template
	*/
	public function template(array $template, array $styles, 
	$div_id=NULL) { }

	/**
	* Content page view helper, generates all the html for a content page by
	* first creating the template, adding the content rows to the content
	* areas and then assigning the content items to the content rows.
	*
	* The content items, rows, and all styles, template and content items
	* have been passed into the view helper, these are passed to the relevant
	* view helpers as soon as possible for performance reasons and then it
	* is down to each dependant view helper to check for data in the base
	* data arrays
	*
	* @param array $template Template div data array
	* @param array $content_rows Content row data array for the page
	* @param array $content Content data array for page, contains the
	* 	raw data for all the content items that have been assigned to the
	* 	current page
	* @param array $template_styles Template styles data array, contains all
	* 	the styles for the divs that make up the template the page is based
	* 	upon
	* @param array $content_styles Content styles data array, contains all
	* 	the styles that have been assigned to content items for the current
	* 	page
	* @param integer|NULL $div_id Id of the currently selected div, referred to
	* 	later as the content area
	* @param integer|NULL $content_row_id Id of the selected content row
	* @param integer|NULL $content_id Id of the selected content item
	* @return Dlayer_View_Page
	*/
	public function page(array $template, array $content_rows, array $content,
		array $template_styles, array $content_styles, $div_id=NULL,
		$content_row_id=NULL, $content_id=NULL) { }

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
		$selected=FALSE, $items=1) { }

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
		$selected=FALSE, $items=1) { }

	/**
	* Simple pagination view helper, generates next and previous links as well
	* as the text between the links. The text between the links can be either
	* of the following formats, 'item n-m of o' or 'page n of m'. All the text
	* can be changed to whatever suits bests.
	*
	* @param integer $per_page The number of results per page
	* @param integer $start Start record for paging
	* @param integer $total Total number of results in the full recordset
	* @param string $url URL to use for pagination links, typically the url
	*                    of the current page
	* @param integer $text_style Text style for text between links,
	*                            1 = item based, 2 = page based
	* @param string $previous Previous page link text
	* @param string $next Next page link text
	* @param string $record Records n of m text, not relevant if page based
	*                       text is used
	* @param string $records Rather than work out plural for text, just set it,
	*                        not relevant if page based text is used
	* @return DLayer_View_Pagination
	*/
	public function pagination($per_page, $start, $total, $url, $text_style=1,
	$previous='Previous', $next='Next', $record='Record',
	$records='Records') { } 
	
	/**
	* Simple navigation menu, nav tag wrapped around a tags, selected item 
	* is given an active class.
	* 
	* @param string $class Class for menu container
	* @param array $items Array of menu links, each item should be an array 
	*                     with url and name fields for the data
	* @param string $active_url The active URL, used to assign the selected 
	*                           class
	* @return Dlayer_View_Navigation
	*/
	public function navigation($class, array $items, $active_url='') { }
	
	/**
	* Generates a UL based navigation item, nav tag wrapped around a UL list
	* 
	* @param string $class Class for nav container
	* @param array $items Array of menu links, each item should be an array 
	*                     with url and name fields for the data
	* @param string $active_url The active URL, used to assign the selected 
	*                           class
	* @return Dlayer_View_Navigation
	*/
	public function ulNavigation($class, array $items, $active_url='') { } 
	
	/**
	* A form is wrapped in a container, the user defines the width and 
	* padding, the layout settings and styes are all defined in the form 
	* builder
	* 
	* @param array $data Content data array. contains the form object, width 
	*                    and padding for the container
	* @param boolean $selectable Should the content item be selectable for 
	*                            moving and editing
	* @param boolean $selected Is the content block currently selected for
	*                          editing
	* @param integer $items Total number of content items in page div
	* @return Dlayer_View_ContentForm
	*/
	public function contentForm(array $data, $selectable=FALSE,
	$selected=FALSE, $items=1) { } 
	
	/**
	* Generates the html for the movement controls, up and down in the content 
	* manager
	* 
	* @param integer $content_id Id of the content item
	* @param integer $div_id Id of the page div content is applied to
	* @param integer $page_id Id of the page
	* @param string $type Content item type
	* @param integer $width Width of the mover
	* @return Dlayer_View_MoverContentItem
	*/
	public function moverContentItem($content_id, $div_id, $page_id, $type, 
	$width) { }
	
	/**
	* Generates the html for the movement controls, up and down in the form 
	* builder
	* 
	* @param integer $field_id Id of the form field
	* @param string $type Form field type
	* @return Dlayer_View_MoverFormField
	*/
	public function moverFormField($field_id, $type) { }
	
	/**
	* Generates the html and javascript for the color picker, called on ribbon 
	* tabs that have color inputs that need to the replaced by calls to the 
	* color picker
	* 
	* The color picker and javscript methods should be returned individually 
	* in different parts of the script, javascript at the end of the script 
	* after all html, color picker before any contols
	* 
	* Example usage, <?php echo $this->colorPicker()->javascript(); ?> 
	* and <?php echo $this->colorPicker()->picker(TRUE, FALSE, TRUE); ?>
	* 
	* @return Dlayer_View_ColorPicker
	*/
	public function colorPicker() { } 
	
	/** 
	* Content styles view helper, generates the additional style attributes 
	* for a content item, data defined using tool styling tab. 
	* 
	* There is a view helper for each styling group this view helper calls 
	* them all and returns the final style string
	* 
	* @return Dlayer_View_ContentStyles
	*/
	public function contentStyles() { }
	
	/** 
	* Content item background color styles view helper, generates the 
	* background color style attributes for each of the content items
	* 
	* @return Dlayer_View_ContentStylesBackgroundColors
	*/
	public function contentStylesBackgroundColors() { }
	
	/** 
	* Content item margin values view helper, generates the style attributes 
	* for each of the content items based on the set data
	* 
	* @return Dlayer_View_ContentStylesMargins
	*/
	public function contentStylesMargins() { }
	
	/**
	* Generate the html for a bootstrap navbar, allows the developer to define 
	* the brand name, navbar items including dropdowns and allow the inverted 
	* style to be selected
	* 
	* @param string $brand Brand name, appears to let of navbar
	* @param array $navbar_items Array containing the navbar items, each item 
	* 							 should be an array with url, title and name 
	* 							 fields, dropdowns can be created by defining 
	* 							 a children field with the same format array
	* @param string $active_url The URL of the active item, not always the 
	* 							current URL
	* @return Dlayer_View_BootstrapNavbar
	*/
	public function bootstrapNavbar($brand, array $navbar_items, 
	$active_url='') { }
	
	/**
	* Generates the HTML for a bootstrap nav item
	* 
	* @param string $class Class for UL, defauilts to 'nav nav-tabs'
	* @param array $items Array of menu links, each item should be an array 
	*                     with url, name and title fields for the data
	* @param string $active_url The active URL, used to assign the active 
	*                           class
	* @return Dlayer_View_BootstrapNav
	*/
	public function bootstrapNav(array $items, $active_url='', 
	$class='nav nav-tabs') { } 
	
	/**
	* Simple pagination view helper, generates next and previous links as well 
	* as the text between the links. The text between the links can be either 
	* of the following formats, 'item n-m of o' or 'page n of m'. All the text 
	* can be changed to whatever suits bests.
	* 
	* @param integer $per_page The number of results per page
	* @param integer $start Start record for paging
	* @param integer $total Total number of results in the full recordset
	* @param string $url URL to use for pagination links, typically the url 
	*                    of the current page
	* @param integer $text_style Text style for text between links,  
	*                            1 = item based, 2 = page based
	* @param string $previous Previous page link text
	* @param string $next Next page link text
	* @param string $record Records n of m text, not relevant if page based 
	*                       text is used
	* @param string $records Rather than work out plural for text, just set it, 
	*                        not relevant if page based text is used
	* @return DLayer_View_BootstrapPagination 
	*/
	public function bootstrapPagination($per_page, $start, $total, $url, 
	$text_style=1, $previous='Previous', $next='Next', $record='Record', 
	$records='Records') { } 
	
	/** 
	* The content row view helpers generated the invisible content rows 
	* divs, these hoold content items, for each content row the content view 
	* helper is called which in turns generates the page comtent
	* 
	* @return Dlayer_View_ContentRow
	*/
	public function contentRow() { }
}