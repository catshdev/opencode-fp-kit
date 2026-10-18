---
description: Pasa a texto los PDF de la documentación de una unidad (pdftotext), con el nombre saneado y borrado opcional de los PDF.
---

Convierte a `.txt` los PDF de `documentacion/` de una unidad de trabajo.

Argumentos: `<modulo>`, `<ut>` y, si se indica, borrar los PDF. Recibido: $ARGUMENTS
Si faltan el módulo o la unidad, pídelos; pregunta también si hay que borrar los PDF después.

Carpeta: `<modulo>/<ut>/documentacion`. Ejecuta exactamente esto:

```bash
dir="<modulo>/<ut>/documentacion"
for pdf in "$dir"/*.pdf; do
  [ -e "$pdf" ] || continue
  base="$(basename "${pdf%.*}")"
  nombre="$(printf '%s' "$base" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed -E 's/[^A-Za-z0-9]+/-/g; s/^-+//; s/-+$//')"
  [ -n "$nombre" ] || nombre="documento"
  pdftotext -layout "$pdf" "$dir/$nombre.txt"
done
```

El nombre de salida es el del PDF sin la extensión: los acentos pasan a su vocal sin acento y los espacios, guiones bajos y demás caracteres raros se cambian por guiones (`-`). Con `-layout`. Si el usuario pide borrar los PDF, `rm -- "$dir"/*.pdf` al terminar. Comprueba que los `.txt` no queden vacíos y avisa si alguno lo está.
