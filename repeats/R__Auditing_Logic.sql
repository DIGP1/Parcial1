
CREATE OR REPLACE FUNCTION fn_verificar_nivel4()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_bioseg  INT;
    v_rango         VARCHAR(100);
BEGIN
    -- Obtener nivel de bioseguridad del laboratorio que se intenta reservar
    SELECT nivel_bioseguridad
    INTO v_nivel_bioseg
    FROM laboratorio
    WHERE id_laboratorio = NEW.id_laboratorio;

    -- Si es nivel 4, verificar el rango del investigador
    IF v_nivel_bioseg = 4 THEN
        
        -- Join corregido usando rango_investigador y id_rango
        SELECT ri.nombre_rango
        INTO v_rango
        FROM investigador i
        JOIN rango_investigador ri ON i.id_rango = ri.id_rango
        WHERE i.id_investigador = NEW.id_investigador;

        -- Usamos LIKE para que acepte 'Director' o 'Director de Proyecto'
        IF v_rango NOT LIKE '%Director%' THEN
            RAISE EXCEPTION
                'Acceso denegado: el laboratorio id=% es de Nivel 4. Solo un Director puede reservarlo. Rango actual: %',
                NEW.id_laboratorio, v_rango;
        END IF;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_verificar_nivel4
    BEFORE INSERT
    ON reserva
    FOR EACH ROW
    EXECUTE FUNCTION fn_verificar_nivel4();



CREATE OR REPLACE FUNCTION fn_registrar_auditoria()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserción corregida para coincidir con la estructura de log_auditoria
    INSERT INTO log_auditoria (
        usuario_db,
        fecha_hora,
        tipo_operacion,
        tabla_afectada,
        detalle_cambio
    )
    VALUES (
        CURRENT_USER,   
        NOW(),          
        TG_OP,          
        TG_TABLE_NAME, -- Función nativa que detecta el nombre de la tabla ('reserva')
        FORMAT(
            'Reserva creada: id_reserva=%s | investigador_id=%s | laboratorio_id=%s | fecha=%s | horario: %s a %s',
            NEW.id_reserva,
            NEW.id_investigador,
            NEW.id_laboratorio,
            NEW.fecha_reserva, -- Columnas corregidas
            NEW.hora_inicio,
            NEW.hora_fin
        )
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_registrar_auditoria
    AFTER INSERT
    ON reserva
    FOR EACH ROW
    EXECUTE FUNCTION fn_registrar_auditoria();