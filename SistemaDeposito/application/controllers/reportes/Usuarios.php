<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Usuarios extends CI_Controller
{
    private $permisos;

    public function __construct()
    {
        parent::__construct();
        $this->permisos = $this->backend_lib->control();
        $this->load->model("Productos_model");
        $this->load->model("Categorias_model");
        $this->load->model("Ventas_model");
        $this->load->model("Usuarios_model");
    }

    public function index()
    {
        $data  = array(
            'permisos' => $this->permisos,
            'productos' => $this->Productos_model->getProductosConStock(),
            'usuarios' => $this->Usuarios_model->getUsuarios(),
        );

        $this->load->view("layouts/header");

        $this->load->view("layouts/aside");
        $this->load->view("admin/reportes/usuarios", $data);
        $this->load->view("layouts/footer");
    }
}
