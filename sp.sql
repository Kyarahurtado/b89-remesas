-- Un SP que reciba la información de la remesa y la guarde en 
-- las tablas que diseñaste (en el lenguaje SQL que más conozcas) 


-- Stored Procerured para recibir informacion de las remesas 
CREATE DEFINER=root@localhost PROCEDURE RegistrarRemesa(
    -- Definiciones de los parametros de entrda
    IN p_id_merchant INT,
    IN p_monto DECIMAL(10, 2),
    IN p_moneda VARCHAR(3),
    IN p_id_remitente INT,
    IN p_id_beneficiario INT,
    IN p_id_cuenta_bancaria INT,
    IN p_id_estado_actual INT,
    IN p_fecha_creacion DATETIME,
    IN p_fecha_actualizacion DATETIME
)
BEGIN
-- inserta los datos recibidos como parametros en "remesas" (tabla)
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
END
