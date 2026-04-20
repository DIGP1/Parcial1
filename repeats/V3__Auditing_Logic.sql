
CREATE OR REPLACE FUNCTION fn_verificar_nivel4()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_bioseg  INT;        -- nivel del lab a reservar
    v_rango         VARCHAR(50);
BEGIN

    SELECT nivel_bioseguridad
    INTO v_nivel_bioseg
    FROM laboratorio
    WHERE id_laboratorio = NEW.id_laboratorio;

    IF v_nivel_bioseg = 4 THEN

        SELECT ti.nombre
        INTO v_rango
        FROM investigador i
        JOIN tipo_investigador ti ON i.id_tipo = ti.id_tipo
        WHERE i.id_investigador = NEW.id_investigador;

        IF v_rango <> 'Director' THEN
            RAISE EXCEPTION
                'Acceso denegado: el laboratorio id=% es nivel 4. Solo un Director puede reservarlo. Rango actual: %',
                NEW.id_laboratorio, v_rango;
        END IF;

    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_registrar_auditoria()
RETURNS TRIGGER AS $$
BEGIN

    INSERT INTO log_auditoria (
        id_reserva,
        usuario_bd,
        fecha_hora,
        tipo_operacion,
        detalle
    )
    VALUES (
        NEW.id_reserva,
        CURRENT_USER,   
        NOW(),          
        TG_OP,         
        FORMAT(
            'Reserva creada: investigador_id=%s | laboratorio_id=%s | equipo_id=%s | %s → %s',
            NEW.id_investigador,
            NEW.id_laboratorio,
            NEW.id_equipo,
            NEW.fecha_inicio,
            NEW.fecha_fin
        )
    );

    RETURN NULL;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_verificar_nivel4
    BEFORE INSERT
    ON reserva
    FOR EACH ROW
    EXECUTE FUNCTION fn_verificar_nivel4();


CREATE TRIGGER trg_registrar_auditoria
    AFTER INSERT
    ON reserva
    FOR EACH ROW
    EXECUTE FUNCTION fn_registrar_auditoria();