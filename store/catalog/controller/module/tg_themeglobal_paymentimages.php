<?php


class ControllerModuletgthemeglobalpaymentimages extends Controller {

	protected function index() {
		
		$this->language->load('module/tg_themeglobal_paymentimages');
	
		$this->data['text_footer'] = sprintf($this->language->get('text_footer'), $this->config->get('config_name'), date('Y', time()));
		$this->data['text_store'] = sprintf($this->language->get('text_store'), $this->config->get('config_name'), date('Y', time()));

        $this->data['config_url'] = $this->config->get('config_url');

        $this->data['slide_images'] = unserialize($this->config->get('tg_themeglobal_paymentimages_slide_image'));

		$this->id = 'tg_themeglobal_paymentimages';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/tg_themeglobal_paymentimages.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/tg_themeglobal_paymentimages.tpl';
		} else {
			$this->template = 'default/template/module/tg_themeglobal_paymentimages.tpl';
		}

		$this->render();
    }
}
?>