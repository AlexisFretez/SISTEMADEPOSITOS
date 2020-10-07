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
                        <td colspan="3"><?php echo $compra->nit; ?></td>
                        <th>Deposito:</th>
                        <td colspan="2"><?php echo $compra->almacenes; ?></td>

                    </tr>
                    <tr>
                        <th>Direccion:</th>
                        <td colspan="4"><?php echo $compra->direccion; ?></td>
                        <th>Fecha:</th>
                        <td><?php echo date("d-m-Y\  H:i", strtotime($compra->fecha)); ?></td>
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

                <th>Costo por Dia:</th>
                <td><?php echo $compra->Costo; ?></td> <br>

                <th>Total Dias:</th>
                <td><?php echo $compra->dias; ?></td>

                </tbody>
            </table>
            <br>
            <table border="1" width="50%">
                <th>Total : <?php echo $compra->a_pagar; ?></th>

            </table>
        </div>
    </div>
</div>