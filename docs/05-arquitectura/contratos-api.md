# Contratos entre componentes

Cada flecha del Nivel 2 tiene una fila. La numeración coincide con el diagrama.

| Flecha | Qué viaja | Qué vuelve | Si falla | Condiciones |
|---|---|---|---|---|
| 1. Chat a Backend `POST /consultas` | `texto` (máx. 200 caracteres) y `rol` (vendedor o inventario). | `id_consulta`, `mensaje`, `intencion`, `confianza` y, si aplica, `datos` (existencias, precio o última venta). | Mensaje claro en pantalla y opción de reintentar; el texto escrito no se pierde. | Respuesta en menos de 2 s en el 95 % de los casos. Solo desde la PC local. |
| 1b. Chat a Backend `POST /consultas/{id}/correccion` | `id_consulta` y `motivo` (intención equivocada, producto equivocado u otro). | Confirmación de guardado. | Se reintenta y se avisa; la corrección no se descarta en silencio. | Una corrección por consulta. |
| 2. Backend a Modelo `POST /clasificar` | `texto` tal como lo escribió el empleado. | `modelo_version`, `probabilidades` por intención, `producto_texto` y `candidatos` con su similitud. | Si no responde en 1 s, el backend contesta "PuntoBot no disponible, use el sistema normal" y lo registra. | El servicio aplica el mismo preprocesamiento del entrenamiento. |
| 3. Backend a Inventario (SQL) | Código del producto y tipo de dato pedido (existencias, precio o última venta). | Valor pedido y fecha del dato. | Se informa "no pude consultar el inventario" y se registra el error; nunca se inventa un dato. | Usuario de base de datos con permiso solo de lectura. |
| 4. Backend a Base de datos de PuntoBot (SQL) | Consulta, rol, intención, confianza, producto, respuesta, versión del modelo y fecha. | Confirmación de guardado. | No se muestra la respuesta sin registrarla: se reintenta y, si sigue fallando, se informa. | No se guarda el nombre del empleado. |
| 5. Backend a Chat (respuesta de la 1) | Ver flecha 1. | Ver flecha 1. | Ver flecha 1. | Viaja por la misma conexión que la 1. |
| A. Base de datos a Entrenamiento | Correcciones exportadas en CSV. | No aplica (copia manual). | Si el archivo no abre, se vuelve a exportar. | Solo texto, rol y etiqueta; nada de clientes. |
| B. Entrenamiento a Modelo | Archivo `.joblib` versionado y catálogo de productos. | Servicio reiniciado con la versión nueva. | Si la versión nueva falla, se vuelve a copiar la anterior. | Copia manual por el administrador. |

## Ejemplo del contrato Backend a Modelo

```json
// Solicitud (backend a servicio del modelo)
{ "texto": "cuanto hay de paracetamol" }

// Respuesta (servicio del modelo a backend)
{
  "modelo_version": "tfidf-lr-v0.1",
  "probabilidades": {
    "consulta_stock": 0.82,
    "consulta_precio": 0.09,
    "consulta_ultima_venta": 0.05,
    "otra": 0.04
  },
  "producto_texto": "paracetamol",
  "candidatos": [ { "nombre": "paracetamol", "similitud": 0.98 } ]
}
```

## Quién decide

El modelo solo devuelve 0.82 para "consulta_stock". El backend compara contra el umbral inicial de 0.60 y concluye "existencias". Si hubiera sido 0.55, respondería "no entendí, reformula". Cambiar el umbral es cambiar una configuración, no reentrenar.

## Casos de error por contrato

| Caso | Qué hace el backend |
|---|---|
| Texto vacío o de más de 200 caracteres | Rechaza con mensaje claro, no llama al modelo |
| Confianza menor a 0.60 o intención "otra" | "No entendí, reformula" y se registra |
| Intención clara, pero ningún candidato con similitud de 0.80 o más | Pregunta por el producto, no ejecuta la consulta |
| Producto que no está en el catálogo copiado con el modelo | Busca por nombre en el inventario; si no aparece, lo informa |
| Inventario sin respuesta | Informa que no pudo consultar y no inventa el dato |
| Modelo sin respuesta en 1 s | "PuntoBot no disponible, use el sistema normal" |

## Coherencia entre entrenamiento e inferencia

El servicio del modelo recibe el texto sin tocar y aplica él mismo el preprocesamiento (minúsculas y recorte de espacios, igual que en `02_preparacion_datos.ipynb`). Hay un solo lugar donde se normaliza, y es el mismo código que se usó para entrenar. Así no puede pasar que el backend normalice distinto y el modelo prediga mal sin avisar.
