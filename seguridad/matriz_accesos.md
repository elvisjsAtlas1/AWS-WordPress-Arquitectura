# Matriz de Accesos y Seguridad

| Sujeto/Recurso | Permiso | Propósito |
| :--- | :--- | :--- |
| Instancia EC2 | Rol IAM `LabInstanceProfile` | Acceso a S3/RDS sin llaves estáticas. |
| Administrador | SSH (Puerto 22, Mi IP) | Gestión de configuración del SO. |
| Internet (ALB) | HTTP (Puerto 80) | Acceso público a la web. |
| Bucket S3 | `s3:GetObject` (Público) | Renderizado de imágenes para usuarios. |