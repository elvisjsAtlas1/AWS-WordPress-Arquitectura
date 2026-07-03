# AWS-WordPress-Arquitectura: Implementación de Alta Disponibilidad

Este repositorio documenta la implementación de un entorno WordPress robusto, escalable y altamente disponible desplegado sobre la infraestructura de Amazon Web Services (AWS).

## 🚀 Descripción del Proyecto
El objetivo principal ha sido transformar una aplicación WordPress tradicional en una arquitectura de nivel profesional, implementando principios de desacoplamiento, resiliencia y escalabilidad automática.

## 🏗️ Características Técnicas
* **Infraestructura como Servicio (IaaS):** Despliegue de instancias EC2 mediante imágenes personalizadas (AMI).
* **Almacenamiento Desacoplado:** Uso de Amazon S3 para la gestión de recursos multimedia, eliminando la carga sobre el almacenamiento local.
* **Persistencia de Datos:** Base de datos gestionada mediante Amazon RDS (MySQL), garantizando alta disponibilidad.
* **Alta Disponibilidad:** Implementación de un Application Load Balancer (ALB) y un grupo de Auto Scaling que ajusta la infraestructura según la carga de CPU (umbral del 50%).
* **Seguridad:** Uso de Roles de IAM para la comunicación segura entre servicios, evitando el uso de credenciales estáticas.

## 📂 Estructura del Repositorio
- `arquitectura/`: Diagramas y justificación del diseño técnico.
- `aws/`: Inventario de recursos y evidencias fotográficas de la infraestructura.
- `costos/`: Estrategias de optimización de presupuesto.
- `monitoreo/`: Configuración de salud y alertas.
- `seguridad/`: Matriz de accesos y políticas de seguridad.
- `wordpress/`: Documentación técnica de la instalación y configuración del CMS.

## 🛠️ Tecnologías Utilizadas
- **AWS:** EC2, S3, RDS, VPC, ALB, Auto Scaling, IAM.
- **WordPress:** CMS con plugin *WP Offload Media*.
- **Control de Versiones:** Git & GitHub.

---
*Desarrollado para el laboratorio de arquitectura en la nube.*