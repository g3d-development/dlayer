<?php

/**
 * Application bootstrap, environment setup for the app, module bootstraps set
 * up anything that is specific to the module
 *
 * @author Dean Blackborough <dean@g3d-development.com>
 * @copyright G3D Development Limited
 * @license https://github.com/Dlayer/dlayer/blob/master/LICENSE
 */
class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    /**
     * Set PHP defaults, in this case the timesize, not safe to rely on the
     * server setting
     *
     * @return void
     */
    public function _initPhpDefaults()
    {
        // Not safe to relay on servers timezone
        if (function_exists('date_default_timezone_set')) {
            date_default_timezone_set('Europe/London');
        }
    }

    /**
     * Set doc type, set to HTML5, ensures that any code generated by the Zend
     * view helper is correct
     */
    public function _initDocType()
    {
        $this->bootstrap('layout');
        $this->getResource('layout')
            ->getView()
            ->doctype('HTML5');
    }

    /**
     * Set up namespaces for our library code, going to be serveral libraries,
     * base library code will reside in Dlayer, specific module library code goes
     * in a folder with the same name as the module
     *
     * @return void
     */
    function _initNamespaces()
    {
        Zend_Loader_Autoloader::getInstance()
            ->registerNamespace('Dlayer_');
    }

    /**
     * Setup view helpers, view helpers exists only inside the Dlayer library,
     * shared between all modules, this appears to be a Zend issue at the moment
     * so just need to work around it
     *
     * @return void
     */
    function _initViewHelpers()
    {
        $renderer = Zend_Controller_Action_HelperBroker::getStaticHelper(
            'viewRenderer');
        $renderer->initView();
        $renderer->view->addHelperPath('Dlayer/View/',
            'Dlayer_View');
    }

    /**
     * Setup action helpers, exist only within the Dlayer library, shared between
     * all the modules, as per view helpers this appears to be a Zend issue so
     * just going to work with it
     *
     * @return void
     */
    public function _initActionHelpers()
    {
        Zend_Controller_Action_HelperBroker::addPath('Dlayer/Action/',
            'Dlayer_Action');
    }

    /**
     * Connect to the default database and set the default adapter
     *
     * @return void
     */
    public function _initDatabaseConnection()
    {
        /**
         * Fetch the options from the application.ini file and create the
         * data array for the database connection
         */
        $config_options = $this->getApplication()
            ->getOptions();

        $pdo_params = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8;');

        $db_config_array =
            array(
                'host' => $config_options['database']['default']['host'],
                'username' => $config_options['database']['default']['user'],
                'password' => $config_options['database']['default']['password'],
                'dbname' => $config_options['database']['default']['name'],
                'driver_options' => $pdo_params,
            );

        if (strlen($config_options['database']['default']['socket']) > 0) {
            $db_config_array['unix_socket'] = $config_options['database']['default']['socket'];
        }

        $dbconn = Zend_Db::factory('Pdo_Mysql', $db_config_array);

        try {
            $dbconn->getConnection();
        } catch (Zend_Db_Adapter_Exception $e) {
            $e->getMessage();
            $e->getTraceAsString();
        } catch (Zend_Exception $e) {
            $e->getMessage();
            $e->getTraceAsString();
        }

        // Assign default adapter
        $dbconn->setFetchMode(PDO::FETCH_ASSOC);
        Zend_Db_Table_Abstract::setDefaultAdapter($dbconn);
    }

    /**
     * Set up the session save handler, sessions are going to be stored in
     * the database, not the filesystem
     *
     * @return void
     */
    public function _initSessionHandler()
    {
        $router = new Zend_Controller_Router_Rewrite();
        $request = new Zend_Controller_Request_Http();
        $router->route($request);
        if ($request->getModuleName() !== 'setup') {
            $session_config = array(
                'name' => 'dlayer_session',
                'primary' => array(
                    'session_id',
                    'save_path',
                    'name',
                ),
                'primaryAssignment' => array(
                    'sessionId',
                    'sessionSavePath',
                    'sessionName',
                ),
                'modifiedColumn' => 'modified',
                'dataColumn' => 'session_data',
                'lifetimeColumn' => 'lifetime',
            );

            $options = $this->getApplication()
                ->getOption('session');

            Zend_Session::setOptions(
                array('gc_maxlifetime' => intval($options['timeout']) + 1));
            Zend_Session::setSaveHandler(new Zend_Session_SaveHandler_DbTable(
                $session_config));
        }
    }

    /**
     * Set up environment settings
     *
     * @return void
     */
    public function _initEnvironmentSettings()
    {
        $this->bootstrap('layout');

        $debug = $this->getApplication()
            ->getOption('debug');

        $this->getResource('layout')
            ->assign('debug', $debug);
    }

    /**
     * Set up the app logger
     *
     * @return void
     */
    public function _initAppLogger()
    {
        $dlayer_session = new Dlayer_Session();

        if ($dlayer_session->identityId() === false) {
            $writer = new Zend_Log_Writer_Stream(APPLICATION_PATH . '/../private/logs/app.log');
            $logger = new Zend_Log($writer);
        } else {
            $writer = new Zend_Log_Writer_Stream(APPLICATION_PATH . '/../private/logs/app-' .
                $dlayer_session->identityId() . '.log');
            $logger = new Zend_Log($writer);
        }

        Zend_Registry::set('log-app', $logger);
    }

    /**
     * Set up the error logger
     *
     * @return void
     */
    public function _initErrorLogger()
    {
        $dlayer_session = new Dlayer_Session();

        if ($dlayer_session->identityId() === false) {
            $writer = new Zend_Log_Writer_Stream(APPLICATION_PATH . '/../private/logs/error.log');
            $logger = new Zend_Log($writer);
        } else {
            $writer = new Zend_Log_Writer_Stream(APPLICATION_PATH . '/../private/logs/error-' .
                $dlayer_session->identityId() . '.log');
            $logger = new Zend_Log($writer);
        }

        Zend_Registry::set('log-error', $logger);
    }

    /**
     * Require the composer autoloader for any vendor packages
     */
    protected function _initComposerAutoLoader()
    {
        require '../vendor/autoload.php';
    }
}
