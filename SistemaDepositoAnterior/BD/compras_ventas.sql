-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.17-log - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para compras_ventas
DROP DATABASE IF EXISTS `compras_ventas`;
CREATE DATABASE IF NOT EXISTS `compras_ventas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `compras_ventas`;

-- Volcando estructura para tabla compras_ventas.almacen
DROP TABLE IF EXISTS `almacen`;
CREATE TABLE IF NOT EXISTS `almacen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `predeterminado` tinyint(1) DEFAULT NULL,
  `ruc` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `precio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.almacen: ~8 rows (aproximadamente)
DELETE FROM `almacen`;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` (`id`, `nombre`, `fecha_creacion`, `estado`, `descripcion`, `predeterminado`, `ruc`, `telefono`, `direccion`, `precio`) VALUES
	(10, 'Deposito 13', '2020-08-28', 1, 'Tinglado derecha', NULL, '10', '0010101', 'itauguya', '5000'),
	(11, 'Deposito 2', '2020-08-02', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 'Deposito 3', '2020-08-02', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 'Deposito 4', '2020-08-02', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 'Deposito 5', '2020-08-02', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 'KILOSooopop', '2020-08-27', 1, NULL, NULL, '25558888', '063552', '777swdsdswdsad', '500'),
	(16, 'Aldo  genes', NULL, 1, NULL, NULL, '888', '98888', '7888', '89000'),
	(17, 'deposito100', '2020-08-27', 1, 'para 100', NULL, NULL, NULL, NULL, '50000');
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.caja
DROP TABLE IF EXISTS `caja`;
CREATE TABLE IF NOT EXISTS `caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `operacion` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `efectivo` decimal(10,2) NOT NULL,
  `observacion` varchar(200) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `gastos_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `fk_caja_gastos_idx` (`gastos_id`),
  CONSTRAINT `caja_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_caja_gastos` FOREIGN KEY (`gastos_id`) REFERENCES `gastos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.caja: ~2 rows (aproximadamente)
DELETE FROM `caja`;
/*!40000 ALTER TABLE `caja` DISABLE KEYS */;
INSERT INTO `caja` (`id`, `fecha`, `monto`, `operacion`, `usuario_id`, `efectivo`, `observacion`, `estado`, `gastos_id`) VALUES
	(1, '2018-10-21 07:25:00', 100.00, 1, 5, 0.00, '', NULL, NULL),
	(2, '2020-06-26 18:26:42', 100000.00, 1, 5, 0.00, '', NULL, NULL);
/*!40000 ALTER TABLE `caja` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.categorias
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `FK_marcas` (`marca_id`),
  CONSTRAINT `FK_marcas` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.categorias: ~4 rows (aproximadamente)
DELETE FROM `categorias`;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `marca_id`, `estado`) VALUES
	(1, 'CLAVOS', 'para alabar ropa', 1, 1),
	(2, 'KILOS', 'Desinfectante Poet Primavera de 648ml', 1, 1),
	(3, 'CLAVOS88', 'para alabar ropa', NULL, 1),
	(4, 'LEXIS', '', NULL, 1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `tipo_contribuyente_id` int(11) DEFAULT NULL,
  `tipo_documento_id` int(11) DEFAULT NULL,
  `num_documento` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_cliente_idx` (`tipo_contribuyente_id`),
  KEY `fk_tipo_documento_idx` (`tipo_documento_id`),
  CONSTRAINT `fk_tipo_contribuyente` FOREIGN KEY (`tipo_contribuyente_id`) REFERENCES `tipo_contribuyente` (`id`),
  CONSTRAINT `fk_tipo_documento` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipo_documento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.clientes: ~7 rows (aproximadamente)
DELETE FROM `clientes`;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `nombre`, `telefono`, `direccion`, `tipo_contribuyente_id`, `tipo_documento_id`, `num_documento`, `estado`) VALUES
	(95, 'Juan Perez', '988898989', 'Miramar E-13 Parte Baja', 3, 2, '89098911', 1),
	(96, 'aLEXIS', '111', 'itaufgua', NULL, NULL, NULL, 1),
	(97, 'aLEXIS', '111', 'itaufgua', NULL, NULL, NULL, 1),
	(98, 'CLAVOS', '111', 'itaufgua', NULL, NULL, NULL, 1),
	(99, 'aLEXIS', '111', 'itaufgua', NULL, NULL, NULL, 1),
	(100, 'aLEXIS', '111', 'itaufgua', NULL, NULL, NULL, 1),
	(101, 'aLEXIS', '022', 'itaufgua', 3, 3, '65563', 1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.compras
DROP TABLE IF EXISTS `compras`;
CREATE TABLE IF NOT EXISTS `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `subtotal` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `comprobante` varchar(100) NOT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `tipo_pago_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `numero` varchar(50) NOT NULL,
  `serie` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_documento_prov_compras_idx` (`comprobante`),
  KEY `fk_proveedor_compras_idx` (`proveedor_id`),
  KEY `fk_usuarios_compras_idx` (`usuario_id`),
  KEY `fk_tipo_pago_compras_idx` (`tipo_pago_id`),
  KEY `fk_almacen_compras_idx` (`almacen_id`),
  CONSTRAINT `fk_almacen_compras` FOREIGN KEY (`almacen_id`) REFERENCES `almacen` (`id`),
  CONSTRAINT `fk_proveedor_compras` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`),
  CONSTRAINT `fk_tipo_pago_compras` FOREIGN KEY (`tipo_pago_id`) REFERENCES `tipo_pago` (`id`),
  CONSTRAINT `fk_usuarios_compras` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.compras: ~7 rows (aproximadamente)
DELETE FROM `compras`;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` (`id`, `fecha`, `subtotal`, `total`, `comprobante`, `proveedor_id`, `tipo_pago_id`, `usuario_id`, `almacen_id`, `estado`, `numero`, `serie`) VALUES
	(16, '2020-08-02', '50000.00', '50000.00', '01', 1, 1, 5, 10, 1, '01', '01'),
	(17, '2020-08-02', '5000.00', '5000.00', '011', 1, 1, 5, 10, 1, '65563', '10'),
	(18, '2020-08-02', '1000.00', '1000.00', '010', 1, 2, 5, 11, 1, '888', '01'),
	(19, '2020-08-02', '900.00', '900.00', '011', 1, 1, 5, 12, 1, '555', '21'),
	(20, '2020-08-03', '25.00', '25.00', '01', 1, 1, 8, 10, 1, '222', '333'),
	(21, '2020-08-03', '1000.00', '1000.00', '01', 1, 1, 8, 10, 1, '02', '01'),
	(22, '2020-08-04', '25.00', '25.00', '10', 1, 1, 8, 11, 1, '10', '10');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.configuraciones
DROP TABLE IF EXISTS `configuraciones`;
CREATE TABLE IF NOT EXISTS `configuraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave_permiso` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.configuraciones: ~1 rows (aproximadamente)
DELETE FROM `configuraciones`;
/*!40000 ALTER TABLE `configuraciones` DISABLE KEYS */;
INSERT INTO `configuraciones` (`id`, `clave_permiso`) VALUES
	(1, 'admin');
/*!40000 ALTER TABLE `configuraciones` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.detalle_compra
DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE IF NOT EXISTS `detalle_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `importe` varchar(45) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_detalle_compra_compra_idx` (`compra_id`),
  KEY `fk_detalle_compra_producto_idx` (`producto_id`),
  KEY `fk_detalle_compra_marca_idx` (`marca_id`),
  CONSTRAINT `fk_detalle_compra_compra` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  CONSTRAINT `fk_detalle_compra_marca` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`),
  CONSTRAINT `fk_detalle_compra_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.detalle_compra: ~7 rows (aproximadamente)
DELETE FROM `detalle_compra`;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` (`id`, `compra_id`, `producto_id`, `precio`, `cantidad`, `importe`, `marca_id`) VALUES
	(1, 16, 193, '5000', '10', '50000.00', NULL),
	(2, 17, 193, '5000', '1', '5000', NULL),
	(3, 18, 192, '100', '10', '1000.00', NULL),
	(4, 19, 189, '9.00', '100', '900.00', NULL),
	(5, 20, 188, '2.50', '10', '25.00', NULL),
	(6, 21, 192, '100', '10', '1000.00', NULL),
	(7, 22, 188, '2.50', '10', '25.00', NULL);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.detalle_venta
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `importe` varchar(45) DEFAULT NULL,
  `codigo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_venta_detalle_idx` (`venta_id`),
  KEY `fk_producto_detalle_idx` (`producto_id`),
  CONSTRAINT `fk_producto_detalle` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `fk_venta_detalle` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.detalle_venta: ~10 rows (aproximadamente)
