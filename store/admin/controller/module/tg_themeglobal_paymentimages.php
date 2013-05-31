<?php


class ControllerModuletgthemeglobalpaymentimages extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/tg_themeglobal_paymentimages');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('tool/image');


		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

        if(isset($this->request->post['slide_image'])){
        $slide_image_settings = serialize($this->request->post['slide_image']);
        }else{
        $slide_image_settings = "";
        }
        
        

        $slide_settings = array(
        'tg_themeglobal_paymentimages_status'      => $this->request->post['slideshow_status'],
        'tg_themeglobal_paymentimages_slide_image' => $slide_image_settings,
        );

			$this->model_setting_setting->editSetting('tg_themeglobal_paymentimages', $slide_settings);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect(HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token']);
		}

		$this->data['heading_title']        = $this->language->get('heading_title');

		$this->data['text_enabled']         = $this->language->get('text_enabled');
		$this->data['text_disabled']        = $this->language->get('text_disabled');
		$this->data['text_true']            = $this->language->get('text_true');
		$this->data['text_false']           = $this->language->get('text_false');
        $this->data['text_pleaseselect']    = $this->language->get('text_pleaseselect');
        $this->data['text_image_manager']   = $this->language->get('text_image_manager');

		$this->data['entry_position']       = $this->language->get('entry_position');
		$this->data['entry_image']          = $this->language->get('entry_image');
        $this->data['entry_status']         = $this->language->get('entry_status');
        $this->data['entry_url']            = $this->language->get('entry_url');
        $this->data['entry_sort']           = $this->language->get('entry_sort');
        $this->data['text_footer']          = $this->language->get('text_footer');
		$this->data['button_save']          = $this->language->get('button_save');
		$this->data['button_cancel']        = $this->language->get('button_cancel');
        $this->data['button_addslide']      = $this->language->get('button_addslide');
        $this->data['button_remove']        = $this->language->get('button_remove');
        
        $this->data['tab_gen']              =  $this->language->get('tab_gen');
		$this->data['tab_sliderimage'] =  $this->language->get('tab_sliderimage');

     
        $this->data['help_linkurl']        = $this->language->get('help_linkurl');

        $this->data['help_addslidehdr']    = $this->language->get('help_addslidehdr');
        $this->data['help_addslidetext']   = $this->language->get('help_addslidetext');
        $this->data['help_target']         = $this->language->get('help_target');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/tg_themeglobal_paymentimages', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/tg_themeglobal_paymentimages', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


		if (isset($this->request->post['slideshow_status'])) {
			$this->data['slideshow_position'] = $this->request->post['slideshow_position'];
		} else {
			$this->data['slideshow_position'] = $this->config->get('tg_themeglobal_paymentimages_position');
		}

		if (isset($this->request->post['slideshow_status'])) {
			$this->data['slideshow_status'] = $this->request->post['slideshow_status'];
		} else {
			$this->data['slideshow_status'] = $this->config->get('tg_themeglobal_paymentimages_status');
		}
		
	
		
		if (isset($this->request->post['tg_themeglobal_paymentimages_power'])) {
			$this->data['tg_themeglobal_paymentimages_power'] = $this->request->post['tg_themeglobal_paymentimages_power'];
		} else {
			$this->data['tg_themeglobal_paymentimages_power'] = $this->config->get('tg_themeglobal_paymentimages_power');
		}
		
		if (isset($this->request->post['tg_themeglobal_paymentimages_totop'])) {
			$this->data['tg_themeglobal_paymentimages_totop'] = $this->request->post['tg_themeglobal_paymentimages_totop'];
		} else {
			$this->data['tg_themeglobal_paymentimages_totop'] = $this->config->get('tg_themeglobal_paymentimages_totop');
		}

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
        $this->data['slide_images'] = array();
        $this->data['slide_images'] = unserialize($this->config->get('tg_themeglobal_paymentimages_slide_image'));
       
        


		$this->template = 'module/tg_themeglobal_paymentimages.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/tg_themeglobal_paymentimages')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
?>