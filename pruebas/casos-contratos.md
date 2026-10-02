# Casos de prueba derivados de los contratos

Responsable de la revisión: Pablo Joshua Castro. Estos casos definen el comportamiento que deberá comprobarse al integrar el sistema.

| Contrato | Caso | Resultado esperado |
|---|---|---|
| Chat → Backend | Texto vacío o más de 200 caracteres | Rechaza sin llamar al modelo |
| Chat → Backend | Falla al enviar | Conserva texto y permite reintentar |
| Backend → Modelo | Respuesta válida | Cuatro probabilidades, versión y candidatos |
| Backend → Modelo | Más de 1 segundo o servicio caído | Informa no disponibilidad y registra el fallo |
| Backend → Modelo | Probabilidades inválidas o clase desconocida | Rechaza respuesta; no consulta inventario |
| Backend → Modelo | Confianza menor a 0.60 o intención otra | Pide reformular |
| Backend → Inventario | Sin producto con similitud mínima 0.80 | Pide identificar producto; no ejecuta SQL |
| Backend → Inventario | Error o producto inexistente | Informa el problema sin inventar valores |
| Backend → Inventario | Intento de modificar datos | Cuenta de base de datos rechaza cualquier escritura |
| Backend → Base de datos | Error al registrar | Reintenta; no muestra un resultado confirmado sin registro |
| Corrección | Una corrección válida | Guarda y confirma |
| Corrección | Segunda corrección para la misma consulta | Rechaza el duplicado |
| Exportación A | Archivo ilegible | Solicita una nueva exportación |
| Publicación B | Artefacto nuevo falla | Restaura la versión anterior |
