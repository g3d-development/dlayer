<?php
/**
* Generates a UL based navigation item, nav tag wrapped around a UL list
* 
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_View_UlNavigation extends Zend_View_Helper_Abstract 
{
    /**
    * Override the hinting for the view property so that we can see the view
    * helpers that have been defined
    *
    * @var Dlayer_View_Codehinting
    */
    public $view;
    
    private $class;
    private $items;
    private $active_url;
    
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
    public function ulNavigation($class, array $items, $active_url='') 
    {
        $this->resetParams();
        
        $this->class = $class;
        $this->items = $items;
        $this->active_url = $active_url;
        
        return $this;
    }
    
    /**
    * Reset any internal params, need to reset the params in case the view 
    * helper is called multiple times within the same view.
    * 
    * @return void
    */
    public function resetParams() 
    {
        $this->class = '';
        $this->items = array();
        $this->active_url = '';
    }
    
    /**
    * Generate the html
    * 
    * @return string 
    */
    private function render() 
    {
        $html = '';
        
        if(count($this->items) > 0) {
            
            $html = '<nav class="' . $this->class . '">';
            $html .= '<ul class="' . $this->class . '">';
            
            foreach($this->items as $item) {
            	$class = NULL;
            	
            	if($item['url'] == $this->active_url) { 
                    $class = ' class="selected"';
                }
            	
                $html .= '<li' . $class . '><a  href="' . 
                $this->view->escape($item['url']) . '" title="' . 
                $this->view->escape($item['title']) . '">' . 
                $this->view->escape($item['name']) . '</a>'; 
                
                if(array_key_exists('children', $item) == TRUE) {
                    $html .= '<ul class="children"">';
                    foreach($item['children'] as $child) {
                        $html .= '<li><a  href="' . 
                        $this->view->escape($child['url']) . '" title="' . 
                        $this->view->escape($child['title']) . '">' . 
                        $this->view->escape($child['name']) . '</a>'; 
                    }
                    $html .= '</ul>';
                }
                
                $html .= '</li>';
            }
            
            $html .= '</ul>';
            $html .= '</nav>';
        }
        
        return $html;
    }
    
    /**
    * The view helpers can be output directly, no need to call and return the 
    * render method, we define the __toString method so that echo and print 
    * calls on the object return the html generated by the render method
    * 
    * @return string Generated html
    */
    public function __toString() 
    {
        return $this->render();
    }
    
}
