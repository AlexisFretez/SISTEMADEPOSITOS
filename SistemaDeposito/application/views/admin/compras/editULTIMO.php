<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Ventas
            <small>Editar</small>
        </h1>
    </section>

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#sumar").click(function() {
                $.ajax({
                    type: 'post',
                    url: base_url + "movimientos/compras/sumar",
                    dataType: 'json',
                    data: {
                        fecha: $("#fecha").val(),
                        fecha_salida: $("#fecha_salida").val(),
                        Costo: $("#Costo").val()
                    },
                    success: function(res) {
                        $("#resultado").val(res.resultado);
                        $("#resultado1").val(res.resultado1);

                    },
                    error: function(res) {
                        alert(res['codigo']);
                    }

                });
            });
        });
    </script>

    <style type="text/css">
        label {
            width: 150px;
            height: 30px;
            line-height: 30px;
            display: inline-block;
        }
    </style>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box box-solid">
            <div class="box-body">

                <div class="row">
                    <form action="<?php echo base_url(); ?>movimientos/compras/update" method="POST" class="form-horizontal">
                        <!--Inicio Primer Columna-->
                        <div class="col-md-9">
                            <input type="hidden" id="modulo" value="compras">
                            <input type="hidden" name="idVenta" value="<?php echo $compra->id; ?>">
                            <div class="col-md-12">
                                <label for="">Producto:</label>
                                <div class="input-group barcode">
                                    <div class="input-group-addon">
                                        <i class="fa fa-barcode"></i>
                                    </div>
                                    <input type="text" class="form-control" id="searchProductoVenta" placeholder="Buscar por codigo de barras o nombre del proucto">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <table id="tbventas" class="table table-bordered table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Codigo</th>
                                            <th>Nombre</th>
                                            <th>Precio</th>
                                            <th>Stock Max.</th>
                                            <th>Cantidad</th>
                                            <th>Importe</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (!empty($detalles)) : ?>
                                            <?php foreach ($detalles as $detalle) : ?>
                                                <tr>
                                                    <td>
                                                        <input type='hidden' name='idproductos[]' value="<?php echo $detalle->producto_id; ?>">
                                                        <?php echo $detalle->codigo_barras; ?>
                                                    </td>
                                                    <td><?php echo $detalle->nombre; ?></td>
                                                    <td>
                                                        <input type='hidden' name='precios[]' value="<?php echo $detalle->precio; ?>">
                                                        <?php echo $detalle->precio; ?>
                                                    </td>
                                                    <td><?php echo $detalle->stock ?></td>
                                                    <td>
                                                        <input type="text" name="cantidades[]" class="cantidadesVenta" value="<?php echo $detalle->cantidad; ?>">
                                                    </td>
                                                    <td>
                                                        <input type='hidden' name='importes[]' value="<?php echo $detalle->importe; ?>">
                                                        <p><?php echo $detalle->importe; ?></p>
                                                    </td>
                                                    <td><button type='button' class='btn btn-danger btn-remove-producto-compra'><span class='fa fa-times'></span></button></td>
                                                </tr>

                                            <?php endforeach ?>
                                        <?php endif ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--Inicio 2da Columna-->
                        <div class="col-md-3">


                            <label for="">Nro de Documento</label>
                            <input type="text" class="form-control" readonly="readonly" name="comprobante" value="<?php echo $compra->comprobante; ?>">

                            <label for="">Tipo de Pago:</label>
                            <select name="almacen" id="almacen" class="form-control" required>

                                <option value="1" <?php echo $compra->estado == 1 ? 'selected' : ''; ?>>Efectivo</option>
                                <option value="2" <?php echo $compra->estado == 2 ? 'selected' : ''; ?>>Credito</option>
                            </select>
                            <label for="">Depositos:</label>
                            <div class="input-group">
                                <input type="hidden" name="almacen" id="almacen" value="<?php echo $compra->almacen_id ?>">
                                <input type="text" class="form-control" " id=" almacen" value="<?php echo $compra->almacenes; ?>">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#modal-proveedor"><span class="fa fa-search"></span> Buscar</button>
                                </span>
                            </div><!-- /input-group -->

                            <label for="">Empresa:</label>
                            <div class="input-group">
                                <input type="hidden" name="idproveedor" id="idproveedor" value="<?php echo $compra->proveedor_id ?>">
                                <input type="text" class="form-control" " id=" proveedor" value="<?php echo $compra->proveedor; ?>">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#modal-proveedor"><span class="fa fa-search"></span> Buscar</button>
                                </span>
                            </div><!-- /input-group -->
                            <div>
                                <h4 style="color: blue">Calcular Dias</h4>
                                <label for="">Fecha:</label>
                                <input type="date" class="form-control" name="fecha" id="fecha" value="<?php echo $compra->fecha; ?>" required readonly>


                                <label for="fecha_salida">Fecha de Salida:</label>

                                <input type="date" class="form-control pull-right" id="fecha_salida" name="fecha_salida" value="<?php echo date("Y-m-d"); ?>" require>

                                <label for="">Costo Deposito</label>
                                <input type="text" class="form-control" readonly="readonly" id="Costo" name="Costo" value="<?php echo $compra->Costo; ?>">

                                <!--<label>Fecha Inicio</label><input type="date" name="" id="a"><br>
                                <label>Fecha Fin</label><input type="date" name="" id="b"><br>-->
                                <label>Total Dias</label><input type="text" name="dias" id="resultado">
                                <label>Total Pagar</label><input type="text" name="a_apagar" id="resultado1"><br> <br>
                                <input type="button" class="btn btn-success btn-flat" name="sumar" id="sumar" value="Calcular Dias">
                            </div>



                            <label for="">Monto Recibido:</label>
                            <input type="text" class="form-control" id="monto_recibido" name="monto_recibido">

                            <br>
                            <div class="input-group">
                                <span class="input-group-addon">Subtotal:</span>
                                <input type="text" class="form-control" placeholder="0.00" name="subtotal" readonly="readonly" value="<?php echo $compra->subtotal; ?>">
                            </div>





                            <div class="input-group">
                                <span class="input-group-addon">Total:</span>
                                <input type="text" class="form-control" placeholder="0.00" name="total" readonly="readonly" value="<?php echo $compra->total ?>">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon">Cambio:</span>
                                <input type="text" class="form-control" placeholder="0.00" name="cambio" readonly="readonly">
                            </div>
                            <br>

                            <button type="submit" class="btn btn-success btn-flat"><i class="fa fa-save"></i> Guardar Venta</button>

                            <a href="<?php echo base_url() . $this->uri->segment(1) . '/' . $this->uri->segment(2); ?>" class="btn btn-danger btn-flat"><i class="fa fa-times"></i> Cancelar</a>

                        </div>
                    </form>


                </div>

                <!--end row-->
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    </section>

    <!-- /.content -->

</div>
<!-- /.content-wrapper -->