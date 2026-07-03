# Instalación y Configuración del Entorno (Comercial Nova)

## 1. Configuración de Arquitectura de Red (Amazon VPC)
Para cumplir con los requisitos de segmentación y alta disponibilidad, se aprovisionó una red personalizada con las siguientes características:
*   **VPC Creada:** `ComercialNova-vpc`
*   **Alta Disponibilidad (Multi-AZ):** Se utilizaron dos Zonas de Disponibilidad (`us-east-1a` y `us-east-1b`).
*   **Subredes Públicas (La DMZ):** 2 subredes enrutadas a un Internet Gateway (`ComercialNova-igw`), destinadas a operar estrictamente como zona desmilitarizada para exponer únicamente el Application Load Balancer.
*   **Subredes Privadas (LAN aislada):** 2 subredes sin acceso directo a internet, enrutadas localmente, para proteger la capa de aplicación (EC2) y la capa de datos (RDS).

*Evidencia visual: Revisar los archivos `vpc_subredes.png` y `rds_subnet_group.png` en la carpeta de capturas.*

---

## 2. Configuración de Base de Datos (Amazon RDS)
Se implementó una base de datos relacional administrada para soportar el CMS WordPress. Para optimizar costos y asegurar el entorno, se aplicaron las siguientes configuraciones detalladas:
*   **Motor y Capa:** MySQL (Community Edition). Se aprovisionó evitando la plantilla de Producción para priorizar la optimización del presupuesto.
*   **Cómputo y Almacenamiento:** Se seleccionó una instancia de cómputo con ráfagas (`db.t3.micro` o equivalente) con 20 GB de almacenamiento de propósito general (gp2/gp3). Como medida concreta de control de costos, se deshabilitó el escalado automático de almacenamiento.
*   **Gestión de Red:** Desplegada dentro del grupo de subredes `comercialnova-db-subnet`, asegurando su ubicación en las subredes privadas.
*   **Seguridad y Acceso:** 
    *   La opción de "Acceso Público" se configuró estrictamente en **Falso (No)**. 
    *   Se asignó un nuevo Security Group (`RDS-SecurityGroup`) para aislarla de internet.
    *   Se optó por credenciales autoadministradas para evitar los sobrecostos asociados a AWS Secrets Manager.
*   **Política de Respaldo:** Se habilitaron los Automated Backups (Respaldos automáticos) con un periodo de retención establecido para garantizar la recuperación ante desastres sobre la base de datos inicial `wordpress`.

*Evidencia visual: Revisar el archivo `rds_creando.png` en la carpeta de capturas.*

---

## 3. Capa de Cómputo y Servidor Web (Amazon EC2)
Se desplegó la capa de aplicación utilizando recursos de la capa gratuita (Free Tier) para mantener la optimización de costos. Las configuraciones aplicadas son:
*   **Instancia:** Se aprovisionó 1 instancia inicial (`WordPress-Web-1`) tipo `t2.micro` con sistema operativo Ubuntu Linux.
*   **Ubicación:** Desplegada en la subred pública `us-east-1a` de la VPC `ComercialNova-vpc` para permitir la descarga inicial de paquetes, con proyección a ser integrada detrás de un balanceador de carga.
*   **Endurecimiento de Seguridad (Security Group):** Se creó el grupo de seguridad `EC2-Web-SG` aplicando el principio de mínimo privilegio. Se limitó el acceso por el puerto 22 (SSH) exclusivamente a la IP del administrador, previniendo ataques automatizados. Se abrieron los puertos 80 y 443 a todo internet (0.0.0.0/0) para el tráfico web.
*   **Automatización (User Data):** Se inyectó un script de inicialización durante el arranque para instalar automáticamente el stack web (Nginx, PHP-FPM, PHP-MySQL), descargar los binarios más recientes de WordPress y configurar los permisos de carpetas sin intervención manual.

*Evidencia visual: Revisar el archivo `ec2_ejecucion.png` en la carpeta de capturas.*


## 4. Integración y Despliegue de Aplicación (WordPress)
Se realizó la configuración y vinculación exitosa entre la capa de aplicación (EC2) y la capa de datos (RDS) en subredes separadas:
*   **Conexión EC2 - RDS:** Se configuró el asistente web de WordPress para apuntar al *Endpoint* privado de la base de datos `wordpress-db`.
*   **Validación de Seguridad Interna:** Se verificó que la comunicación EC2-RDS es exitosa únicamente gracias a las reglas estrictas del `RDS-SecurityGroup`, el cual limita el tráfico entrante (puerto 3306) exclusivamente desde el grupo de seguridad de la capa web (`EC2-Web-SG`).
*   **Instalación del CMS:** Se finalizó la instalación de WordPress desplegando el panel de control principal, evidenciando un entorno web conectado a su base de datos y 100% funcional.

*Evidencia visual: Revisar los archivos `wp_conexion_exitosa.png` y `wp_panel_admin.png` en la carpeta de capturas.*


## 5. Capa de Almacenamiento Persistente (Amazon S3)
Para garantizar la escalabilidad de la plataforma y evitar la saturación de los discos locales de la capa de cómputo, se desacopló el almacenamiento multimedia:
* **Bucket Creado:** `comercialnova-media-[tu-apellido]` (reemplaza por el nombre real de tu bucket).
* **Región:** `us-east-1` (Norte de Virginia), garantizando baja latencia con la capa web y de datos.
* **Políticas de Acceso:** Se deshabilitó el bloqueo de acceso público general, permitiendo la lectura de objetos multimedia para que las imágenes se rendericen correctamente en el navegador de los usuarios finales de WordPress.

*Evidencia visual: Revisar el archivo `s3_bucket_creado.png` en la carpeta de capturas.*


### 5.1 Integración de S3 con WordPress y Roles IAM
Para completar el almacenamiento en la nube, se vinculó el servidor web con el bucket S3 previamente creado:

* **Autenticación Segura (Roles de IAM):** Aplicando las buenas prácticas de AWS, se evitó el uso de credenciales estáticas (Access Keys). Se asignó el rol `LabInstanceProfile` directamente a la instancia EC2 para proveer una conexión nativa y segura hacia S3.
* **Configuración de Políticas:** Se aplicó una política de bucket en JSON (`s3:GetObject`) para permitir la lectura pública y global de los recursos multimedia.
* **Interceptación Multimedia:** Se instaló el plugin *WP Offload Media Lite* y se configuraron las dependencias del servidor web (`php-gd`, `php-xml`). Con esto, los archivos subidos al CMS migran automáticamente a la nube, reescribiendo las URLs locales hacia el dominio de Amazon S3.

*Evidencia visual: El archivo `wp_s3_imagen_subida.png` en la carpeta de capturas certifica que las URLs de las imágenes apuntan correctamente a la infraestructura de S3.*

