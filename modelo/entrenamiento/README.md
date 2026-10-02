# Entrenamiento fuera de línea

Los datos se preparan en la etapa 3. El clasificador se construye en la etapa 6 y se entrena y evalúa en la etapa 7. El pipeline será TF-IDF de palabras y caracteres con regresión logística, según la selección de la etapa 4.

El administrador exporta correcciones en CSV y el equipo prepara una nueva versión. El artefacto `.joblib` incluye vectorizador y clasificador. Se copia al servicio local junto con el catálogo, sin incorporar datos reales ni artefactos entrenados a Git.
