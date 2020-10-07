<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Reportes
            <small>Ingresos</small>
        </h1>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box box-solid">
            <div class="box-body">
                <div class="row">
                    <form action="<?php echo current_url(); ?>" method="POST" class="form-horizontal">
                        <div class="form-group">
                            <label for="" class="col-md-1 control-label">Desde:</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" name="fechainicio" value="<?php echo !empty($fechainicio) ? $fechainicio : date("Y-m-d"); ?>">
                            </div>
                            <label for="" class="col-md-1 control-label">Hasta:</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" name="fechafin" value="<?php echo !empty($fechafin) ? $fechafin : date("Y-m-d"); ?>">
                            </div>
                            <div class="col-md-4">
                                <input type="submit" name="buscar" value="Buscar" class="btn btn-primary">
                                <a href="<?php echo base_url(); ?>reportes/compras" class="btn btn-danger">Restablecer</a>
                            </div>
                        </div>
                    </form>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <table id="USUARIOS" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre Empresa</th>
                                    <th>Administrador</th>
                                    <th>Tipo Comprobante</th>
                                    <th>Depositos</th>
                                    <th>Fecha</th>
                                    <th>Costo por Mes</th>
                                    <th>Estado</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (!empty($compras)) : ?>
                                    <?php foreach ($compras as $compra) : ?>
                                        <tr>
                                            <td><?php echo $compra->id; ?></td>
                                            <td><?php echo $compra->nombreproveedor; ?></td>
                                            <td><?php echo $compra->nombres; ?></td>
                                            <td><?php echo $compra->serie; ?></td>
                                            <td><?php echo $compra->almacenes; ?></td>
                                            <td><?php echo date("d-m-Y\  H:i", strtotime($compra->fecha)); ?></td>
                                            <!-- /.box-body <td><?php echo $compra->fecha; ?></td>-->
                                            <td><?php echo $compra->costo; ?></td>
                                            <td>
                                                <?php if ($compra->estado == "1") {
                                                    echo '<span class="label label-success">En Deposito</span>';
                                                } else if ($compra->estado == "2") {
                                                    echo '<span class="label label-primary">Retirado</span>';
                                                } else {
                                                    echo '<span class="label label-primary">Anulado</span>';
                                                } ?>

                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-info btn-view-compra" value="<?php echo $compra->id; ?>" data-toggle="modal" data-target="#modal-compra"><span class="fa fa-search"></span></button>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif ?>
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
                <h4 class="modal-title">Informacion de la ingreso</h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary btn-print"><span class="fa fa-print"> </span>Imprimir</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->