---
description: Revisa una unidad completa (todos sus capítulos) según los convenios de redacción.
---

Revisa todos los capítulos de una unidad siguiendo los convenios de redacción de `AGENTS.md`.

Argumentos: `<curso>` y `<ut>`. Recibido: $ARGUMENTS
Si falta el curso o la unidad, pídelos. Si llega un tercer argumento (un capítulo), no revises solo ese capítulo: avisa de que este comando revisa la unidad entera y de que para un capítulo se usa `/revisar-capitulo`, y sigue con la unidad completa.

Localiza todos los `capitulos/*.typ` de la unidad:

- En `<curso>/<ut>/tarea/typst/capitulos/`, si es una tarea de documento único.
- En `<curso>/<ut>/tarea/partes/p*/typst/capitulos/`, si la unidad está dividida en partes.

Incluye también el `referencias.bib` de cada proyecto Typst que corresponda. Revisa la unidad completa, con todas sus partes; no preguntes por capítulos sueltos. Si no encuentras ningún capítulo, avisa y no inventes.

Luego:

1. Pasa el corrector ortográfico: `bash {{KIT}}/typst/revisar.sh <ficheros>`.
   - Si sale una palabra bien escrita que va a repetirse (tecnicismo, nombre propio, sigla), añádela al diccionario que corresponda: si vale para cualquier proyecto, al genérico del kit; si es propia de este curso, a `.typst/.aspell.es.pwl` del proyecto.
   - Las palabras españolas sin tilde (`version`, `maximo`) no se añaden: son faltas reales.
2. Revisa el texto contra los convenios de `AGENTS.md` y contra el enunciado (`1-descripcion.pdf` o `descripcion.pdf`) y la documentación de la unidad (`documentacion/*.txt`): tics, voz, densidad, repeticiones y frases forzadas. Si la unidad va por partes, usa el enunciado de cada parte (`partes/p*/1-descripcion.pdf` o `descripcion.pdf`). Propón los cambios concretos.
   - No borres código comentado de los `.typ` por tu cuenta: si propones quitarlo, pregunta antes. Si el comentario lleva `NO ELIMINAR`, `NO BORRAR`, `MANTENER` o similar, no lo toques.
3. Si un recorte es grande, propónlo con el ahorro estimado y espera confirmación antes de aplicarlo.
