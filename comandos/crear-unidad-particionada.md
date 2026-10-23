---
description: Crea una unidad de trabajo nueva (utNN) con la tarea dividida en partes, desde la plantilla del kit.
---

Crea una unidad de trabajo nueva con la tarea dividida en partes, desde la plantilla `unidad-particionada` del kit.

Curso, unidad y número de partes (si faltan, pídelos): $ARGUMENTS

Antes de crear nada, pide al usuario lo que falte; no lo inventes:

- El curso y la unidad (por ejemplo, `curso-1` y `ut02`).
- El número de partes (por ejemplo, 5).
- El subtítulo base de la tarea (por ejemplo, «TAREA 1»); cada parte usará `TAREA 1\ PARTE 1`, `TAREA 1\ PARTE 2`, etc.
- La documentación de la unidad, para pasarla a `.txt` en `<curso>/<ut>/documentacion/` con `pdftotext`.
- Para `<curso>/<ut>/tarea/.typst/tarea.typ`: `titulo`, `dia`, `mes` y `anyo` de la fecha de entrega.
- Si ya tienes los enunciados de las partes, su ruta; cada PDF va en `<curso>/<ut>/tarea/partes/pNN/1-descripcion.pdf` (o `descripcion.pdf`). No los inventes.

Si `<curso>/<ut>` ya existe, avisa antes de sobrescribir y espera confirmación.

Copia la plantilla:

```bash
src={{KIT}}/typst/plantillas/unidad-particionada
mkdir -p "<curso>/<ut>"
cp -R "$src"/. "<curso>/<ut>/"
```

Duplica `tarea/partes/p01` para cada parte adicional:

```bash
n=<número>
base="<curso>/<ut>/tarea/partes/p01"
for ((i=2; i<=n; i++)); do
  printf -v parte '%02d' "$i"
  cp -R "$base" "<curso>/<ut>/tarea/partes/p$parte"
done
```

Ajusta el subtítulo de `parte.typ` en todas, usando el subtítulo base y el número de parte: `TAREA 1\ PARTE 1`, `TAREA 1\ PARTE 2`, etc. Las carpetas van a dos dígitos (`p02`) y el subtítulo usa el número de parte (`PARTE 2`).

Cada parte es un proyecto Typst completo en `tarea/partes/pNN/typst/` (con `documento.typ`, `parte.typ`, `capitulos/`, `figuras/` y `referencias.bib`); no hay un `documento.typ` común.

Los datos comunes de la tarea van en `<curso>/<ut>/tarea/.typst/tarea.typ` (no en `tarea/typst/`): rellena `titulo`, `dia`, `mes` y `anyo` de la fecha de entrega. No pongas ahí `subtitulo`; el de cada parte vive en su `partes/pNN/typst/parte.typ`.

Añade la documentación en `.txt` en `<curso>/<ut>/documentacion/` (con `pdftotext`) y deja cada enunciado de parte en su carpeta `partes/pNN/` si el usuario los ha dado. No cambies los capítulos de ejemplo salvo que el usuario lo pida.