DELETE FROM `detalle_venta`;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` (`id`, `producto_id`, `venta_id`, `precio`, `cantidad`, `importe`, `codigo`) VALUES
	(1, 193, 1138, '5000', 12, '60000.00', NULL),
	(2, 193, 1145, '5000', 8, '40000.00', NULL),
	(3, 193, 1146, '5000', 15, '75000.00', NULL),
	(4, 193, 1147, '5000', 15, '75000.00', NULL),
	(5, 193, 1148, '5000', 10, '50000.00', NULL),
	(6, 193, 1149, '5000', 10, '50000.00', NULL),
	(8, 189, 1150, '9.00', 11, '99.00', NULL),
	(9, 188, 1151, '2.50', 1, '2.50', NULL),
	(10, 193, 1152, '5000', 1, '5000', NULL),
	(11, 189, 1153, '9.00', 1, '9.00', NULL);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.documento_prov
DROP TABLE IF EXISTS `documento_prov`;
CREATE TABLE IF NOT EXISTS `documento_prov` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL,
  `correlativo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.documento_prov: ~0 rows (aproximadamente)
DELETE FROM `documento_prov`;
/*!40000 ALTER TABLE `documento_prov` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_prov` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.empresa
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `propietario` varchar(45) DEFAULT NULL,
  `logotipo` varchar(45) DEFAULT NULL,
  `nit` varchar(45) DEFAULT NULL,
  `moneda_id` int(11) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `facebook` varchar(45) DEFAULT NULL,
  `web` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_moneda_empresa_idx` (`moneda_id`),
  CONSTRAINT `fk_tipo_moneda_empresa` FOREIGN KEY (`moneda_id`) REFERENCES `tipo_moneda` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.empresa: ~1 rows (aproximadamente)
DELETE FROM `empresa`;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` (`id`, `nombre`, `propietario`, `logotipo`, `nit`, `moneda_id`, `telefono`, `direccion`, `facebook`, `web`, `email`, `estado`) VALUES
	(1, 'aaa', 'sasas', 'dsdsd', 'dasd', 1, '120', '111', '111', '222', '222', 1);
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.gastos
DROP TABLE IF EXISTS `gastos`;
CREATE TABLE IF NOT EXISTS `gastos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `tipo_gasto_id` int(11) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `notas` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gastos_tipo_gasto_idx` (`tipo_gasto_id`),
  CONSTRAINT `fk_gastos_tipo_gasto` FOREIGN KEY (`tipo_gasto_id`) REFERENCES `tipo_gasto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.gastos: ~0 rows (aproximadamente)
DELETE FROM `gastos`;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.inventarios
DROP TABLE IF EXISTS `inventarios`;
CREATE TABLE IF NOT EXISTS `inventarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` int(11) NOT NULL,
  `year` year(4) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.inventarios: ~2 rows (aproximadamente)
DELETE FROM `inventarios`;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
INSERT INTO `inventarios` (`id`, `month`, `year`, `usuario_id`, `created_at`) VALUES
	(20, 10, '2018', 5, '2018-10-25 02:00:00'),
	(21, 6, '2020', 1, '2020-06-25 00:00:00');
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.inventario_producto
DROP TABLE IF EXISTS `inventario_producto`;
CREATE TABLE IF NOT EXISTS `inventario_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `inventario_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.inventario_producto: ~6 rows (aproximadamente)
DELETE FROM `inventario_producto`;
/*!40000 ALTER TABLE `inventario_producto` DISABLE KEYS */;
INSERT INTO `inventario_producto` (`id`, `producto_id`, `inventario_id`, `cantidad`) VALUES
	(33, 188, 20, 21),
	(34, 189, 20, 0),
	(35, 190, 20, 3),
	(36, 188, 21, 21),
	(37, 189, 21, 12),
	(38, 190, 21, 3);
