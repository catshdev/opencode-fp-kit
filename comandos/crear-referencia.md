---
description: Añade una referencia nueva al referencias.bib de una unidad.
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

Pregunta por el nombre de la referencia: será el `title`. Genera una clave de cita única a partir del nombre (o del primer autor y el año, si los tienes): pásala a ASCII, minúsculas y guiones; si queda vacía, usa `referencia`. Si ya existe esa clave en el `.bib`, pide otra. Si el usuario te da una clave, respétala.

Después pregunta si quiere rellenar los campos ahora o dejarlos para luego manualmente. Todos los campos son opcionales; el nombre/título es lo único que no puede faltar. Si quiere rellenarlos ahora, pide solo los que correspondan al tipo:

- `@online`: `author`, `year`, `url`.
- `@article`: `author`, `journal`, `year`, `volume`, `number`, `pages`, `doi`.
- `@book`: `author`, `publisher`, `year`, `address`, `edition`.
- `@incollection`: `author`, `booktitle`, `editor`, `publisher`, `year`, `pages`.
- `@inproceedings`: `author`, `booktitle`, `year`, `pages`.
- `@misc`: `author`, `year`, `howpublished`, `note`.

Si el usuario deja campos para luego, omítelos; no pongas valores inventados ni campos vacíos.

Si hay `author`, escríbelo con llaves dobles para que aparezca el nombre completo:

```bib
  author = {{Nombre completo}},
```

Esto vale para cualquier tipo de referencia. Si no hay `author`, no pongas esa línea.

Para `@online`, rellena siempre `urldate` con la fecha de entrega del `tarea.typ`: lee `dia`, `mes` y `anyo` y escribe `AAAA-MM-DD`, con el día y el mes a dos cifras. Si no encuentras las tres variables o no son válidas, pide la fecha; no la inventes. Si no hay `url`, avisa de que falta, aunque dejes el resto para después.

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

Si falta `author`, `year` o `url`, quita esas líneas. No dupliques la clave ni la entrada.
