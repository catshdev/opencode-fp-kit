---
description: Crea un curso nuevo desde la plantilla del kit (con su primera unidad de trabajo, ut01).
---

Crea un curso nuevo desde las plantillas del kit.

Nombre del curso (si falta, pídelo): $ARGUMENTS

Antes de crear nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes:

- Curso, para `<curso>/.typst/curso.typ`: `nombre` (el del curso) y el del profesor o la profesora (`profesor` o `profesora`; el que no se use queda en `none`).
- Primera tarea (`ut01`), para `<curso>/ut01/tarea/typst/tarea.typ`: `titulo`, `subtitulo` (por ejemplo «TAREA 1»), `dia`, `mes` y `anyo`.

Crea el curso copiando `{{KIT}}/typst/plantillas/curso` al directorio `<curso>` y rellena su `.typst/curso.typ`.

Después crea la primera unidad de trabajo (`ut01`) con los mismos pasos que el comando `/crear-unidad`: copia `{{KIT}}/typst/plantillas/unidad` a `<curso>/ut01`, añade la documentación en `.txt` (con `pdftotext`) y rellena `<curso>/ut01/tarea/typst/tarea.typ`.

Los ficheros de datos se vuelcan en el `thesis.with` de cada `documento.typ`; los parámetros de centro, logo, autor, etc. salen del `.typst/base.typ` de la raíz.
