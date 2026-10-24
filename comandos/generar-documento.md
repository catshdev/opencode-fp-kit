---
description: Genera los PDF de una unidad de trabajo a partir de su documento.typ, con el nombre acordado.
---

Genera los PDF de una unidad de trabajo a partir de sus `documento.typ`.

Argumentos: `<curso>`, `<ut>` y el nombre del fichero. Recibido: $ARGUMENTS
Si falta alguno, pídelo. No sanes el nombre: se usa tal cual, con mayúsculas, acentos y guiones.

Antes de compilar, mira qué estructura tiene la unidad:

- Documento único: existe `<curso>/<ut>/tarea/typst/documento.typ`. Genera un solo PDF en `<curso>/<ut>/tarea/<nombre>.pdf`.
- Por partes: no existe el anterior y sí hay `<curso>/<ut>/tarea/partes/p*/typst/documento.typ`. Genera un PDF por cada parte en `<curso>/<ut>/tarea/partes/pNN/<nombre>.pdf`, con el mismo nombre dentro de la carpeta de cada parte. No generes un PDF común.
- Si no hay ninguno, avisa y termina.

Formato del nombre:

- Busca en el `AGENTS.md` del proyecto una línea que empiece por `Formato del nombre del PDF:`. Si existe, usa ese formato como referencia.
- Si no existe, pide el formato al usuario y guárdalo en el `AGENTS.md`: si ya hay un apartado `## Entrega`, añade la línea a su lista; si no, créalo al final. La línea es:

  ```markdown
  ## Entrega

  - Formato del nombre del PDF: `<formato>`
  ```

  No sanes el formato. Un ejemplo es `apellido1_apellido2_nombre_CURSO{numero}_Tarea`, con la abreviatura del curso y el número de la unidad. Si el usuario no da un formato, no sigas. Si no existe el `AGENTS.md`, avisa y termina.
- Pide el nombre del fichero si no lo tienes. Se usa exactamente como lo escriba el usuario, sin sanear. Si no acaba en `.pdf`, añade la extensión y no la dupliques si ya la lleva. Comprueba que sea un nombre de fichero y no una ruta; si queda vacío, pídelo otra vez.

Si ya existe alguno de los PDFs de destino, pregunta si hay que sobrescribirlos; si dice que no, termina.

Compila desde la raíz del proyecto:

```bash
nombre="<nombre>"
case "$nombre" in
  *.pdf) ;;
  *) nombre="$nombre.pdf" ;;
esac

if [ -f "<curso>/<ut>/tarea/typst/documento.typ" ]; then
  typst compile --root . "<curso>/<ut>/tarea/typst/documento.typ" "<curso>/<ut>/tarea/$nombre"
else
  base="<curso>/<ut>/tarea/partes"
  partes=("$base"/p*/typst/documento.typ)
  if [ ! -e "${partes[0]}" ]; then
    echo "No hay ningún documento.typ en la unidad." >&2
    exit 1
  fi
  for documento in "${partes[@]}"; do
    parte="${documento%/typst/documento.typ}"
    typst compile --root . "$documento" "$parte/$nombre"
  done
fi
```

Al terminar, comprueba que cada PDF existe y no está vacío y muestra su ruta. Si `typst` falla en alguna parte, muestra el error y no des esa parte por buena.
