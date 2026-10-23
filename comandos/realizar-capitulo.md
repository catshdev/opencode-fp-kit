---
description: Crea y redacta un capítulo nuevo, o revisa el que ya existe.
---

Realiza un capítulo de una unidad: si no existe, lo crea y lo redacta entero desde cero; si ya existe, lo revisa.

Argumentos: `<curso>`, `<ut>`, `<número>` y `<nombre>`. Recibido: $ARGUMENTS
Si falta el curso, la unidad o el número, pídelos. El número tiene que ser entero (`3` se convierte en `03`). El nombre solo hace falta si el capítulo no existe; si falta y hay que crearlo, pídelo. Si ya existe, usa el del fichero y no lo renombres.

Comprueba que existe `<curso>/<ut>`. Si no existe, para y avisa.

Localiza el proyecto Typst de la unidad:

- Si existe `<curso>/<ut>/tarea/typst/capitulos/`, es una tarea de documento único y los datos están en `<curso>/<ut>/tarea/typst/tarea.typ`.
- Si existen `<curso>/<ut>/tarea/partes/p*/typst/capitulos/`, es una tarea por partes. Si hay más de una parte, pregunta en qué parte va el capítulo; los datos de esa parte están en su `parte.typ`.

Si hay ambas estructuras, pregunta cuál usar. Si no encuentras ninguna, para y avisa.

En la carpeta `capitulos/` elegida, busca el fichero cuyo nombre empiece por `<NN>-`.

- Si no existe, créalo siguiendo los mismos pasos que `/crear-capitulo`: comprueba que no haya otro con ese número, sanea el nombre, crea `capitulos/<NN>-<nombre-saneado>.typ` y añade el `#include` a la lista `capitulos` de `tarea.typ` o `parte.typ`. Para el detalle exacto, lee `{{KIT}}/comandos/crear-capitulo.md`. Si no se puede registrar el `#include`, para y avisa antes de redactar; no des el capítulo por terminado.
- Si existe, no lo crees ni lo sobrescribas; usa ese fichero. Si hay más de uno con ese número, pregunta cuál es.

Si acabas de crear el capítulo, redáctalo entero desde cero:

- Lee el enunciado (`1-descripcion.pdf` o `descripcion.pdf`) y la documentación de la unidad (`documentacion/*.txt`); si está en una parte, usa el enunciado de esa parte. Si no encuentras el enunciado o la documentación, pídelos antes de escribir.
- Escribe el capítulo completo en el fichero, con la cabecera `= <nombre>` y los apartados que pida el enunciado, siguiendo los convenios de `AGENTS.md`. No inventes datos que no estén en el enunciado o en la documentación; si falta algo, pregúntalo.
- No repitas contenido de otros capítulos ni rellenes por rellenar. Ajusta la extensión a lo que pida la tarea.
- Después pásale el corrector y revisa el texto con el mismo criterio que `/revisar-capitulo`: `bash {{KIT}}/typst/revisar.sh <capítulo> <referencias.bib>`. Añade al diccionario las palabras propias que correspondan.
- Comprueba que el documento compila con `typst compile --root . <documento.typ>`. Si el error viene de este capítulo, corrígelo; si viene de otro, avisa sin tocarlo.

Si ya existía, no lo reescribas desde cero: revísalo con los mismos pasos que `/revisar-capitulo` (corrector ortográfico, convenios de `AGENTS.md`, enunciado y documentación de la unidad). Para el detalle exacto, lee `{{KIT}}/comandos/revisar-capitulo.md`; si dentro ves una marca de ruta del kit, usa la ruta real. Propón los cambios concretos y no toques los demás capítulos. Si un recorte es grande, propónlo con el ahorro estimado y espera confirmación.

En los dos casos, trabaja solo con ese capítulo y el `referencias.bib` de su proyecto Typst. No borres código comentado por tu cuenta: si propones quitarlo, pregunta antes; si lleva `NO ELIMINAR`, `NO BORRAR`, `MANTENER` o similar, no lo toques.
