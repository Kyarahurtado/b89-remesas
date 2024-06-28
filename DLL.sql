-- DLL de creacion de tablas 

-- Crear tabla de Merchants
CREATE TABLE Merchants (
    id_merchant INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

-- Crear tabla de Remitentes
CREATE TABLE Remitentes (
    id_remitente INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento VARCHAR(20) NOT NULL,
    numero_documento VARCHAR(50) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

-- Crear tabla de Beneficiarios
CREATE TABLE Beneficiarios (
    id_beneficiario INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento VARCHAR(20) NOT NULL,
    numero_documento VARCHAR(50) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

-- Crear tabla de CuentasBancarias
CREATE TABLE CuentasBancarias (
    id_cuenta_bancaria INT PRIMARY KEY AUTO_INCREMENT,
    id_beneficiario INT NOT NULL,
    banco VARCHAR(100) NOT NULL,
    numero_cuenta VARCHAR(50) NOT NULL,
    tipo_cuenta VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_beneficiario) REFERENCES Beneficiarios(id_beneficiario)
);

-- Crear tabla de EstadosRemesas
CREATE TABLE EstadosRemesas (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    estado VARCHAR(50) NOT NULL
);

-- Crear tabla de Remesas
CREATE TABLE Remesas (
    id_remesa INT PRIMARY KEY AUTO_INCREMENT,
    id_merchant INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    moneda VARCHAR(3) NOT NULL,
    id_remitente INT NOT NULL,
    id_beneficiario INT NOT NULL,
    id_cuenta_bancaria INT NOT NULL,
    id_estado_actual INT NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    fecha_actualizacion DATETIME NOT NULL,
    FOREIGN KEY (id_merchant) REFERENCES Merchants(id_merchant),
    FOREIGN KEY (id_remitente) REFERENCES Remitentes(id_remitente),
    FOREIGN KEY (id_beneficiario) REFERENCES Beneficiarios(id_beneficiario),
    FOREIGN KEY (id_cuenta_bancaria) REFERENCES CuentasBancarias(id_cuenta_bancaria),
    FOREIGN KEY (id_estado_actual) REFERENCES EstadosRemesas(id_estado)
);

-- Crear tabla de HistorialEstadosRemesas
CREATE TABLE HistorialEstadosRemesas (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_remesa INT NOT NULL,
    id_estado INT NOT NULL,
    fecha_cambio DATETIME NOT NULL,
    observaciones VARCHAR(255),
    FOREIGN KEY (id_remesa) REFERENCES Remesas(id_remesa),
    FOREIGN KEY (id_estado) REFERENCES EstadosRemesas(id_estado)
);

-- Insertar posibles estados en la tabla EstadosRemesas
INSERT INTO EstadosRemesas (estado) VALUES ('Enviado'), ('Validando'), ('Entregado'), ('Rechazado');
