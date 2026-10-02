# Respuestas de los ejercicios de las sesiones 19, 20 y 21

## Sesión 19 · Etapa 4

### Práctica 1: clasificar seis casos

| # | Caso | Respuesta |
|---|---|---|
| 1 | Perfiles naturales de pacientes sin clasificación previa | No supervisado |
| 2 | 12 000 imágenes dermatoscópicas con diagnóstico | Visión por computadora |
| 3 | Estimar minutos de espera con registros en tabla | Supervisado |
| 4 | Protocolo del ministerio, decisión auditable | Sistema de reglas |
| 5 | 8 000 comentarios, 1 500 ya clasificados | NLP |
| 6 | Brazo robótico que prueba y corrige en un simulador | Por refuerzo |

### Práctica 2: árbol de decisión aplicado a PuntoBot

| Pregunta del árbol | Respuesta de PuntoBot |
|---|---|
| ¿Hay etiquetas? | Sí, las asignamos nosotros a cada consulta recolectada |
| ¿Qué tipo de dato? | Texto |
| ¿Qué salida? | Una categoría entre cuatro, más el producto |
| ¿Cuántos ejemplos por clase? | Menos de 100 en todas |
| Resultado | Supervisado dentro de NLP; con tan pocos ejemplos, partir de un clasificador simple o de un modelo preentrenado |

### Práctica 3: Teachable Machine

No aplica: solo entrena imagen, sonido y pose, y nuestro dato es texto. Se hizo el prototipo equivalente con scikit-learn (resultados en `04-seleccion-enfoque.md`).

### Práctica 4: contraste con el estado del arte

Papers With Code cerró en 2025 y redirige a Hugging Face. Se usó el paper de MASSIVE, el dataset de intenciones de la propuesta de datos. Detalle en `04-seleccion-enfoque.md`.

### Ficha 4.A

Completa en `04-seleccion-enfoque.md` y en `Sesión19-IA-Etapa4-seleccion_tipo_IA-Completada.html`.

## Sesión 20 · Arquitectura, parte 1

### Ejercicio 1: componente responsable (ejemplo de la clínica)

| Tarea | Componente |
|---|---|
| Abrir la cámara y capturar la foto | Interfaz de usuario |
| Verificar archivo, peso y sesión | Backend |
| Cargar los pesos al iniciar | Servicio del modelo |
| Conservar predicción, fecha, usuario y versión | Base de datos |
| Aplicar el umbral 0.60 | Backend |
| Mostrar urgencia con color y mensaje | Interfaz de usuario |
| Redimensionar, normalizar y ejecutar la red | Servicio del modelo |
| Guardar la corrección del dermatólogo | Base de datos |

Regla: mostrar es interfaz, coordinar y decidir es backend, calcular es servicio del modelo, conservar es base de datos. En PuntoBot el umbral de 0.60 también está en el backend.

### Ejercicio 2: nivel de cada elemento

| Elemento | Nivel |
|---|---|
| Personal de enfermería | Nivel 1 · Contexto |
| App móvil en las tabletas | Nivel 2 · Contenedores |
| Sistema de expedientes clínicos | Nivel 1 · Contexto |
| Capas convolucionales y tamaño de filtros | Fuera de esta etapa |
| Base de datos de predicciones | Nivel 2 · Contenedores |
| Función que convierte RGBA a RGB | Fuera de esta etapa |
| Servicio que expone la API | Nivel 2 · Contenedores |
| Dermatólogo que corrige | Nivel 1 · Contexto |

### Ejercicio 3: contrato

| Pregunta | Respuesta |
|---|---|
| Método HTTP para enviar la foto | POST |
| Formato de la imagen | multipart/form-data |
| Qué devuelve el backend además de la urgencia | La confianza y el identificador de la predicción |
| Foto demasiado borrosa | Error con el motivo y sugerencia de repetir |
| Quién aplica el umbral | El backend |

### Ejercicio 4: coherencia entre entrenamiento e inferencia

| Entrenamiento | Inferencia | Resultado |
|---|---|---|
| Redimensiona a 224 × 224 | Redimensiona a 224 × 224 | Coherente |
| Divide entre 255 | Envía valores de 0 a 255 | Incoherente |
| Copias rotadas y volteadas | No rota ni voltea | Coherente |
| Convierte a tres canales RGB | Acepta imagen con transparencia | Incoherente |
| Recorta el cuadrado central | Redimensiona la foto completa | Incoherente |

Aplicado a PuntoBot: el servicio del modelo normaliza el texto con el mismo código del entrenamiento (ver `contratos-api.md`).

### Práctica para llevar

Nivel 1, Nivel 2, contrato del modelo y una frase por componente están en `05-arquitectura/`.

## Sesión 21 · Arquitectura, parte 2

| Actividad | Dónde está |
|---|---|
| Lista de verificación del Nivel 2 | `05-arquitectura/lista-verificacion.md` (9 de 10; el punto 10 depende de ustedes) |
| Estructura del repositorio y `.gitignore` | Raíz del repositorio |
| Requisitos no funcionales | `05-arquitectura/requisitos-no-funcionales.md` |
| Dos ADR | `05-arquitectura/decisiones/` |
| Roles y flujo en Git | `05-arquitectura/trabajo-en-equipo.md` |
