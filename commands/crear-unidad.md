---
description: Crea una unidad de trabajo nueva (utNN) desde la plantilla del kit.
---

Crea una unidad de trabajo nueva siguiendo los pasos del `README.md`.

Módulo y unidad (si faltan, pídelos): $ARGUMENTS

Antes de crear nada, pide al usuario lo que falte; no lo inventes: el módulo y el número de unidad (por ejemplo `modulo-1` y `ut02`), la documentación de la unidad y los datos de la tarea (`titulo`, `subtitulo`, `dia`, `mes` y `anyo`).

Después: copia `{{KIT}}/typst/templates/unidad-trabajo` al directorio de la unidad, añade la documentación en `.txt` (con `pdftotext`, ver `README.md`) y rellena `<modulo>/<ut>/tarea/typst/data.typ`.
