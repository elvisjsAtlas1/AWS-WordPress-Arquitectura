# Instalación y Configuración del Entorno (Comercial Nova)

## 1. Configuración de Arquitectura de Red (Amazon VPC)
Para cumplir con los requisitos de segmentación y alta disponibilidad, se aprovisionó una red personalizada con las siguientes características:
*   **VPC Creada:** `ComercialNova-vpc`
*   **Alta Disponibilidad (Multi-AZ):** Se utilizaron dos Zonas de Disponibilidad (`us-east-1a` y `us-east-1b`).
*   **Subredes Públicas (DMZ):** 2 subredes enrutadas a un Internet Gateway (`ComercialNova-igw`), destinadas a alojar el Application Load Balancer.
*   **Subredes Privadas (LAN aislada):** 2 subredes sin acceso directo a internet, enrutadas localmente, para alojar la capa de aplicación (EC2) y la capa de datos (RDS).

*Evidencia visual: Revisar el archivo `vpc_subredes.png` en la carpeta de capturas.*

---

## 2. Configuración de Base de Datos (Amazon RDS)
Se implementó una base de datos relacional administrada para soportar el CMS WordPress, aplicando controles de acceso estrictos:
*   **Motor de BD:** MySQL.
*   **Identificador:** `wordpress-db` (Base de datos inicial creada: `wordpress`).
*   **Ubicación de Red:** Desplegada dentro del grupo de subredes privadas (`comercialnova-db-subnet`).
*   **Seguridad y Acceso:** La opción de "Acceso Público" se configuró en **Falso (No)**. Se asignó el Security Group `RDS-SecurityGroup` para aislarla de internet y permitir tráfico únicamente desde la capa de aplicación.
*   **Política de Respaldo:** Se habilitaron los Automated Backups (Respaldos automáticos) con un periodo de retención configurado para garantizar la recuperación ante desastres.

*Evidencia visual: Revisar el archivo `rds_configuracion.png` en la carpeta de capturas.*