/*!40000 ALTER TABLE `inventario_producto` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.logs
DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `modulo` varchar(200) DEFAULT NULL,
  `accion` text,
  PRIMARY KEY (`id`),
  KEY `fk_logs_usuarios_idx` (`usuario_id`),
  CONSTRAINT `fk_logs_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.logs: ~204 rows (aproximadamente)
DELETE FROM `logs`;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`id`, `fecha`, `usuario_id`, `modulo`, `accion`) VALUES
	(1, '2018-10-23 22:35:30', 5, 'Usuarios', 'Cierre de sesión'),
	(2, '2018-10-23 22:35:37', 5, 'Usuarios', 'Inicio de sesión'),
	(3, '2018-10-23 22:47:18', 5, 'Productos', 'Actualización del Producto con codigo de barra 7756641003971'),
	(4, '2018-10-23 22:47:40', 5, 'Productos', 'Eliminación del  Producto con codigo de barra 7750885014649'),
	(5, '2018-10-23 22:56:30', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1084'),
	(6, '2018-10-25 20:53:17', 5, 'Usuarios', 'Inicio de sesión'),
	(7, '2018-10-25 22:58:23', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1085'),
	(8, '2018-10-25 23:05:05', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1086'),
	(9, '2018-10-25 23:28:21', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1087'),
	(10, '2018-10-25 23:29:17', 5, 'Ventas', 'Actualizacion de la venta con identificador 1087'),
	(11, '2018-10-25 23:30:48', 5, 'Ventas', 'Actualizacion de la venta con identificador 1087'),
	(12, '2018-10-25 23:47:59', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1088'),
	(13, '2018-10-25 23:48:25', 5, 'Ventas', 'Eliminacion de la venta con identificador 1088'),
	(14, '2020-06-25 20:41:10', 1, 'Productos', 'Inserción de un nuevo producto con codigo de barras 100'),
	(15, '2020-06-25 20:42:51', 1, 'Productos', 'Actualización del Producto con codigo de barra 7756641003971'),
	(16, '2020-06-25 20:43:23', 1, 'Productos', 'Actualización del Producto con codigo de barra 1002255555'),
	(17, '2020-06-25 20:44:38', 1, 'Productos', 'Actualización del Producto con codigo de barra 1002255555'),
	(18, '2020-06-25 20:45:44', 1, 'Productos', 'Inserción de un nuevo producto con codigo de barras 108108'),
	(19, '2020-06-26 18:10:19', 1, 'Usuarios', 'Cierre de sesión'),
	(20, '2020-06-26 18:10:29', 5, 'Usuarios', 'Inicio de sesión'),
	(21, '2020-06-26 18:25:03', 5, 'Usuarios', 'Cierre de sesión'),
	(22, '2020-06-26 18:25:22', 5, 'Usuarios', 'Inicio de sesión'),
	(23, '2020-06-30 17:13:20', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1089'),
	(24, '2020-07-06 20:40:05', 5, 'Usuarios', 'Inicio de sesión'),
	(25, '2020-07-06 20:41:23', 5, 'Usuarios', 'Cierre de sesión'),
	(26, '2020-07-06 20:48:47', 5, 'Usuarios', 'Inicio de sesión'),
	(27, '2020-07-06 20:48:51', 5, 'Usuarios', 'Cierre de sesión'),
	(28, '2020-07-06 20:50:12', 5, 'Usuarios', 'Inicio de sesión'),
	(29, '2020-07-06 20:50:29', 5, 'Usuarios', 'Cierre de sesión'),
	(30, '2020-07-06 20:56:07', 5, 'Usuarios', 'Inicio de sesión'),
	(31, '2020-07-07 18:31:31', 5, 'Usuarios', 'Cierre de sesión'),
	(32, '2020-07-07 18:42:40', 5, 'Usuarios', 'Inicio de sesión'),
	(33, '2020-07-07 19:38:33', 5, 'Usuarios', 'Cierre de sesión'),
	(34, '2020-07-07 19:38:41', 5, 'Usuarios', 'Inicio de sesión'),
	(35, '2020-07-08 18:20:52', 5, 'Usuarios', 'Cierre de sesión'),
	(36, '2020-07-08 18:28:17', 5, 'Usuarios', 'Inicio de sesión'),
	(37, '2020-07-08 18:29:02', 5, 'Usuarios', 'Inicio de sesión'),
	(38, '2020-07-08 18:43:11', 5, 'Usuarios', 'Inicio de sesión'),
	(39, '2020-07-09 18:56:45', 5, 'Ventas', 'Eliminacion de la venta con identificador 1089'),
	(40, '2020-07-09 21:38:38', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1090'),
	(41, '2020-07-09 22:13:09', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1096'),
	(42, '2020-07-09 22:13:46', 5, 'Ventas', 'Actualizacion de la venta con identificador 1096'),
	(43, '2020-07-10 17:44:43', 5, 'Usuarios', 'Cierre de sesión'),
	(44, '2020-07-10 17:44:48', 5, 'Usuarios', 'Inicio de sesión'),
	(45, '2020-07-10 17:48:37', 5, 'Usuarios', 'Cierre de sesión'),
	(46, '2020-07-10 17:48:45', 5, 'Usuarios', 'Inicio de sesión'),
	(47, '2020-07-10 19:30:14', 5, 'Usuarios', 'Cierre de sesión'),
	(48, '2020-07-10 19:30:19', 5, 'Usuarios', 'Inicio de sesión'),
	(49, '2020-07-10 19:36:42', 5, 'Ventas', 'Eliminacion de la venta con identificador 1127'),
	(50, '2020-07-10 19:36:46', 5, 'Ventas', 'Eliminacion de la venta con identificador 1090'),
	(51, '2020-07-10 19:36:50', 5, 'Ventas', 'Eliminacion de la venta con identificador 1091'),
	(52, '2020-07-10 19:36:53', 5, 'Ventas', 'Eliminacion de la venta con identificador 1092'),
	(53, '2020-07-10 19:36:56', 5, 'Ventas', 'Eliminacion de la venta con identificador 1093'),
	(54, '2020-07-10 19:42:00', 5, 'Ventas', 'Eliminacion de la venta con identificador 1094'),
	(55, '2020-07-10 19:42:03', 5, 'Ventas', 'Eliminacion de la venta con identificador 1095'),
	(56, '2020-07-10 19:42:06', 5, 'Ventas', 'Eliminacion de la venta con identificador 1096'),
	(57, '2020-07-10 21:08:06', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1138'),
	(58, '2020-07-10 21:33:05', 5, 'Usuarios', 'Cierre de sesión'),
	(59, '2020-07-10 21:33:10', 5, 'Usuarios', 'Inicio de sesión'),
	(60, '2020-07-10 21:44:26', 5, 'Usuarios', 'Cierre de sesión'),
	(61, '2020-07-10 21:44:29', 5, 'Usuarios', 'Inicio de sesión'),
	(62, '2020-07-10 21:56:45', 5, 'Ventas', 'Eliminacion de la venta con identificador 1142'),
	(63, '2020-07-10 21:56:48', 5, 'Ventas', 'Eliminacion de la venta con identificador 1141'),
	(64, '2020-07-10 22:01:19', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1145'),
	(65, '2020-07-10 22:03:07', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1146'),
	(66, '2020-07-10 22:04:27', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1147'),
	(67, '2020-07-10 22:05:48', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1148'),
	(68, '2020-07-16 20:13:43', 5, 'Usuarios', 'Cierre de sesión'),
	(69, '2020-07-16 20:13:54', 5, 'Usuarios', 'Inicio de sesión'),
	(70, '2020-07-16 20:17:54', 5, 'Usuarios', 'Cierre de sesión'),
	(71, '2020-07-16 20:18:00', 8, 'Usuarios', 'Inicio de sesión'),
	(72, '2020-07-16 20:19:13', 8, 'Usuarios', 'Cierre de sesión'),
	(73, '2020-07-16 20:19:32', 5, 'Usuarios', 'Inicio de sesión'),
	(74, '2020-07-16 20:23:11', 5, 'Usuarios', 'Cierre de sesión'),
	(75, '2020-07-16 20:23:16', 8, 'Usuarios', 'Inicio de sesión'),
	(76, '2020-07-16 20:23:29', 8, 'Usuarios', 'Cierre de sesión'),
	(77, '2020-07-16 20:23:33', 8, 'Usuarios', 'Inicio de sesión'),
	(78, '2020-07-16 20:23:39', 8, 'Usuarios', 'Cierre de sesión'),
	(79, '2020-07-16 20:23:45', 5, 'Usuarios', 'Inicio de sesión'),
	(80, '2020-07-16 20:24:48', 5, 'Usuarios', 'Cierre de sesión'),
	(81, '2020-07-16 20:24:52', 8, 'Usuarios', 'Inicio de sesión'),
	(82, '2020-07-17 17:15:58', 8, 'Usuarios', 'Cierre de sesión'),
	(83, '2020-07-17 17:42:01', 8, 'Usuarios', 'Inicio de sesión'),
	(84, '2020-07-17 19:47:27', 8, 'Usuarios', 'Cierre de sesión'),
	(85, '2020-07-17 20:05:20', 8, 'Usuarios', 'Inicio de sesión'),
	(86, '2020-07-17 20:05:25', 8, 'Usuarios', 'Cierre de sesión'),
	(87, '2020-07-17 20:19:29', 8, 'Usuarios', 'Inicio de sesión'),
	(88, '2020-07-17 20:19:38', 8, 'Usuarios', 'Cierre de sesión'),
	(89, '2020-07-17 20:32:48', 8, 'Usuarios', 'Inicio de sesión'),
	(90, '2020-07-17 20:32:52', 8, 'Usuarios', 'Cierre de sesión'),
	(91, '2020-07-17 20:37:34', 8, 'Usuarios', 'Inicio de sesión'),
	(92, '2020-07-20 17:48:41', 8, 'Usuarios', 'Cierre de sesión'),
	(93, '2020-07-20 17:48:47', 8, 'Usuarios', 'Inicio de sesión'),
	(94, '2020-07-20 17:55:11', 8, 'Usuarios', 'Cierre de sesión'),
	(95, '2020-07-20 17:55:17', 8, 'Usuarios', 'Inicio de sesión'),
	(96, '2020-07-20 18:04:26', 8, 'Usuarios', 'Cierre de sesión'),
	(97, '2020-07-20 18:04:33', 5, 'Usuarios', 'Inicio de sesión'),
	(98, '2020-07-20 20:48:58', 8, 'Usuarios', 'Inicio de sesión'),
	(99, '2020-07-20 20:49:53', 8, 'Usuarios', 'Cierre de sesión'),
	(100, '2020-07-20 20:49:57', 8, 'Usuarios', 'Inicio de sesión'),
	(101, '2020-07-20 20:52:56', 8, 'Usuarios', 'Cierre de sesión'),
	(102, '2020-07-20 20:53:00', 8, 'Usuarios', 'Inicio de sesión'),
	(103, '2020-07-20 20:53:41', 8, 'Usuarios', 'Cierre de sesión'),
	(104, '2020-07-20 20:53:45', 5, 'Usuarios', 'Inicio de sesión'),
	(105, '2020-07-20 20:54:28', 5, 'Usuarios', 'Cierre de sesión'),
	(106, '2020-07-20 20:55:36', 5, 'Usuarios', 'Inicio de sesión'),
	(107, '2020-07-20 20:57:44', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1149'),
	(108, '2020-07-20 20:59:21', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1150'),
	(109, '2020-07-20 21:01:11', 5, 'Ventas', 'Actualizacion de la venta con identificador 1150'),
	(110, '2020-07-20 21:01:39', 5, 'Ventas', 'Eliminacion de la venta con identificador 1137'),
	(111, '2020-07-20 21:02:40', 5, 'Ventas', 'Eliminacion de la venta con identificador 1149'),
	(112, '2020-07-20 21:36:26', 5, 'Usuarios', 'Cierre de sesión'),
	(113, '2020-07-20 21:36:30', 8, 'Usuarios', 'Inicio de sesión'),
	(114, '2020-07-21 17:28:38', 8, 'Usuarios', 'Cierre de sesión'),
	(115, '2020-07-21 17:30:39', 8, 'Usuarios', 'Inicio de sesión'),
	(116, '2020-07-22 21:16:01', 8, 'Usuarios', 'Cierre de sesión'),
	(117, '2020-07-22 21:16:07', 8, 'Usuarios', 'Inicio de sesión'),
	(118, '2020-07-22 21:19:04', 8, 'Usuarios', 'Cierre de sesión'),
	(119, '2020-07-22 21:19:07', 8, 'Usuarios', 'Inicio de sesión'),
	(120, '2020-07-22 21:31:12', 8, 'Usuarios', 'Cierre de sesión'),
	(121, '2020-07-22 21:31:15', 8, 'Usuarios', 'Inicio de sesión'),
	(122, '2020-07-22 21:36:19', 8, 'Usuarios', 'Cierre de sesión'),
	(123, '2020-07-22 21:36:22', 8, 'Usuarios', 'Inicio de sesión'),
	(124, '2020-07-23 19:08:39', 8, 'Usuarios', 'Cierre de sesión'),
	(125, '2020-07-23 19:08:42', 5, 'Usuarios', 'Inicio de sesión'),
	(126, '2020-07-24 18:20:40', 5, 'Usuarios', 'Cierre de sesión'),
	(127, '2020-07-24 18:20:43', 5, 'Usuarios', 'Inicio de sesión'),
	(128, '2020-07-27 17:56:07', 5, 'Usuarios', 'Cierre de sesión'),
	(129, '2020-07-27 17:56:20', 8, 'Usuarios', 'Inicio de sesión'),
	(130, '2020-07-27 17:57:11', 8, 'Usuarios', 'Cierre de sesión'),
	(131, '2020-07-27 17:57:15', 5, 'Usuarios', 'Inicio de sesión'),
	(132, '2020-07-27 17:57:49', 5, 'Usuarios', 'Cierre de sesión'),
	(133, '2020-07-27 17:57:53', 5, 'Usuarios', 'Inicio de sesión'),
	(134, '2020-07-27 17:58:52', 5, 'Usuarios', 'Cierre de sesión'),
	(135, '2020-07-27 17:58:55', 8, 'Usuarios', 'Inicio de sesión'),
	(136, '2020-07-27 17:59:49', 8, 'Usuarios', 'Cierre de sesión'),
	(137, '2020-07-27 17:59:52', 8, 'Usuarios', 'Inicio de sesión'),
	(138, '2020-07-27 18:17:04', 8, 'Usuarios', 'Cierre de sesión'),
	(139, '2020-07-27 18:17:47', 8, 'Usuarios', 'Inicio de sesión'),
	(140, '2020-07-27 18:19:41', 8, 'Usuario', 'Cierre de sesión'),
	(141, '2020-07-27 18:19:44', 8, 'Usuario', 'Inicio de sesión'),
	(142, '2020-07-27 18:20:19', 8, 'Usuarios', 'Cierre de sesión'),
	(143, '2020-07-27 18:20:22', 8, 'Usuarios', 'Inicio de sesión'),
	(144, '2020-07-27 18:20:44', 8, 'Usuarios', 'Cierre de sesión'),
	(145, '2020-07-27 18:21:43', 8, 'Usuarios', 'Inicio de sesión'),
	(146, '2020-07-27 18:55:26', 8, 'Usuarios', 'Cierre de sesión'),
	(147, '2020-07-27 18:55:31', 5, 'Usuarios', 'Inicio de sesión'),
	(148, '2020-07-27 19:25:28', 5, 'Usuarios', 'Cierre de sesión'),
	(149, '2020-07-27 19:25:33', 5, 'Usuarios', 'Inicio de sesión'),
	(150, '2020-07-27 19:37:01', 5, 'Usuarios', 'Cierre de sesión'),
	(151, '2020-07-27 19:37:05', 5, 'Usuarios', 'Inicio de sesión'),
	(152, '2020-07-27 20:14:01', 5, 'Usuarios', 'Cierre de sesión'),
	(153, '2020-07-27 20:14:06', 8, 'Usuarios', 'Inicio de sesión'),
	(154, '2020-07-28 18:37:01', 8, 'Productos', 'Actualización del Producto con codigo de barra 7756641003971'),
	(155, '2020-07-28 19:25:09', 8, 'Productos', 'Inserción de un nuevo producto con codigo de barras 9887'),
	(156, '2020-07-28 19:43:29', 8, 'Usuarios', 'Cierre de sesión'),
	(157, '2020-07-28 19:45:51', 5, 'Usuarios', 'Cierre de sesión'),
	(158, '2020-07-28 19:45:56', 8, 'Usuarios', 'Inicio de sesión'),
	(159, '2020-07-28 19:51:03', 8, 'Usuarios', 'Cierre de sesión'),
	(160, '2020-07-28 19:51:06', 5, 'Usuarios', 'Inicio de sesión'),
	(161, '2020-07-28 19:52:41', 5, 'Usuarios', 'Cierre de sesión'),
	(162, '2020-07-28 19:52:45', 8, 'Usuarios', 'Inicio de sesión'),
	(163, '2020-07-28 19:55:23', 8, 'Usuarios', 'Cierre de sesión'),
	(164, '2020-07-28 19:55:37', 16, 'Usuarios', 'Inicio de sesión'),
	(165, '2020-07-28 19:57:09', 16, 'Usuarios', 'Cierre de sesión'),
	(166, '2020-07-28 19:57:13', 8, 'Usuarios', 'Inicio de sesión'),
	(167, '2020-07-28 20:09:47', 8, 'Usuarios', 'Cierre de sesión'),
	(168, '2020-07-28 20:09:53', 8, 'Usuarios', 'Inicio de sesión'),
	(169, '2020-07-28 20:11:39', 8, 'Usuarios', 'Cierre de sesión'),
	(170, '2020-07-28 20:11:49', 18, 'Usuarios', 'Inicio de sesión'),
	(171, '2020-07-28 20:17:46', 18, 'Usuarios', 'Cierre de sesión'),
	(172, '2020-07-28 20:17:51', 8, 'Usuarios', 'Inicio de sesión'),
	(173, '2020-07-28 20:18:19', 8, 'Usuarios', 'Cierre de sesión'),
	(174, '2020-07-28 20:18:22', 5, 'Usuarios', 'Inicio de sesión'),
	(175, '2020-07-29 17:52:07', 5, 'Usuarios', 'Cierre de sesión'),
	(176, '2020-07-29 17:54:29', NULL, 'Usuarios', 'Cierre de sesión'),
	(177, '2020-07-31 20:23:07', 5, 'Usuarios', 'Cierre de sesión'),
	(178, '2020-07-31 20:23:15', 8, 'Usuarios', 'Inicio de sesión'),
	(179, '2020-08-02 19:20:14', 8, 'Productos', 'Eliminación del  Producto con codigo de barra 1002255555'),
	(180, '2020-08-02 19:20:29', 8, 'Productos', 'Eliminación del  Producto con codigo de barra 108108'),
	(181, '2020-08-02 19:54:39', 8, 'Usuarios', 'Cierre de sesión'),
	(182, '2020-08-02 19:54:47', 5, 'Usuarios', 'Inicio de sesión'),
	(183, '2020-08-02 19:58:05', 5, 'Usuarios', 'Cierre de sesión'),
	(184, '2020-08-02 19:58:08', 8, 'Usuarios', 'Inicio de sesión'),
	(185, '2020-08-02 20:04:50', 8, 'Usuarios', 'Cierre de sesión'),
	(186, '2020-08-02 20:04:56', 5, 'Usuarios', 'Inicio de sesión'),
	(187, '2020-08-03 17:14:31', 5, 'Usuarios', 'Cierre de sesión'),
	(188, '2020-08-03 17:14:35', 8, 'Usuarios', 'Inicio de sesión'),
	(189, '2020-08-03 17:24:01', 8, 'Usuarios', 'Cierre de sesión'),
	(190, '2020-08-03 17:24:07', 8, 'Usuarios', 'Inicio de sesión'),
	(191, '2020-08-03 20:20:33', 8, 'Ventas', 'Inserción de una nueva venta con identificador 1151'),
	(192, '2020-08-03 20:21:32', 8, 'Ventas', 'Inserción de una nueva venta con identificador 1152'),
	(193, '2020-08-03 22:37:15', 8, 'Ventas', 'Inserción de una nueva venta con identificador 1153'),
	(194, '2020-08-04 18:21:40', 8, 'Usuarios', 'Cierre de sesión'),
	(195, '2020-08-04 18:21:43', 8, 'Usuarios', 'Inicio de sesión'),
	(196, '2020-08-05 20:34:29', 8, 'Usuarios', 'Cierre de sesión'),
	(197, '2020-08-05 20:34:33', 8, 'Usuarios', 'Inicio de sesión'),
	(198, '2020-08-05 20:39:29', 8, 'Productos', 'Inserción de un nuevo producto con codigo de barras 10777ff'),
	(199, '2020-08-05 21:17:38', 8, 'Productos', 'Inserción de un nuevo producto con codigo de barras 1002'),
	(200, '2020-08-05 21:21:08', 8, 'Productos', 'Inserción de un nuevo producto con codigo de barras 888'),
	(201, '2020-08-06 18:08:11', 8, 'Usuarios', 'Cierre de sesión'),
	(202, '2020-08-27 18:33:28', 5, 'Usuarios', 'Inicio de sesión'),
	(203, '2020-08-27 18:34:20', 5, 'Usuarios', 'Cierre de sesión'),
	(204, '2020-08-27 18:34:25', 8, 'Usuarios', 'Inicio de sesión');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.marca
DROP TABLE IF EXISTS `marca`;
CREATE TABLE IF NOT EXISTS `marca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.marca: ~2 rows (aproximadamente)
DELETE FROM `marca`;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` (`id`, `nombre`, `estado`) VALUES
	(1, 'Poet', 1),
	(2, 'CLAVOS', 1);
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.menus
DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `parent` varchar(10) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.menus: ~40 rows (aproximadamente)
DELETE FROM `menus`;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `nombre`, `link`, `parent`, `orden`, `estado`) VALUES
	(1, 'Inicio', 'dashboard', '0', 1, 1),
	(2, 'Categorias', 'mantenimiento/categorias', '9', 0, 1),
	(3, 'Solicitante Producto', 'mantenimiento/clientes', '9', 0, 1),
	(4, 'Productos', 'mantenimiento/productos', '9', 0, 1),
	(5, 'Salidas', 'movimientos/ventas', '10', 0, 1),
	(6, 'Reporte de Ventas', 'reportes/ventas', '11', 0, 1),
	(7, 'Usuarios', 'administrador/usuarios', '12', 0, 1),
	(8, 'Permisos', 'administrador/permisos', '12', 0, 1),
	(9, 'Mantenimiento', '#', '0', 3, 1),
	(10, 'Movimientos', '#', '0', 5, 1),
	(11, 'Reportes', '#', '0', 6, 1),
	(12, 'Administrador', '#', '0', 7, 1),
	(13, 'Configuraciones', '#', '0', 0, 1),
	(14, 'Apertura de Caja', 'caja/apertura', '15', 0, 1),
	(15, 'Caja', '#', '0', 4, 1),
	(16, 'Cierre de Caja', 'caja/cierre', '15', 0, 1),
	(17, 'Reporte de Inventario', 'reportes/inventario', '11', 0, 1),
	(18, 'Ordenes', 'movimientos/ordenes', '10', 0, 1),
	(19, 'Mesas', 'mantenimiento/mesas', '15', 0, 1),
	(20, 'Clave de Permiso', 'administrador/clave-permiso', '12', 0, 1),
	(21, 'Productos Vendidos', 'reportes/productos', '11', 0, 1),
	(22, 'Subcategorias', 'mantenimiento/subcategorias', '9', 0, 1),
	(23, 'Panel de Control', 'reportes/grafico', '0', 0, 0),
	(24, 'Cuentas por Cobrar', '#', '0', 6, 1),
	(25, 'Ordenes Pendientes', 'movimientos/ordenes_pendientes', '24', 0, 1),
	(26, 'Marcas', 'mantenimiento/marcas', '9', 0, 1),
	(27, 'Presentacion', 'mantenimiento/presentacion', '9', 0, 1),
	(28, 'Depositos', 'mantenimiento/almacen', '9', 0, 1),
	(29, 'Contribuyente', 'mantenimiento/contribuyente', '9', 0, 1),
	(30, 'Documentos', 'mantenimiento/documento', '9', 0, 1),
	(31, 'Comprobantes', 'mantenimiento/comprobante', '9', 0, 1),
	(32, 'Empresa/Cliente', 'mantenimiento/proveedor', '9', 0, 1),
	(33, 'Moneda', 'mantenimiento/monedas', '9', 0, 1),
	(34, 'Empresa', 'administrador/empresa', '12', 0, 1),
	(35, 'Entradas', 'movimientos/compras', '10', 0, 1),
	(36, 'Inventario', '#', '0', 8, 1),
	(37, 'Registrar Inventario Inicial', 'inventario/registro_mensual', '36', 0, 1),
	(38, 'seguimiento', 'inventario/seguimiento', '36', 0, 1),
	(39, 'Logs', 'administrador/logs', '12', 0, 1),
	(40, 'Reporte Usuarios', 'reportes/usuarios', '11', 0, 1);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.mesas
DROP TABLE IF EXISTS `mesas`;
CREATE TABLE IF NOT EXISTS `mesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(50) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.mesas: ~4 rows (aproximadamente)
DELETE FROM `mesas`;
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
INSERT INTO `mesas` (`id`, `numero`, `estado`) VALUES
	(1, '01', 0),
	(2, '02', 0),
	(3, '3', 0),
	(5, '5', 0);
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.notificaciones
DROP TABLE IF EXISTS `notificaciones`;
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productos_notificaciones_idx` (`producto_id`),
  CONSTRAINT `fk_productos_notificaciones` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.notificaciones: ~6 rows (aproximadamente)
DELETE FROM `notificaciones`;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` (`id`, `producto_id`, `estado`) VALUES
	(1, 190, 1),
	(2, 189, 1),
	(3, 190, 1),
	(4, 190, 1),
	(5, 190, 1),
	(6, 190, 1);
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos: ~3 rows (aproximadamente)
DELETE FROM `pedidos`;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` (`id`, `fecha`, `usuario_id`, `estado`) VALUES
	(1, '2020-07-10', 5, 0),
	(2, '2020-07-10', 5, 0),
	(3, '2020-07-10', 5, 1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos_mesa
DROP TABLE IF EXISTS `pedidos_mesa`;
CREATE TABLE IF NOT EXISTS `pedidos_mesa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) DEFAULT NULL,
  `mesa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos_mesa: ~33 rows (aproximadamente)
DELETE FROM `pedidos_mesa`;
/*!40000 ALTER TABLE `pedidos_mesa` DISABLE KEYS */;
INSERT INTO `pedidos_mesa` (`id`, `pedido_id`, `mesa_id`) VALUES
	(1, 1, 1),
	(5, 5, 2),
	(6, 6, 2),
	(7, 7, 2),
	(8, 8, 2),
	(9, 9, 2),
	(10, 10, 2),
	(11, 11, 2),
	(12, 12, 2),
	(13, 13, 3),
	(14, 14, 2),
	(15, 15, 2),
	(16, 16, 2),
	(17, 17, 2),
	(18, 18, 2),
	(19, 19, 2),
	(20, 20, 2),
	(21, 21, 2),
	(22, 22, 2),
	(23, 22, 0),
	(24, 23, 3),
	(25, 24, 1),
	(26, 25, 1),
	(27, 26, 1),
	(28, 27, 1),
	(29, 28, 1),
	(30, 29, 1),
	(60, 59, 1),
	(61, 60, 2),
	(62, 60, 0),
	(63, 1, 3),
	(64, 2, 1),
	(65, 3, 5);
