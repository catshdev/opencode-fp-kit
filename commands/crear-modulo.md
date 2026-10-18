---
description: Crea un módulo nuevo desde la plantilla del kit (con su primera unidad de trabajo, ut01).
---

Crea un módulo nuevo siguiendo los pasos del `README.md`.

Nombre del módulo (si falta, pídelo): $ARGUMENTS

Antes de crear nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes:

- Asignatura, para `<modulo>/.typst/data.typ`: `nombre` y `profesor` o `profesora`.
- Primera tarea (`ut01`), para `<modulo>/ut01/tarea/typst/data.typ`: `titulo`, `subtitulo`, `dia`, `mes` y `anyo`.

Crea el módulo copiando `{{KIT}}/typst/templates/modulo` al directorio `<modulo>` y rellena su `.typst/data.typ`.

Después crea la primera unidad de trabajo (`ut01`) con los mismos pasos que el comando `/crear-unidad`: copia `{{KIT}}/typst/templates/unidad-trabajo` a `<modulo>/ut01`, añade la documentación en `.txt` (con `pdftotext`, ver `README.md`) y rellena `<modulo>/ut01/tarea/typst/data.typ`.

Por último, añade el módulo a la lista de «Módulos» del `README.md`.

Los `data.typ` se vuelcan en el `thesis.with` de cada `main.typ`; los parámetros de centro, logo, autor, etc. salen del `.typst/data.typ` de la raíz. El resto de pasos, en el `README.md`.
