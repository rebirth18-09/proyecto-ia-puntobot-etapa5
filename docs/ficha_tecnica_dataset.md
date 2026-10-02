# Ficha Técnica del Dataset — PuntoBot

Esta ficha corresponde a la corrida del notebook sobre `consultas_prueba_sintetica.csv`, el lote de 203 consultas que armamos nosotros para probar que el pipeline completo funciona sin errores. No es todavía el corpus real del personal de Punto Farma. En cuanto terminemos la recolección con `docs/guion_entrevista.md`, volvemos a correr el notebook sobre `consultas_puntofarma_raw.csv` y reemplazamos los números de esta ficha por los definitivos.

---

## 1. Identificación

| Campo | Contenido |
|---|---|
| Nombre del dataset | `consultas_puntofarma_clean.csv` |
| Proyecto | PuntoBot — Asistente Conversacional para Consultas de Inventario y Ventas en Punto Farma |
| Fuente de esta corrida | Lote de prueba sintético (`consultas_prueba_sintetica.csv`), no el corpus real |
| Fuente complementaria | MASSIVE (AmazonScience/massive, es-ES) — CC BY 4.0 — usada solo como referencia metodológica, no incluida en este dataset |
| Generado por | `notebooks/02_preparacion_datos.ipynb` |
| Versión | 0.1 (corrida de prueba, previa a la recolección real) |

## 2. Propósito

Servir como datos de entrenamiento, validación y prueba para el clasificador de intención de PuntoBot (`consulta_stock`, `consulta_precio`, `consulta_ultima_venta`, `otra`) y como base para la extracción de la entidad `producto_mencionado`.

## 3. Diccionario de variables

| Variable | Tipo | Descripción | Valores posibles |
|---|---|---|---|
| `id` | entero | Identificador de la consulta | — |
| `texto_consulta` | texto | Pregunta del empleado, normalizada (minúsculas, sin espacios extremos) | libre |
| `rol_empleado` | categórica | Rol de quien formuló la consulta | `vendedor`, `inventario` |
| `hora_consulta` | categórica | Franja horaria de la consulta | `manana`, `tarde` |
| `producto_mencionado` | texto | Producto detectado en la consulta, si existe | libre / vacío |
| `longitud_consulta` | numérica | Número de tokens de `texto_consulta` (derivada, calculada en el notebook) | entero ≥ 1 |
| `intencion` | categórica (objetivo) | Intención de la consulta | `consulta_stock`, `consulta_precio`, `consulta_ultima_venta`, `otra` |

## 4. Conteo por clase

Sobre las 203 filas del lote de prueba, antes de limpiar:

| Clase | Registros | % del total |
|---|---|---|
| `consulta_stock` | 82 | 41.4% |
| `consulta_precio` | 57 | 28.8% |
| `consulta_ultima_venta` | 40 | 20.2% |
| `otra` | 19 | 9.6% |
| sin etiquetar | 5 | 2.5% |

## 5. Bitácora de limpieza

| Paso | Descripción | Registros antes | Registros después | Registros perdidos |
|---|---|---|---|---|
| 1 | Eliminación de duplicados exactos por `texto_consulta` | 203 | 170 | 33 |
| 2 | Normalización de texto (minúsculas, recorte de espacios) | 170 | 170 | 0 |
| 3 | Eliminación de filas sin `intencion` etiquetada | 170 | 166 | 4 |

El paso 1 eliminó bastantes filas porque el lote de prueba se armó con pocas plantillas de frase, sobre todo para la categoría `otra`. Con el corpus real, donde cada persona pregunta a su manera, esperamos un porcentaje de duplicados mucho menor.

## 6. Detalle de las particiones

División estratificada por `intencion`, 70/15/15, `RANDOM_STATE = 42`, sobre 166 filas limpias.

| Conjunto | Registros | `consulta_stock` | `consulta_precio` | `consulta_ultima_venta` | `otra` |
|---|---|---|---|---|---|
| `train.csv` | 116 | 49 | 33 | 24 | 10 |
| `val.csv` | 25 | 10 | 7 | 6 | 2 |
| `test.csv` | 25 | 11 | 7 | 5 | 2 |

Con solo 25 filas en `test`, la clase `otra` queda con 2 registros. Esto confirma lo que ya habíamos anticipado en el cálculo de suficiencia de la propuesta de datos: con este volumen no se puede medir el desempeño de esa clase de forma confiable. En la recolección real vamos a insistir en juntar casos de `otra` a propósito para no repetir este problema.

## 7. Baseline trivial

Predicción constante de la clase mayoritaria (`DummyClassifier`, `strategy="most_frequent"`), sobre el conjunto de validación:

| Métrica | Valor |
|---|---|
| Accuracy | 0.400 |
| F1-macro | 0.143 |

El accuracy coincide con la proporción de `consulta_stock` en validación, que es justo lo esperable de un baseline que siempre predice la clase mayoritaria. El F1-macro bajo refleja que el baseline no acierta nunca en las otras tres clases. Este es el piso que el modelo de la Etapa 7 tiene que superar, y conviene seguir mirando el F1-macro además del accuracy porque con clases desbalanceadas el accuracy por sí solo puede esconder un mal desempeño en las clases chicas.

## 8. Limitaciones del dataset

1. **Esta versión no usa datos reales.** El lote de prueba se generó a partir de plantillas de frase, no de entrevistas ni observación al personal. Los conteos y el baseline de esta ficha sirven para validar que el pipeline funciona, no para sacar conclusiones sobre cómo pregunta realmente el personal de Punto Farma.
2. **Tamaño reducido y de una sola farmacia.** El corpus final se recolecta en una única sede (Punto Farma, Ocotal); los patrones de lenguaje pueden no generalizar a otras sucursales o farmacias con distinto personal.
3. **Desbalance esperado en la clase `otra`.** Tanto en la proyección de la propuesta como en esta corrida de prueba, esta clase queda con muy pocos registros en el conjunto de prueba, lo que hace poco confiable medir su desempeño de forma aislada.
4. **Posible efecto observador.** Parte de las consultas reales se van a recolectar sabiendo el empleado que están siendo registradas, lo que puede hacer que se formulen de manera menos natural que en una consulta espontánea al mostrador.
5. **Catálogo de productos cambiante.** El campo `producto_mencionado` refleja el catálogo vigente al momento de la recolección; productos nuevos o descontinuados después no van a estar representados.

## 9. Historial de versiones

| Versión | Fecha | Cambios |
|---|---|---|
| 0.1 | 23/09/2026 | Corrida completa del pipeline sobre el lote de prueba sintético; pendiente de repetir con el corpus real |
