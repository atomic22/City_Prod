<?php
class ControllerToolApsonaSA extends Controller {
    public function index() {
        $this->template = 'tool/apsona_sa.tpl';
        $this->children = array();
        $this->response->setOutput ($this->render(true), $this->config->get('config_compression'));
    }
}
?>
