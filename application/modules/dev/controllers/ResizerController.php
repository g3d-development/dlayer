<?php
/**
* Controller for image library class development
*
* @author Dean Blackborough <dean@g3d-development.com>
* @copyright G3D Development Limited
*/
class Dev_ResizerController extends Zend_Controller_Action
{
    /**
    * Type hinting for action helpers, hints the property to the code
    * hinting class which exists in the library
    *
    * @var Dlayer_Action_CodeHinting
    */
    protected $_helper;

    private $layout;

    /**
    * Init the controller, run any set up code required by all the actions
    * in the controller
    *
    * @return void
    */
    public function init()
    {
        $this->_helper->setLayout('dev');
        
        // Include js and css files in layout
        $this->layout = Zend_Layout::getMvcInstance();
        $this->layout->assign('js_include', array());
        $this->layout->assign('css_include', array());
    }

    /**
    * Overview action for new class
    *
    * @return void
    */
    public function indexAction()
    {
        // Add in code to see if thumbnail exists
    }
    
    /**
    * Process
    *
    * @return void
    */
    public function processAction()
    {
        $error = "None";
        
        try {
            $resizer = new Dlayer_Image_LibraryResizer_Jpeg(100);
            $resizer->loadImage('test-s2.jpg', 
            'images/testing/resizer/');
            $resizer->resize('images/testing/resizer/', 'test-s2-resized');
        } catch (Exception $e) {
            $error = $e->getMessage();
        } 
        
        $this->view->error = $error;
    }
    
    /**
    * Load new thumbnail
    * 
    * @return void
    */
    public function deleteAction() 
    {
        $error = "None";
        
        if(file_exists(
        'images/testing/resizer/test-resized.jpg') == TRUE) {
            $result = unlink(
            'images/testing/resizer/test-resized.jpg');
            
            if($result == TRUE) {
                $this->_redirect('/dev/resizer/index');
            } else {
                 $error = "Delete failed";
            }
        } else {
            $error = "File doesn't exist, expected 
            'images/testing/resizer/test-resized.jpg'";
        }
        
        $this->view->error = $error;
    }
}