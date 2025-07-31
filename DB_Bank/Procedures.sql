Use banco;

Drop procedure if exists ActualizarUsuario;

DELIMITER //

CREATE PROCEDURE ActualizarUsuario (IN U_id_cliente INT, IN U_nombre_usuario VARCHAR(20),
    IN U_contrasenia VARCHAR(12), IN U_id_tipouser TINYINT, IN U_estado TINYINT(1) 
)
BEGIN
    UPDATE usuarios
    SET
        nombreusuario = U_nombre_usuario,
        contrasenia = U_contrasenia,
        id_tipouser = U_id_tipouser,
        estado = U_estado
    WHERE
        id_cliente = U_id_cliente;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS ActualizarCliente;

DELIMITER //
CREATE PROCEDURE ActualizarCliente (
    IN p_id_cliente INT,
    IN p_direccion VARCHAR(100),
    IN p_id_localidad SMALLINT,
    IN p_correo VARCHAR(50),
    IN p_telefono VARCHAR(15)
)
BEGIN
    UPDATE clientes
    SET
        direccion = p_direccion,
        id_localidad = p_id_localidad,
        correo = p_correo,
        telefono = p_telefono
    WHERE
        id_cliente = p_id_cliente;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarLogicoUsuario;
DELIMITER //
CREATE PROCEDURE EliminarLogicoUsuario(IN p_id_usuario INT)
BEGIN
    UPDATE usuarios SET estado = 0 WHERE id_usuario = p_id_usuario;
    
END //
DELIMITER ;


Drop procedure if exists RealizarTransferencia;

DELIMITER //


CREATE PROCEDURE RealizarTransferencia(
    IN p_numCuentaOrigen VARCHAR(13),
    IN p_numCuentaDestino VARCHAR(13),
    IN p_importe DECIMAL(15, 2),
    IN p_fecha DATETIME,        
    IN p_detalle VARCHAR(50)    
)
BEGIN

DECLARE saldo_origen DECIMAL(15, 2);

    START TRANSACTION;

    -- Verificamos el saldo actual
    SELECT saldo INTO saldo_origen
    FROM cuentas
    WHERE num_de_cuenta = p_numCuentaOrigen
    FOR UPDATE;

    -- Si no hay saldo suficiente, se cancela la transacción
    IF saldo_origen IS NULL OR saldo_origen < p_importe THEN
        ROLLBACK;
    ELSE

    UPDATE cuentas
    SET saldo = saldo - p_importe
    WHERE num_de_cuenta = p_numCuentaOrigen;

    UPDATE cuentas
    SET saldo = saldo + p_importe
    WHERE num_de_cuenta = p_numCuentaDestino;

    INSERT INTO transferencias (fecha, numCuentaDestino, numCuentaOrigen, importe)
    VALUES (p_fecha, p_numCuentaDestino, p_numCuentaOrigen, p_importe);

    INSERT INTO movimientos (fecha, detalle, importe, id_tipomovimiento, num_de_cuenta)
    VALUES (p_fecha, p_detalle, p_importe, 4, p_numCuentaOrigen);
    

    INSERT INTO movimientos (fecha, detalle, importe, id_tipomovimiento, num_de_cuenta)
    VALUES (p_fecha, p_detalle, p_importe, 3, p_numCuentaDestino);
    
    COMMIT;
    END IF;

END //

DELIMITER ;