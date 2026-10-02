# Servicio del modelo

Responsable del contrato: Josias Beeri Zeledón Pastrán.

API prevista: `POST /clasificar`, con entrada `{"texto": "cuanto hay de paracetamol"}`. Devuelve versión, probabilidades de intención, producto mencionado y candidatos. El backend aplica los umbrales y decide cómo responder.

[Respuesta de prueba](respuesta-prueba.json). Es un ejemplo del contrato, con valores de demostración. El servicio ejecutable y el clasificador real corresponden a las etapas de modelo e integración; esta etapa documenta su interfaz.
