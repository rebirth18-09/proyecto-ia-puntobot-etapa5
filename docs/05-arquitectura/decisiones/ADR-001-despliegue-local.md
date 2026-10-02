# ADR-001 · Despliegue del sistema en la PC local de la farmacia

**Fecha:** 2026-10-01
**Estado:** aceptada
**Decidido por:** los tres integrantes

## Contexto

PuntoBot responde sobre existencias, precios y ventas de Punto Farma, que viven en el sistema de inventario y facturación ya instalado en la farmacia. El alcance de la Fase 2 pide integrarlo en la interfaz de escritorio actual, en una sola sede (Ocotal), y las consultas ocurren en el mostrador durante la atención.

## Decisión

Desplegar el backend, el servicio del modelo y la base de datos de PuntoBot en la PC de la farmacia, dentro de la red local. El entrenamiento se hace fuera, en la PC del equipo.

## Alternativas consideradas

| Alternativa | Por qué se descartó |
|---|---|
| Nube | Los precios y ventas saldrían de la farmacia, haría falta internet estable en el mostrador y un servicio contratado por una sola sede y un modelo pequeño. Habría que cumplir además las exigencias de la Ley 787 de Protección de Datos Personales, citada en la guía de la cátedra. |
| Híbrido (modelo en la nube, resto local) | Mantiene la dependencia de internet para la parte más usada y no resuelve la salida de datos. |

## Consecuencias

Se gana: funciona sin internet, los datos comerciales no salen del negocio y no hay costo mensual por uso.

Se cede: el cómputo está limitado a la PC de la farmacia y el equipo responde por los respaldos y las actualizaciones. No se puede usar desde otra sede.

Garantías obligatorias de elegir lo local:

| Garantía | Cómo se cumple |
|---|---|
| Respaldo periódico de la base de datos | Copia semanal de la base de PuntoBot, a cargo del Administrador de PuntoBot. |
| Cómo se actualiza el modelo | Se copia a mano el archivo `.joblib` versionado y se reinicia el servicio (flujo B del diagrama). Si falla, se vuelve a la versión anterior. |
| Quién lo administra | El Administrador de PuntoBot. Quién ocupa ese rol en la farmacia queda por definir. |

## Qué haría reconsiderar esta decisión

Abrir una segunda sucursal, o que la PC de la farmacia no soporte la carga del modelo (por ejemplo, si responder pasa de 2 s en más del 5 % de las consultas).