/*!40000 ALTER TABLE `pedidos_mesa` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos_productos
DROP TABLE IF EXISTS `pedidos_productos`;
CREATE TABLE IF NOT EXISTS `pedidos_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `producto_asociado` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `pagados` int(11) DEFAULT NULL,
  `updated` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos_productos: ~3 rows (aproximadamente)
DELETE FROM `pedidos_productos`;
/*!40000 ALTER TABLE `pedidos_productos` DISABLE KEYS */;
INSERT INTO `pedidos_productos` (`id`, `pedido_id`, `producto_id`, `producto_asociado`, `cantidad`, `pagados`, `updated`, `estado`) VALUES
	(1, 1, 193, NULL, 2, NULL, NULL, NULL),
	(2, 2, 193, NULL, 5, NULL, NULL, NULL),
	(3, 3, 188, NULL, 5, NULL, NULL, NULL);
/*!40000 ALTER TABLE `pedidos_productos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.permisos
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `read` int(11) DEFAULT NULL,
  `insert` int(11) DEFAULT NULL,
  `update` int(11) DEFAULT NULL,
  `delete` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menus_idx` (`menu_id`),
  KEY `fk_rol_idx` (`rol_id`),
  CONSTRAINT `fk_menus` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`),
  CONSTRAINT `fk_rol` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.permisos: ~77 rows (aproximadamente)
DELETE FROM `permisos`;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` (`id`, `menu_id`, `rol_id`, `read`, `insert`, `update`, `delete`) VALUES
	(1, 1, 2, 1, 1, 1, 1),
	(2, 2, 2, 1, 1, 1, 0),
	(3, 3, 2, 1, 1, 1, 1),
	(4, 4, 2, 1, 1, 1, 0),
	(5, 5, 2, 1, 1, 1, 1),
	(10, 1, 1, 1, 1, 1, 1),
	(11, 2, 1, 1, 1, 1, 1),
	(12, 4, 1, 1, 1, 1, 1),
	(13, 5, 1, 1, 1, 1, 1),
	(14, 6, 1, 1, 1, 1, 1),
	(15, 7, 1, 1, 1, 1, 1),
	(16, 3, 1, 1, 1, 1, 1),
	(17, 8, 1, 1, 1, 1, 1),
	(18, 9, 1, 1, 1, 1, 1),
	(19, 10, 1, 1, 1, 1, 1),
	(20, 11, 1, 1, 1, 1, 1),
	(21, 12, 1, 1, 1, 1, 1),
	(23, 9, 2, 1, 1, 1, 1),
	(24, 10, 2, 1, 1, 1, 1),
	(25, 15, 1, 1, 1, 1, 1),
	(26, 14, 1, 1, 1, 1, 1),
	(27, 16, 1, 1, 1, 1, 1),
	(28, 14, 2, 1, 1, 1, 1),
	(29, 16, 2, 1, 1, 1, 1),
	(30, 17, 1, 1, 1, 1, 1),
	(32, 19, 1, 1, 1, 1, 1),
	(33, 18, 2, 1, 1, 1, 0),
	(34, 17, 2, 1, 1, 1, 1),
	(35, 6, 2, 0, 0, 0, 0),
	(36, 11, 2, 1, 1, 1, 1),
	(37, 15, 2, 1, 1, 1, 1),
	(38, 19, 2, 1, 1, 1, 1),
	(39, 20, 1, 1, 1, 1, 1),
	(40, 21, 1, 1, 1, 1, 1),
	(41, 22, 1, 1, 1, 1, 1),
	(42, 23, 1, 1, 1, 1, 1),
	(43, 23, 2, 0, 1, 1, 1),
	(44, 24, 1, 1, 1, 1, 1),
	(45, 25, 1, 1, 1, 1, 1),
	(46, 26, 1, 1, 1, 1, 1),
	(47, 27, 1, 1, 1, 1, 1),
	(48, 28, 1, 1, 1, 1, 1),
	(49, 29, 1, 1, 1, 1, 1),
	(50, 30, 1, 1, 1, 1, 1),
	(51, 31, 1, 1, 1, 1, 1),
	(52, 32, 1, 1, 1, 1, 1),
	(53, 33, 1, 1, 1, 1, 1),
	(54, 34, 1, 1, 1, 1, 1),
	(55, 35, 1, 1, 1, 1, 1),
	(56, 36, 1, 1, 1, 1, 1),
	(57, 37, 1, 1, 1, 1, 1),
	(58, 38, 1, 1, 1, 1, 1),
	(59, 39, 1, 1, 1, 1, 1),
	(60, 13, 1, 1, 1, 1, 1),
	(61, 18, 1, 1, 1, 1, 1),
	(62, 19, 1, 1, 1, 1, 1),
	(64, 23, 1, 1, 1, 1, 1),
	(65, 1, 3, 1, 1, 1, 1),
	(67, 7, 3, 1, 1, 1, 1),
	(68, 23, 3, 1, 1, 1, 1),
	(69, 12, 3, 1, 1, 1, 1),
	(70, 8, 3, 1, 1, 1, 1),
	(71, 2, 3, 1, 1, 1, 1),
	(72, 9, 3, 1, 1, 1, 1),
	(74, 26, 3, 1, 1, 1, 1),
	(75, 3, 3, 1, 1, 1, 1),
	(76, 27, 3, 1, 1, 1, 1),
	(77, 32, 3, 1, 1, 1, 1),
	(78, 10, 3, 1, 1, 1, 1),
	(80, 28, 3, 1, 1, 1, 1),
	(84, 40, 1, 1, 1, 1, 1),
	(85, 11, 3, 1, 1, 1, 1),
	(86, 40, 3, 1, 1, 1, 1),
	(87, 4, 3, 1, 1, 1, 1),
	(88, 4, 2, 1, 1, 1, 1),
	(89, 35, 3, 1, 1, 1, 1),
	(90, 5, 3, 1, 1, 1, 1);
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.presentacion
DROP TABLE IF EXISTS `presentacion`;
CREATE TABLE IF NOT EXISTS `presentacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.presentacion: ~2 rows (aproximadamente)
DELETE FROM `presentacion`;
/*!40000 ALTER TABLE `presentacion` DISABLE KEYS */;
INSERT INTO `presentacion` (`id`, `nombre`, `estado`) VALUES
	(1, 'Unidad', 1),
	(2, 'KILOS', 1);
