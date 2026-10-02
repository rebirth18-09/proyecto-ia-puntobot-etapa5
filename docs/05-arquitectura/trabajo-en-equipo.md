# Trabajo en equipo

## Roles (tres integrantes, revisión circular)

| Integrante | Rol | Es dueño de | Revisa |
|---|---|---|---|
| 1 (por asignar) | Arquitecto de contexto | `nivel-1-contexto.md`, `requisitos-no-funcionales.md` | Contratos del integrante 2 |
| 2 (por asignar) | Arquitecto de contenedores | `nivel-2-contenedores.md`, `contratos-api.md`, `diagramas/` | ADR del integrante 3 |
| 3 (por asignar) | Responsable del repositorio | `README.md`, `.gitignore`, `decisiones/` | Nivel 1 del integrante 1 |

Nadie aprueba su propio trabajo: 1 revisa a 2, 2 revisa a 3, 3 revisa a 1.

## Flujo en Git

```powershell
git checkout main
git pull origin main
git checkout -b arq/nivel-2-contenedores
git add docs/05-arquitectura/nivel-2-contenedores.md
git commit -m "arq: agrega diagrama de nivel 2 con frontera local"
git push origin arq/nivel-2-contenedores
```

Después se abre el Pull Request en GitHub y se asigna como revisor al integrante que corresponde. Prefijos de rama: `arq/` diagramas y contratos, `docs/` documentación, `repo/` estructura.

## Tareas iniciales

| # | Tarea | Responsable | Etiqueta |
|---|---|---|---|
| 1 | Ordenar el repositorio y proteger `main` | Integrante 3 | configuración |
| 2 | Completar `docs/propuesta.md` (aportan todos) | Integrante 3 | documentación |
| 3 | Revisar el diagrama de nivel 1 | Integrante 1 | arquitectura |
| 4 | Revisar el diagrama de nivel 2 y su frontera | Integrante 2 | arquitectura |
| 5 | Revisar ADR-001 y ADR-002 | Integrante 3 | decisión |
| 6 | Mantener `docs/03-datos.md` al día con el corpus real | Integrante 1 | datos |
| 7 | Contrato Backend a Modelo y respuesta de prueba | Integrante 2 | modelo |
| 8 | Contratos Chat a Backend y Backend a Base de datos | Integrante 2 | backend |
| 9 | Esquema de la base de datos de PuntoBot (SQLite) | Integrante 2 | backend |
| 10 | Boceto del chat y del botón "no era eso" | Integrante 1 | interfaz |
| 11 | Listar los casos de error de cada contrato | Integrante 3 | pruebas |

La guía del docx pide cuatro integrantes y once tareas; aquí se repartieron entre tres.
