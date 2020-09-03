<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Entrada
            <small>Nueva</small>
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
                                <label for="">Depositos:</label>
                                <div class="input-group barcode">
                                    <div class="input-group-addon">
                                        <i class="fa fa-barcode"></i>
                                    </div>
                                    <input type="text" class="form-control" id="searchProductoCompra" placeholder="Buscar por codigo de barras o nombre del Deposito">
                                </div>

                            </div>

                            <div class="col-md-12">
                                <table id="tbcompras" class="table table-bordered table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Codigo</th>
                                            <th>Nombre</th>
                                            <th>Marca a Guardar</th>
                                            <th>Costo</th>
                                            <th>Cantidad Dias</th>
                                            <th>Importe</th>
                                            <th>Descripcion</th>
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

                        <label for="">Comprobante:</label>
                        <input type="text" name="comprobante" class="form-control">




                        <label for="">Tipo de Pago:</label>
                        <select name="tipo_pago" id="tipo_pago" class="form-control" required>
                            <option value="">Seleccione...</option>
                            <?php foreach ($tipo_pagos as $tipo_pago) : ?>
                                <option value="<?php echo $tipo_pago->id ?>"><?php echo $tipo_pago->nombre ?></option>
                            <?php endforeach ?>

                        </select>
                        <label for="">Descripcion Articulo:</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Escriba la Descripcion a guardar">

                        <label for="">Serie:</label>
                        <input type="text" class="form-control" id="serie" name="serie" placeholder="Escriba la Serie">


                        <label for="">No. Comprobante:</label>
                        <input type="text" class="form-control" name="numero" placeholder="Escriba el No. de Factura">

                        <label for="">Fecha de Entrada:</label>
                        <input type="date" class="form-control" name="fecha" value="<?php echo date("Y-m-d"); ?>" required readonly>

                        <!--  <label for="">Fecha de Entrada:</label>
                        <input type="datetime" class="form-control" name="fecha" step="1" min="2013-01-01-00:00Z" max="2013-12-31-12:00" value="<?php echo date("Y-m-d\TH-:i"); ?>">-->






                        <label for="">Empresa/Cliente:</label>
                        <div class="input-group">
                            <input type="hidden" name="idproveedor" id="idproveedor">
                            <input type="text" class="form-control" name="proveedor" id="proveedor" placeholder="Escriba el nombre de la Empresa">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#modal-compras"><span class="fa fa-search"></span> Buscar</button>
                            </span>
                        </div><!-- /input-group -->


                        <br>
                        <div class="input-group">
                            <span class="input-group-addon">Subtotal:</span>
                            <input type="text" class="form-control" placeholder="0.00" name="subtotal" readonly="readonly">
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon">Total:</span>
                            <input type="text" class="form-control" placeholder="0.00" name="total" readonly="readonly">
                        </div>
                        <br>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success btn-flat" id="btn-guardar-compra"><i class="fa fa-save"></i> Guardar Compra</button>
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

<div class="modal fade" id="modal-compras">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Empresa</h4>
            </div>
            <div class="modal-body">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Listado</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Registrar</a></li>

                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <table id="example1" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Documento</th>
                                        <th>Numero</th>
                                        <th>Nombre</th>
                                        <th>Opcion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (!empty($proveedores)) : ?>
                                        <?php foreach ($proveedores as $proveedor) : ?>
                                            <tr>
                                                <td><?php echo $proveedor->id; ?></td>
                                                <td><?php echo $proveedor->nombre; ?></td>
                                                <td><?php echo $proveedor->nit; ?></td>
                                                <?php $dataproveedor = $proveedor->id . "*" . $proveedor->nombre . "*" . $proveedor->nit . "*" . $proveedor->direccion . "*" . $proveedor->telefono; ?>
                                                <td>
                                                    <button type="button" class="btn btn-success btn-check" value="<?php echo $dataproveedor; ?>"><span class="fa fa-check"></span></button>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>

                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">
                            <form action="<?php echo base_url(); ?>movimientos/ventas/savecliente" method="POST" id="form-cliente">
                                <div class="form-group">
                                    <label for="nombre">Nombre:</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" required>

                                </div>
                                <div class="form-group">
                                    <label for="tipocliente">Tipo de Cliente</label>
                                    <select name="tipocliente" id="tipocliente" class="form-control" required>
                                        <option value="">Seleccione...</option>
                                        <?php foreach ($tipoclientes as $tipocliente) : ?>
                                            <option value="<?php echo $tipocliente->id; ?>"><?php echo $tipocliente->nombre ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="tipodocumento">Tipo de Documento</label>
                                    <select name="tipodocumento" id="tipodocumento" class="form-control" required>
                                        <option value="">Seleccione...</option>
                                        <?php foreach ($tipodocumentos as $tipodocumento) : ?>
                                            <option value="<?php echo $tipodocumento->id; ?>"><?php echo $tipodocumento->nombre ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="numero">No. de Documento:</label>
                                    <input type="text" class="form-control" id="numero" name="numero" required>
                                </div>

                                <div class="form-group">
                                    <label for="telefono">Telefono:</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono">
                                </div>
                                <div class="form-group">
                                    <label for="direccion">Direccion:</label>
                                    <input type="text" class="form-control" id="direccion" name="direccion">
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-success btn-flat">Guardar y Seleccionar</button>
                                </div>
                            </form>
                        </div>
                        <!-- /.tab-pane -->

                    </div>
                    <!-- /.tab-content -->
                </div>



            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>