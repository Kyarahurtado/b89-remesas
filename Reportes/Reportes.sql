-- Generamos los reportes : 

-- 1. Montos enviados correctamente por Merchant mensualmente

SELECT 
    R.id_merchant,
    M.nombre AS merchant_nombre,
    YEAR(H.fecha_cambio) AS año,
    MONTH(H.fecha_cambio) AS mes,
    SUM(R.monto) AS total_monto
FROM 
    Remesas R
JOIN 
    Merchants M ON R.id_merchant = M.id_merchant
JOIN 
    HistorialEstadosRemesas H ON R.id_remesa = H.id_remesa
JOIN 
    EstadosRemesas E ON H.id_estado = E.id_estado
WHERE 
    E.estado = 'Entregado'
GROUP BY 
    R.id_merchant, 
    M.nombre,
    YEAR(H.fecha_cambio), 
    MONTH(H.fecha_cambio)
ORDER BY 
    R.id_merchant, 
    año, 
    mes;

-- 2. Monto enviados por remitente mensualmente

SELECT 
    R.id_remitente,
    YEAR(H.fecha_cambio) AS año,
    MONTH(H.fecha_cambio) AS mes,
    SUM(R.monto) AS total_monto
FROM 
    Remesas R
JOIN 
    HistorialEstadosRemesas H ON R.id_remesa = H.id_remesa
JOIN 
    EstadosRemesas E ON H.id_estado = E.id_estado
WHERE 
    E.estado = 'Entregado'
GROUP BY 
    R.id_remitente, 
    YEAR(H.fecha_cambio), 
    MONTH(H.fecha_cambio)
ORDER BY 
    R.id_remitente, 
    año, 
    mes;

-- 3. Montos recibidos por beneficiarios mensuales

SELECT 
    R.id_beneficiario,
    YEAR(H.fecha_cambio) AS año,
    MONTH(H.fecha_cambio) AS mes,
    SUM(R.monto) AS total_monto
FROM 
    Remesas R
JOIN 
    HistorialEstadosRemesas H ON R.id_remesa = H.id_remesa
JOIN 
    EstadosRemesas E ON H.id_estado = E.id_estado
WHERE 
    E.estado = 'Entregado'
GROUP BY 
    R.id_beneficiario, 
    YEAR(H.fecha_cambio), 
    MONTH(H.fecha_cambio)
ORDER BY 
    R.id_beneficiario, 
    año, 
    mes;
