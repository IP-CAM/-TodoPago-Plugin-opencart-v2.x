<?php
require_once DIR_APPLICATION . '../catalog/controller/todopago/vendor/autoload.php';
require_once DIR_APPLICATION . '../admin/resources/todopago/todopago_ctes.php';
require_once DIR_APPLICATION . '../admin/resources/todopago/Logger/loggerFactory.php';

class ControllerPaymentTodopago extends Controller
{

    const INSTALL = 'install';
    const UPGRADE = 'upgrade';

    private $error = array();

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->logger = loggerFactory::createLogger();
        // cargo urls del json segun sea la version
        $data = file_get_contents(DIR_APPLICATION . "../system/config/todopago_routes.json");
        $tp_routes = json_decode($data, true);
        $arr_version = explode('.', VERSION);
        $oc_version = $arr_version[0] . '.' . $arr_version[1];
        $this->tp_routes = $tp_routes[$oc_version];
    }

    public function install()
    {
        $this->response->redirect($this->url->link($this->tp_routes['payment-extension'] . '/confirm_installation', 'token=' . $this->session->data['token'], 'SSL')); //Redirecciono para poder salir del ciclo de instalación y poder mostrar mi pantalla.
    }

    public function confirm_installation()
    {
        $this->load->model($this->tp_routes['payment-module']);

        //Preparo tpl
        $data['header'] = $this->load->controller("common/header");
        $data['column_left'] = $this->load->controller("common/column_left");
        $data['footer'] = $this->load->controller("common/footer");

        $data['todopago_version'] = TP_VERSION;
        $data['install_button_text'] = 'Instalar';
        $data['cancel_button_text'] = 'Cancelar';
        $data['install_button_action'] = html_entity_decode($this->url->link($this->tp_routes['payment-module'] . '/_install', 'action=' . self::INSTALL . '&token=' . $this->session->data['token'] . '&pluginVersion=' . $this->model_payment_todopago->getVersion(), 'SSL'));
        $data['cancel_button_action'] = html_entity_decode($this->url->link($this->tp_routes['payment-extension'] . '/_revert_installation', 'token=' . $this->session->data['token'], 'SSL')); //Al llegar la pantalla ell plugin ya se instaló en el commerce por lo qe hace falta dsinstalarlo
        $data['back_button_message'] = "Esto interrumpirá la instalación";
        $data['visible_url'] = html_entity_decode($this->url->link($this->tp_routes['payment-module'] . '/install', 'token=' . $this->session->data['token'], 'SSL')); //Al llegar la pantalla ell plugin ya se instaló en el commerce por lo qe hace falta dsinstalarlo
        $data['extension'] = $this->tp_routes['extension'];

        $this->template = $this->tp_routes['template'] . '/install.tpl';
        $this->response->setOutput($this->load->view($this->template, $data));
    }

    private function do_install($plugin_version)
    {
        /*******************************************************************
         *Al no tener breaks entrará en todos los case posteriores.         *
         *TODAS LAS VERSIONES DEBEN APARECER,                               *
         *de lo contrario LA VERSION QUE NO APAREZCA NO PODRÁ UPGRADEARSE   *
         *******************************************************************/
        $actualVersion = $plugin_version;//$this->model_payment_todopago->getVersion();

        $this->logger->debug("version actual: " . $actualVersion);
        $errorMessage = null;
        if ($actualVersion <= "1.3.0") {
            $this->logger->debug("downgrade to v1.0.0");
            $actualVersion = "1.0.0";
        }
        switch ($actualVersion) {
            case "0.0.0":
                $this->logger->info('Begining install');
            case "1.0.0":
                $this->logger->debug("Upgrade to v1.0.0");
                try {
                    $this->model_todopago_transaccion_admin->createTable(); //Crea la tabla todopago_transaccion
                } catch (Exception $e) {
                    $errorMessage = 'Fallo al crear la tabla todopago_transaccion';
                    $this->logger->fatal($errorMessage, $e);
                    break;
                }
                try {
                    $this->model_payment_todopago->setProvincesCode(); //Guarda los códigos de prevencion de fraude para las provincias
                } catch (Exception $e) {
                    $errorMessage = 'Fallo al grabar los codigos de provincias para preveción de Fraude';
                    $this->logger->fatal($errorMessage, $e);
                    break;
                }
                try {
                    $this->model_payment_todopago->setPostCodeRequired(); //Setea el código postal obligatorio para argentina
                } catch (Exception $e) {
                    $errorMessage = 'Fallo al setear el código postal obligatorio para Argentina';
                    $this->logger->fatal($errorMessage, $e);
                    break;
                }

                //
                try {
                    $this->model_todopago_addressbook_admin->createTable(); //Crea la tabla direcciones
                } catch (Exception $e) {
                    $errorMessage = 'Fallo al crear la tabla todopago_addressbook';
                    $this->logger->fatal($errorMessage, $e);
                    break;
                }

            case "1.1.0":
                $this->logger->debug("Upgrade to v1.2.0");
            case "1.2.0":
                $this->logger->debug("Upgrade to v1.3.0");
            case "1.3.0":
                $this->logger->debug("Upgrade to v1.4.0");
            case "1.4.0":
                $this->logger->debug("Upgrade to v1.5.0");
            case "1.5.0":
                $this->logger->debug("Upgrade to v1.6.0");
            case "1.6.0":
                $this->logger->debug("Upgrade to v1.7.0");
            case "1.7.0":
                $this->logger->debug("Upgrade to v1.8.0");
            case "1.8.0":
                $this->logger->debug("Upgrade to v1.8.1");
            case "1.8.1":
                $this->logger->debug("Upgrade to v1.9.0");
            case "1.9.0":
                $this->logger->debug("Upgrade to v1.10.0");
            case "1.10.0":
                $this->logger->debug("Upgrade to v1.11.0");
            case "1.11.0":
                $this->logger->debug("Upgrade to v1.12.0");
            case "1.12.0":
                $this->logger->debug("Upgrade to v1.12.1");
                $this->logger->info("Plugin instalado/upgradeado");
        }
    }

    //ALTER TABLE `open2`.`oc_todopago_transaccion` ADD COLUMN `devolucion_key` TEXT NULL COMMENT '' AFTER `answer_key`;
    public function _install()
    {
        //Este es el método que se ocupa en realidad de la instalación así como del upgrade
        if (isset($this->request->get['action'])) {

            $action = $this->request->get['action']; //Acción a realizar (puede ser self::INSTALL o self::UPGRADE)

            //Modelos necesarios
            //$this->load->model($this->tp_routes['payment-module']);
            //$this->load->model($this->tp_routes['template'].'/transaccion_admin');
            $this->load->model('payment/todopago');
            $this->load->model('todopago/transaccion_admin');
            $this->load->model('todopago/addressbook_admin');

            $this->logger->debug("Verifying required upgrades");
            $actualVersion = $this->request->get['pluginVersion'];
            $this->do_install($actualVersion);

            if (!isset($errorMessage)) {
                if ($action == self::UPGRADE) {
                    $this->session->data['success'] = 'Upgrade finalizado.';
                } else {
                    try {
                        $this->load->model('setting/setting');
                        $settings['todopago_version'] = TP_VERSION;
                        $this->model_setting_setting->editSetting('todopago', $settings); //Registra en la tabla el nro de Versión a la que se ha actualizado
                        //guarda registro de banner billetera para ser reconocido en front
                        //instala BVTP de una vez
                        $this->db->query("INSERT INTO `".DB_PREFIX."extension` (type, code) SELECT * FROM (SELECT 'payment', 'todopagobilletera') AS tmp WHERE NOT EXISTS (SELECT code FROM `".DB_PREFIX."extension` WHERE code = 'todopagobilletera') LIMIT 1;");
                        $this->db->query("INSERT INTO `".DB_PREFIX."extension` (type, code) SELECT * FROM (SELECT 'payment', 'todopago') AS tmp WHERE NOT EXISTS (SELECT code FROM `".DB_PREFIX."extension` WHERE code = 'todopago') LIMIT 1;");
                        $this->session->data['success'] = 'Instalación finalizada.';
                    } catch (Exception $e) {
                        $errorMessage = 'Fallo deconocido, se pedirá reintentar';
                        $this->logger->fatal($errorMessage, $e);
                    }
                }
            } else {
                $this->session->data['success'] = 'Upgraded.';
            }
            $this->response->redirect($this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL'));
        } else {
            $this->response->redirect($this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')); //Nunca deberíamos haber llegado aquí, así que nos vamos
        }
    }

    public function _revert_installation()
    { //Desinstalación silenciosa del plugin para el commerce (para cuando no se finaliza la instalación)
        $this->load->model('extension/extension');
        $this->model_extension_extension->uninstall('payment', 'todopago');
        $this->response->redirect($this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL'));
    }

    public function uninstall()
    {
        $this->response->redirect($this->url->link($this->tp_routes['payment-extension'] . '/config_uninstallation', 'token=' . $this->session->data['token'], 'SSL')); //Recirijo para salir del ciclo de desinstallación del plugin y pooder mostrar mi pantalla
    }

    public function config_uninstallation()
    { //Permite seleccionar que cambios de instalación deshacer

        //Se prepara el tpl
        $this->document->setTitle('Desinstalación TodoPago');
        $this->document->addStyle('view/stylesheet/todopago/back.css');

        $data['header'] = $this->load->controller("common/header");
        $data['column_left'] = $this->load->controller("common/column_left");
        $data['footer'] = $this->load->controller("common/footer");

        $data['todopago_version'] = TP_VERSION;
        $data['button_continue_text'] = 'Continue';
        $data['button_continue_action'] = $this->url->link($this->tp_routes['payment-extension'] . '/_uninstall', 'token=' . $this->session->data['token'], 'SSL');
        $data['back_button_message'] = "Esto ejecutará la instalación básica (No se ejecutará ninguna de las acciones descriptas en la página actual)";
        $data['extension'] = $this->tp_routes['extension'];

        $this->template = $this->tp_routes['template'] . '/uninstall.tpl';
        $this->response->setOutput($this->load->view($this->template, $data));
    }

    public function _uninstall()
    { //Méto do de desinstalación interno, deshace los cambios seleccionados.
        //$this->load->model($this->tp_routes['payment-module']);
        //$this->load->model($this->tp_routes['template'].'/transaccion_admin');
        $this->load->model('payment/todopago');
        $this->load->model('todopago/transaccion_admin');
        $this->load->model('todopago/addressbook_admin');
        $this->load->model('setting/setting');

        //borrando todopagobilletera y todopago de tabla extension
        //es necesario borrar ambos por cual sea de los dos hayan hecho la desistalacion
        $this->db->query("DELETE FROM `".DB_PREFIX."extension` WHERE code = 'todopagobilletera'");
        $this->db->query("DELETE FROM `".DB_PREFIX."extension` WHERE code = 'todopago'");

        //setea a false BVTP
        $this->model_setting_setting->editSetting('todopagobilletera', array("todopagobilletera_status"=>false));

        if (isset($this->request->post['revert_postcode_required'])) {
            $this->model_payment_todopago->setPostCodeRequired(false);
        }
        if (isset($this->request->post['drop_column_cs_code'])) {
            $this->model_payment_todopago->unsetProvincesCode();
        }
        if (isset($this->request->post['drop_table_todopago_transaccion'])) {
            $this->model_todopago_transaccion_admin->dropTable();
        }

        if (isset($this->request->post['drop_table_todopago_addressbook']))
            $this->model_todopago_addressbook_admin->dropTable();

        $this->response->redirect($this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL'));
    }

    protected function validate()
    {
        $timeout_form = '';
        $res = true;

        if (isset($this->request->post['todopago_timeout_form_enabled'])) {
            if (isset($this->request->post['todopago_timeout_form'])) {
                $timeout_form = $this->request->post['todopago_timeout_form'];
            } else {
                $timeout_form = $this->config->get('todopago_timeout_form');
            }

            if ($timeout_form < 60 * 5 * 1000 || $timeout_form > 6 * 60 * 60 * 1000) {
                $res = false;
            }
        }

        return $res;
    }

    public function index()
    {
        $this->language->load('payment/todopago');
        $this->document->setTitle('TodoPago Configuration');
        $this->document->addScript('view/javascript/todopago/jquery.dataTables.min.js');
        $this->document->addStyle('view/stylesheet/todopago/jquery.dataTables.css');
        $this->document->addStyle('view/stylesheet/todopago.css');
        $this->load->model('setting/setting');
        $this->load->model($this->tp_routes['payment-module']);
        $this->load->model('todopago/transaccion_admin');
        $this->load->model('todopago/addressbook_admin');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) { //Si Viene con datos via post viene con datos del menú de configuracion.
            $value_status_banner = $this->request->post["todopago_status"];
            $this->model_setting_setting->editSetting('todopago', $this->request->post);
            //inserto todopagobilletera como clave para que sea reconocido en front
            $this->model_setting_setting->editSetting('todopagobilletera', array("todopagobilletera_status"=>$value_status_banner));
            
            
            if ($this->request->post['upgrade'] == '1') { //Si necesita upgradear llamamos al _install()
                $this->response->redirect($this->url->link($this->tp_routes['payment-module'] . '/_install', 'action=' . self::UPGRADE . '&token=' . $this->session->data['token'] . '&pluginVersion=' . $this->model_payment_todopago->getVersion(), 'SSL'));
            } else {
                $this->session->data['success'] = "Guardado.";
            }
            $this->response->redirect($this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL'));
        } else {
            if ($this->request->server['REQUEST_METHOD'] == 'POST') {
                $this->session->data['error'] = "Error en el rango del campo timeout";
            }
        }

        $data['heading_title'] = "Todo Pago";

        //Upgrade verification
        $installedVersion = $this->model_payment_todopago->getVersion();

        $data['installed_todopago_version'] = $installedVersion;
        $data['need_upgrade'] = (TP_VERSION > $installedVersion) ? true : false;
        $data['todopago_version'] = TP_VERSION;

        $data['entry_text_config_two'] = $this->language->get('text_config_two');

        //Botón de Guardar / Upgrade
        if ($data['need_upgrade']) {

            if (version_compare(VERSION, '2.3.0.0') >= 0) {
                $this->do_install($this->model_payment_todopago->getVersion());
                $settings['todopago_version'] = TP_VERSION;
                $this->model_setting_setting->editSetting('todopago', $settings);
                $data['button_save'] = $this->language->get('text_button_save');
                $data['button_save_class'] = "fa-save";
                $data['need_upgrade'] = false;
            } else {
                $data['button_save'] = "Upgrade";
                $data['button_save_class'] = "fa-arrow-circle-o-up";
            }

        } else {
            $data['button_save'] = $this->language->get('text_button_save');
            $data['button_save_class'] = "fa-save";
        }

        $data['button_cancel'] = $this->language->get('text_button_cancel');
        $data['entry_order_status'] = $this->language->get('entry_order_status');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['entry_status'] = $this->language->get('entry_status');

        //breadcrumbs
        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_payment'),
            'href' => $this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL'),
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link($this->tp_routes['payment-module'], 'token=' . $this->session->data['token'], 'SSL'),
        );

        $data['action'] = $this->url->link($this->tp_routes['payment-extension'], 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel'] = $this->url->link($this->tp_routes['extension-list'], 'token=' . $this->session->data['token'], 'SSL');

        //warning
        if (isset($this->error)) { //I ignore if it is the correct key
            $data['warning'] = $this->error;
        } else {
            $data['warning'] = "";
        }

        //error
        if (isset($this->session->data['error'])) { //It must work...
            $data['error']['error_warning'] = $this->session->data['error'];
            unset($this->session->data['error']);
        }

        //datos para el tag general
        if (isset($this->request->post['todopago_status'])) {
            $data['todopago_status'] = $this->request->post['todopago_status'];
        } else {
            $data['todopago_status'] = $this->config->get('todopago_status');
        }

        if (isset($this->request->post['todopago_segmentodelcomercio'])) {
            $data['todopago_segmentodelcomercio'] = $this->request->post['todopago_segmentodelcomercio'];
        } else {
            $data['todopago_segmentodelcomercio'] = $this->config->get('todopago_segmentodelcomercio');
        }


        if (isset($this->request->post['todopago_canaldeingresodelpedido'])) {
            $data['todopago_canaldeingresodelpedido'] = $this->request->post['todopago_canaldeingresodelpedido'];
        } else {
            $data['todopago_canaldeingresodelpedido'] = $this->config->get('todopago_canaldeingresodelpedido');
        }

        if (isset($this->request->post['todopago_deadline'])) {
            $data['todopago_deadline'] = $this->request->post['todopago_deadline'];
        } else {
            $data['todopago_deadline'] = $this->config->get('todopago_deadline');
        }

        if (isset($this->request->post['todopago_modotestproduccion'])) {
            $data['todopago_modotestproduccion'] = $this->request->post['todopago_modotestproduccion'];
        } else {
            $data['todopago_modotestproduccion'] = $this->config->get('todopago_modotestproduccion');
        }

        if (isset($this->request->post['todopago_formulario'])) {
            $data['todopago_formulario'] = $this->request->post['todopago_formulario'];
        } else {
            $data['todopago_formulario'] = $this->config->get('todopago_formulario');
        }

        if (isset($this->request->post['todopago_maxinstallments'])) {
            $data['todopago_maxinstallments'] = $this->request->post['todopago_maxinstallments'];
        } else {
            $data['todopago_maxinstallments'] = $this->config->get('todopago_maxinstallments');
        }

        if (isset($this->request->post['todopago_timeout_form_enabled'])) {
            $data['todopago_timeout_form_enabled'] = 1;
        } else {
            $data['todopago_timeout_form_enabled'] = $this->config->get('todopago_timeout_form_enabled');
        }

        if (isset($this->request->post['todopago_timeout_form'])) {
            $data['todopago_timeout_form'] = $this->request->post['todopago_timeout_form'];
        } else {
            $data['todopago_timeout_form'] = $this->config->get('todopago_timeout_form');
        }

        if (isset($this->request->post['todopago_cart'])) {
            $data['todopago_cart'] = $this->request->post['todopago_cart'];
        } else {
            $data['todopago_cart'] = $this->config->get('todopago_cart');
        }

        // validar a través de gmaps
        if (isset($this->request->post['todopago_gmaps_validacion'])) {
            $data['todopago_gmaps_validacion'] = $this->request->post['todopago_gmaps_validacion'];
        } else {
            $data['todopago_gmaps_validacion'] = $this->config->get('todopago_gmaps_validacion');
        }

        //datos para tags ambiente test
        if (isset($this->request->post['todopago_authorizationHTTPtest'])) {
            $data['todopago_authorizationHTTPtest'] = $this->request->post['todopago_authorizationHTTPtest'];
        } else {
            $data['todopago_authorizationHTTPtest'] = $this->config->get('todopago_authorizationHTTPtest');
        }

        if (isset($this->request->post['todopago_idsitetest'])) {
            $data['todopago_idsitetest'] = $this->request->post['todopago_idsitetest'];
        } else {
            $data['todopago_idsitetest'] = $this->config->get('todopago_idsitetest');
        }

        if (isset($this->request->post['todopago_securitytest'])) {
            $data['todopago_securitytest'] = $this->request->post['todopago_securitytest'];
        } else {
            $data['todopago_securitytest'] = $this->config->get('todopago_securitytest');
        }

        //datos para tags ambiente produccion
        if (isset($this->request->post['todopago_authorizationHTTPproduccion'])) {
            $data['todopago_authorizationHTTPproduccion'] = $this->request->post['todopago_authorizationHTTPproduccion'];
        } else {
            $data['todopago_authorizationHTTPproduccion'] = $this->config->get('todopago_authorizationHTTPproduccion');
        }

        if (isset($this->request->post['todopago_idsiteproduccion'])) {
            $data['todopago_idsiteproduccion'] = $this->request->post['todopago_idsiteproduccion'];
        } else {
            $data['todopago_idsiteproduccion'] = $this->config->get('todopago_idsiteproduccion');
        }

        if (isset($this->request->post['todopago_securityproduccion'])) {
            $data['todopago_securityproduccion'] = $this->request->post['todopago_securityproduccion'];
        } else {
            $data['todopago_securityproduccion'] = $this->config->get('todopago_securityproduccion');
        }

        //datos para estado del pedido
        if (isset($this->request->post['todopago_order_status_id_aprov'])) {
            $data['todopago_order_status_id_aprov'] = $this->request->post['todopago_order_status_id_aprov'];
        } else {
            $data['todopago_order_status_id_aprov'] = $this->config->get('todopago_order_status_id_aprov');
        }

        if (isset($this->request->post['todopago_order_status_id_rech'])) {
            $data['todopago_order_status_id_rech'] = $this->request->post['todopago_order_status_id_rech'];
        } else {
            $data['todopago_order_status_id_rech'] = $this->config->get('todopago_order_status_id_rech');
        }

        if (isset($this->request->post['todopago_order_status_id_off'])) {
            $data['todopago_order_status_id_off'] = $this->request->post['todopago_order_status_id_off'];
        } else {
            $data['todopago_order_status_id_off'] = $this->config->get('todopago_order_status_id_off');
        }

        if (isset($this->request->post['todopago_order_status_id_pro'])) {
            $data['todopago_order_status_id_pro'] = $this->request->post['todopago_order_status_id_pro'];
        } else {
            $data['todopago_order_status_id_pro'] = $this->config->get('todopago_order_status_id_pro');
        }

        if (isset($this->request->post['todopago_bannerbilletera'])) {
            $data['todopago_bannerbilletera'] = $this->request->post['todopago_bannerbilletera'];
        } else {
            $data['todopago_bannerbilletera'] = $this->config->get('todopago_bannerbilletera');
        }
        $this->load->model('localisation/order_status');
        $data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
        $data['extension'] = $this->tp_routes['extension'];
        $this->template = $this->tp_routes['payment'] . '/todopago.tpl';

        $data['header'] = $this->load->controller("common/header");
        //column left is loaded via controller and should be placed in all modules
        $data['column_left'] = $this->load->controller("common/column_left");
        $data['footer'] = $this->load->controller("common/footer");

        //getOrders()
        $this->load->model($this->tp_routes['payment-module']);
        $orders_array = $this->model_payment_todopago->get_orders();
        $data['orders_array'] = json_encode($orders_array->rows);
        $data['url_get_status'] = $this->url->link($this->tp_routes['payment-module'] . "/get_status&token=" . $this->session->data["token"]);
        $data['url_devolver'] = $this->url->link($this->tp_routes['payment-module'] . "/devolver&token=" . $this->session->data["token"]);

        $this->response->setOutput($this->load->view($this->template, $data));
    }

    /* LEGACY FUNCTION
    public function render()
    {
        return $this->load->view($this->template, $data);
    }
    */
    public function getOrders()
    {
        $this->load->model($this->tp_routes['payment-module']);
        $orders_array = $this->model_payment_todopago->get_orders();
        $orders_array = json_encode($orders_array->rows);
    }


    public function devolver()
    {
        $monto = $_POST["monto"];
        $order_id = $_POST['order_id'];
        $transaction_row = $this->db->query("SELECT request_key FROM `" . DB_PREFIX . "todopago_transaccion` WHERE id_orden=$order_id");
        $mode = $this->get_mode();
        $authorizationHTTP = $this->get_authorizationHTTP();
        $request_key = $transaction_row->row["request_key"];

        if (empty($request_key)) {
            echo "No es posible hacer devolución sobre esa transacción";
        } else {
            try {
                $connector = new TodoPago\Sdk($authorizationHTTP, $mode);
                $options = array(
                    "Security" => $this->get_security_code(), // API Key del comercio asignada por TodoPago
                    "Merchant" => $this->get_id_site(), // Merchant o Nro de comercio asignado por TodoPago
                    "RequestKey" => $request_key//, // RequestKey devuelto como respuesta del servicio SendAutorizeRequest
                    //"AMOUNT" => $monto // Opcional. Monto a devolver, si no se envía, se trata de una devolución total
                );

                if (empty($monto)) {
                    $this->logger->info("Pedido de devolución total pesos de la orden $order_id");
                    $this->logger->info(json_encode($options));
                    $resp = $connector->voidRequest($options);
                    $this->logger->info(json_encode($resp));
                } else {
                    $this->logger->info("Pedido de devolución por $monto pesos de la orden $order_id");
                    $options["AMOUNT"] = $monto;
                    $this->logger->info(json_encode($options));
                    $resp = $connector->returnRequest($options);
                    $this->logger->info(json_encode($resp));
                }

                if ($resp["StatusCode"] == "2011") {
                    $this->load->model("sale/return");
                    if (empty($monto)) {
                        $order_row = $this->db->query("SELECT total FROM `" . DB_PREFIX . "order` WHERE order_id = $order_id AND payment_code='todopago';");
                        $options["AMOUNT"] = $order_row->row["total"];
                    }

                    $this->model_sale_return->addReturn($this->getReturnValues($order_id, $resp, $options["AMOUNT"]));

                    echo("La devolución ha sido efectuada con éxito");


                } else {
                    if ($resp["StatusMessage"]) {
                        $complete_value = json_encode($resp["StatusMessage"]);
                        $complete_value = preg_replace_callback('/\\\\u(\w{4})/', function ($matches) {
                            return html_entity_decode('&#x' . $matches[1] . ';', ENT_COMPAT, 'UTF-8');
                        }, $complete_value);
                        echo $complete_value;
                    } else {
                        echo "No se pudo realizar la devolución.";
                    }
                }

            } catch (Exception $e) {
                echo json_encode($e->getMessage());
            }
        }
    }

    public function get_status()
    {
        $order_id = $_GET['order_id'];
        $this->load->model($this->tp_routes['model'] . '/transaccion');
        $transaction = $this->model_todopago_transaccion;
        $this->logger->debug('todopago -  step: ' . $transaction->getStep($order_id));
        // if($transaction->getStep($order_id) == $transaction->getTransactionFinished()){
        $authorizationHTTP = $this->get_authorizationHTTP();
        $this->logger->debug('Authorization HTTP: ' . json_encode($authorizationHTTP));
        $mode = $this->get_mode();
        $this->logger->debug('Mode: ' . $mode);
        try {
            $connector = new TodoPago\Sdk($authorizationHTTP, $mode);
            $optionsGS = array('MERCHANT' => $this->get_id_site(), 'OPERATIONID' => $order_id);
            $this->logger->debug('Options GetStatus: ' . json_encode($optionsGS));
            $status = $connector->getStatus($optionsGS);
            $status_json = json_encode($status);
            $this->logger->info("GETSTATUS: " . $status_json);
            $rta = '';

            if ($status) {
                if (isset($status['Operations']) && is_array($status['Operations'])) {
                    
                    $rta = $this->printGetStatus($status['Operations'], 0);

                } else {
                    $rta = 'No hay operaciones para esta orden.';
                }
            } else {
                $rta = 'No se ecuentra la operación. Esto puede deberse a que la operación no se haya finalizado o a una configuración erronea.';
            }
        } catch (Exception $e) {
            $this->logger->fatal("Ha surgido un error al consultar el estado de la orden: ", $e);
            $rta = 'ERROR AL CONSULTAR LA ORDEN';
        }
//        }
//        else{
//            $rta = "NO HAY INFORMACIÓN DE PAGO";
//        }
        echo($rta);

    }

    private function printGetStatus($array, $indent) {
        $rta = '';

        foreach ($array as $key => $value) {
            if ($key !== 'nil' && $key !== "@attributes") {
                if (is_array($value) ){
                    $rta .= str_repeat("-", $indent) . "$key: <br/>";
                    $rta .= $this->printGetStatus($value, $indent + 2);
                } else {
                    $rta .= str_repeat("-", $indent) . "$key: $value <br/>";
                }
            }
        }
        
        return $rta;
    }

    private function get_authorizationHTTP()
    {

        if ($this->get_mode() == "test") {
            $http_header = html_entity_decode($this->config->get('todopago_authorizationHTTPtest'));

        } else {
            $http_header = html_entity_decode($this->config->get('todopago_authorizationHTTPproduccion'));
        }

        if (json_decode($http_header, TRUE) == null) {
            $http_header = array("Authorization" => $http_header);
        } else {
            $http_header = json_decode($http_header, TRUE);
        }

        return $http_header;
    }

    private function get_mode()
    {
        return html_entity_decode($this->config->get('todopago_modotestproduccion'));
    }

    private function get_id_site()
    {
        if ($this->get_mode() == "test") {
            return html_entity_decode($this->config->get('todopago_idsitetest'));
        } else {
            return html_entity_decode($this->config->get('todopago_idsiteproduccion'));
        }
    }

    private function get_security_code()
    {
        if ($this->get_mode() == "test") {
            return html_entity_decode($this->config->get('todopago_securitytest'));
        } else {
            return html_entity_decode($this->config->get('todopago_securityproduccion'));
        }
    }

    private function getReturnValues($order_id, $resp, $amout)
    {
        $this->load->model("sale/order");
        $order = $this->model_sale_order->getOrder($order_id);
        $returnValues = array(
            "order_id" => $order_id,
            "firstname" => $order["firstname"],
            "lastname" => $order["lastname"],
            "telephone" => $order["telephone"],
            "email" => $order["email"],
            "product" => "DEVOLUCION TODOPAGO",
            "model" => "$" . $amout,
            "comment" => json_encode($resp),
            "customer_id" => $order["customer_id"],
            "quantity" => "1",
            "date_ordered" => $order["date_added"],
            "product_id" => 0,
            "return_reason_id" => 0,
            "return_action_id" => 0,
            "return_status_id" => 0,
            "opened" => 0

        );

        return $returnValues;

    }



    //Descomentar e implementar cuando se habiliten los verticales que requieren campos adicionales:
    /*private function createAttributeGroup($name){
        $data = array('sort_order' => 0);

        $this->load->model('catalog/attribute_group');
        $this->load->model('localisation/language');

        $languages = $this->model_localisation_language->getLanguages(); //obitene todos los idiomas instalados
            $attributeGroupDescription = array();
        foreach ($languages as $lang){
            $attributeGroupDescription[$lang['language_id']] = array('name' => $name); //setea el nombre en ese idioma
        }
        $data['attribute_group_description'] = $attributeGroupDescription;

        $this->model_catalog_attribute_group->addAttributeGroup($data); //Crea el attribute_group

        return $this->getAttributeGroupId($name); //devuelve el id del nuevo grupo
    }

    private function createAttribute($name, $attributeGroupId){
        $data = array(
            'sort_order' => 0,
            'attribute_group_id' => $attributeGroupId
        );

        $this->load->model('catalog/attribute');
        $this->load->model('localisation/language');

        $languages = $this->model_localisation_language->getLanguages();
        $attributeDescription = array();
        foreach ($languages as $lang){
                $attributeDescription[$lang['language_id']] = array('name' => $name);
        }
        $data['attribute_description'] = $attributeDescription;

        $this->model_catalog_attribute->addAttribute($data);

    }

    private function getAttributeGroupId($attributeGroupName){

        $this->load->model('catalog/attribute_group');
        $attributeGroups = $this->model_catalog_attribute_group->getAttributeGroups();
        foreach ($attributeGroups as $attrGrp){
            if ($attrGrp['name'] == $attributeGroupName) {
                $attributeGroupId = $attrGrp['attribute_group_id'];
                break;
            }
        }
        return $attributeGroupId;
    }

    private function getAttributeId($attributeName){
        $this->load->model('catalog/attribute');
        $attributes = $this->model_catalog_attribute->getAttributes();
        foreach ($attributes as $attr){
            if ($attr['name'] == $attributeName) {
                $attributeId = $attr['attribute_id'];
                break;
            }
        }
        return $attributeId;
    }

    private function deleteControlFraudeAttributeGroup(){
        $controlFraudeAttributeGroupId = $this->getAttributeGroupId(TP_CS_ATTGROUP);
        $this->load->model('catalog/attribute');
        $controlFraudeAttributeGroupAttributes = $this->model_catalog_attribute->getAttributesByAttributeGroupId(array('filter_attribute_group_id' => $controlFraudeAttributeGroupId));
        foreach ($controlFraudeAttributeGroupAttributes as $attribute){
            $this->model_catalog_attribute->deleteAttribute($attribute['attribute_id']);
        }
        $attributeGroups = $this->model_catalog_attribute_group->getAttributeGroups();
        $this->model_catalog_attribute_group->deleteAttributeGroup($controlFraudeGroupId);
    }*/
}
