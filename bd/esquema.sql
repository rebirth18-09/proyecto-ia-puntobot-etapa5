-- Esquema propuesto para la base local de PuntoBot, Etapa 5.
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS consultas (
    id_consulta INTEGER PRIMARY KEY AUTOINCREMENT,
    texto TEXT NOT NULL CHECK(length(trim(texto)) BETWEEN 1 AND 200),
    rol TEXT NOT NULL CHECK(rol IN ('vendedor','inventario')),
    intencion TEXT CHECK(intencion IN ('consulta_stock','consulta_precio','consulta_ultima_venta','otra')),
    confianza REAL CHECK(confianza BETWEEN 0.0 AND 1.0),
    producto TEXT,
    respuesta TEXT NOT NULL,
    datos_respuesta_json TEXT,
    modelo_version TEXT,
    estado TEXT NOT NULL CHECK(estado IN ('respondida','reformular','producto_pendiente','error_modelo','error_inventario')),
    fecha_utc TEXT NOT NULL DEFAULT(strftime('%Y-%m-%dT%H:%M:%fZ','now'))
);

CREATE TABLE IF NOT EXISTS correcciones (
    id_correccion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_consulta INTEGER NOT NULL UNIQUE REFERENCES consultas(id_consulta),
    motivo TEXT NOT NULL CHECK(motivo IN ('intencion_equivocada','producto_equivocado','otro')),
    detalle TEXT,
    fecha_utc TEXT NOT NULL DEFAULT(strftime('%Y-%m-%dT%H:%M:%fZ','now'))
);

CREATE INDEX IF NOT EXISTS idx_consultas_fecha ON consultas(fecha_utc);
