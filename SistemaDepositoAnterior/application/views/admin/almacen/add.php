<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Deposito
            <small>Nuevo</small>
        </h1>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box box-solid">
            <div class="box-body">
                <div class="row">
                    <div class="col-md-12">
                        <?php if ($this->session->flashdata("error")) : ?>
                            <div class="alert alert-danger alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <p><i class="icon fa fa-ban"></i><?php echo $this->session->flashdata("error"); ?></p>

                            </div>
                        <?php endif; ?>
                        <form action="<?php echo base_url(); ?>mantenimiento/almacen/store" method="POST">
                            <div class="form-group <?php echo form_error('nombre') == true ? 'has-error' : '' ?>">
                                <label for="nombre">Nombre:</label>
                                <input type="text" class="form-control" id="nombre" name="nombre">
                                <?php echo form_error("nombre", "<span class='help-block'>", "</span>"); ?>
                            </div>
                            <div class="form-group">
                                <label for="fecha_creacion">Fecha de Creacion:</label>
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <label for="">Fecha de Entrada:</label>
                                    <input type="datetime" class="form-control" name="fecha_creacion" id="fecha_creacion" step="1" min="2013-01-01-00:00Z" max="2013-12-31-12:00" value="<?php echo date("Y-m-d\TH-:i"); ?>" readonly>
                                </div>
                            </div>
                            <div class="form-group <?php echo form_error('descripcion') == true ? 'has-error' : '' ?>">
                                <label for="descripcion">Ubicacion:</label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion">
                                <?php echo form_error("descripcion", "<span class='help-block'>", "</span>"); ?>
                            </div>

                            <div class="form-group <?php echo form_error('precio') == true ? 'has-error' : '' ?>">
                                <label for="precio">Costo por Mes:</label>
                                <input type="text" class="form-control" id="precio" name="precio">
                                <?php echo form_error("precio", "<span class='help-block'>", "</span>"); ?>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-flat">Guardar</button>
                                <a href="<?php echo base_url() . $this->uri->segment(1) . '/' . $this->uri->segment(2); ?>" class="btn btn-danger btn-flat">Volver</a>
                            </div>
                        </form>
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