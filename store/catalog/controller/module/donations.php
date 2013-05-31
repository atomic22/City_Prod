<?php  
class ControllerModuleDonations extends Controller {
	protected function index($setting) {
		$this->language->load('module/donations');
		
		$this->data['heading_title'] = $setting['modulename'];
		$this->data['name'] = $setting['name'];
		$this->data['donatenumber'] = $setting['donatenumber'];
		$this->data['email'] = $setting['email'];
		$this->data['amount'] = $setting['amount'];
		$this->data['buttontype'] = $setting['buttontype'];
		$this->data['currency'] = $setting['currency'];
    	
		$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		$this->data['justification'] = $setting['justification'];

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/donations.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/donations.tpl';
		} else {
			$this->template = 'default/template/module/donations.tpl';
		}
		
		$this->render();
	}
}
?>