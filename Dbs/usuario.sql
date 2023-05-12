PRAGMA FOREIGN_KEYS = ON;

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT
);

DROP TABLE IF EXISTS reserva;
CREATE TABLE reserva (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	descripcion TEXT,
	id_usuario INTEGER,
	FOREIGN KEY(id_usuario) REFERENCES usuario(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX nombres ON usuario(nombre);
CREATE VIEW todos_datos AS SELECT usuario.id, descripcion , nombre FROM usuario , reserva WHERE reserva.id_usuario = usuario.id;

/*Creación de trigger para rellenar una tabla história*/

DROP TABLE IF EXISTS historial;
CREATE TABLE historial(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre_borrado TEXT,
	fecha TEXT
);

DROP TRIGGER IF EXISTS borrado_usuario; 
CREATE TRIGGER borrado_usuario BEFORE DELETE 
ON usuario
BEGIN
	INSERT INTO historial (nombre_borrado, fecha) VALUES 
		(old.nombre, DATETIME());
END;


