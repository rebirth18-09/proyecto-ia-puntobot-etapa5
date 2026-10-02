# Entregable 4.A — Ficha de selección de enfoque

Etapa 4 · Selección del tipo de IA

## Problema
Clasificar la intención de la pregunta que escribe un empleado de Punto Farma (existencias, precio, última venta u otra) y extraer el producto mencionado, para responderla desde el sistema de inventario y facturación sin navegar menús ni reportes.

## Forma del dato
Texto libre corto en español de Nicaragua: una pregunta de una línea (de 2 a 9 palabras en el lote actual), con errores de tipeo, sin tildes y con expresiones coloquiales. Además, un catálogo cerrado de productos que ya existe en el sistema de la farmacia.

## Salida al usuario
Una categoría entre cuatro (consulta_stock, consulta_precio, consulta_ultima_venta u otra) más el producto mencionado. Con esos dos datos el sistema ejecuta una consulta de solo lectura y muestra el resultado.

## Etiquetas
Todavía no existen en ningún sistema. Las asigna a mano el propio equipo a cada consulta recolectada con el guion de entrevista, sin un segundo etiquetador. Para el producto se usa como referencia el catálogo del sistema de la farmacia.

## Ejemplos por clase
Lote de prueba actual (sintético, 166 filas limpias): stock 70, precio 47, última venta 35, otra 14. Meta del corpus real: de 150 a 200 consultas, con unas 15 a 20 en la clase otra. Todas las clases quedan por debajo de 100 ejemplos.

## Enfoque elegido
Aprendizaje supervisado dentro de procesamiento de lenguaje natural (clasificación de intención y extracción del producto mencionado).

## Familia de modelos
Regresión logística con pesos de clase balanceados sobre TF-IDF (palabras y n-gramas de caracteres) como línea base y primer modelo. Si no alcanza la meta de 85 %, el siguiente paso es usar embeddings de un modelo preentrenado en español (por ejemplo BETO) con la misma cabeza lineal. El producto se reconoce con coincidencia aproximada contra el catálogo (componente basado en reglas, sin entrenamiento).

## Justificación
La entrada es texto libre y la salida es una categoría cerrada, así que es clasificación de texto. Existe una respuesta correcta conocida (la etiqueta que ponemos al recolectar), por eso el paradigma es supervisado y no tiene sentido agrupar. Las reglas por palabras clave no alcanzan porque la misma pregunta se escribe de muchas formas, con errores de tipeo y jerga local. Como el corpus es chico (menos de 200 consultas) y el vocabulario es limitado, empezamos con un clasificador lineal sobre TF-IDF: entrena en segundos, se explica palabra por palabra y sirve de punto de comparación. Solo si no llega a la meta pasamos a un modelo preentrenado. El producto no se entrena: el catálogo es cerrado y ya existe, así que se resuelve con coincidencia aproximada.

## Alternativa descartada
1) Reglas por palabras clave: descartadas porque fallan con variantes como 'cuanto hay', 'me queda' o 'tenemos todavia', y con errores de tipeo, y habría que mantenerlas a mano. 2) Generar la consulta SQL con un modelo de lenguaje (texto a SQL, como en las referencias de la Fase 1): descartado porque PuntoBot solo debe leer, el SQL generado no es verificable ni reproducible y exigiría un modelo grande o salida a internet. 3) Ajuste fino completo de un transformer: descartado por ahora porque con menos de 200 ejemplos tiende a memorizar y pide más cómputo del que tiene la PC de la farmacia.

## Baseline trivial
Responder siempre consulta_stock, la clase mayoritaria: accuracy 0.400 y F1-macro 0.143 sobre validación del lote de prueba (calculado en el notebook de la Etapa 3). Cualquier modelo debe superarlo con margen en F1-macro, no solo en accuracy.

## Auditabilidad requerida
Sí, es deseable pero no obligatorio

## Prototipo en Teachable Machine
Teachable Machine solo entrena modelos de imagen, sonido y pose, y nuestro dato es texto, así que no se pudo usar. Como prototipo equivalente entrenamos TF-IDF más regresión logística sobre el lote de prueba sintético (solo train y val; test sin abrir). Validación (25 filas): accuracy 0.96 y F1-macro 0.97, frente al baseline de 0.40 y 0.14. Validación cruzada de 5 pliegues sobre 141 filas: accuracy 0.95 y F1-macro 0.91; la clase otra tiene recall 0.58 (7 de 12) con precisión 1.0. Para romper el modelo le dimos preguntas fuera de dominio: 'cuanto cuesta el viaje a managua' salió como consulta_precio con confianza 0.69 y 'cual es la capital de francia' como consulta_stock con 0.32. Con solo 3 ejemplos de otra en el entrenamiento, el recall de esa clase en validación cayó de 1.0 a 0.0 y el F1-macro de 0.97 a 0.70. Estos números salen de datos armados con plantillas, así que están inflados: sirven para probar el procedimiento, no como desempeño esperado. El tiempo real de etiquetado queda pendiente de medir en las entrevistas.

## Contraste con el estado del arte
Papers With Code cerró en julio de 2025 y hoy redirige a Hugging Face, así que ya no hay tablas de benchmarks ahí. Usamos en su lugar el paper de MASSIVE (FitzGerald et al., ACL 2023), el dataset de intenciones de nuestra propuesta de datos. Tarea buscada: intent classification. Métrica reportada: exactitud de intención (junto con exact match y F1 de slots). En el espejo de los datos de Papers With Code, XLM-R Base (85.1), mT5 Base solo codificador (86.1) y mT5 Base texto a texto (85.3) son los métodos listados: los tres son transformers multilingües preentrenados y ninguno es convolucional. No pudimos abrir los repositorios para ver cuántos datos usaron; el subconjunto es-ES de MASSIVE trae 11 514 frases de entrenamiento, unas 70 veces más que nuestro lote. Nuestro enfoque se aparta del estado del arte: empieza con TF-IDF y regresión logística en lugar de ajustar un transformer, porque con unos 170 ejemplos de un dominio cerrado conviene probar primero lo simple y comparar. Si no se llega a la meta, el siguiente paso sí coincide con el estado del arte (modelo preentrenado en español).

## Riesgo principal
Que el clasificador responda con seguridad una intención equivocada y el empleado reciba un dato que no pidió (por ejemplo, un precio en lugar de existencias). En el prototipo, una pregunta fuera de dominio salió como consulta_precio con 0.69 de confianza. El riesgo crece porque el corpus será pequeño, de una sola farmacia, con etiquetas puestas por nosotros y con la clase otra casi vacía (2 casos en test). Mitigación: evaluar precisión y recall por clase y F1-macro (no solo accuracy), exigir además que se reconozca un producto del catálogo antes de ejecutar la consulta, usar otra como salida segura bajo un umbral de confianza calibrado con validación, y dejar el botón 'no era eso' para recolectar correcciones.

