<?php

/**
 * Heading content item ribbon data class
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Dlayer_DesignerTool_ContentManager_Heading_SubTool_Styling_Ribbon extends Dlayer_Ribbon_Content
{
    /**
     * Fetch the view data for the current tool tab, typically the returned array will have at least two indexes,
     * one for the form and another with the data required by the preview functions
     *
     * @param array $tool Tool and environment data
     *
     * @return array
     */
    public function viewData(array $tool)
    {
        $this->tool = $tool;

        return array(
            'form' => new Dlayer_DesignerTool_ContentManager_Heading_SubTool_Styling_Form(
                $tool,
                $this->contentData(),
                $this->instancesOfData(),
                array()
            ),
        );
    }

    /**
     * Fetch the data array for the content item, if in edit mode mode populate the values otherwise every value is
     * set to FALSE, the tool form can simply check to see if the value is FALSe or not and then set the existing value
     *
     * @return array
     */
    protected function contentData()
    {
        $data = array(
            'content_background_color' => false,
        );

        if ($this->tool['content_id'] !== null) {
            $model_styling = new Dlayer_DesignerTool_ContentManager_Heading_SubTool_Styling_Model();
            $content_background_color = $model_styling->contentBackgroundColor(
                $this->tool['site_id'],
                $this->tool['page_id'],
                $this->tool['content_id']
            );

            if ($content_background_color !== false) {
                $data['content_background_color'] = $content_background_color;
            }

        }

        return $data;
    }

    /**
     * Fetch the number of instances for the content items data
     *
     * @return integer
     */
    protected function instancesOfData()
    {
        return 0;
    }
}