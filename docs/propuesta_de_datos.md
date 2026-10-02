# Propuesta de Datos del Proyecto
### Etapa 3 · Entrega 3.A

---

## 0. Identificación

| Campo | Contenido |
|---|---|
| Equipo | PuntoBot |
| Integrantes | Ricardo José Romero Blandón — Josias Beeri Zeledón Pastrán — Pablo Joshua Castro |
| Título del proyecto | PuntoBot: Asistente Conversacional para Consultas de Inventario y Ventas en Punto Farma |
| Docente | Norman Ariel Gutiérrez Hernández |
| Fecha de entrega | 10/09/2026 |
| Versión | 1.0 |

---

## 1. Recordatorio del problema (Etapas 1 y 2)

**Problema:** el personal de venta e inventario de Punto Farma (Ocotal, Nueva Segovia) pierde tiempo y depende de compañeros con más experiencia técnica para obtener información puntual del sistema de inventario y facturación —existencias, precio, última venta de un producto—, porque hacerlo requiere navegar menús, filtros y reportes que no todos dominan con soltura.

**Usuario final:** los encargados de venta y el personal responsable del inventario de Punto Farma, que atienden en el mostrador.

**Decisión que se apoya:** qué operación ejecutar sobre la base de datos operativa (consultar stock, precio o última venta de un producto) a partir de una pregunta escrita en lenguaje natural.

**Aclaración de alcance (Fase 2):** PuntoBot **no** escribe ni modifica datos. Solo consulta información ya existente en el sistema de inventario y facturación, integrado en la interfaz de escritorio actual. No incluye WhatsApp, voz, ni recomendaciones clínicas o farmacológicas.

---

## 2. Pregunta de datos

| Campo | Contenido |
|---|---|
| ¿Qué debe predecir el sistema? | La intención de la consulta que escribe el empleado, para ejecutar automáticamente la operación correspondiente sobre la base de datos de inventario y facturación |
| **Variable objetivo** | `intencion` — categórica multiclase: `consulta_stock`, `consulta_precio`, `consulta_ultima_venta`, `otra` (consulta fuera de las tres funciones del alcance) |
| Tipo de tarea | Clasificación multiclase de texto (NLP). Se complementa con una segunda tarea de extracción de entidades (NER) para identificar el producto mencionado, evaluada por separado (ver Fase 2, matriz de objetivos) |
| **Unidad de análisis** | Una consulta individual en lenguaje natural, escrita por un empleado en la ventana de chat de PuntoBot |
| Momento de la predicción | En el instante en que el empleado envía su pregunta en el chat, **antes** de que el sistema ejecute cualquier búsqueda en la base de datos operativa |

**Control de fuga aplicado:** ninguna variable usada para predecir la intención puede depender de información posterior al envío de la consulta. En concreto, el resultado que PuntoBot terminará mostrando (el dato de stock, precio o venta) **no** puede usarse como variable de entrada del clasificador, porque en el momento real de la decisión ese resultado todavía no existe.

---

## 3. Fuentes de datos candidatas

### Fuente 1 — Corpus propio de consultas del personal de Punto Farma (principal)

| Campo | Contenido |
|---|---|
| Tipo | Recolección primaria propia (entrevistas estructuradas + registro de consultas reales al mostrador) |
| Enlace | No aplica — dato propio, no publicado |
| Origen | Personal de venta e inventario de Punto Farma, Ocotal |
| Estado | **En construcción.** El equipo tiene acceso directo al personal y comenzará la recolección al aprobarse esta propuesta |
| Formato y tamaño previsto | CSV, meta mínima de 150–200 consultas |
| **Licencia** | No aplica (dato propietario del equipo y de Punto Farma). Uso exclusivamente académico dentro de esta cátedra, con consentimiento informado del personal |
| ¿Permite el uso que le daremos? | Sí — es el propósito para el que se recolecta |
| Aporte | Es la única fuente que refleja el vocabulario, los errores de tipeo y las expresiones coloquiales reales con las que el personal formularía sus preguntas; sin ella no hay forma de entrenar el clasificador de intención para este dominio específico |

**Procedimiento de recolección:** entrevistas cortas donde se le pide a cada empleado formular, con sus propias palabras, la pregunta que le haría a un compañero para conocer existencias, precio o última venta de un producto; complementado con observación discreta de consultas reales al sistema actual durante la jornada, transcritas por el equipo.

