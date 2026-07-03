# Optimización de Costos

Para mantener la eficiencia presupuestaria del proyecto, se aplicaron las siguientes estrategias:
* **Instancias t3.micro:** Uso de tipos de instancia de propósito general (Capa Gratuita) adecuadas para cargas de tráfico moderado.
* **Almacenamiento S3 vs. EBS:** Se movieron los recursos multimedia a S3, reduciendo el costo de almacenamiento comparado con volúmenes EBS y eliminando la necesidad de redimensionar discos locales.
* **Escalado bajo demanda:** Gracias al Auto Scaling, los recursos solo se aprovisionan cuando el uso de CPU supera el 50%, evitando el pago por cómputo ocioso.