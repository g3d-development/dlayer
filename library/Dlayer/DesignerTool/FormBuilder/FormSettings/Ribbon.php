<?php

/**
 * Form setting/options ribbon data class.
 *
 * Returns the data for the requested tool tab ready to be passed to the view script. The viewData method needs to
 * always return an array, other than that there are no specific requirements for tools
 *
 * Each view file needs to check for the expected indexes itself, tools and tool tabs can and do operate differently
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Dlayer_DesignerTool_FormBuilder_FormSettings_Ribbon extends Dlayer_Ribbon_Module_Form
{
	/**
	 * Instantiate and return the form to add or edit a text field
	 *
	 * @param integer $site_id
	 * @param integer $form_id
	 * @param string $tool Name of the selected tool
	 * @param string $tab Name of the selected tool tab
	 * @param integer $multi_use Tool tab multi use param
	 * @param integer|NULL $field_id Id of the form field if in edit mode
	 * @param boolean $edit_mode Is the tool tab in edit mode
	 * @return array
	 */
	public function viewData($site_id, $form_id, $tool, $tab, $multi_use, $field_id = NULL, $edit_mode = FALSE)
	{
		$this->writeParams($site_id, $form_id, $tool, $tab, $multi_use, $field_id, $edit_mode);

		return array(
			'form' => new Dlayer_DesignerTool_FormBuilder_FormSettings_Form('form-settings', '', '/form/process/tool/', $this->form_id,
				$this->existingData(), $this->edit_mode, $this->multi_use),
			'preview_data' => array(),
		);
	}

	/**
	 * Fetch any existing data to preset the values on the form, alternative to the Dlayer_Ribbon_Module_Form::fieldData
	 * method
	 *
	 * @return array
	 */
	private function existingData()
	{
		return array();
	}
}