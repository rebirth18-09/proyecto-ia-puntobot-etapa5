# Comprobación de la estructura y los archivos

Referencias: guía HTML de la sesión 21 y documento de arquitectura de la etapa 5.

## Estructura de la sesión 21

| Requisito | Archivo o carpeta | Estado |
|---|---|---|
| Presentación, navegación y roles | README.md | Completo |
| Exclusión de datos y credenciales | .gitignore | Completo |
| Definición del problema | docs/01-definicion-problema.md | Presente |
| Análisis del dominio | docs/02-analisis-dominio.md | Presente |
| Datos y continuidad | docs/03-datos.md | Presente |
| Selección del enfoque | docs/04-seleccion-enfoque.md | Presente |
| Índice de arquitectura | docs/05-arquitectura/README.md | Completo |
| Nivel 1 y nivel 2 | nivel-1-contexto.md, nivel-2-contenedores.md | Presentes |
| Contratos y requisitos medibles | contratos-api.md, requisitos-no-funcionales.md | Presentes |
| Dos decisiones | decisiones/ADR-001-despliegue-local.md, ADR-002-inferencia-inmediata.md | Presentes |
| Fuentes editables | diagramas/fuente/*.drawio | Ambos niveles |
| Exportaciones | diagramas/exportados/*.png y *.svg | Ambos niveles |
| Carpeta de datos sin datos reales | data/.gitkeep | Presente |
| Carpetas para las etapas siguientes | notebooks/.gitkeep, src/.gitkeep | Presentes |

El ADR local responde a la pregunta «dónde se despliega» del proyecto PuntoBot. La guía indica usar el ejemplo de la clínica como modelo de forma y adaptar el contenido; por eso se conserva el nombre `ADR-001-despliegue-local.md`.

## Archivos complementarios del documento de arquitectura

Se incluyen `docs/propuesta.md`, `docs/arquitectura/contratos.md`, `docs/adr/0001-despliegue.md`, `docs/adr/plantilla.md`, `data/README.md`, `modelo/entrenamiento/`, `modelo/servicio/`, `backend/`, `interfaz/`, `bd/esquema.sql` y `pruebas/casos-contratos.md`. Los directorios contienen documentos de responsabilidad y un ejemplo JSON del contrato, sin simular que el sistema completo ya está implementado.

El esquema SQLite se ejecutó en memoria y se comprobaron las restricciones de texto, rol y corrección única. Los enlaces relativos se verificaron.

## Aspectos que requieren participación del equipo

- La guía solicita un Pull Request revisado por integrante. Deben realizarse desde las cuentas de los compañeros; no se registran aprobaciones en su nombre.
- La guía sitúa el repositorio en la organización del curso. Este repositorio está en la cuenta de Ricardo, conforme a la organización separada elegida; la organización del curso no se ha proporcionado.
- La cuenta de Josias está identificada como Mastergamer1309. Pablo figura por nombre en los documentos, según lo solicitado.
- La tecnología del sistema de escritorio y del inventario debe confirmarse con la farmacia. También queda pendiente mostrar el diagrama a una persona ajena al equipo.
