<?php
/**
* Base form class for app level forms
*
* @author Dean Blackborough
* @copyright G3D Development Limited
* @version $Id: App.php 1708 2014-04-10 16:28:58Z Dean.Blackborough $
*/
abstract class Dlayer_Form_Module_App extends Dlayer_Form
{
    /**
    * Pass in any values that are needed to set up the form, optional
    * 
    * @param array|NULL Options for form
    * @return void
    */
    public function __construct($options=NULL)
    {
        parent::__construct($options=NULL);
    }
    
    /**
    * Add the default decorators to use for the form inputs
    *
    * @return void
    */
    protected function addDefaultElementDecorators()
    {
        $this->setDecorators(array(
        	'FormElements', 
        	array('Form', array('class'=>'form'))));
    	
        $this->setElementDecorators(array(
        	array('ViewHelper', array('tag' => 'div', 'class'=>'form-group')), 
        	array('Description', array('tag' => 'p', 'class'=>'help-block')),
        	array('Errors'), 
        	array('Label'), 
        	array('HtmlTag', array('tag' => 'div', 'class'=>'form-group'))));
    }

    /**
    * Add any custom decorators, these are inputs where we need a little more
    * control over the html, an example being the submit button
    *
    * @return void
    */
    protected function addCustomElementDecorators()
    {
        $this->elements['submit']->setDecorators(array(array('ViewHelper'),
        array('HtmlTag', array('tag' => 'div', 'class'=>'form-group'))));
    }
}