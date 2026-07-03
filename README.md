# AWS-WordPress-Arquitectura: Implementación de Alta Disponibilidad

## 👥 Integrantes y Roles
* **[Tu Nombre Completo]:** Arquitecto Cloud, Desarrollador e Ingeniero de Infraestructura.

## 📝 Problema Planteado y Alcance
La empresa "Comercial Nova" requiere migrar su portal web a la nube para mejorar su disponibilidad, seguridad y capacidad de respuesta ante picos de tráfico. El alcance de este proyecto incluye el despliegue de una infraestructura resiliente, automatizada y optimizada en costos utilizando servicios de AWS.

## 🏗️ Arquitectura Propuesta
La solución utiliza una arquitectura de tres capas: capa de presentación (ALB + Auto Scaling), capa de aplicación (EC2) y capa de datos (RDS), con almacenamiento desacoplado en S3.
- **Diagrama de Arquitectura:** [Ver diagrama en /arquitectura/diagrama.png]

## ☁️ Servicios Cloud Utilizados
* **EC2 & Auto Scaling:** Cómputo escalable para alta disponibilidad.
* **RDS (MySQL):** Base de datos gestionada con alta resiliencia.
* **S3:** Almacenamiento multimedia para desacoplamiento.
* **ALB:** Balanceo de carga para distribución eficiente.
* **IAM:** Seguridad basada en roles (evita credenciales estáticas).
* **CloudWatch:** Monitoreo y métricas de salud.

## 🌐 Acceso al Sistema
* **URL de acceso (DNS del ALB):** `[ComercialNova-ALB-2122882934.us-east-1.elb.amazonaws.com]`
* **Evidencias de acceso:** Ver capturas en `/aws/evidencias/capturas_servicios/`.

## 🛠️ Pasos para Desplegar (Resumen)
1. Despliegue de VPC con subredes públicas/privadas.
2. Configuración de RDS (Multi-AZ) y Bucket S3.
3. Configuración de instancia base EC2 e instalación de stack LAMP.
4. Creación de AMI (`ComercialNova-WP-GoldenImage`).
5. Configuración de Launch Template y Auto Scaling Group con ALB.
6. Ajuste de permisos mediante Roles IAM.

## 🛡️ Estrategias Implementadas
* **Seguridad:** Implementación de IAM Roles y grupos de seguridad restrictivos.
* **Monitoreo:** Alarmas de CloudWatch configuradas al 50% de uso de CPU.
* **Costos:** Uso de instancias `t3.micro` (Free Tier) y escalado dinámico bajo demanda.

## ⚠️ Limitaciones y Mejoras Futuras
* **Limitación:** Acceso actual mediante nombre DNS dinámico de AWS.
* **Mejora:** Implementación de Route 53 con dominio propio (`www.comercialnova.com`) y CloudFront para CDN.

## 🎓 Lecciones Aprendidas
* La importancia de desacoplar recursos multimedia (S3) para una arquitectura *stateless*.
* El rol de IAM es crítico para la seguridad en entornos AWS.
* La configuración de Health Checks en el ALB es fundamental para la alta disponibilidad real.

---
*Desarrollado para el laboratorio de arquitectura en la nube - 2026.*