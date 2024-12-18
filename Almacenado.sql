create database procedimientoAl;
use procedimientoAl;
CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  
    Nombre VARCHAR(100),                     
    Estatura DECIMAL(5,2),                 
    FechaNacimiento DATE,                    
    Sueldo DECIMAL(10,2)                      
);
INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
VALUES 
('Ana Martínez', 1.65, '1995-03-12', 1500.50),
('Carlos Gómez', 1.78, '1988-07-22', 2500.75),
('María López', 1.60, '2000-11-05', 1800.00),
('Pedro Ramírez', 1.82, '1993-01-15', 3000.20),
('Lucía Torres', 1.70, '1998-09-18', 2200.40),
('Jorge Herrera', 1.75, '1985-04-30', 2800.60),
('Laura Sánchez', 1.68, '1992-06-10', 2000.80);

DELIMITER $$

CREATE PROCEDURE SeleccionarClientes()
BEGIN
    SELECT * FROM cliente;
END $$

DELIMITER ;

CALL SeleccionarClientes();

DELIMITER $$

CREATE PROCEDURE InsertarCliente(
    IN p_Nombre VARCHAR(100),
    IN p_Estatura DECIMAL(5,2),
    IN p_FechaNacimiento DATE,
    IN p_Sueldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (p_Nombre, p_Estatura, p_FechaNacimiento, p_Sueldo);
END $$

DELIMITER ;

CALL InsertarCliente('Sofía Pérez', 1.72, '1994-05-20', 2400.50);

DELIMITER $$

CREATE PROCEDURE ActualizarFechaNacimiento(
    IN p_ClienteID INT,
    IN p_NuevaFechaNacimiento DATE
)
BEGIN
    UPDATE cliente
    SET FechaNacimiento = p_NuevaFechaNacimiento
    WHERE ClienteID = p_ClienteID;
END $$

DELIMITER ;

CALL ActualizarFechaNacimiento(3, '1990-05-15');

DELIMITER $$

CREATE PROCEDURE EliminarCliente(
    IN p_ClienteID INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = p_ClienteID;
END $$

DELIMITER ;

CALL EliminarCliente(1);

DELIMITER $$

CREATE PROCEDURE VerificarEdadCliente(
    IN p_ClienteID INT
)
BEGIN
    DECLARE v_Edad INT;

    -- Calcula la edad del cliente
    SELECT TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE())
    INTO v_Edad
    FROM cliente
    WHERE ClienteID = p_ClienteID;

    -- Verifica si la edad es mayor o igual a 22
    IF v_Edad >= 22 THEN
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', v_Edad, ' años y es mayor o igual a 22.') AS Resultado;
    ELSE
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', v_Edad, ' años y es menor a 22.') AS Resultado;
    END IF;
END $$

DELIMITER ;

CALL VerificarEdadCliente(3);

CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,   -- ID único de la orden
    ClienteID INT,                           -- ID del cliente (clave foránea)
    FechaOrden DATE,                         -- Fecha de la orden
    Total DECIMAL(10,2),                     -- Monto total de la orden
    Descripción VARCHAR(255)                 -- Descripción de la orden
);
-- insertar orden
DELIMITER $$

CREATE PROCEDURE InsertarOrden(
    IN p_ClienteID INT,
    IN p_FechaOrden DATE,
    IN p_Total DECIMAL(10,2),
    IN p_Descripcion VARCHAR(255)
)
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, Total, Descripción)
    VALUES (p_ClienteID, p_FechaOrden, p_Total, p_Descripcion);
END $$

DELIMITER ;

-- actualizar orden
DELIMITER $$

CREATE PROCEDURE ActualizarOrden(
    IN p_OrdenID INT,
    IN p_NuevaFechaOrden DATE,
    IN p_NuevoTotal DECIMAL(10,2),
    IN p_NuevaDescripcion VARCHAR(255)
)
BEGIN
    UPDATE ordenes
    SET FechaOrden = p_NuevaFechaOrden,
        Total = p_NuevoTotal,
        Descripción = p_NuevaDescripcion
    WHERE OrdenID = p_OrdenID;
END $$

DELIMITER ;

-- eliminar orden
DELIMITER $$

CREATE PROCEDURE EliminarOrden(
    IN p_OrdenID INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = p_OrdenID;
END $$

DELIMITER ;

-- llamar a los procedimientos
CALL InsertarOrden(1, '2024-12-17', 500.00, 'Pedido de productos electrónicos');
CALL ActualizarOrden(1, '2024-12-18', 550.00, 'Pedido modificado de productos electrónicos');
CALL EliminarOrden(1);




