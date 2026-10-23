---
description: Añade una referencia nueva al archivo referencias.bib de una unidad.
---

Añade una referencia nueva a la bibliografía de una unidad.

Argumentos: `<curso>` y `<ut>`. Recibido: $ARGUMENTS
Si falta alguno, pídelo.

Comprueba que existe `<curso>/<ut>`. Si no existe, para y avisa.

Localiza el proyecto Typst de la unidad:

- Si existe `<curso>/<ut>/tarea/typst/referencias.bib`, es una tarea de documento único. La fecha de entrega está en `<curso>/<ut>/tarea/typst/tarea.typ`.
- Si existen `<curso>/<ut>/tarea/partes/p*/typst/referencias.bib`, es una tarea por partes. Si hay más de una parte, pregunta en qué parte va la referencia. La fecha de entrega está en el `tarea.typ` común, en `<curso>/<ut>/tarea/.typst/tarea.typ`.

Si hay ambas estructuras, pregunta cuál usar. Si no encuentras el `.bib`, para y avisa.

Lee los ejemplos de `{{KIT}}/typst/plantillas/unidad/tarea/typst/referencias.bib` y pregunta qué tipo de referencia es. Como mínimo, ofrece estos:

- Libro: `@book`.
- Artículo de revista: `@article`.
- URL o página web: `@online`.
- Capítulo de libro: `@incollection`.
- Ponencia o congreso: `@inproceedings`.
- Software o dataset: `@misc`.

Si el usuario pide otro tipo, usa el tipo BibLaTeX que corresponda.

Pregunta por el nombre de la referencia: será el `title`. Sanea ese mismo nombre para la clave de cita: pásalo a ASCII, minúsculas y cambia espacios y signos por guiones; quita los guiones sobrantes y, si queda vacío, usa `referencia`. El nombre original se queda como título; la clave es el nombre saneado. Si el usuario te da otra clave, pásala por el mismo saneado. Si la clave ya existe en el `.bib`, pide otra o añade un sufijo.

Puedes usar este bloque para generar la clave:

```bash
nombre="<nombre>"
clave=$(printf '%s' "$nombre" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed -E 's/[^A-Za-z0-9]+/-/g; s/^-+//; s/-+$//; s/.*/\L&/')
[ -n "$clave" ] || clave="referencia"
```

Después pregunta si quiere rellenar los campos ahora o dejarlos para luego manualmente. Todos los campos son opcionales de rellenar, pero la entrada se crea completa: el nombre/título siempre va y lo que no rellenes se pone con valores de ejemplo o aleatorios. Si quiere rellenarlos ahora, pide solo los que correspondan al tipo:

- `@online`: `author`, `year`, `url`.
- `@article`: `author`, `journal`, `year`, `volume`, `number`, `pages`, `doi`.
- `@book`: `author`, `publisher`, `year`, `address`, `edition`.
- `@incollection`: `author`, `booktitle`, `editor`, `publisher`, `year`, `pages`.
- `@inproceedings`: `author`, `booktitle`, `year`, `pages`.
- `@misc`: `author`, `year`, `howpublished` (si es una URL, `\url{...}`), `note`.

Si deja campos para luego, no los omitas: ponlos todos con valores de ejemplo o aleatorios (por ejemplo, `Autor de ejemplo`, `Revista de ejemplo`, `2026`, `1--10`, `https://example.com/`). Si elige rellenarlos ahora pero salta alguno, haz lo mismo. Luego se cambian a mano.

Si hay `author`, escríbelo con llaves dobles para que aparezca el nombre completo:

```bib
  author = {{Nombre completo}},
```

Esto vale para cualquier tipo de referencia. Si no hay `author`, usa `{{Autor de ejemplo}}` para que la entrada quede completa.

Para `@online`, rellena siempre `urldate` con la fecha de entrega del `tarea.typ`: lee `dia`, `mes` y `anyo` y escribe `AAAA-MM-DD`, con el día y el mes a dos cifras. Si no encuentras las tres variables o no son válidas, pide la fecha; no la inventes. Si no hay `url`, pon `https://example.com/` y avisa de que es un valor de ejemplo.

Puedes usar este bloque como guía para sacar la fecha:

```bash
datos="<ruta>/tarea.typ"
dia=$(sed -nE 's/^#let dia[[:space:]]*=[[:space:]]*([0-9]+).*/\1/p' "$datos" | head -n1)
mes=$(sed -nE 's/^#let mes[[:space:]]*=[[:space:]]*([0-9]+).*/\1/p' "$datos" | head -n1)
anyo=$(sed -nE 's/^#let anyo[[:space:]]*=[[:space:]]*([0-9]+).*/\1/p' "$datos" | head -n1)
[ -n "$dia" ] && [ -n "$mes" ] && [ -n "$anyo" ] || { echo "No encuentro la fecha de entrega"; exit 1; }
printf -v dia2 '%02d' "$((10#$dia))"
printf -v mes2 '%02d' "$((10#$mes))"
urldate="$anyo-$mes2-$dia2"
```

Añade la entrada al final del `.bib` con una línea en blanco de separación. Por ejemplo, para una URL:

```bib
@online{<clave>,
  author  = {{<author>}},
  title   = {<nombre>},
  year    = {<año>},
  url     = {<url>},
  urldate = {<AAAA-MM-DD>},
}
```

No quites líneas de campos: si falta un valor, pon el de ejemplo. Añade solo la entrada nueva: no reescribas el `.bib` entero, no dupliques la clave ni la entrada y no modifiques las que ya haya.