/*!40000 ALTER TABLE `presentacion` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_barras` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `codigo_slug` varchar(45) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `precio_compra` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT '0',
  `stock_minimo` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) NOT NULL,
  `subcategoria` int(11) NOT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  `pasillo` varchar(45) DEFAULT NULL,
  `estanteria` varchar(45) DEFAULT NULL,
  `condicion` tinyint(4) DEFAULT NULL,
  `asociado` tinyint(4) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo_barras`),
  KEY `fk_categoria_producto_idx` (`categoria_id`),
  KEY `fk_subcategoria_producto_idx` (`subcategoria_id`),
  KEY `fk_presentacion_producto_idx` (`presentacion_id`),
  KEY `fk_marca_producto_idx` (`marca_id`),
  KEY `fk_almacen_producto_idx` (`almacen_id`),
  CONSTRAINT `fk_categoria_producto` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  CONSTRAINT `fk_marca_producto` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`),
  CONSTRAINT `fk_presentacion_producto` FOREIGN KEY (`presentacion_id`) REFERENCES `presentacion` (`id`),
  CONSTRAINT `fk_subcategoria_producto` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.productos: ~10 rows (aproximadamente)
DELETE FROM `productos`;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`id`, `codigo_barras`, `codigo`, `codigo_slug`, `nombre`, `descripcion`, `precio`, `precio_compra`, `stock`, `stock_minimo`, `categoria_id`, `subcategoria_id`, `subcategoria`, `imagen`, `presentacion_id`, `marca_id`, `pasillo`, `estanteria`, `condicion`, `asociado`, `estado`, `almacen_id`) VALUES
	(188, '7756641003971', NULL, NULL, 'Desinfectante Poet Primavera de 648ml', 'Desinfectante Poet Primavera de 648ml', '3.00', '2.50', 45, 10, 25, 5, 1, 'Poet_Portada.jpg', 1, 1, '3', '4', NULL, NULL, 1, 1),
	(189, '7751271011693', NULL, NULL, 'Detergente Ariel de 1kg', 'Detergente Ariel de 1kg', '10.00', '9.00', 120, 5, 25, 5, 0, 'Penguins.jpg', 1, 1, '3', '2', NULL, NULL, 1, NULL),
	(190, '7759307005197', NULL, NULL, 'Lejia Clorox de 1litro', 'Lejia Clorox de 1litro', '5.00', '4.00', 1, 5, 25, 5, 0, 'Penguins1.jpg', 1, 1, '1', '3', NULL, NULL, 1, NULL),
	(191, '7750885014649', NULL, NULL, 'Avena 3 ositos', 'Avena 3 ositos', '1.50', '1.20', 48, 6, 25, 5, 0, 'Lighthouse1.jpg', 1, 1, '1', '2', NULL, NULL, 1, NULL),
	(192, '1002255555', NULL, NULL, 'CLAVOS', 'para alabar ropa', '150', '100', 20, 50, 25, 5, 0, 'fhfhf.png', 1, 1, '1', '5', NULL, NULL, 1, NULL),
	(193, '108108', NULL, NULL, 'alexis', 'vx', '15000', '5000', 160, 20, 35, 5, 0, 'REST.jpg', 2, 2, '1', '5', NULL, NULL, 1, NULL),
	(194, '9887', NULL, NULL, 'CLAVOS666', 'para alabar ropa', '20000', '15000', 0, 10, 25, 5, 0, 'Poet_Portada1.jpg', 2, 2, '1', '22', NULL, NULL, 1, NULL),
	(198, '10777ff', NULL, NULL, 'CLAVOSddd', '32', '20000', '100', 0, 10, 41, 5, 0, 'economic1.png', 2, 1, '2', '10', NULL, NULL, 1, NULL),
	(200, '1002', NULL, NULL, 'CLAVOS2', 'para alabar ropa', '20000', '15000', 0, 10, 1, 6, 0, 'internet1.png', 1, 1, '3', '3', NULL, NULL, 1, NULL),
	(202, '888', NULL, NULL, 'CLAVOS2333', 'DD', '150', '1000', 0, 0, 1, 5, 0, 'pallet.png', 1, 1, '3', '1', NULL, NULL, 1, NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.productos_asociados
DROP TABLE IF EXISTS `productos_asociados`;
CREATE TABLE IF NOT EXISTS `productos_asociados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `producto_asociado` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.productos_asociados: ~0 rows (aproximadamente)
DELETE FROM `productos_asociados`;
/*!40000 ALTER TABLE `productos_asociados` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos_asociados` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.proveedor
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `nit` varchar(45) DEFAULT NULL,
  `contribuyente_id` int(11) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `contacto` varchar(45) DEFAULT NULL,
  `tel_contacto` varchar(45) DEFAULT NULL,
  `banco` varchar(45) DEFAULT NULL,
  `no_cuenta` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contribuyente_proveedor_idx` (`contribuyente_id`),
  CONSTRAINT `fk_contribuyente_proveedor` FOREIGN KEY (`contribuyente_id`) REFERENCES `tipo_contribuyente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.proveedor: ~3 rows (aproximadamente)
DELETE FROM `proveedor`;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` (`id`, `nombre`, `nit`, `contribuyente_id`, `direccion`, `telefono`, `email`, `contacto`, `tel_contacto`, `banco`, `no_cuenta`, `estado`) VALUES
	(1, 'JJ Moran S.A', '10477471123', 3, 'Calle Arica 430', '988898989', 'jjmoran@ventas.pe', '1000', '989112121', NULL, NULL, 1),
	(2, 'ALEXIS', '4555', 3, 'itaufgua', '888', 'aada@gmai.com1', '2000', '55888', NULL, NULL, 1),
	(3, '999999966SZADWD', '4565666666', NULL, 'ITAUGUUA', '0255556', NULL, '36555', NULL, NULL, NULL, 1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.roles: ~3 rows (aproximadamente)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
	(1, 'admin', 'todas las funciones'),
	(2, 'cajero', 'algunas funciones'),
	(3, 'Vendedor', 'Acceso algunas funciones');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.subcategorias
DROP TABLE IF EXISTS `subcategorias`;
CREATE TABLE IF NOT EXISTS `subcategorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.subcategorias: ~2 rows (aproximadamente)
DELETE FROM `subcategorias`;
/*!40000 ALTER TABLE `subcategorias` DISABLE KEYS */;
INSERT INTO `subcategorias` (`id`, `nombre`, `estado`) VALUES
	(5, 'Desinfectante', 1),
	(6, 'CLAVOS', 1);
