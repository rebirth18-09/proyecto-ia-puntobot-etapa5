# Boceto del módulo de chat

Responsable: Ricardo José Romero Blandón. El módulo se integra al sistema de escritorio existente; su tecnología debe confirmarse con la farmacia.

## Captura

La pantalla muestra el campo «Escribe tu consulta», el rol de la sesión y el botón «Consultar». Conserva el texto cuando falla la comunicación. La entrada admite de 1 a 200 caracteres.

## Resultado

Muestra la respuesta y el identificador de la consulta. Cuando corresponde, muestra el producto y el dato obtenido del inventario con su fecha. Incluye el botón «No era eso» y los motivos «Intención equivocada», «Producto equivocado» y «Otro».

## Estados de error

Texto inválido: pedir que se corrija. Intención poco clara: pedir reformulación. Producto ambiguo: pedir que se identifique el producto. Modelo o inventario sin respuesta: informar disponibilidad y permitir usar el sistema habitual. Registro fallido: no presentar el resultado como confirmado.