### Fuente 2 — MASSIVE (Amazon Science), subconjunto es-ES (complementaria)

| Campo | Contenido |
|---|---|
| Tipo | Dataset público |
| Enlace | https://huggingface.co/datasets/AmazonScience/massive |
| Origen | Amazon Science (localización del dataset SLURP a 52 idiomas) |
| Fecha de consulta | 10/09/2026 |
| Formato y tamaño | Parquet/JSON vía librería `datasets`; subconjunto `es-ES`: 16,521 consultas (11,514 train · 2,033 validación · 2,974 test), 60 intenciones agrupadas en 18 dominios |
| **Licencia** | CC BY 4.0 (Creative Commons Attribution 4.0 International) |
| ¿Permite el uso que le daremos? | Sí, con atribución — uso académico |
| ¿Está descargada? | No todavía; se descarga bajo demanda con `datasets.load_dataset("AmazonScience/massive", "es-ES")` |
| Aporte | **No es intercambiable con la Fuente 1**: son consultas de asistente de voz de propósito general (alarmas, clima, música, listas), no de farmacia. Se usa únicamente como referencia metodológica para validar el pipeline de NLP en español (tokenización, arquitectura del clasificador, formato de entrada/salida) mientras el corpus propio todavía es pequeño, no para etiquetar ni aumentar directamente los datos de entrenamiento del dominio |

Al revisar el candidato que habíamos mencionado en la Fase 1 (`kaggle.com/datasets/sebastinconcha/datos-farmacias`), nos dimos cuenta de que en realidad es un listado de ubicaciones de farmacias en Chile, sin relación con consultas de lenguaje natural ni con inventario. Lo descartamos y lo reemplazamos por MASSIVE, que sí es un dataset de intención verificable y con licencia exacta.

---

## 4. Volumen y suficiencia

| Campo | Contenido |
|---|---|
| Registros meta (Fuente 1) | 150–200 consultas |
| Clases | 4 (`consulta_stock`, `consulta_precio`, `consulta_ultima_venta`, `otra`) |
| Distribución esperada (proyección, a validar con datos reales) | `consulta_stock` ~40% · `consulta_precio` ~30% · `consulta_ultima_venta` ~20% · `otra` ~10% |
| ¿Desbalance esperado? | Sí, moderado-alto: la clase `otra` quedaría con apenas ~15–20 registros totales |

**Cálculo de suficiencia.** Con una meta de 200 registros y una división 70/15/15, el conjunto de prueba tendría ~30 registros. Si `otra` representa el 10% del total, quedarían solo **2–3 registros de esa clase en test** — insuficiente para medir su desempeño de forma confiable. Esto se declara como riesgo (ver sección 7): la recolección priorizará explícitamente ejemplos de la clase `otra` (preguntas fuera de alcance, saludos, consultas ambiguas) para no quedar por debajo de un mínimo de ~15 registros en test, y en la ficha técnica se reportará esta limitación en vez de ocultarla.

---

## 5. Variables previstas

| # | Variable | Tipo | Por qué podría aportar | ¿Disponible al predecir? |
|---|---|---|---|---|
| 1 | `texto_consulta` | Texto libre | Es la entrada principal: la pregunta tal como la escribe el empleado; el modelo de NLP la procesa para predecir `intencion` | Sí |
| 2 | `producto_mencionado` | Entidad de texto / categórica | Nombre del producto detectado dentro de la consulta (extraído con un modelo de reconocimiento de entidades); es el parámetro que se usará para ejecutar la consulta real sobre la base de datos una vez identificada la intención | Sí, pero se extrae del propio texto, no se recolecta aparte |
| 3 | `longitud_consulta` | Numérica (tokens) | Feature auxiliar derivado del texto; consultas cortas y directas ("precio paracetamol") podrían distinguirse de consultas más largas con contexto adicional | Sí (se calcula en el notebook) |
| 4 | `rol_empleado` | Categórica (vendedor / inventario) | Contextual: el rol podría correlacionar con el tipo de consulta más frecuente (inventario pregunta más por bajo stock, ventas pregunta más por precio) | Sí |
| 5 | `hora_consulta` | Categórica (mañana / tarde) | Contextual: permite explorar si el volumen o el tipo de consulta cambia según el momento del día (ej. más consultas de stock antes de abrir) | Sí |

---

## 6. Legalidad, privacidad y ética