/*!40000 ALTER TABLE `subcategorias` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_comprobante
DROP TABLE IF EXISTS `tipo_comprobante`;
CREATE TABLE IF NOT EXISTS `tipo_comprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `iva` int(11) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `no_inicial` int(11) NOT NULL,
  `no_final` int(11) NOT NULL,
  `resolucion` varchar(50) NOT NULL,
  `fecha_resolucion` date NOT NULL,
  `predeterminado` tinyint(1) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `igv` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_comprobante: ~3 rows (aproximadamente)
DELETE FROM `tipo_comprobante`;
/*!40000 ALTER TABLE `tipo_comprobante` DISABLE KEYS */;
INSERT INTO `tipo_comprobante` (`id`, `nombre`, `iva`, `serie`, `fecha_registro`, `no_inicial`, `no_final`, `resolucion`, `fecha_resolucion`, `predeterminado`, `estado`, `cantidad`, `igv`) VALUES
	(3, 'Factura', 18, '001', '0000-00-00 00:00:00', 1, 99999999, 'resolucion 01', '0000-00-00', 0, 1, 5, NULL),
	(4, 'Boleta', 0, '002', '0000-00-00 00:00:00', 1, 99999999, 'resolucion 01', '0000-00-00', 1, 1, 46, NULL),
	(5, 'Ticket', 0, '001', '2018-10-18 00:00:00', 1, 99999999, 'resolucion 01', '2018-10-18', 0, 1, 24, NULL);
