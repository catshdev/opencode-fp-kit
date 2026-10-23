---
description: Revisa un capítulo concreto de una unidad según los convenios de redacción.
---

Revisa un solo capítulo de una unidad siguiendo los convenios de redacción de `AGENTS.md`. No revises el resto de capítulos.

Argumentos: `<curso>`, `<ut>` y `<capítulo>`. Recibido: $ARGUMENTS
Si falta el curso, la unidad o el capítulo, pídelos.

El capítulo puede ser un número (`3` → `03-*.typ`) o el nombre del fichero, con o sin extensión. Busca solo en:

- `<curso>/<ut>/tarea/typst/capitulos/`, si es una tarea de documento único.
- `<curso>/<ut>/tarea/partes/p*/typst/capitulos/`, si la unidad está dividida en partes.

Si no encuentras el capítulo, pide el nombre exacto. Si hay más de un fichero que coincide (por ejemplo, el mismo número en varias partes), pregunta cuál es y no revises nada hasta saberlo.

Trabaja solo con ese capítulo y el `referencias.bib` de su proyecto Typst. No incluyas los demás capítulos.

Luego:

1. Pasa el corrector ortográfico: `bash {{KIT}}/typst/revisar.sh <ficheros>`.
   - Si sale una palabra bien escrita que va a repetirse (tecnicismo, nombre propio, sigla), añádela al diccionario que corresponda: si vale para cualquier proyecto, al genérico del kit; si es propia de este curso, a `.typst/.aspell.es.pwl` del proyecto.
   - Las palabras españolas sin tilde (`version`, `maximo`) no se añaden: son faltas reales.
2. Revisa el texto del capítulo contra los convenios de `AGENTS.md` y contra el enunciado (`1-descripcion.pdf` o `descripcion.pdf`) y la documentación de la unidad (`documentacion/*.txt`): tics, voz, densidad, repeticiones y frases forzadas. Si el capítulo está en una parte, usa el enunciado de esa parte (`partes/p*/1-descripcion.pdf` o `descripcion.pdf`). Propón los cambios concretos.
   - Si el capítulo incluye capturas o figuras con texto, sácales el texto si puedes (leyendo la imagen o con OCR) y míralo: si aporta un dato, una cifra, un error o una contradicción con la prosa, úsalo; si no, no lo metas por rellenar.
   - No borres código comentado de los `.typ` por tu cuenta: si propones quitarlo, pregunta antes. Si el comentario lleva `NO ELIMINAR`, `NO BORRAR`, `MANTENER` o similar, no lo toques.
3. Si un recorte es grande, propónlo con el ahorro estimado y espera confirmación antes de aplicarlo.
