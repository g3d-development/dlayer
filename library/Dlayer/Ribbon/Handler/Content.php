<?php

/**
 * Handler class for the content manager tools, called by the content manager Ajax method, simply passes the
 * request off to the specific ribbon class for the tool
 *
 * The handlers are similar for each of the designers, the difference being the designer environment variables that are
 * passed in
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Dlayer_Ribbon_Handler_Content
{
	/**
	 * @var integer $site_id Id of the selected site
	 */
	private $site_id;

	/**
	 * @var integer $page_id Id of the selected page
	 */
	private $page_id;

	/**
	 * @var integer $multi_use Is the tool a multi use tool?
	 */
	private $multi_use;

	/**
	 * @var boolean $edit_mode Is the tool in what would be considered edit mode
	 */
	private $edit_mode;

	/**
	 * @var integer|NULL Id of the selected row, if any
	 */
	private $row_id;

	/**
	 * @var integer|NULL Id of the selected row, if any
	 */
	private $column_id;

	/**
	 * @var integer|NULL Id of the selected content item, if any
	 */
	private $content_id;

	/**
	 * Constructor for class, set required data
	 *
	 * @param integer $site_id
	 * @param integer $page_id
	 * @param string $tool
	 * @param string $tab
	 * @param integer $multi_use
	 * @param boolean $edit_mode
	 * @param integer|NULL $row_id
	 * @param integer|NULL $column_id
	 * @param integer|NULL $content_id
	 * @return array|FALSE Returns an array of the data necessary to create the tool tab for the tool or FALSE if
	 * there is no data or something went wrong
	 */
	public function viewData($site_id, $page_id, $tool, $tab, $multi_use, $edit_mode=FALSE, $row_id=NULL,
		$column_id=NULL, $content_id=NULL)
	{
		$this->site_id = $site_id;
		$this->page_id = $page_id;
		$this->multi_use = $multi_use;
		$this->edit_mode = $edit_mode;
		$this->row_id = $row_id;
		$this->column_id = $column_id;
		$this->content_id = $content_id;

		switch($tool)
		{
			case 'add-row':
				$data = $this->addRow($tool, $tab);
			break;

			
			
			
			case 'page':
				$data = $this->page();
			break;

			case 'content-area':
				$data = $this->contentArea();
			break;

			case 'content-row':
				$data = $this->contentRow();
			break;

			case 'move-row':
				$data = $this->moveRow();
			break;

			case 'move-item':
				$data = $this->moveItem();
			break;

			case 'text':
				$data = $this->text();
			break;

			case 'heading':
				$data = $this->heading();
			break;

			case 'jumbotron':
				$data = $this->jumbotron();
			break;

			case 'import-form':
				$data = $this->importForm();
			break;

			case 'image':
				$data = $this->image();
			break;

			case 'import-text':
				$data = $this->importText();
			break;

			case 'import-heading':
				$data = $this->importHeading();
			break;

			case 'import-jumbotron':
				$data = $this->importJumbotron();
			break;

			case 'select':
				$data = $this->select();
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Base tool params, uses by every tool, accessible via $data['tool'] in the view
	 *
	 * @todo Once all the tool have been updated move this method, could be in controller
	 * @param string $tool
	 * @return array
	 */
	private function toolParams($tool)
	{
		return array(
			'name' => $tool,
			'page_id' => $this->page_id,
			'column_id' => $this->column_id,
			'row_id' => $this->row_id,
			'content_id' => $this->content_id,
			'multi_use' => $this->multi_use,
		);
	}

	/**
	 * Fetch the view data for the add row tool, very simple tool, currently no ribbon class, just going to
	 * return an array containing the data for the hidden fields
	 *
	 * @param string $tool The tool name
	 * @param string $tab The tool tab name
	 * @return array|FALSE
	 */
	private function addRow($tool, $tab)
	{
		$data = FALSE;

		switch($tab)
		{
			case 'add-row':
				$data = array(
					'tool' => $this->toolParams($tool),
				);
			break;

			default:
			break;
		}

		return $data;
	}



	/**
	 * Fetch the view tab data for the heading tool, in this case the form for
	 * the ribbon. If there is any existing data the form will show the current
	 * values
	 *
	 * @return array|FALSE
	 */
	private function heading()
	{
		switch($this->tab)
		{
			case 'heading':
				$ribbon_heading = new Dlayer_Ribbon_Content_Heading();

				$data = $ribbon_heading->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'position':
				$ribbon_position = new
				Dlayer_Ribbon_Content_Position_Heading();
				$data = $ribbon_position->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'styling':
				$ribbon_styling = new Dlayer_Ribbon_Content_Styling_Heading();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the text tool, in this case the form for
	 * the ribbon. If there is any existing data the form will show the current
	 * values
	 *
	 * @return array|FALSE
	 */
	private function text()
	{
		switch($this->tab)
		{
			case 'text':
				$ribbon_text = new Dlayer_Ribbon_Content_Text();
				$data = $ribbon_text->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'position':
				$ribbon_position = new Dlayer_Ribbon_Content_Position_Text();
				$data = $ribbon_position->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'styling':
				$ribbon_styling = new Dlayer_Ribbon_Content_Styling_Text();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the jumbotron tool, in this case the form for
	 * the ribbon. If there is any existing data the form will show the current
	 * values
	 *
	 * @return array|FALSE
	 */
	private function jumbotron()
	{
		switch($this->tab)
		{
			case 'jumbotron':
				$ribbon_jumbotron = new Dlayer_Ribbon_Content_Jumbotron();
				$data = $ribbon_jumbotron->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'position':
				$ribbon_position =
					new Dlayer_Ribbon_Content_Position_Jumbotron();
				$data = $ribbon_position->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'styling':
				$ribbon_styling =
					new Dlayer_Ribbon_Content_Styling_Jumbotron();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the import text tool, in this case the
	 * form for the ribbon.
	 *
	 * @return array|FALSE
	 */
	private function importText()
	{
		switch($this->tab)
		{
			case 'import-text':
				$ribbon_import_text = new Dlayer_Ribbon_Content_ImportText();
				$data = $ribbon_import_text->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the import heading tool, in this case the
	 * form for the ribbon.
	 *
	 * @return array|FALSE
	 */
	private function importHeading()
	{
		switch($this->tab)
		{
			case 'import-heading':
				$ribbon_import_heading =
					new Dlayer_Ribbon_Content_ImportHeading();
				$data = $ribbon_import_heading->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the import jumbotron tool, in this case the
	 * form for the ribbon.
	 *
	 * @return array|FALSE
	 */
	private function importJumbotron()
	{
		switch($this->tab)
		{
			case 'import-jumbotron':
				$ribbon_import_jumbotron =
					new Dlayer_Ribbon_Content_ImportJumbotron();
				$data = $ribbon_import_jumbotron->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the import form tool, in this case a form
	 * with the list of forms for the site, a width for the form container
	 * and also a padding value
	 *
	 * @return array|FALSE
	 */
	private function importForm()
	{
		switch($this->tab)
		{
			case 'import-form':
				$ribbon_form = new Dlayer_Ribbon_Content_ImportForm();
				$data = $ribbon_form->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'edit':
				$ribbon_reference =
					new Dlayer_Ribbon_Content_Reference_ImportForm();
				$data = $ribbon_reference->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'position':
				$ribbon_position = new
				Dlayer_Ribbon_Content_Position_ImportForm();
				$data = $ribbon_position->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			case 'styling':
				$ribbon_styling =
					new Dlayer_Ribbon_Content_Styling_ImportForm();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the selected image tool tab (sub tool)
	 *
	 * @return array|FALSE
	 */
	private function image()
	{
		switch($this->tab)
		{
			/**
			 * Fetch the data for the image tab, the returned array will include
			 * the html for the insert image form
			 */
			case 'image':
				$ribbon_form = new Dlayer_Ribbon_Content_Image();
				$data = $ribbon_form->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			/**
			 * Fetch the data for the size and position tab, the returned aray
			 * will include the html for the form along with the data required
			 * for the preview functions
			 */
			case 'position':
				$ribbon_position = new
				Dlayer_Ribbon_Content_Position_Image();
				$data = $ribbon_position->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			/**
			 * Fetch the data for the styling tab, the returns array will
			 * include the form foe the styling options along with the data
			 * required for the preview functions
			 */
			case 'styling':
				$ribbon_styling =
					new Dlayer_Ribbon_Content_Styling_Image();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			/**
			 * No need to return any data to generate the view script, typically
			 * this will be for help tabs
			 */
			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the select parent tool
	 *
	 * @return array|FALSE
	 */
	private function select()
	{
		switch($this->tab)
		{
			/**
			 * Fetch the data for the select tab, returns all the ids required
			 * to generate the links
			 */
			case 'select':
				$ribbon_select = new Dlayer_Ribbon_Content_Select();
				$data = $ribbon_select->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			/**
			 * No need to return any data to generate the view script, typically
			 * this will be for help tabs
			 */
			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the move row tool, in this case just the
	 * form for the ribbon
	 *
	 * @return array|FALSE
	 */
	private function moveRow()
	{
		switch($this->tab)
		{
			case 'move-row':
				$ribbon_move_row =
					new Dlayer_Ribbon_Content_MoveRow();
				$data = $ribbon_move_row->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the content row tool, in this case just the
	 * form for the ribbon
	 *
	 * @return array|FALSE
	 */
	private function contentRow()
	{
		switch($this->tab)
		{
			case 'styling':
				$ribbon_styling =
					new Dlayer_Ribbon_Content_Styling_ContentRow();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the move item tool, in this case just the
	 * form for the ribbon
	 *
	 * @return array|FALSE
	 */
	private function moveItem()
	{
		switch($this->tab)
		{
			case 'move-item':
				$ribbon_move_item =
					new Dlayer_Ribbon_Content_MoveItem();
				$data = $ribbon_move_item->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view tab data for the content area tool, in this case just the
	 * form for the ribbon
	 *
	 * @return array|FALSE
	 */
	private function contentArea()
	{
		switch($this->tab)
		{
			case 'styling':
				$ribbon_styling =
					new Dlayer_Ribbon_Content_Styling_ContentArea();
				$data = $ribbon_styling->viewData($this->site_id,
					$this->page_id, $this->div_id, $this->tool, $this->tab,
					$this->multi_use, $this->edit_mode, $this->content_row_id,
					$this->content_id);
			break;

			default:
				$data = FALSE;
			break;
		}

		return $data;
	}

	/**
	 * Fetch the view data for the page tool
	 *
	 * There are no sub tools for the page tool at the moment so we can simply return FALSE
	 *
	 * @return array|FALSE
	 */
	private function page()
	{
		return FALSE;
	}
}