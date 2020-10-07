<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Ingreso
            <small>Nuevo</small>
        </h1>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box box-solid">
            <div class="box-body">
                <div class="row">
                    <!--Inicio Primer Columna-->
                    <div class="col-md-9">
                        <form action="<?php echo base_url(); ?>movimientos/compras/store" method="POST" class="form-horizontal">
                            <!--   <input type="hidden" name="estado" value="<? php // echo $estado; 
                                                                                ?>">-->

                            <div class="col-md-12">
                                <label for="">Agregar Productos:</label>
                                <div class="input-group barcode">
                                    <div class="input-group-addon">
                                        <i class="fa fa-barcode"></i>
                                    </div>
                                    <input type="text" class="form-control" id="searchProductoCompra" placeholder="Buscar por codigo de barras o nombre del Producto">
                                </div>

                            </div>

                            <div class="col-md-12">
                                <table id="tbcompras" class="table table-bordered table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Codigo</th>
                                            <th>Nombre</th>
                                            <th></th>
                                            <th>Cantidad</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>

                    </div>
                    <!--Inicio 2da Columna-->
                    <div class="col-md-3">

                        <input type="hidden" class="form-control" name="fecha" id="fecha" step="1" min="2013-01-01-00:00Z" max="2013-12-31-12:00" value="<?php echo date("Y-m-d\TH-:i"); ?>" readonly>

                        <label for="">Empresa/Cliente:</label>



                        <label for="">Empresa:</label>
                        <div class="input-group">
                            <input type="hidden" name="idproveedor" id="idproveedor">
                            <input type="text" class="form-control" name="proveedor" id="proveedor" placeholder="">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#modal-proveedor"><span class="fa fa-search"></span> Buscar</button>
                            </span>
                        </div><!-- /input-group -->

                        <label for="">Depositos:</label>
                        <select name="almacen" id="almacen" class="form-control" required>
                            <option value="">Seleccione...</option>
                            <?php foreach ($almacenes as $almacen) : ?>
                                <option value="<?php echo $almacen->id ?>"><?php echo $almacen->nombre ?></option>
                            <?php endforeach ?>

                        </select>

                        <label for="">Observacion:</label>
                        <input type="text" name="comprobante" class="form-control">



                        <!--Inicio 2da Columna
                        <label for="">Tipo de Pago:</label>
                        <select name="tipo_pago" id="tipo_pago" class="form-control" required>
                            <option value="">Seleccione...</option>
                            <?php foreach ($tipo_pagos as $tipo_pago) : ?>
                                <option value="<?php echo $tipo_pago->id ?>"><?php echo $tipo_pago->nombre ?></option>
                            <?php endforeach ?>

                        </select>


                        //input de Subtotal y Total


                        <div class="input-group">
                            <span class="input-group-addon">Subtotal:</span>
                            <input type="hidden" class="form-control" placeholder="0.00" name="subtotal" readonly="readonly">
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon">Total:</span>
                            <input type="hidden" class="form-control" placeholder="0.00" name="total" readonly="readonly">
                        </div>
                        -->



                        <label for="">Serie:</label>
                        <input type="text" class="form-control" id="serie" name="serie" placeholder="Escriba la Serie">


                        <label for="">Numero:</label>
                        <input type="text" class="form-control" name="numero" placeholder="Escriba el No. de Factura">




                        <!-- /.tab-pane -->


                        <!-- /.tab-pane -->

                        <br>

                        <br>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success btn-flat" id="btn-guardar-compra"><i class="fa fa-save"></i> Guardar Ingreso</button>
                            <a href="<?php echo base_url() . $this->uri->segment(1) . '/' . $this->uri->segment(2); ?>" class="btn btn-danger btn-flat"><i class="fa fa-times"></i> Cancelar</a>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            <!--Fin de Primer Columna-->
        </div>

        <!--end row1-->
</div>
<!-- /.box-body -->
</div>
<!-- /.box -->
</section>

<!-- /.content -->

</div>
<!-- /.content-wrapper -->


<div class="modal fade" id="modal-proveedor">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Empresa</h4>
            </div>
            <div class="modal-body">
                <div class="nav-tabs-custom">

                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <table id="example1" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Ruc</th>

                                        <th>Nombre</th>
                                        <th>Numero Trelefono</th>
                                        <th>Opcion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (!empty($proveedores)) : ?>
                                        <?php foreach ($proveedores as $proveedor) : ?>
                                            <tr>
                                                <td><?php echo $proveedor->nit; ?></td>
                                                <td><?php echo $proveedor->nombre; ?></td>

                                                <td><?php echo $proveedor->telefono; ?></td>
                                                <?php $dataproveedor = $proveedor->id . "*" . $proveedor->nombre . "*" . $proveedor->telefono . "*" .   $proveedor->telefono . "*" . $proveedor->direccion; ?>
                                                <td>
                                                    <button type="button" class="btn btn-success btn-check1" value="<?php echo $dataproveedor; ?>"><span class="fa fa-check"></span></button>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>

                        </div>
                        <!-- /.tab-pane -->

                        <!-- /.tab-pane -->

                    </div>
                    <!-- /.tab-content -->
                </div>