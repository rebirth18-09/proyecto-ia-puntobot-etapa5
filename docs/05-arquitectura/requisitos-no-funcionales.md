# Requisitos no funcionales

Ningún requisito queda como adjetivo. Las cifras de rendimiento son propuestas del equipo y se confirman midiendo en la Etapa 6.

| En lugar de | Se compromete |
|---|---|
| Rápido | La respuesta aparece en pantalla en menos de 2 segundos en el 95 % de las consultas, en la PC de la farmacia. Si el modelo no responde en 1 segundo, el chat lo dice y el empleado usa el sistema normal. |
| Preciso | El clasificador alcanza al menos 85 % de exactitud de intención y la extracción del producto al menos 0.80 de F1, medidos sobre datos reales (metas de la Fase 2). Se reporta también la precisión por clase. |
| Seguro | PuntoBot solo lee del inventario (usuario de base de datos con permiso SELECT). El backend solo acepta conexiones de la PC local. No se guarda el nombre del empleado, solo su rol. |
| Disponible | Funciona durante el horario de atención de Punto Farma sin necesitar internet. Si cae, el sistema actual sigue funcionando igual que hoy. El horario exacto queda por confirmar con la farmacia. |
| Auditable | Cada consulta se conserva con fecha, rol, intención, confianza, producto, respuesta, versión del modelo y corrección si la hubo. |
| Respaldable | Copia de la base de datos de PuntoBot una vez por semana, en una carpeta distinta de la del sistema. La administra el Administrador de PuntoBot. |
| Mantenible | Cambiar un umbral es cambiar una configuración. Publicar un modelo nuevo es copiar un archivo versionado y reiniciar el servicio. |
| Privado | Los datos comerciales (precios, ventas, existencias) no salen de la PC de la farmacia. El corpus de entrenamiento no lleva datos de clientes. |
