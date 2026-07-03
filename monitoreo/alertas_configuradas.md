# Monitoreo y Salud del Sistema

La supervisión del entorno se basa en:
* **Health Checks (ALB):** Verificaciones automáticas cada 30 segundos; si una instancia no responde HTTP 200, es marcada como no saludable y reemplazada.
* **Métricas de CloudWatch:** El grupo de Auto Scaling monitorea la `CPUUtilization`. Al superar el 50%, se disparan alarmas que ejecutan la creación de nuevas instancias para mantener el rendimiento.