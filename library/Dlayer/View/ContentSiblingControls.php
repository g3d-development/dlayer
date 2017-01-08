<?php

/**
 * Generate the sibling content item controls
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Dlayer_View_ContentSiblingControls extends Zend_View_Helper_Abstract
{
    /**
     * Override the hinting for the view property so that we can see the view
     * helpers that have been defined
     *
     * @var Dlayer_View_Codehinting
     */
    public $view;

    private $siblings;

    /**
     * Set the data for the controls
     *
     * @param array $siblings
     *
     * @return Dlayer_View_ContentSiblingControls
     */
    public function contentSiblingControls($siblings)
    {
        $this->resetParams();

        $this->siblings = $siblings;

        return $this;
    }

    /**
     * Reset any internal params, we need to reset the params in case the view helper is called multiple times
     * within the same view script.
     *
     * @return void
     */
    public function resetParams()
    {
        $this->siblings = null;
    }

    /**
     * Generate the further reading html
     *
     * @return string
     */
    private function render()
    {
        $html = '<div class="col-md-12 col-sm-12">';
        $html .= '<h5>Column content items: <small>Select a sibling</small></h5>';

        if ($this->siblings['previous'] === false) {
            $html .= '<a class="btn btn-sm btn-info" disabled="disabled" href="#">Previous</a> ';
        } else {
            $html .= '<a class="btn btn-sm btn-info" title="Select the previous content item in this column" href="/content/design/set-selected-content/id/' . $this->view->escape($this->siblings['previous']) . '/tool/' . $this->view->escape($this->siblings['previous_data']['tool']) . '/content-type/' . $this->view->escape($this->siblings['previous_data']['content_type']) . '">Previous</a> ';
        }

        if ($this->siblings['next'] === false) {
            $html .= '<a class="btn btn-sm btn-info" disabled="disabled" href="#">Next</a>';
        } else {
            $html .= '<a class="btn btn-sm btn-info" title="Select the next content item in this column" href="/content/design/set-selected-content/id/' . $this->view->escape($this->siblings['next']) . '/tool/' . $this->view->escape($this->siblings['next_data']['tool']) . '/content-type/' . $this->view->escape($this->siblings['next_data']['content_type']) . '">Next</a> ';
        }

        $html .= '</div>';

        return $html;
    }

    /**
     * The view helpers can be output directly, we define the __toString method so that echo and print calls on the
     * object return the html generated by the render method
     *
     * @return string The generated html
     */
    public function __toString()
    {
        return $this->render();
    }
}
