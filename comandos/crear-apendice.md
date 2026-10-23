---
description: Crea un apéndice nuevo en una unidad y lo añade a la lista de apéndices de su tarea.
---

Crea un apéndice nuevo en una unidad.

Argumentos: `<curso>`, `<ut>`, `<letra>` y `<nombre>`. Recibido: $ARGUMENTS
Si falta alguno, pídelo. La letra tiene que ser una sola (`a`, `b`, `c`, ...); si llega en mayúscula, pásala a minúscula.

Comprueba que existe `<curso>/<ut>`. Si no existe, para y avisa.

Localiza el proyecto Typst de la unidad:

- Si existe `<curso>/<ut>/tarea/typst/capitulos/`, es una tarea de documento único y los datos están en `<curso>/<ut>/tarea/typst/tarea.typ`.
- Si existen `<curso>/<ut>/tarea/partes/p*/typst/capitulos/`, es una tarea por partes. Si hay más de una parte, pregunta en qué parte va el apéndice; los datos de esa parte están en su `parte.typ`.

Si hay ambas estructuras, pregunta cuál usar. Si no encuentras ninguna, para y avisa.

En la carpeta `capitulos/` elegida, comprueba que no exista ningún fichero cuyo nombre empiece por `<letra>-`. Los apéndices y los capítulos comparten carpeta, así que revisa todos los `.typ` de esa carpeta. Si ya hay uno con esa letra, para y avisa; no sobrescribas nada.

Sanitiza el nombre para el fichero: pásalo a ASCII, cambia espacios y caracteres raros por `-`, quita los guiones sobrantes y pásalo a minúsculas. Si queda vacío, usa `apendice`. El fichero será `capitulos/<letra>-<nombre-saneado>.typ`.

Crea el fichero con una cabecera `= <nombre>` y una línea en blanco. Después añade al final de la lista `apendices` del `tarea.typ` o del `parte.typ` elegido esta línea, con la misma indentación que las demás:

```typ
  #include "capitulos/<letra>-<nombre-saneado>.typ"
```

Si `apendices` vale `none` o está en el bloque comentado `none /* [ ... ] */`, conviértelo en una lista real con el apéndice nuevo. No dupliques la línea si ya existe. Si el fichero de datos no tiene una definición `#let apendices = ...`, no lo modifiques a ciegas: avisa y deja el apéndice creado sin incluir.

Puedes usar este bloque como guía, sustituyendo los valores entre `<>`:

```bash
letra=$(printf '%s' "<letra>" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//; s/.*/\L&/')
[[ "$letra" =~ ^[a-z]$ ]] || { echo "La letra del apéndice no es válida"; exit 1; }
nombre="<nombre>"

san=$(printf '%s' "$nombre" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed -E 's/[^A-Za-z0-9]+/-/g; s/^-+//; s/-+$//; s/.*/\L&/')
[ -n "$san" ] || san="apendice"

capitulos="<ruta>/capitulos"
datos="<ruta>/tarea.typ" # o parte.typ
fichero="$capitulos/$letra-$san.typ"

[ -d "$capitulos" ] || { echo "No existe la carpeta de capítulos"; exit 1; }
for f in "$capitulos/$letra"-*.typ; do
  if [ -e "$f" ]; then
    echo "Ya existe un apéndice con la letra $letra"
    exit 1
  fi
done
if [ -e "$fichero" ]; then
  echo "Ya existe $fichero"
  exit 1
fi

printf '= %s\n\n' "$nombre" > "$fichero"

inc="  #include \"capitulos/$letra-$san.typ\""
if grep -Fq "capitulos/$letra-$san.typ" "$datos"; then
  echo "El apéndice ya está incluido"
else
  if awk -v inc="$inc" '
    BEGIN { hecho=0; en=0; saltar=0 }
    /^#let apendices = none[[:space:]]*\/\*[[:space:]]*\[.*\]\*\/[[:space:]]*$/ {
      print "#let apendices = ["
      print inc
      print "]"
      hecho=1
      next
    }
    /^#let apendices = none[[:space:]]*\/\*[[:space:]]*\[/ {
      print "#let apendices = ["
      print inc
      print "]"
      saltar=1
      hecho=1
      next
    }
    saltar {
      if ($0 ~ /^[[:space:]]*\]\*\/[[:space:]]*$/) {
        saltar=0
      }
      next
    }
    /^#let apendices = none([[:space:]]|$)/ {
      print "#let apendices = ["
      print inc
      print "]"
      hecho=1
      next
    }
    /^#let apendices = \[/ { en=1 }
    en && /^[[:space:]]*\]/ {
      print inc
      print
      en=0
      hecho=1
      next
    }
    { print }
    END { if (!hecho || saltar) exit 1 }
  ' "$datos" > "$datos.tmp"; then
    mv "$datos.tmp" "$datos"
  else
    rm -f "$datos.tmp"
    echo "No se pudo añadir el apéndice a $datos"
    exit 1
  fi
fi
```
