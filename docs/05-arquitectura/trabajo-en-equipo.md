# Trabajo en equipo

## Roles (tres integrantes, revisión circular)

| Integrante | Rol | Es dueño de | Revisa |
|---|---|---|---|
| Ricardo José Romero Blandón | Arquitecto de contexto | `nivel-1-contexto.md`, `requisitos-no-funcionales.md` | Contratos del Josias Beeri Zeledón Pastrán |
| Josias Beeri Zeledón Pastrán | Arquitecto de contenedores | `nivel-2-contenedores.md`, `contratos-api.md`, `diagramas/` | ADR del Pablo Joshua Castro |
| Pablo Joshua Castro | Responsable del repositorio | `README.md`, `.gitignore`, `decisiones/` | Nivel 1 del Ricardo José Romero Blandón |

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
| 1 | Ordenar el repositorio y proteger `main` | Pablo Joshua Castro | configuración |
| 2 | Completar `docs/propuesta.md` (aportan todos) | Pablo Joshua Castro | documentación |
| 3 | Revisar el diagrama de nivel 1 | Ricardo José Romero Blandón | arquitectura |
| 4 | Revisar el diagrama de nivel 2 y su frontera | Josias Beeri Zeledón Pastrán | arquitectura |
| 5 | Revisar ADR-001 y ADR-002 | Pablo Joshua Castro | decisión |
| 6 | Mantener `docs/03-datos.md` al día con el corpus real | Ricardo José Romero Blandón | datos |
| 7 | Contrato Backend a Modelo y respuesta de prueba | Josias Beeri Zeledón Pastrán | modelo |
| 8 | Contratos Chat a Backend y Backend a Base de datos | Josias Beeri Zeledón Pastrán | backend |
| 9 | Esquema de la base de datos de PuntoBot (SQLite) | Josias Beeri Zeledón Pastrán | backend |
| 10 | Boceto del chat y del botón "no era eso" | Ricardo José Romero Blandón | interfaz |
| 11 | Listar los casos de error de cada contrato | Pablo Joshua Castro | pruebas |

Los roles siguen la guía de la sesión 21 para tres integrantes. Las once tareas complementarias del documento de arquitectura se distribuyen entre esos mismos responsables. Esta asignación organiza el trabajo; las revisiones deben realizarlas los integrantes desde sus propias cuentas.

## Identificación en GitHub

| Integrante | Cuenta |
|---|---|
| Ricardo José Romero Blandón | [rebirth18-09](https://github.com/rebirth18-09) |
| Josias Beeri Zeledón Pastrán | [Mastergamer1309](https://github.com/Mastergamer1309) |
| Pablo Joshua Castro | Nombre registrado en los documentos; cuenta no proporcionada |

Docente: Norman Ariel Gutiérrez Hernández.
