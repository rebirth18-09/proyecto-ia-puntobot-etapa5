# Nivel 1: diagrama de contexto

![Nivel 1](../../diagramas/exportados/nivel-1-contexto.png)

Archivo editable: `diagramas/fuente/nivel-1-contexto.drawio`.

## Lista previa al dibujo

| Tipo | Elemento | Frase de tres a cinco palabras |
|---|---|---|
| Actor | Vendedor | Pregunta desde el mostrador |
| Actor | Encargado de inventario | Consulta y corrige respuestas |
| Actor | Administrador de PuntoBot | Mantiene el asistente |
| Sistema externo | Sistema de inventario y facturación | Fuente de los datos |
| Nuestro sistema | PuntoBot | Entiende preguntas y responde |

## Una frase por componente (los cinco)

| Componente | Frase |
|---|---|
| Interfaz (módulo de chat) | Muestra la pregunta y la respuesta y captura la corrección. |
| Backend | Valida, aplica los umbrales, consulta el inventario y registra. |
| Servicio del modelo | Calcula probabilidades de intención y candidatos de producto. |
| Base de datos | Conserva cada consulta, respuesta y corrección. |
| Flujo de datos | Cada flecha tiene su contrato en `contratos-api.md`. |

## Relaciones

| Quién | Acción | Con quién |
|---|---|---|
| Vendedor | Escribe una pregunta y lee la respuesta | PuntoBot |
| Encargado de inventario | Escribe preguntas y marca respuestas incorrectas | PuntoBot |
| Administrador | Revisa correcciones y publica nuevas versiones | PuntoBot |
| PuntoBot | Consulta existencias, precios y ventas (solo lectura) | Sistema de inventario y facturación |

En este nivel no aparece ninguna tecnología ni pieza interna.
