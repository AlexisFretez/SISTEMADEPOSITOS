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

            "productos" => $this->Ventas_model->getProducts(),
            "tipo_pagos" => $this->Compras_model->getTipoPagos(),

            // "almacenes" => $this->Compras_model->getAlmacenes(),
            "proveedores" => $this->Proveedor_model->getProveedores(),
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
        $tipo_pago = $this->input->post("tipo_pago");
        $descripcion = $this->input->post("descripcion");
        $serie = $this->input->post("serie");
        $numero = $this->input->post("numero");
        $fecha = $this->input->post("fecha");
        $idproveedor = $this->input->post("idproveedor");
        $precios = $this->input->post("precios");
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
            'tipo_pago_id' => $tipo_pago,
            'descripcion' => $descripcion,
            'usuario_id' => $this->session->userdata('id'),
            'estado' => 1,
        );

        if ($this->Compras_model->save($data)) {
            $idcompra = $this->Compras_model->lastID();
            // $this->updateComprobante($comprobante);
            $this->save_detalle($idproductos, $idcompra, $precios, $cantidades, $importes);
            $this->backend_lib->savelog($this->modulo, "Inserción de una nueva venta con identificador " . $idcompra);
            redirect(base_url() . "movimientos/compras");
        } else {
            //redirect(base_url()."movimientos/ventas/add");
            echo "0";
        }
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
    //hATA ACA

    protected function numberDocumentGenerated($id)
    {
        $comprobante = $this->Comprobante_model->getComprobante($id);
        return str_pad($comprobante->cantidad + 1, 8, '0', STR_PAD_LEFT);
    }

    protected function updatePedidoProductos($pedidoproductos, $cantidades)
    {
        for ($i = 0; $i < count($pedidoproductos); $i++) {
            $infoP = $this->Ordenes_model->getPedidoProducto($pedidoproductos[$i]);

            $pagados = $infoP->pagados + $cantidades[$i];
            $estado = 0;
            if ($infoP->cantidad == $pagados) {
                $estado = 1;
            }

            $data  = array(
                "estado" => $estado,
                "pagados" => $pagados
            );

            $this->Ordenes_model->updatePedidoProductos($pedidoproductos[$i], $data);
        }
    }



    protected function save_detalle($productos, $idcompra, $precios, $cantidades, $importes)
    {
        for ($i = 0; $i < count($productos); $i++) {
            $data  = array(
                'producto_id' => $productos[$i],
                'compra_id' => $idcompra,
                'precio' => $precios[$i],
                'cantidad' => $cantidades[$i],
                'importe' => $importes[$i],
                //'descripcion' => $descripcion[$i],
            );

            $this->Compras_model->save_detalle($data);
            $this->updateStockProducto($productos[$i], $cantidades[$i]);
            $this->GenerarNotificacion($productos[$i]);
            //Descontar stock de los productos asociados
            $cantidadProdAsociados = $this->Productos_model->getProductosA($productos[$i]);
            if (!empty($cantidadProdAsociados)) {
                foreach ($cantidadProdAsociados as $cpa) {
                    $this->updateStockProducto($cpa->producto_asociado, ($cantidades[$i] * $cpa->cantidad));
                    $this->GenerarNotificacion($cpa->producto_asociado);
                }
            }
        }
        $this->reset_stock_negative();
    }

    protected function reset_stock_negative()
    {
        $data = array(
            "stock" => 0
        );
        $products = $this->Productos_model->setear_stock_negative($data);
    }

    protected function GenerarNotificacion($idproducto)
    {
        $productoActual = $this->Productos_model->getProducto($idproducto);
        if ($productoActual->stock <= $productoActual->stock_minimo) {
            $data = array(
                'estado' => 0,
                'producto_id' => $idproducto
            );
            $this->Compras_model->saveNotificacion($data);
        }
    }

    protected function updateStockProducto($idproducto, $cantidad)
    {
        $infoproducto = $this->Productos_model->getProducto($idproducto);

        $data = array(
            'stock' => $infoproducto->stock + $cantidad,
        );
        $this->Productos_model->update($idproducto, $data);
    }

    protected function updateProductosAsociados($idproducto)
    {
        $productosA = $this->Productos_model->getProductosA($idproducto);
        if (!empty($productosA)) {
            foreach ($productosA as $productoA) {
                $productoActual = $this->Productos_model->getProducto($productoA->producto_asociado);
                $this->updateProducto($productoA->producto_asociado, $productoA->cantidad);
            }
        }
    }

    protected function updateProducto($idproducto, $cantidad)
    {
        $productoActual = $this->Productos_model->getProducto($idproducto);
        $data = array(
            'stock' => $productoActual->stock + $cantidad,
        );
        $this->Productos_model->update($idproducto, $data);
    }


    public function edit($id)
    {
        $data  = array(
            'compra' => $this->Compras_model->getVenta($id),
            "detalles" => $this->Compras_model->getDetalle($id),
            "tipocomprobantes" => $this->Compras_model->getComprobantes(),
            "tipopagos" => $this->Compras_model->getTipoPagos(),
            "proveedores" => $this->Proveedores_model->getProveedores(),
            "estado" => "2",
        );
        $this->load->view("layouts/header");
        $this->load->view("layouts/aside");
        $this->load->view("admin/compras/edit", $data);
        $this->load->view("layouts/footer");
    }

    public function savecliente()
    {
        $nombre = $this->input->post("nombre");
        //$tipodocumento = $this->input->post("tipodocumento");
        //$tipocliente = $this->input->post("tipocliente");
        $direccion = $this->input->post("direccion");
        $telefono = $this->input->post("telefono");
        //$num_documento = $this->input->post("numero");

        $data  = array(
            'nombre' => $nombre,
            //	'tipo_documento_id' => $tipodocumento,
            //	'tipo_cliente_id' => $tipocliente,
            'direccion' => $direccion,
            'telefono' => $telefono,
            //	'num_documento' => $num_documento,
            'estado' => "1"
        );
        $cliente = $this->Ventas_model->savecliente($data);
        if (!$cliente) {
            echo "0";
        } else {
            $data  = array(
                'id' => $cliente,
                'nombres' => $nombre,
            );
            echo json_encode($data);
        }
    }

    public function update()
    {
        $comprobante = $this->input->post("comprobante");
        $tipo_pago = $this->input->post("tipo_pago");
        $descripcion = $this->input->post("descripcion");
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
            'tipo_pago_id' => $tipo_pago,
            'descripcion' => $descripcion,
            'usuario_id' => $this->session->userdata('id'),
            'estado' => 1,
        );

        $this->retornarStockCompra($idventa);

        $this->Compras_model->deleteDetail($idventa);

        if ($this->Compras_model->update($idventa, $data)) {
            //$this->session->set_flashdata("msg_success","La informacion de la categoria  ".$name." se actualizo correctamente");
            for ($i = 0; $i < count($idproductos); $i++) {
                $this->save_detalle($idproductos, $idventa, $precios, $cantidades, $importes, $descripcion);
            }
            $this->backend_lib->savelog($this->modulo, "Actualizacion de la venta con identificador " . $idventa);
            $this->session->set_flashdata("msg_success", "La informacion de la venta se actualizo correctamente");
            redirect(base_url() . "movimientos/ventas");
        } else {
            //$this->session->set_flashdata("msg_error","La informacion de la categoria ".$name." no pudo actualizarse");
            //redirect(base_url() . "movimientos/ventas/edit/" . $idarea);

        }
    }


    protected function retornarStockCompra($idcompra)
    {
        $detalles = $this->Compras_model->getDetalle($idcompra);

        foreach ($detalles as $detalle) {
            $infoproducto = $this->Productos_model->getProducto($detalle->producto_id);
            //reponer stock de los productos asociados
            $productosAsociados = $this->Productos_model->getProductosA($detalle->producto_id);

            foreach ($productosAsociados as $productoA) {
                $infoproductoA = $this->Productos_model->getProducto($productoA->producto_asociado);

                $dataProductoA = array(
                    'stock' => $infoproductoA->stock + ($productoA->cantidad * $detalle->cantidad),
                );

                $this->Productos_model->update($productoA->producto_asociado, $dataProductoA);
            }
            //Actualizando el stock del producto
            $dataProducto = array(
                'stock' => $infoproducto->stock + $detalle->cantidad,
            );

            $this->Productos_model->update($detalle->producto_id, $dataProducto);
        }
    }


    public function delete($idcompra)
    {
        $this->retornarStockCompra($idcompra);
        //$this->Ventas_model->deleteDetail($idcompra);
        $data  = array(
            'estado' => "0",
        );
        $this->backend_lib->savelog($this->modulo, "Eliminacion de la venta con identificador " . $idcompra);
        $this->Compras_model->update($idcompra, $data);
        echo "movimientos/compras";
    }


    public function comprobarPassword()
    {
        $password = $this->input->post("password");

        if (!$this->Ventas_model->comprobarPassword($password)) {
            echo "0";
        } else {
            echo "1";
        }
    }

    public function descontarStock()
    {
        $idproducto = $this->input->post("idproducto");
        $stock = $this->input->post("stock");
        $asociado = $this->input->post("asociado");

        $this->products[$idproducto]['stock'] = $this->products[$idproducto]['stock'] - $stock;
        echo json_encode($this->products);
    }

    public function verStock()
    {
        echo json_encode($this->products);
    }
}
