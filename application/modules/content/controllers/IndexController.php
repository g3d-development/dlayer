<?php

/**
 * Root controller for the Content Manager, shows a lits of all the pages in the selected web site as well as links
 * the setting pages for the Content Manager
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Content_IndexController extends Zend_Controller_Action
{
    /**
     * Type hinting for action helpers
     *
     * @var Dlayer_Action_CodeHinting
     */
    protected $_helper;

    /**
     * @var Dlayer_Session_Content
     */
    private $session_content;

    private $site_id;
    private $content_page_form;

    /**
     * @var array Nav bar items
     */
    private $nav_bar_items = array(
        array(
            'uri' => '/dlayer/index/home',
            'name' => 'Dlayer Demo',
            'title' => 'Dlayer.com: Web development simplified'
        ),
        array('uri' => '/content/index/index', 'name' => 'Content Manager', 'title' => 'Content Manager'),
        array('uri' => 'http://www.dlayer.com/docs/', 'name' => 'Docs', 'title' => 'Read the Docs for Dlayer'),
    );

    /**
     * Execute the setup methods for the controller and set the properties
     *
     * @return void
     */
    public function init()
    {
        $this->_helper->validateModule();

        $this->_helper->authenticate();

        $this->_helper->validateSiteId();

        $session_dlayer = new Dlayer_Session();

        $this->site_id = $session_dlayer->siteId();
        $this->session_content = new Dlayer_Session_Content();
    }

    /**
     * Show a list of the pages that belong to the currently selected site along with add new page and edit/management
     * options
     *
     * @return void
     */
    public function indexAction()
    {
        $model_sites = new Dlayer_Model_Site();
        $model_pages = new Dlayer_Model_Page();
        
        $pages = $model_pages->pages($this->site_id);

        if ($this->session_content->pageId() === null && count($pages) === 1) {
            $this->redirect('/content/index/activate/page-id/' . $pages[0]['id']);
        }

        $this->view->site = $model_sites->site($this->site_id);
        $this->view->pages = $pages;
        $this->view->page_id = $this->session_content->pageId();

        $session_dlayer = new Dlayer_Session();
        $this->controlBar($session_dlayer->identityId(), $this->site_id);

        $this->_helper->setLayoutProperties($this->nav_bar_items, '/content/index/index', array('css/dlayer.css'),
            array(), 'Dlayer.com - Content Manager');
    }

    /**
     * Control bar
     *
     * @param integer $identity_id
     * @param integer $site_id
     *
     * @return void
     */
    private function controlBar($identity_id, $site_id)
    {
        $model_sites = new Dlayer_Model_Site();

        $control_bar_buttons = array(
            array(
                'uri' => '/dlayer/index/home',
                'class' => 'default',
                'name' => 'Dashboard'
            ),
            array(
                'uri'=>'/content/index/new-page',
                'class' => 'primary',
                'name'=>'New page'
            )
        );

        $control_bar_drops = array(
            array(
                'name' => 'Your websites',
                'class' => 'default',
                'buttons' => $model_sites->sitesForControlBar($identity_id, $site_id)
            )
        );

        $this->assignToControlBar($control_bar_buttons, $control_bar_drops);
    }

    /**
     * Assign control bar buttons
     *
     * @param array $buttons
     * @param array $drops
     *
     * @todo Move this into an action helper
     * @return void
     */
    private function assignToControlBar(array $buttons, array $drops)
    {
        $layout = Zend_Layout::getMvcInstance();
        $layout->assign('show_control_bar', true);
        $layout->assign('control_bar_buttons', $buttons);
        $layout->assign('control_bar_drops', $drops);
    }

    /**
     * Activate another content page, check that the id is valid and also check that it belongs tpo the site set
     * in the session
     *
     * @return void
     */
    public function activateAction()
    {
        $this->_helper->disableLayout(false);

        $model_pages = new Dlayer_Model_Page();

        $page_id = Dlayer_Helper::getParamAsInteger('page-id');

        if ($page_id !== null && $model_pages->valid($page_id, $this->site_id) == true) {
            $page = $model_pages->page($page_id);

            if ($page !== false) {
                $this->session_content->clearAll();
                $this->session_content->setPageId($page_id);
            }
        }

        $this->redirect('/content');
    }

    /**
     * Handle add content page, if successful the user is redirected after the ids for the new page has been set in
     * the session
     *
     * @return void
     */
    private function handleAddContentPage()
    {
        $post = $this->getRequest()->getPost();

        if ($this->content_page_form->isValid($post)) {
            $model_pages = new Dlayer_Model_Page();
            $page_id = $model_pages->savePage($this->site_id, $post['name'], $post['title'], $post['description']);

            if ($page_id !== false) {
                $this->session_content->clearAll(true);
                $this->session_content->setPageId($page_id);
                $this->redirect('/content');
            }
        }
    }

    /**
     * Handle edit content page, if successful the user is redirected back to Content manager root
     *
     * @return void
     */
    private function handleEditContentPage()
    {
        $post = $this->getRequest()->getPost();

        if ($this->content_page_form->isValid($post)) {
            $model_pages = new Dlayer_Model_Page();
            $page_id = $model_pages->savePage($this->site_id, $post['name'], $post['title'], $post['description'],
                $this->session_content->pageId());

            if ($page_id !== false) {
                $this->redirect('/content');
            }
        }
    }

    /**
     * Create a new content page for the currently selected site, users needs to enter a name to identify the
     * page within Dlayer as well as the title and description for the html
     *
     * @return void
     */
    public function newPageAction()
    {
        $model_sites = new Dlayer_Model_Site();

        $this->content_page_form = new Dlayer_Form_Site_ContentPage('/content/index/new-page', $this->site_id);

        if ($this->getRequest()->isPost()) {
            $this->handleAddContentPage();
        }

        $this->view->form = $this->content_page_form;
        $this->view->site = $model_sites->site($this->site_id);

        $session_dlayer = new Dlayer_Session();
        $this->controlBar($session_dlayer->identityId(), $this->site_id);

        $this->_helper->setLayoutProperties($this->nav_bar_items, '/content/index/index', array('css/dlayer.css'),
            array(), 'Dlayer.com - New content page');
    }

    /**
     * Edit the selected content page
     *
     * @return void
     */
    public function editPageAction()
    {
        $model_sites = new Dlayer_Model_Site();

        $this->content_page_form = new Dlayer_Form_Site_ContentPage('/content/index/edit-page', $this->site_id,
            $this->session_content->pageId());

        if ($this->getRequest()->isPost()) {
            $this->handleEditContentPage();
        }

        $this->view->form = $this->content_page_form;
        $this->view->site = $model_sites->site($this->site_id);

        $session_dlayer = new Dlayer_Session();
        $this->controlBar($session_dlayer->identityId(), $this->site_id);

        $this->_helper->setLayoutProperties($this->nav_bar_items, '/content/index/index', array('css/dlayer.css'),
            array(), 'Dlayer.com - Edit content page');
    }
}
