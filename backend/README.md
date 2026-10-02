# Backend de PuntoBot

Responsable del contrato: Josias Beeri Zeledón Pastrán.

API prevista: Python y FastAPI. Valida el texto y el rol, llama al servicio del modelo, aplica los umbrales iniciales 0.60 para intención y 0.80 para producto, consulta el inventario en solo lectura y registra antes de mostrar la respuesta.

Contratos: [arquitectura](../docs/05-arquitectura/contratos-api.md). Persistencia: [esquema SQLite](../bd/esquema.sql). Este directorio conserva la responsabilidad del contenedor; la integración se implementa después del desarrollo y la evaluación del modelo.
