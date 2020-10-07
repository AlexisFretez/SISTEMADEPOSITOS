<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Compras extends CI_Controller
{
    private $permisos;

    private $modulo = "Compras";
    public function __construct()
    {
        parent::__construct();
        $this->permisos = $this->backend_lib->control();
        $this->load->model("Productos_model");
        $this->load->model("Compras_model");
        $this->load->model("Proveedor_model");
    }

    public function index()
    {
        $data  = array(
            'permisos' => $this->permisos,
            'compras' => $this->Compras_model->getCompras(),


        );

        $this->load->view("layouts/header");
        $this->load->view("layouts/aside");
        $this->load->view("admin/compras/list", $data);
        $this->load->view("layouts/footer");
    }

    public function add()
    {

        $data = array(
            "tipocomprobantes" => $this->Ventas_model->getComprobantes(),
            "proveedores" => $this->Proveedor_model->getProveedores(),

            "productos" => $this->Ventas_model->getProducts(),
            "tipo_pagos" => $this->Compras_model->getTipoPagos(),

            "almacenes" => $this->Compras_model->getAlmacenes(),
        );
        $this->load->view("layouts/header");
        $this->load->view("layouts/aside");
        $this->load->view("admin/compras/add", $data);
        $this->load->view("layouts/footer");
    }


    //metodo para mostrar productos en la accion de asociar
    public function getProductos()
    {
        $valor = $this->input->post("valor");
        $productos = $this->Compras_model->getProductos($valor);
        echo json_encode($productos);
    }

    public function getProductoByCode()
    {
        $codigo_barra = $this->input->post("codigo_barra");
        $producto = $this->Compras_model->getProductoByCode($codigo_barra);

        if ($producto != false) {
            echo json_encode($producto);
        } else {
            echo "0";
        }
    }

    public function store()
    {
        $comprobante = $this->input->post("comprobante");
        //$tipo_pago = $this->input->post("tipo_pago");
        $almacen = $this->input->post("almacen");
        $serie = $this->input->post("serie");
        $numero = $this->input->post("numero");
        $fecha = $this->input->post("fecha");
        $idproveedor = $this->input->post("idproveedor");

        $subtotal = $this->input->post("subtotal");

        $total = $this->input->post("total");

        $idproductos = $this->input->post("idproductos");
        $cantidades = $this->input->post("cantidades");
        $importes = $this->input->post("importes");


        $data = array(
            'serie' => $serie,
            'numero' => $numero,
            'fecha' => $fecha,
            'subtotal' => $subtotal,

            'total' => $total,
            'comprobante' => $comprobante,
            'proveedor_id' => $idproveedor,
            //'tipo_pago_id' => $tipo_pago,
            'almacen_id' => $almacen,
            'usuario_id' => $this->session->userdata('id'),
            'estado' => 1,
        );

        if ($this->Compras_model->save($data)) {
            $this->backend_lib->savelog($this->modulo, "Actualización del Office con nombre ");
            $this->session->set_flashdata("success", "Los datos fueron guardados exitosamente");
            //echo "1";
            redirect(base_url() . "movimientos/compras");
        } else {
            $this->session->set_flashdata("error", "Los datos no fueron guardados");
            //echo "1";
            redirect(base_url() . "movimientos/compras/add");
        }
    }

    public function edit($id)
    {
        $data  = array(
            'compra' => $this->Compras_model->getCompra($id),
            "detalles" => $this->Compras_model->getDetalle($id),
            "tipocomprobantes" => $this->Compras_model->getComprobantes(),
            "tipopagos" => $this->Compras_model->getTipoPagos(),
            "proveedores" => $this->Proveedor_model->getProveedores(),
            "estado" => "2",
        );
        $this->load->view("layouts/header");
        $this->load->view("layouts/aside");
        $this->load->view("admin/compras/edit", $data);
        $this->load->view("layouts/footer");
    }

    public function view()
    {
        $idCompra = $this->input->post("id");
        $data = array(
            "compra" => $this->Compras_model->getCompra($idCompra),
            "detalles" => $this->Compras_model->getDetalle($idCompra)
        );
        $this->load->view("admin/compras/view", $data);
    }

    public function getProveedores()
    {
        $valor = $this->input->post("valor");
        $proveedores = $this->Compras_model->getProveedores($valor);
        echo json_encode($proveedores);
    }

    public function delete($id)
    {
        $data  = array(
            'estado' => "0",
        );
        $this->Compras_model->update($id, $data);
        echo "movimientos/compras";
    }

    public function sumar()
    {
        $fecha   = $_POST['fecha'];
        $fecha_salida   = $_POST['fecha_salida'];

        $Costo   = $_POST['Costo'];
        //$resultado = $a+$b;


        $resultado = abs(strtotime($fecha) - strtotime($fecha_salida));


        $years = floor($resultado / (365 * 60 * 60 * 24));
        $months = floor(($resultado - $years * 365 * 60 * 60 * 24) / (30 * 60 * 60 * 24));
        $days = floor(($resultado - $years * 30 * 60 * 60 * 24) / (60 * 60 * 24));


        //Dias Original

        //$diff = abs(strtotime($date2) - strtotime($date1));

        //$years = floor($diff / (365 * 60 * 60 * 24));
        //$months = floor(($diff - $years * 365 * 60 * 60 * 24) / (30 * 60 * 60 * 24));
        //$days = floor(($diff - $years * 365 * 60 * 60 * 24 - $months * 30 * 60 * 60 * 24) / (60 * 60 * 24));

        //printf($days);
        $total = $days * $Costo;


        $arr  = array(
            "resultado" => $days,
            "resultado1" => $total
        );

        echo json_encode($arr);
    }
}
