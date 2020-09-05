<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Grafica extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model("Compras_model");
    }
    public function getData()
    {

        $resultados = $this->Compras_model->montos();
        echo json_encode($resultados);
    }
}
