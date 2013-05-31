<?php  
class ControllerModuletgthemeglobalslideshow extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		$this->document->addScript('catalog/view/javascript/jquery/nivo-slider/jquery.nivo.slider.pack.js');
		$this->document->addScript('catalog/view/javascript/jquery/accordion-slider/jquery.nivo.slider.pack.js');
		
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		
		$this->data['delay'] = $this->config->get('tg_themeglobal_slideshow_slideshow_delay');
        $this->data['speed'] = $this->config->get('tg_themeglobal_slideshow_slideshow_speed');
        $this->data['effect'] = $this->config->get('tg_themeglobal_slideshow_slideshow_effect');
        $this->data['pause'] = $this->config->get('tg_themeglobal_slideshow_slideshow_pause');
		$this->data['slices'] = $this->config->get('tg_themeglobal_slideshow_slideshow_slices');
		$this->data['boxcolumns'] = $this->config->get('tg_themeglobal_slideshow_slideshow_boxcolumns');
		$this->data['boxrows'] = $this->config->get('tg_themeglobal_slideshow_slideshow_boxrows');
		
		$this->data['coin_effect'] = $this->config->get('tg_themeglobal_slideshow_coin_effect');
		$this->data['coin_delay'] = $this->config->get('tg_themeglobal_slideshow_coin_delay');
		$this->data['coin_speed'] = $this->config->get('tg_themeglobal_slideshow_coin_speed');
	    $this->data['coin_pause'] = $this->config->get('tg_themeglobal_slideshow_coin_pause');
	    
	    $this->data['accordion_max'] = $this->config->get('tg_themeglobal_slideshow_accordion_max');
	    $this->data['accordion_sticky'] = $this->config->get('tg_themeglobal_slideshow_accordion_sticky');
	    $this->data['accordion_event'] = $this->config->get('tg_themeglobal_slideshow_accordion_event');
		 
		$this->data['banners'] = array();
		
		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		  
		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$this->data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}
		
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/tg_themeglobal_slideshow.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/tg_themeglobal_slideshow.tpl';
		} else {
			$this->template = 'default/template/module/tg_themeglobal_slideshow.tpl';
		}
		
		$this->render();
	}
}
?>