/*!40000 ALTER TABLE `tipo_comprobante` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_contribuyente
DROP TABLE IF EXISTS `tipo_contribuyente`;
CREATE TABLE IF NOT EXISTS `tipo_contribuyente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_contribuyente: ~2 rows (aproximadamente)
DELETE FROM `tipo_contribuyente`;
/*!40000 ALTER TABLE `tipo_contribuyente` DISABLE KEYS */;
INSERT INTO `tipo_contribuyente` (`id`, `nombre`, `descripcion`, `estado`) VALUES
	(3, 'Persona Natural', '', 1),
	(4, 'Empresa', NULL, 1);
/*!40000 ALTER TABLE `tipo_contribuyente` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_documento
DROP TABLE IF EXISTS `tipo_documento`;
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_documento: ~3 rows (aproximadamente)
DELETE FROM `tipo_documento`;
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` (`id`, `nombre`, `estado`) VALUES
	(2, 'DNI', 1),
	(3, 'RUC', 1),
	(4, 'Pasaporte', 1);
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_gasto
DROP TABLE IF EXISTS `tipo_gasto`;
CREATE TABLE IF NOT EXISTS `tipo_gasto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_gasto: ~0 rows (aproximadamente)
DELETE FROM `tipo_gasto`;
/*!40000 ALTER TABLE `tipo_gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_gasto` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_moneda
DROP TABLE IF EXISTS `tipo_moneda`;
CREATE TABLE IF NOT EXISTS `tipo_moneda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `simbolo` varchar(10) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_moneda: ~1 rows (aproximadamente)
DELETE FROM `tipo_moneda`;
/*!40000 ALTER TABLE `tipo_moneda` DISABLE KEYS */;
INSERT INTO `tipo_moneda` (`id`, `nombre`, `simbolo`, `estado`) VALUES
	(1, 'Guaranies', 'Gs', 1);
