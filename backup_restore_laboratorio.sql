-- 1. CREAR BASE DE DATOS Y TABLA
CREATE DATABASE PruebaBackups;
GO

USE PruebaBackups;
GO

CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Correo NVARCHAR(100)
);
GO

INSERT INTO Clientes VALUES 
(1, 'Juan Pérez', 'juan@gmail.com'),
(2, 'Ana Gómez', 'ana@hotmail.com');
GO

-- 2. HACER BACKUP COMPLETO
-- Asegurate de que la carpeta C:\Backups exista, o cambiá la ruta por una válida
BACKUP DATABASE PruebaBackups
TO DISK = 'C:\Backups\PruebaBackups_Completo.bak'
WITH FORMAT, INIT, NAME = 'Backup completo de PruebaBackups';
GO

-- 3. INSERTAR MÁS DATOS
INSERT INTO Clientes VALUES (3, 'Carlos Ruiz', 'carlos@yahoo.com');
GO

-- 4. HACER BACKUP DIFERENCIAL
BACKUP DATABASE PruebaBackups
TO DISK = 'C:\Backups\PruebaBackups_Diferencial.bak'
WITH DIFFERENTIAL, INIT, NAME = 'Backup diferencial de PruebaBackups';
GO

-- 5. SIMULAR PÉRDIDA: ELIMINAR LA BASE
USE master;
GO

DROP DATABASE PruebaBackups;
GO

-- 6. RESTAURAR BACKUP COMPLETO CON NORECOVERY
RESTORE DATABASE PruebaBackups
FROM DISK = 'C:\Backups\PruebaBackups_Completo.bak'
WITH NORECOVERY, 
     REPLACE;
GO

-- 7. RESTAURAR BACKUP DIFERENCIAL CON RECOVERY
RESTORE DATABASE PruebaBackups
FROM DISK = 'C:\Backups\PruebaBackups_Diferencial.bak'
WITH RECOVERY;
GO

-- 8. VERIFICAR DATOS RESTAURADOS
USE PruebaBackups;
GO

SELECT * FROM Clientes;
GO