| Pregunta | Respuesta |
|---|---|
| ¿Contiene datos personales? | El corpus propio no contiene datos de clientes ni de pacientes. Contiene el texto de preguntas formuladas por el personal en el desempeño de su trabajo |
| ¿Contiene datos sensibles? | No en el corpus de consultas. La base de datos operativa de inventario (fuente ya existente, Fase 1) sí contiene precios y datos comerciales internos, considerados información propietaria del negocio, no datos personales de terceros |
| ¿Cómo se anonimizan? | El identificador de cada empleado se reemplaza por su rol general (`vendedor` / `inventario`) antes de guardar el registro. No se almacena nombre ni número de identificación |
| ¿Hubo consentimiento? | Se solicitará consentimiento informado y verbal a cada empleado antes de registrar o entrevistarlo, explicando que el propósito es exclusivamente este proyecto académico |
| Dataset público (MASSIVE) | Sus autores declaran explícitamente que el corpus está libre de información personal o sensible |
| ¿Qué daño causaría un error? | Un falso `otra` (el sistema no reconoce una consulta válida) obliga al empleado a repetir la pregunta o volver al método manual: costo bajo. Un falso `consulta_stock`/`consulta_precio`/`consulta_ultima_venta` cruzado (confundir el tipo de consulta) entrega al empleado una respuesta que no corresponde a lo que preguntó, lo cual puede inducir un error de atención al cliente en el mostrador |
| ¿A quién perjudica más el error? | Al empleado y, en cadena, al cliente atendido: una respuesta cruzada es peor que un "no entendí", porque el empleado podría confiar en una respuesta equivocada sin notar el error |

**Consecuencia directa sobre el proyecto:** dado que confundir el tipo de consulta es más costoso que no reconocerla, la Etapa 7 priorizará la **precisión por clase (precision)** de las tres intenciones del alcance por sobre el *accuracy* global, y `otra` funcionará como una salida segura ante la duda.

**Compromiso del equipo:** el corpus propio se usa exclusivamente con fines académicos dentro de esta cátedra y no se comparte fuera del equipo y la evaluación del curso.

---

## 7. Riesgos y plan B

| # | Riesgo | Probabilidad | Impacto | Acción preventiva |
|---|---|---|---|---|
| 1 | El corpus propio queda demasiado pequeño o desbalanceado entre las 4 clases | Alta | Alto | Recolección dirigida a la clase `otra` desde el inicio; ponderación de clases en el entrenamiento (Etapa 6) |
| 2 | El personal formula las consultas de forma artificial al saber que se están registrando (efecto observador) | Media | Media | Complementar entrevistas con observación discreta de consultas reales al sistema actual |
| 3 | MASSIVE, al ser de dominio general, no comparte vocabulario con farmacia y no puede etiquetarse directamente para este proyecto | Confirmada | Media | Se usa solo como referencia metodológica del pipeline de NLP, nunca como fuente de entrenamiento del dominio |
| 4 | Retraso en la recolección por disponibilidad del personal de la farmacia | Media | Media | Iniciar la recolección de inmediato tras la aprobación de esta propuesta; construir en paralelo el notebook con la estructura lista para recibir los datos reales |

**Plan B:** si el corpus propio no alcanza el volumen mínimo (~150 consultas) dentro del plazo de la etapa, el equipo ampliará la búsqueda de un dataset público adicional de intención para atención al cliente/retail en español (Kaggle o Hugging Face), verificando en ese momento su licencia exacta antes de usarlo, y documentará el cambio en la ficha técnica. Se perdería especificidad de dominio farmacéutico frente a la Fuente 1.

---

## 8. Cronograma de la etapa

| Actividad | Fecha |
|---|---|
| Redacción y entrega de esta propuesta (3.A) | 10/09/2026 |
| Recolección de consultas reales (entrevistas + observación) | 11/09/2026 – 18/09/2026 |
| Inventario y limpieza en el notebook | 19/09/2026 |
| EDA y cinco preguntas del dominio | 20/09/2026 |
| División train/val/test y baseline trivial | 21/09/2026 |
| Ficha técnica redactada | 22/09/2026 |

---

## 9. Uso de la cátedra

| Campo | Contenido |
|---|---|
| Estado | Aprobada / Aprobada con observaciones / Requiere replanteo (marcar la que corresponda) |
| Observaciones | |
| Fecha de revisión | |