/*!40000 ALTER TABLE `tipo_moneda` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_pago
DROP TABLE IF EXISTS `tipo_pago`;
CREATE TABLE IF NOT EXISTS `tipo_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `predeterminado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_pago: ~2 rows (aproximadamente)
DELETE FROM `tipo_pago`;
/*!40000 ALTER TABLE `tipo_pago` DISABLE KEYS */;
INSERT INTO `tipo_pago` (`id`, `nombre`, `predeterminado`) VALUES
	(1, 'Efectivo', 1),
	(2, 'Credito', 0);
/*!40000 ALTER TABLE `tipo_pago` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(45) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_rol_usuarios_idx` (`rol_id`),
  CONSTRAINT `fk_rol_usuarios` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.usuarios: ~10 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `imagen`, `nombres`, `apellidos`, `telefono`, `email`, `username`, `password`, `fecha_creacion`, `rol_id`, `estado`, `codigo`) VALUES
	(1, NULL, 'Gary', 'Cano', '42956492', 'gcanom88@gmail.com', 'gcano', 'b2ffdbeb87e8e6331d350b482b328d309bc5a321', '2020-07-24', 1, 0, NULL),
	(5, NULL, 'Alexander', 'Fretez', '45645342', 'alexander@gmail.com', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '2020-07-24', 1, 1, NULL),
	(6, NULL, 'julio', 'mendoza', '46464545', 'julio@admin.com', 'julio17', 'd033e22ae348aeb5660fc2140aec35850c4da997', NULL, 2, 1, NULL),
	(8, NULL, 'Alexis', 'Fretez', '01222', 'aada@gmai.com', 'admin1', 'd033e22ae348aeb5660fc2140aec35850c4da997', '2020-07-24', 3, 1, NULL),
	(11, NULL, 'Jorge', 'Genes', '022', 'aada@gmai.com1', 'admin2', 'd033e22ae348aeb5660fc2140aec35850c4da997', NULL, 2, 0, NULL),
	(12, NULL, 'Alexis', 'Genes', '022', 'aada@gmai.com120', 'fretez', '8e16be22305386f83121c439e97b35e2a48ef670', NULL, 1, 0, NULL),
	(13, NULL, 'aldo', 'moreno', '4788', 'asa', 'aldo', '1c89c0f71ac97754ffc597c567d01b2ade0c9324', NULL, 1, 0, NULL),
	(15, NULL, 'Aldo', 'moreno', '588', '7441ll', 'aldo1', '49f2e484735122b468e2516259b6fd83e0cdb569', NULL, 1, 0, NULL),
	(16, NULL, 'aldo', 'Genes', '111', 'aada@gmai.com1g', 'aldo14', '87fe6eba85db238529e69e41ce5aee1365a2f3d0', '2020-07-24', 2, 1, NULL),
	(19, NULL, 'Alexander1', 'dsdsd', '2255', 'alexisolimpero18@gmasdsil.com', 'alexsdisdisdi', 'fb5b6d9791554e2f3bafb22e4ce8a819c47e26df', '2020-08-04', 2, 1, '100');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.ventas
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `subtotal` varchar(45) DEFAULT NULL,
  `descuento` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `tipo_comprobante_id` int(11) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `compras_id` int(11) DEFAULT NULL,
  `num_documento` varchar(45) DEFAULT NULL,
  `monto_recibido` varchar(45) DEFAULT NULL,
  `cambio` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `iva` varchar(50) NOT NULL,
  `igv` varchar(50) NOT NULL,
  `serie` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario_venta_idx` (`usuario_id`),
  KEY `fk_cliente_venta_idx` (`cliente_id`),
  KEY `fk_tipo_comprobante_venta_idx` (`tipo_comprobante_id`),
  KEY `fk_compras_id` (`compras_id`),
  CONSTRAINT `fk_cliente_venta` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_compras_id` FOREIGN KEY (`compras_id`) REFERENCES `compras` (`id`),
  CONSTRAINT `fk_tipo_comprobante_venta` FOREIGN KEY (`tipo_comprobante_id`) REFERENCES `tipo_comprobante` (`id`),
  CONSTRAINT `fk_usuario_venta` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1154 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.ventas: ~17 rows (aproximadamente)
DELETE FROM `ventas`;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` (`id`, `fecha`, `fecha_compra`, `subtotal`, `descuento`, `total`, `tipo_comprobante_id`, `cliente_id`, `usuario_id`, `compras_id`, `num_documento`, `monto_recibido`, `cambio`, `estado`, `iva`, `igv`, `serie`) VALUES
	(1137, '2020-07-10', '2020-08-03', '36.00', '0.00', '36.00', 5, 95, 5, NULL, '000016', NULL, NULL, 0, '', '0.00', 1),
	(1138, '2020-07-10', NULL, '60000.00', '', '60000.00', 5, 100, 5, NULL, '00000017', NULL, NULL, 1, '0.00', '', NULL),
	(1139, '2020-07-10', NULL, '30000.00', '0.00', '30000.00', 5, 95, 5, NULL, '000018', NULL, NULL, 1, '', '0.00', 1),
	(1140, '2020-07-10', NULL, '30000.00', '0.00', '30000.00', 4, 95, 5, NULL, '000043', NULL, NULL, 1, '', '0.00', 2),
	(1141, '2020-07-10', NULL, '75000.00', '0.00', '75000.00', 4, 95, 5, NULL, '000044', NULL, NULL, 0, '', '0.00', 2),
	(1142, '2020-07-10', NULL, '75000.00', '0.00', '75000.00', 5, 95, 5, NULL, '000019', NULL, NULL, 0, '', '0.00', 1),
	(1143, '2020-07-10', NULL, '75000.00', '0.00', '75000.00', 5, 95, 5, NULL, '000020', NULL, NULL, 1, '', '0.00', 1),
	(1144, '2020-07-10', NULL, '40000.00', '0.00', '47200.00', NULL, 95, 5, NULL, NULL, NULL, NULL, 1, '', '7200.00', NULL),
	(1145, '2020-07-10', NULL, '40000.00', '0.00', '47200.00', 3, 95, 5, NULL, '00000003', NULL, NULL, 1, '7200.00', '', NULL),
	(1146, '2020-07-10', NULL, '75000.00', '', '75000.00', 5, 95, 5, NULL, '00000021', NULL, NULL, 1, '0.00', '', NULL),
	(1147, '2020-07-10', NULL, '75000.00', '', '75000.00', 5, 100, 5, NULL, '00000022', NULL, NULL, 1, '0.00', '', NULL),
	(1148, '2020-07-10', NULL, '50000.00', '', '59000.00', 3, 100, 5, NULL, '00000004', NULL, NULL, 1, '9000.00', '', NULL),
	(1149, '2020-07-20', NULL, '50000.00', '0.00', '50000.00', 5, 95, 5, NULL, '00000023', NULL, NULL, 0, '0.00', '', NULL),
	(1150, '2020-07-20', NULL, '99.00', '0.00', '99.00', 5, 95, 5, NULL, '00000024', NULL, NULL, 1, '0.00', '', NULL),
	(1151, '2020-08-03', '2020-07-27', '2.50', '0.00', '2.50', 4, 95, 8, NULL, '00000045', NULL, NULL, 1, '0.00', '', NULL),
	(1152, '2020-08-03', '2020-07-31', '5000.00', '0.00', '5900.00', 3, 101, 8, NULL, '00000005', NULL, NULL, 1, '900.00', '', NULL),
	(1153, '2020-08-03', '2020-07-27', '9.00', '0.00', '9.00', 4, 101, 8, NULL, '00000046', NULL, NULL, 1, '0.00', '', NULL);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
