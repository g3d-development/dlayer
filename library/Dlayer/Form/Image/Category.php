<?php
/**
* Form for the category tool
* 
* Allows the user to add a new category to the image library
* 
* This form is only used for both the add and edit category forms
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dlayer_Form_Image_Category extends Dlayer_Form_Module_Image
{
	/**
    * Set the initial properties for the form
    * 
    * @param array $existing_data Exisitng data array for form, array values 
    *                             always preset, will have FALSE values if there 
    *                             is no existing data value
    * @param boolean $edit_mode Is the tool in edit mode
    * @param array|NULL $options Zend form options data array
    * @return void
    */
    public function __construct(array $existing_data, $edit_mode, 
    $options=NULL)
    {
        parent::__construct($existing_data, $edit_mode, $options);
    }
    
    /**
    * Initialuse the form, sers the url and submit method and then calls the
    * methods that set up the form
    *
    * @return void
    */
    public function init()
    {
        $this->setAction('/image/process/tool');

        $this->setMethod('post');

        $this->setUpFormElements();

        $this->validationRules();
        
        $this->addElementsToForm('category', 'Category', $this->elements);

        $this->addDefaultElementDecorators();

        $this->addCustomElementDecorators();
    }

	/**
    * Set up all the elements required for the form, these are broken down 
    * into two sections, hidden elements for the tool and then visible 
    * elements for the user
    *
    * @return void The form elements are written to the private $this->elemnets
    * 			   array
    */
    protected function setUpFormElements()
    {
        $this->toolElements();

        $this->userElements();
    }

    /**
    * Set up the tool elements, these are the elements that define the tool and 
    * store the session values for the designer
    *
    * @return void Writes the elements to the private $this->elements array
    */
    private function toolElements()
    {
        $tool = new Zend_Form_Element_Hidden('tool');
        $tool->setValue($this->tool);

        $this->elements['tool'] = $tool;
        
        if($this->edit_mode == TRUE && 
        array_key_exists('id', $this->existing_data) == TRUE && 
        $this->existing_data['id'] != FALSE) {
            $category_id = new Zend_Form_Element_Hidden('category_id');
            $category_id->setValue($this->existing_data['id']);
            $this->elements['category_id'] = $category_id;
        }
        
        $multi_use = new Zend_Form_Element_Hidden('multi_use');
        $multi_use->setValue(1);
        $multi_use->setBelongsTo('params');

        $this->elements['multi_use'] = $multi_use;
    }

    /**
    * Set up the user elements, these are the elements that the user interacts 
    * with to use the tool
    * 
    * @return void Writes the elements to the private $this->elements array
    */
    private function userElements()
    {
    	$name = new Zend_Form_Element_Text('name');
        $name->setLabel('Category name');
        $name->setAttribs(array('maxlength'=>255, 
        'placeholder'=>'e.g., Backgrounds'));
        $name->setDescription('Enter a name for the image category.');
        $name->setBelongsTo('params');
        
        /**
        * @todo Need to move these simple checks into a method in the base 
        * class, stop the duplication
        */
        if($this->edit_mode == TRUE && 
        array_key_exists('name', $this->existing_data) == TRUE && 
        $this->existing_data['name'] != FALSE) {
            $name->setValue($this->existing_data['name']);
        }

        $this->elements['name'] = $name;
        
        $submit = new Zend_Form_Element_Submit('submit');
        $submit->setAttrib('class', 'submit');
        $submit->setAttrib('disabled', 'disabled');
        $submit->setLabel('Save');

        $this->elements['submit'] = $submit;
    }

    /**
    * Add the validation rules for the form elements and set the custom error
    * messages
    *
    * @return void
    */
    protected function validationRules()
    {

    }
}