# Propuesta de proyecto: ficha del equipo

Etapa 5 · Arquitectura del sistema de IA

| Campo | Pregunta que responde | PuntoBot |
|---|---|---|
| Nombre | ¿Cómo se llama el sistema? | PuntoBot: asistente conversacional para consultas de inventario y ventas en Punto Farma |
| Problema | ¿Qué situación concreta resuelve? | El personal de ventas e inventario pierde tiempo navegando menús, filtros y reportes para saber si hay un producto, cuánto cuesta o cuándo se vendió por última vez, y depende de compañeros con más experiencia. |
| Usuarios | ¿Quién lo usa y para qué? | Vendedor: pregunta en el mostrador. Encargado de inventario: consulta existencias y marca respuestas incorrectas. Administrador de PuntoBot: revisa las correcciones y publica nuevas versiones del modelo. |
| Entrada | ¿Qué dato recibe el sistema? | Una pregunta escrita en español, de una línea, con el rol del empleado (vendedor o inventario). |
| Qué calcula el modelo | ¿Qué produce la IA? | Probabilidad de cada intención (consulta_stock, consulta_precio, consulta_ultima_venta, otra) y el producto mencionado con sus candidatos del catálogo. |
| Qué decide el sistema | ¿Qué regla se aplica al resultado? | Si la mayor probabilidad es menor a 0.60 o la intención es "otra", responde "no entendí, reformula". Si hay intención clara pero ningún producto coincide con similitud de 0.80 o más, pregunta por el producto. Solo con intención y producto claros ejecuta la consulta de lectura. Los dos umbrales son valores iniciales que se calibran con el conjunto de validación en la Etapa 6. |
| Qué se registra | ¿Qué queda guardado y para qué? | Texto de la pregunta, rol, intención y confianza, producto resuelto, respuesta mostrada, versión del modelo, fecha y, si el empleado la marca, la corrección. Sirve para auditar y para reentrenar. No se guarda el nombre del empleado. |
| Sistemas externos | ¿Con qué otro sistema se conecta? | El sistema de inventario y facturación de Punto Farma, en solo lectura. |
| Despliegue | ¿Nube o local? ¿Por qué? | Local, en la PC de la farmacia: el sistema actual ya corre ahí, los datos comerciales no salen del negocio y no se depende de internet (ver ADR-001). |

Nota: "qué calcula el modelo" y "qué decide el sistema" son filas distintas. El modelo entrega probabilidades; los umbrales viven en el backend, así que se pueden cambiar sin reentrenar.
