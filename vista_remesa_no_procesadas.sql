-- Una vista que muestre la cantidad de remesas por 
-- merchant que no pudieron ser procesadas en el último mes 


-- se crea la vista en la bd 
CREATE 
    ALGORITHM = UNDEFINED  --el motor de la bd de datos elije el algoritmo mas eficiente para ejecutar la vista
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `b89e`.`vistaremesasnoprocesadas` AS
-- se selecciona los campos a usar
    SELECT 
        `m`.`id_merchant` AS `id_merchant`,
        `m`.`nombre` AS `NombreMerchant`,
        COUNT(`r`.`id_remesa`) AS `CantidadRemesasNoProcesadas` --contador de las remesas
    FROM
    --tablas
        (`b89e`.`merchants` `m`
        JOIN `b89e`.`remesas` `r` ON (`m`.`id_merchant` = `r`.`id_merchant`))
    WHERE
    --condicion  el 4 significa como rechazado la remesa
        `r`.`id_estado_actual` = 4
            AND `r`.`fecha_creacion` >= CURDATE() - INTERVAL 1 MONTH -- remesas realizadas en el ultimo mes
    GROUP BY `m`.`id_merchant` , `m`.`nombre`