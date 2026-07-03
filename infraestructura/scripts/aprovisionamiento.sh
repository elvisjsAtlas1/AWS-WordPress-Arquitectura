#!/bin/bash
# Script de aprovisionamiento para el servidor Web - Comercial Nova

# 1. Actualización del sistema
apt update && apt upgrade -y

# 2. Instalación de stack LAMP (Nginx + PHP 8.5)
apt install nginx php8.5-fpm php8.5-mysql php8.5-xml php8.5-mbstring -y

# 3. Instalación de librerías para manejo de imágenes (solución cartel azul)
apt install php8.5-gd php8.5-imagick imagemagick -y

# 4. Configuración de servicios
systemctl restart php8.5-fpm nginx

# 5. Nota: El plugin WP Offload Media se configuró mediante 
# la consola de WordPress usando el Rol de IAM 'LabInstanceProfile'.