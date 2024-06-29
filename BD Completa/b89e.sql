-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-06-2024 a las 07:11:57
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `b89e`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarRemesa` (IN `p_id_merchant` INT, IN `p_monto` DECIMAL(10,2), IN `p_moneda` VARCHAR(3), IN `p_id_remitente` INT, IN `p_id_beneficiario` INT, IN `p_id_cuenta_bancaria` INT, IN `p_id_estado_actual` INT, IN `p_fecha_creacion` DATETIME, IN `p_fecha_actualizacion` DATETIME)   BEGIN
INSERT INTO Remesas (
        id_merchant,
        monto,
        moneda,
        id_remitente,
        id_beneficiario,
        id_cuenta_bancaria,
        id_estado_actual,
        fecha_creacion,
        fecha_actualizacion
    ) VALUES (
        p_id_merchant,
        p_monto,
        p_moneda,
        p_id_remitente,
        p_id_beneficiario,
        p_id_cuenta_bancaria,
        p_id_estado_actual,
        p_fecha_creacion,
        p_fecha_actualizacion
    );
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficiarios`
--

CREATE TABLE `beneficiarios` (
  `id_beneficiario` int(11) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `numero_documento` varchar(50) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `beneficiarios`
--

INSERT INTO `beneficiarios` (`id_beneficiario`, `tipo_documento`, `numero_documento`, `nombres`, `email`, `telefono`) VALUES
(1, 'DNI', '87654321', 'Ana López', 'ana.lopez@example.com', '123987654'),
(2, 'DNI', '98765432', 'Beatriz Díaz', 'beatriz.diaz@example.com', '123987655'),
(3, 'DNI', '09876543', 'Diego Torres', 'diego.torres@example.com', '123987656'),
(4, 'DNI', '10987654', 'Elena Romero', 'elena.romero@example.com', '123987657'),
(5, 'DNI', '21098765', 'Fernando Ortiz', 'fernando.ortiz@example.com', '123987658');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentasbancarias`
--

CREATE TABLE `cuentasbancarias` (
  `id_cuenta_bancaria` int(11) NOT NULL,
  `id_beneficiario` int(11) NOT NULL,
  `banco` varchar(100) NOT NULL,
  `numero_cuenta` varchar(50) NOT NULL,
  `tipo_cuenta` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `cuentasbancarias`
--

INSERT INTO `cuentasbancarias` (`id_cuenta_bancaria`, `id_beneficiario`, `banco`, `numero_cuenta`, `tipo_cuenta`) VALUES
(1, 1, 'Banco de Prueba', '0011-0022-0033-0044', 'Ahorros'),
(2, 2, 'Banco de Prueba', '0011-0022-0033-0045', 'Corriente'),
(3, 3, 'Banco de Prueba', '0011-0022-0033-0046', 'Ahorros'),
(4, 4, 'Banco de Prueba', '0011-0022-0033-0047', 'Corriente'),
(5, 5, 'Banco de Prueba', '0011-0022-0033-0048', 'Ahorros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadosremesas`
--

CREATE TABLE `estadosremesas` (
  `id_estado` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `estadosremesas`
--

INSERT INTO `estadosremesas` (`id_estado`, `estado`) VALUES
(1, 'Enviado'),
(2, 'Validando'),
(3, 'Entregado'),
(4, 'Rechazado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialestadosremesas`
--

CREATE TABLE `historialestadosremesas` (
  `id_historial` int(11) NOT NULL,
  `id_remesa` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_cambio` datetime NOT NULL,
  `observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `merchants`
--

CREATE TABLE `merchants` (
  `id_merchant` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `merchants`
--

INSERT INTO `merchants` (`id_merchant`, `nombre`, `email`, `telefono`) VALUES
(1, 'Comercio A', 'contacto@comercioa.com', '1234567890'),
(2, 'Comercio B', 'contacto@comerciob.com', '1234567891'),
(3, 'Comercio C', 'contacto@comercioc.com', '1234567892'),
(4, 'Comercio D', 'contacto@comerciod.com', '1234567893'),
(5, 'Comercio E', 'contacto@comercioe.com', '1234567894');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remesas`
--

CREATE TABLE `remesas` (
  `id_remesa` int(11) NOT NULL,
  `id_merchant` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL,
  `id_remitente` int(11) NOT NULL,
  `id_beneficiario` int(11) NOT NULL,
  `id_cuenta_bancaria` int(11) NOT NULL,
  `id_estado_actual` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `remesas`
--

INSERT INTO `remesas` (`id_remesa`, `id_merchant`, `monto`, `moneda`, `id_remitente`, `id_beneficiario`, `id_cuenta_bancaria`, `id_estado_actual`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 1, 500.00, 'USD', 1, 1, 1, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(2, 2, 750.00, 'USD', 2, 2, 2, 2, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(3, 3, 1000.00, 'USD', 3, 3, 3, 3, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(4, 4, 1250.00, 'USD', 4, 4, 4, 4, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(5, 5, 1500.00, 'USD', 5, 5, 5, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(6, 1, 1750.00, 'USD', 1, 2, 2, 2, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(7, 2, 2000.00, 'USD', 2, 3, 3, 3, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(8, 3, 2250.00, 'USD', 3, 4, 4, 4, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(9, 4, 2500.00, 'USD', 4, 5, 5, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(10, 5, 2750.00, 'USD', 5, 1, 1, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(11, 1, 3000.00, 'USD', 1, 3, 3, 3, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(12, 2, 3250.00, 'USD', 2, 4, 4, 4, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(13, 3, 3500.00, 'USD', 3, 5, 5, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(14, 4, 3750.00, 'USD', 4, 1, 1, 1, '2024-06-28 23:20:03', '2024-06-28 23:20:03'),
(15, 5, 4000.00, 'USD', 5, 2, 2, 2, '2024-06-28 23:20:03', '2024-06-28 23:20:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remitentes`
--

CREATE TABLE `remitentes` (
  `id_remitente` int(11) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `numero_documento` varchar(50) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `remitentes`
--

INSERT INTO `remitentes` (`id_remitente`, `tipo_documento`, `numero_documento`, `nombres`, `email`, `telefono`) VALUES
(1, 'DNI', '12345678', 'Juan Pérez', 'juan.perez@example.com', '987654321'),
(2, 'DNI', '23456789', 'Laura Martínez', 'laura.martinez@example.com', '987654322'),
(3, 'DNI', '34567890', 'Carlos Ruiz', 'carlos.ruiz@example.com', '987654323'),
(4, 'DNI', '45678901', 'Sofía Castro', 'sofia.castro@example.com', '987654324'),
(5, 'DNI', '56789012', 'Mario Gómez', 'mario.gomez@example.com', '987654325');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `topbeneficiariosremesas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `topbeneficiariosremesas` (
`id_beneficiario` int(11)
,`NombreBeneficiario` varchar(100)
,`EmailBeneficiario` varchar(100)
,`TelefonoBeneficiario` varchar(15)
,`CantidadRemesasRecibidas` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistaremesasnoprocesadas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistaremesasnoprocesadas` (
`id_merchant` int(11)
,`NombreMerchant` varchar(100)
,`CantidadRemesasNoProcesadas` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `topbeneficiariosremesas`
--
DROP TABLE IF EXISTS `topbeneficiariosremesas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `topbeneficiariosremesas`  AS SELECT `b`.`id_beneficiario` AS `id_beneficiario`, `b`.`nombres` AS `NombreBeneficiario`, `b`.`email` AS `EmailBeneficiario`, `b`.`telefono` AS `TelefonoBeneficiario`, count(`r`.`id_remesa`) AS `CantidadRemesasRecibidas` FROM (`beneficiarios` `b` join `remesas` `r` on(`b`.`id_beneficiario` = `r`.`id_beneficiario`)) WHERE `r`.`fecha_creacion` >= curdate() - interval 1 month GROUP BY `b`.`id_beneficiario`, `b`.`nombres`, `b`.`email`, `b`.`telefono` ORDER BY count(`r`.`id_remesa`) DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistaremesasnoprocesadas`
--
DROP TABLE IF EXISTS `vistaremesasnoprocesadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistaremesasnoprocesadas`  AS SELECT `m`.`id_merchant` AS `id_merchant`, `m`.`nombre` AS `NombreMerchant`, count(`r`.`id_remesa`) AS `CantidadRemesasNoProcesadas` FROM (`merchants` `m` join `remesas` `r` on(`m`.`id_merchant` = `r`.`id_merchant`)) WHERE `r`.`id_estado_actual` = 4 AND `r`.`fecha_creacion` >= curdate() - interval 1 month GROUP BY `m`.`id_merchant`, `m`.`nombre` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `beneficiarios`
--
ALTER TABLE `beneficiarios`
  ADD PRIMARY KEY (`id_beneficiario`);

--
-- Indices de la tabla `cuentasbancarias`
--
ALTER TABLE `cuentasbancarias`
  ADD PRIMARY KEY (`id_cuenta_bancaria`),
  ADD KEY `id_beneficiario` (`id_beneficiario`);

--
-- Indices de la tabla `estadosremesas`
--
ALTER TABLE `estadosremesas`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `historialestadosremesas`
--
ALTER TABLE `historialestadosremesas`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_remesa` (`id_remesa`),
  ADD KEY `id_estado` (`id_estado`);

--
-- Indices de la tabla `merchants`
--
ALTER TABLE `merchants`
  ADD PRIMARY KEY (`id_merchant`);

--
-- Indices de la tabla `remesas`
--
ALTER TABLE `remesas`
  ADD PRIMARY KEY (`id_remesa`),
  ADD KEY `id_merchant` (`id_merchant`),
  ADD KEY `id_remitente` (`id_remitente`),
  ADD KEY `id_beneficiario` (`id_beneficiario`),
  ADD KEY `id_cuenta_bancaria` (`id_cuenta_bancaria`),
  ADD KEY `id_estado_actual` (`id_estado_actual`);

--
-- Indices de la tabla `remitentes`
--
ALTER TABLE `remitentes`
  ADD PRIMARY KEY (`id_remitente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `beneficiarios`
--
ALTER TABLE `beneficiarios`
  MODIFY `id_beneficiario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cuentasbancarias`
--
ALTER TABLE `cuentasbancarias`
  MODIFY `id_cuenta_bancaria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estadosremesas`
--
ALTER TABLE `estadosremesas`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historialestadosremesas`
--
ALTER TABLE `historialestadosremesas`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id_merchant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `remesas`
--
ALTER TABLE `remesas`
  MODIFY `id_remesa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `remitentes`
--
ALTER TABLE `remitentes`
  MODIFY `id_remitente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuentasbancarias`
--
ALTER TABLE `cuentasbancarias`
  ADD CONSTRAINT `cuentasbancarias_ibfk_1` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiarios` (`id_beneficiario`);

--
-- Filtros para la tabla `historialestadosremesas`
--
ALTER TABLE `historialestadosremesas`
  ADD CONSTRAINT `historialestadosremesas_ibfk_1` FOREIGN KEY (`id_remesa`) REFERENCES `remesas` (`id_remesa`),
  ADD CONSTRAINT `historialestadosremesas_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estadosremesas` (`id_estado`);

--
-- Filtros para la tabla `remesas`
--
ALTER TABLE `remesas`
  ADD CONSTRAINT `remesas_ibfk_1` FOREIGN KEY (`id_merchant`) REFERENCES `merchants` (`id_merchant`),
  ADD CONSTRAINT `remesas_ibfk_2` FOREIGN KEY (`id_remitente`) REFERENCES `remitentes` (`id_remitente`),
  ADD CONSTRAINT `remesas_ibfk_3` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiarios` (`id_beneficiario`),
  ADD CONSTRAINT `remesas_ibfk_4` FOREIGN KEY (`id_cuenta_bancaria`) REFERENCES `cuentasbancarias` (`id_cuenta_bancaria`),
  ADD CONSTRAINT `remesas_ibfk_5` FOREIGN KEY (`id_estado_actual`) REFERENCES `estadosremesas` (`id_estado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
