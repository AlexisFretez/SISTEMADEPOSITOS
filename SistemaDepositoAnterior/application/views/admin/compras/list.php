<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Ingresos
            <small>Listado</small>
        </h1>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box box-solid">
            <div class="box-body">
                <div class="row">
                    <div class="col-md-12">

                        <a href="<?php echo base_url(); ?>movimientos/compras/add" class="btn btn-primary btn-flat"><span class="fa fa-plus"></span> Nuevo Ingreso</a>

                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <table id="example1" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Fecha</th>
                                    <th>Descripcion</th>
                                    <th>Empresa/Cliente</th>
                                    <th>Depositos</th>
                                    <th>Estado</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (!empty($compras)) : ?>
                                    <?php foreach ($compras as $compra) : ?>
                                        <tr>
                                            <td><?php echo $compra->id; ?></td>
                                            <td><?php echo $compra->fecha; ?></td>
                                            <td><?php echo $compra->comprobante; ?></td>

                                            <td><?php echo $compra->proveedor; ?></td>

                                            <td><?php echo $compra->almacenes; ?></td>
                                            <td>
                                                <?php if ($compra->estado == "1") {
                                                    echo '<span class="label label-success">En Deposito</span>';
                                                } else if ($compra->estado == "2") {
                                                    echo '<span class="label label-warning">Pendiente</span>';
                                                } else {
                                                    echo '<span class="label label-danger">Anulado</span>';
                                                } ?>
                                            </td>

                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-success btn-info-compra" data-toggle="modal" data-target="#modal-compra" value="<?php echo $compra->id; ?>"><span class="fa fa-search"></span></button>

                                                    <?php if ($compra->estado != 0) : ?>


                                                        <?php if ($permisos->update == 1) : ?>
                                                            <a href="<?php echo base_url() ?>movimientos/compras/edit/<?php echo $compra->id; ?>" class="btn btn-warning"><span class="fa fa-pencil"></span></a>
                                                        <?php endif; ?>
                                                        <?php if ($permisos->delete == 1) : ?>
                                                            <a href="<?php echo base_url(); ?>movimientos/compras/delete/<?php echo $compra->id; ?>" class="btn btn-danger btn-remove"><span class="fa fa-remove"></span></a>
                                                        <?php endif; ?>
                                                    <?php endif ?>

                                                </div>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<div class="modal fade" id="modal-compra">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Informacion de la Compra</h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary btn-flat btn-print"><span class="fa fa-print"></span> Imprimir</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->