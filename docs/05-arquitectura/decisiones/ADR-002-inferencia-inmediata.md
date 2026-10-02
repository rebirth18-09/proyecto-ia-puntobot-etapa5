# ADR-002 · Inferencia inmediata por consulta

**Fecha:** 2026-10-01
**Estado:** aceptada
**Decidido por:** los tres integrantes

## Contexto

El empleado escribe una pregunta con el cliente esperando en el mostrador. Hay que decidir si cada pregunta se procesa en el momento o si se acumulan para procesarlas después.

## Decisión

Cada pregunta se clasifica en el momento en que se envía, una por una, y la respuesta vuelve en menos de 2 segundos.

## Alternativas consideradas

| Alternativa | Por qué se descartó |
|---|---|
| Procesar por lotes (por ejemplo, cada cierto tiempo) | El empleado necesita la respuesta mientras atiende; esperar un lote no sirve. |
| Reentrenar el modelo con cada corrección | Con un corpus de unos cientos de ejemplos, una sola corrección puede empeorar el modelo sin que nadie lo note. Se reentrena fuera de línea y con revisión (flujos A y B). |

## Consecuencias

Se gana: respuesta inmediata y un modelo que no cambia sin que alguien lo decida. El modelo se carga en memoria al iniciar el servicio.

Se cede: las correcciones no mejoran al modelo al instante, solo cuando el administrador reentrena y publica.

Se observará: si el tiempo de respuesta supera 2 s en más del 5 % de las consultas, hay que revisar esta decisión.
