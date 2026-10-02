# Guion de entrevista — recolección de consultas reales

Este guion es para sentarnos diez o quince minutos con cada empleado de venta o inventario y registrar, con sus propias palabras, las preguntas que le haría al sistema. La meta es juntar entre 150 y 200 consultas repartidas entre el personal disponible.

## Antes de empezar

Explicarle a la persona, en una frase, de qué se trata: estamos armando un proyecto de la universidad para que el sistema entienda preguntas escritas normales, como "cuánto hay de tal cosa", y que no necesite que ella use los reportes. Le pedimos permiso para anotar lo que diga y le aclaramos que no se guarda su nombre, solo si es de ventas o de inventario.

No corregirle la forma de hablar. Si dice "tenemos paracetamol o ya se jodio" se anota tal cual, con esas palabras. Ahí está el valor real de la entrevista.

## Preguntas para provocar consultas naturales

Se le van planteando situaciones y se anota literalmente lo que respondería:

1. Se te acerca un cliente preguntando por un medicamento. ¿Qué le preguntarías al sistema para saber si hay?
2. Ahora quiere saber el precio de ese mismo producto. ¿Cómo se lo preguntarías al sistema?
3. Un cliente dice que ya compró ese medicamento antes acá y quiere saber cuándo fue la última vez que se vendió. ¿Cómo harías esa consulta?
4. Pensá en tres productos distintos que se venden seguido en la farmacia (que no sean el que ya mencionaste) y repetí las tres preguntas anteriores para cada uno.
5. Si tuvieras que preguntar por algo relacionado al negocio que no sea existencia, precio ni última venta, ¿qué preguntarías? (esto sirve para la categoría "otra")
6. ¿Hay alguna forma distinta en la que preguntarías lo mismo si estuvieras apurada o apurado, o si el cliente está esperando?

Con las preguntas 1 a 4 repetidas para unos ocho o diez productos por persona ya se juntan entre quince y veinte consultas por entrevista, así que con ocho o diez entrevistas se llega a la meta.

## Cómo anotar cada consulta

Por cada respuesta se llena una fila con estas columnas, que son las mismas del archivo `data/raw/`:

| Columna | Qué anotar |
|---|---|
| texto_consulta | Lo que dijo la persona, tal cual, sin corregir |
| rol_empleado | vendedor o inventario |
| hora_consulta | manana o tarde, según cuándo se hizo la entrevista |
| producto_mencionado | el producto sobre el que preguntó, si mencionó uno |
| intencion | consulta_stock, consulta_precio, consulta_ultima_venta u otra, según cuál de las preguntas del guion la generó |

Conviene llevar esto en una hoja de cálculo simple durante la entrevista y pasar todo a `data/raw/consultas_puntofarma_raw.csv` al final del día, respetando el esquema que está en `data/raw/ESQUEMA.md`.

## Productos sugeridos para cubrir variedad

Para no quedarnos siempre con los mismos ejemplos, conviene ir rotando entre productos de alta rotación (paracetamol, ibuprofeno, suero oral) y otros menos comunes (algún antibiótico, algo de cuidado crónico como losartán o metformina), así el corpus no queda sesgado hacia dos o tres nombres.

## Meta de la semana

Entre el 11 y el 18 de septiembre, con el personal disponible en ese período, juntar el mínimo de 150 consultas repartidas entre los cuatro tipos de intención, cuidando que la categoría "otra" no quede con menos de quince o veinte casos, porque si no el modelo casi no tiene con qué aprenderla.
