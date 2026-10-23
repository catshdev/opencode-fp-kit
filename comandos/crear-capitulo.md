---
description: Crea un capítulo nuevo en una unidad y lo añade a la lista de capítulos de su tarea.
---

Crea un capítulo nuevo en una unidad.

Argumentos: `<curso>`, `<ut>`, `<número>` y `<nombre>`. Recibido: $ARGUMENTS
Si falta alguno, pídelo. El número tiene que ser entero (`3` se convierte en `03`).

Comprueba que existe `<curso>/<ut>`. Si no existe, para y avisa.

Localiza el proyecto Typst de la unidad:

- Si existe `<curso>/<ut>/tarea/typst/capitulos/`, es una tarea de documento único y los datos están en `<curso>/<ut>/tarea/typst/tarea.typ`.
- Si existen `<curso>/<ut>/tarea/partes/p*/typst/capitulos/`, es una tarea por partes. Si hay más de una parte, pregunta en qué parte va el capítulo; los datos de esa parte están en su `parte.typ`.

Si hay ambas estructuras, pregunta cuál usar. Si no encuentras ninguna, para y avisa.

En la carpeta `capitulos/` elegida, comprueba que no exista ningún fichero cuyo nombre empiece por `<NN>-`. Si ya hay uno, para y avisa; no sobrescribas nada.

Sanitiza el nombre para el fichero: pásalo a ASCII, cambia espacios y caracteres raros por `-`, quita los guiones sobrantes y pásalo a minúsculas. Si queda vacío, usa `capitulo`. El fichero será `capitulos/<NN>-<nombre-saneado>.typ`.

Crea el fichero con una cabecera `= <nombre>` y una línea en blanco. Después añade al final de la lista `capitulos` del `tarea.typ` o del `parte.typ` elegido esta línea, con la misma indentación que las demás:

```typ
  #include "capitulos/<NN>-<nombre-saneado>.typ"
```

No dupliques la línea si ya existe. Si el fichero de datos no tiene una lista `#let capitulos = [`, no lo modifiques a ciegas: avisa y deja el capítulo creado sin incluir.

Puedes usar este bloque como guía, sustituyendo los valores entre `<>`:

```bash
numero="<número>"
nombre="<nombre>"
[[ "$numero" =~ ^[0-9]+$ ]] || { echo "El número de capítulo no es válido"; exit 1; }
printf -v num '%02d' "$((10#$numero))"

san=$(printf '%s' "$nombre" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed -E 's/[^A-Za-z0-9]+/-/g; s/^-+//; s/-+$//; s/.*/\L&/')
[ -n "$san" ] || san="capitulo"

capitulos="<ruta>/capitulos"
datos="<ruta>/tarea.typ" # o parte.typ
fichero="$capitulos/$num-$san.typ"

[ -d "$capitulos" ] || { echo "No existe la carpeta de capítulos"; exit 1; }
for f in "$capitulos/$num"-*.typ; do
  if [ -e "$f" ]; then
    echo "Ya existe un capítulo con el número $num"
    exit 1
  fi
done
if [ -e "$fichero" ]; then
  echo "Ya existe $fichero"
  exit 1
fi

printf '= %s\n\n' "$nombre" > "$fichero"

grep -q '^#let capitulos = \[' "$datos" || { echo "No encuentro la lista de capítulos en $datos"; exit 1; }
inc="  #include \"capitulos/$num-$san.typ\""
if grep -Fqx "$inc" "$datos"; then
  echo "El capítulo ya está incluido"
else
  if awk -v inc="$inc" '
    /#let capitulos = \[/ { en=1 }
    en && /^[[:space:]]*\]/ { print inc; print; en=0; next }
    { print }
  ' "$datos" > "$datos.tmp"; then
    mv "$datos.tmp" "$datos"
  else
    rm -f "$datos.tmp"
    echo "No se pudo añadir el capítulo a $datos"
    exit 1
  fi
fi
```
