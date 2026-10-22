# PuntoBot — Etapa 5

Arquitectura del asistente de consultas de inventario y ventas de Punto Farma. Despliegue local con interfaz de chat, backend, servicio de clasificación y base de datos de consultas.

## Equipo

- Ricardo José Romero Blandón
- Beerí Josías Zeledón Pastrán
- Pablo Joshua Castro

Docente: Norman Ariel Gutiérrez Hernández.


## Entregables

- [Propuesta del proyecto](docs/propuesta.md).
- [Arquitectura y sus documentos](docs/05-arquitectura/README.md).
- [Contratos entre componentes](docs/05-arquitectura/contratos-api.md).
- [Decisión de despliegue local](docs/05-arquitectura/decisiones/ADR-001-despliegue-local.md).
- [Decisión de inferencia inmediata](docs/05-arquitectura/decisiones/ADR-002-inferencia-inmediata.md).
- [Diagramas editables](diagramas/fuente) y [exportaciones PNG y SVG](diagramas/exportados).
- [Lista de revisión](docs/05-arquitectura/lista-verificacion.md) y [trabajo en equipo](docs/05-arquitectura/trabajo-en-equipo.md).

## Diagramas

![Nivel 1](diagramas/exportados/nivel-1-contexto.png)

![Nivel 2](diagramas/exportados/nivel-2-contenedores.png)

La tecnología del sistema de escritorio y del inventario debe confirmarse con la farmacia. La estructura y los archivos se comprobaron contra la sesión 21 y el documento de arquitectura; el detalle está en la [revisión de entregables](docs/05-arquitectura/revision-entregables.md).


## Roles

| Integrante | Rol | Revisa |
|---|---|---|
| Ricardo José Romero Blandón | Arquitecto de contexto | Contratos de Josias |
| Josias Beeri Zeledón Pastrán ([Mastergamer1309](https://github.com/Mastergamer1309)) | Arquitecto de contenedores | ADR de Pablo |
| Pablo Joshua Castro | Responsable del repositorio | Nivel 1 de Ricardo |

## Estructura

```text
README.md
.gitignore
docs/
  01-definicion-problema.md
  02-analisis-dominio.md
  03-datos.md
  04-seleccion-enfoque.md
  propuesta.md
  05-arquitectura/
    README.md
    nivel-1-contexto.md
    nivel-2-contenedores.md
    contratos-api.md
    requisitos-no-funcionales.md
    trabajo-en-equipo.md
    revision-entregables.md
    decisiones/
      ADR-001-despliegue-local.md
      ADR-002-inferencia-inmediata.md
  arquitectura/contratos.md
  adr/
diagramas/
  fuente/
  exportados/
data/.gitkeep
data/README.md
notebooks/.gitkeep
src/.gitkeep
modelo/
  entrenamiento/
  servicio/
backend/
interfaz/
bd/esquema.sql
pruebas/casos-contratos.md
```

Los directorios complementarios documentan los contenedores y los casos de falla. No contienen datos reales. El [esquema SQLite](bd/esquema.sql) y la [respuesta de prueba del modelo](modelo/servicio/respuesta-prueba.json) completan los archivos de diseño.

## Continuidad

- [Etapa 3 — Datos](https://github.com/rebirth18-09/proyecto-ia-puntobot).
- [Etapa 4 — Selección](https://github.com/rebirth18-09/proyecto-ia-puntobot-etapa4).
- [Etapa 6 — Modelo](https://github.com/rebirth18-09/proyecto-ia-puntobot-etapa6).
