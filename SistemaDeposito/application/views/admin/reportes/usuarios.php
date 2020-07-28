<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Usuarios
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
                        <div class="table-responsive">
                            <table id="inventario1" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Nombres</th>
                                        <th>Apellidos</th>
                                        <th>Email</th>
                                        <th>Usuario</th>
                                        <th>Rol</th>
                                        <th>Fecha Creacion</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (!empty($usuarios)) : ?>
                                        <?php foreach ($usuarios as $usuario) : ?>
                                            <tr>
                                                <td><?php echo $usuario->id; ?></td>
                                                <td><?php echo $usuario->nombres; ?></td>
                                                <td><?php echo $usuario->apellidos; ?></td>
                                                <td><?php echo $usuario->email; ?></td>
                                                <td><?php echo $usuario->username; ?></td>
                                                <td><?php echo $usuario->rol; ?></td>
                                                <td><?php echo $usuario->fecha_creacion; ?></td>



                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
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

<div class="modal fade" id="modal-default">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Informacion del Producto</h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->