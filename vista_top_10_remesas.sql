-- Una vista que muestre la información de los 10 clientes 
-- que recibieron más remesas el último mes 

--se crea la vista
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
    -- define la vista 
VIEW `b89e`.`topbeneficiariosremesas` AS
    SELECT 
        `b`.`id_beneficiario` AS `id_beneficiario`,
        `b`.`nombres` AS `NombreBeneficiario`,
        `b`.`email` AS `EmailBeneficiario`,
        `b`.`telefono` AS `TelefonoBeneficiario`,
        COUNT(`r`.`id_remesa`) AS `CantidadRemesasRecibidas` --contador de remesa
    FROM
    --tablas 
        (`b89e`.`beneficiarios` `b`
        JOIN `b89e`.`remesas` `r` ON (`b`.`id_beneficiario` = `r`.`id_beneficiario`))
    WHERE
        `r`.`fecha_creacion` >= CURDATE() - INTERVAL 1 MONTH   -- remesas realizadas el ultimo mes
    GROUP BY `b`.`id_beneficiario` , `b`.`nombres` , `b`.`email` , `b`.`telefono`
    ORDER BY COUNT(`r`.`id_remesa`) DESC
    LIMIT 10 -- solo 10 resultados