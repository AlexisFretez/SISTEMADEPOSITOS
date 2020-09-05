<div class="row">
    <div class="col-xs-12">
        <div class="form-group">
            <table border="1" width="100%">
                <tbody>
                    <tr>
                        <th colspan="7" class="text-center">Informacion de la Empresa</th>
                    </tr>
                    <tr>
                        <th>Empresa:</th>
                        <td colspan="2"><?php echo $compra->proveedor; ?></td>
                        <th>Serie:</th>
                        <td><?php echo $compra->serie; ?></td>
                        <th>No. Comprobante</th>
                        <td><?php echo $compra->numero; ?></td>

                    </tr>
                    <tr>
                        <th>RUC:</th>
                        <td><?php echo $compra->nit; ?></td>
                        <th>Descripcion:</th>
                        <td colspan="2"><?php echo $compra->comprobante; ?></td>

                    </tr>
                    <tr>
                        <th>Direccion:</th>
                        <td colspan="4"><?php echo $compra->direccion; ?></td>
                        <th>Fecha Entrada:</th>
                        <td><?php echo $compra->fecha; ?></td>
                    </tr>


                </tbody>
            </table>
            <br>
            <table border="1" width="100%">
                <tbody>
                    <tr>
                        <th colspan="4" class="text-center">Detalle de la Entrada</th>
                    </tr>
                    <tr>
                        <th>Cantidad</th>
                        <th>Producto</th>
                        <?php foreach ($detalles as $detalle) : ?>
                    <tr>
                        <td><?php echo $detalle->cantidad; ?></td>
                        <td><?php echo $detalle->nombre; ?></td>
                    </tr>
                <?php endforeach ?>



                </tbody>
            </table>
        </div>
    </div>
</div>