---
description: Revisa el entregable de un módulo (todos los capítulos o uno concreto) según los convenios de redacción.
---

Revisa el entregable de un módulo siguiendo los convenios de redacción de `AGENTS.md`.

Argumentos: `<modulo>` y, solo si es un capítulo suelto, su número. Recibido: $ARGUMENTS
Si falta el módulo, pídelo.

Localiza los ficheros del entregable: los `chapters/*.typ` y el `references.bib` del módulo.

- Sin número: todos los capítulos del módulo.
- Con número: solo el capítulo cuyo nombre empieza por ese número a dos dígitos (`3` → `03-*.typ`). Si el módulo está dividido en partes y sale más de uno, pregunta cuál revisar.

Luego:

1. Pasa el corrector ortográfico: `bash {{KIT}}/typst/revisar.sh <ficheros>`.
   - Si sale una palabra bien escrita que va a repetirse (tecnicismo, nombre propio, sigla), añádela al diccionario que corresponda: si vale para cualquier proyecto, al genérico del kit; si es propia de este módulo, a `typst/.aspell.es.pwl` del proyecto.
   - Las palabras españolas sin tilde (`version`, `maximo`) no se añaden: son faltas reales.
2. Revisa el texto contra los convenios de `AGENTS.md` y contra el enunciado (`1_descripcion.pdf`) y la documentación de la unidad (`documentacion/*.txt`): tics, voz, densidad, repeticiones y frases forzadas. Propón los cambios concretos.
3. Si un recorte es grande, propónlo con el ahorro estimado y espera confirmación antes de aplicarlo.
