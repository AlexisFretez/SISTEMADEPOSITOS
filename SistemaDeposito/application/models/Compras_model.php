<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Compras_model extends CI_Model
{

    public function getCompras()
    {
        $this->db->select("c.*,p.nit,p.nombre as proveedor,tp.nombre as tipopago, u.nombres");

        //$this->db->select("c.*,al.nombre as almacenes,");

        $this->db->from("compras c");
        $this->db->join("proveedor p", "c.proveedor_id = p.id");
        //$this->db->join("almacen al", "c.almacen_id = al.id");
        $this->db->join("tipo_pago tp", "c.tipo_pago_id = tp.id");
        $this->db->join("usuarios u", "c.usuario_id = u.id");

        $resultados = $this->db->get();
        if ($resultados->num_rows() > 0) {
            return $resultados->result();
        } else {
            return false;
        }
    }
    public function getVentasbyDate($fechainicio, $fechafin)
    {
        $this->db->select("v.*,c.nombre,tc.nombre as tipocomprobante, u.nombres");
        $this->db->from("ventas v");
        $this->db->join("clientes c", "v.cliente_id = c.id");
        $this->db->join("tipo_comprobante tc", "v.tipo_comprobante_id = tc.id");
        $this->db->join("usuarios u", "v.usuario_id = u.id");
        $this->db->where("v.fecha >=", $fechainicio);
        $this->db->where("v.fecha <=", $fechafin);
        $resultados = $this->db->get();
        if ($resultados->num_rows() > 0) {
            return $resultados->result();
        } else {
            return false;
        }
    }

    public function getCompra($id)
    {
        $this->db->select("c.*,p.nombre as proveedor,p.nit,p.direccion,tp.nombre as tipopago");
        //$this->db->select("c.*,al.nombre as almacenes,");
        $this->db->from("compras c");
        $this->db->join("proveedor p", "c.proveedor_id = p.id");
        $this->db->join("tipo_pago tp", "c.tipo_pago_id = tp.id");
        //$this->db->join("almacen al", "c.almacen_id = al.id");
        $this->db->where("c.id", $id);
        $resultados = $this->db->get();
        if ($resultados->num_rows() > 0) {
            return $resultados->row();
        } else {
            return false;
        }
    }

    public function getDetalle($id)
    {
        $this->db->select("dc.*,p.codigo_barras,p.nombre,p.stock");
        $this->db->from("detalle_compra dc");
        $this->db->join("productos p", "dc.producto_id = p.id");
        $this->db->where("dc.compra_id", $id);
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function getComprobantes()
    {
        $resultados = $this->db->get("tipo_comprobante");
        return $resultados->result();
    }
    public function getTipoPagos()
    {
        $resultados = $this->db->get("tipo_pago");
        return $resultados->result();
    }

    public function getComprobante($idcomprobante)
    {
        $this->db->where("id", $idcomprobante);
        $resultado = $this->db->get("tipo_comprobante");
        return $resultado->row();
    }

    public function getproductos($valor)
    {


        //ete borrar si n anda guardar
        // $this->db->select("dc.*,c.descripcion");
        //$this->db->from("detalle_compra dc");
        //$this->db->join("compras c", "dc.compra_id = c.id");
        //$this->db->join("productos p", "dc.producto_id = p.id");

        //hasta aca borrar



        $this->db->select("p.id,CONCAT(p.codigo_barras,' - ',p.nombre) as label,p.nombre,p.codigo_barras,p.precio_compra,m.nombre as marca,p.stock");
        $this->db->from("productos p");
        $this->db->join("marca m", "p.marca_id = m.id");
        $this->db->like("CONCAT(p.codigo_barras,'',p.nombre)", $valor);
        $resultados = $this->db->get();
        return $resultados->result_array();
    }

    public function getProductoByCode($codigo_barra)
    {
        $this->db->select("p.id,p.nombre,p.codigo_barras,p.precio,m.nombre as marca,p.stock");
        $this->db->from("productos p");
        $this->db->join("marca m", "p.marca_id = m.id");
        $this->db->where("p.codigo_barras", $codigo_barra);
        $this->db->where("p.stock > ", 0);
        $resultados = $this->db->get();
        if ($resultados->num_rows() > 0) {
            return $resultados->row();
        } else {
            return false;
        }
    }

    public function getproductosA($valor)
    {
        $this->db->select("id,codigo_barras,nombre as label,precio,stock");
        $this->db->from("productos");
        $this->db->like("nombre", $valor);
        $resultados = $this->db->get();
        return $resultados->result_array();
    }

    public function save($data)
    {
        return $this->db->insert("compras", $data);
    }

    public function lastID()
    {
        return $this->db->insert_id();
    }

    public function updateComprobante($idcomprobante, $data)
    {
        $this->db->where("id", $idcomprobante);
        $this->db->update("tipo_comprobante", $data);
    }

    public function save_detalle($data)
    {
        $this->db->insert("detalle_compra", $data);
    }

    public function years()
    {
        $this->db->select("YEAR(fecha) as year");
        $this->db->from("compras");
        $this->db->group_by("year");
        $this->db->order_by("year", "desc");
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function montos()
    {
        $this->db->select("fecha, SUM(total) as monto");
        $this->db->from("compras");
        $this->db->where("estado", "1");
        $this->db->group_by("fecha");
        $this->db->order_by("fecha");
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function montosMeses($year)
    {
        $this->db->select("MONTH(fecha) as mes, SUM(total) as monto");
        $this->db->from("compras");
        $this->db->where("fecha >=", $year . "-01-01");
        $this->db->where("fecha <=", $year . "-12-31");
        $this->db->group_by("mes");
        $this->db->order_by("mes");
        $resultados = $this->db->get();
        return $resultados->result();
    }


    public function savecliente($data)
    {
        if ($this->db->insert("clientes", $data)) {
            return $this->db->insert_id();
        } else {
            return false;
        }
    }

    public function stockminimo()
    {
        $this->db->where("estado", "1");
        $query = $this->db->get("productos");
        $return = array();

        foreach ($query->result() as $producto) {
            if ($producto->stock <= $producto->stock_minimo) {
                $return[$producto->id] = $producto;
            }
        }

        return $return;
    }

    public function deleteDetail($id)
    {
        $this->db->where("compra_id", $id);
        return $this->db->delete("detalle_compra");
    }

    public function update($id, $data)
    {
        $this->db->where("id", $id);
        return $this->db->update("compras", $data);
    }

    public function comprobarPassword($password)
    {
        $this->db->where("clave_permiso", $password);
        $resultados  = $this->db->get("configuraciones");
        if ($resultados->num_rows() > 0) {
            return $resultados->row();
        } else {
            return false;
        }
    }

    public function saveNotificacion($data)
    {
        $this->db->insert("notificaciones", $data);
    }

    public function updateNotificacion($id, $data)
    {
        $this->db->where("id", $id);
        return $this->db->update("notificaciones", $data);
    }

    public function getProducts()
    {
        $this->db->select("p.*,c.nombre as categoria");
        $this->db->from("productos p");
        $this->db->join("categorias c", "p.categoria_id = c.id");
        $this->db->where("p.estado", "1");
        $resultados = $this->db->get();

        $productos = array();
        foreach ($resultados->result_array() as $resultado) {
            $productos[$resultado['id']] = $resultado;
        }

        return $productos;
    }

    public function productosVendidos($fechainicio, $fechafin)
    {
        $this->db->select("p.id, p.nombre, p.stock, p.precio,SUM(dv.cantidad) as totalVendidos");
        $this->db->from("detalle_venta dv");
        $this->db->join("productos p", "dv.producto_id = p.id");
        $this->db->join("ventas v", "dv.venta_id = v.id");
        $this->db->where("v.fecha >=", $fechainicio);
        $this->db->where("v.fecha <=", $fechafin);
        $this->db->group_by("dv.producto_id");
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function getLastProductos()
    {
        $this->db->select("p.*, c.nombre as categoria");
        $this->db->from("productos p");
        $this->db->join("categorias c", "p.categoria_id = c.id");
        $this->db->order_by('id', "desc");
        $this->db->limit(5);
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function getProductosStockMinimo()
    {
        $this->db->select("p.*,c.nombre as categoria");
        $this->db->from("productos p");
        $this->db->join("categorias c", "p.categoria_id = c.id");
        $this->db->where("p.estado", "1");
        $this->db->where("stock <", 10);
        $resultados = $this->db->get();
        return $resultados->result();
    }

    public function getProductosmasVendidos()
    {
        $this->db->select("p.id, p.codigo_barras, p.nombre, p.stock, p.precio,SUM(dv.cantidad) as totalVendidos, c.nombre as categoria");
        $this->db->from("detalle_venta dv");
        $this->db->join("productos p", "dv.producto_id = p.id");
        $this->db->join("ventas v", "dv.venta_id = v.id");
        $this->db->join("categorias c", "p.categoria_id = c.id");
        $this->db->order_by("totalVendidos", "desc");
        $this->db->limit(10);
        $this->db->group_by("dv.producto_id");
        $resultados = $this->db->get();
        return $resultados->result();
    }
    public function getProveedores($valor)
    {
        $this->db->select("id,nit,nombre as label");
        $this->db->from("proveedor");
        $this->db->like("nombre", $valor);
        $resultados = $this->db->get();
        return $resultados->result_array();
    }
}
