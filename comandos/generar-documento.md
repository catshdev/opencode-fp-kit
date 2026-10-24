---
description: Genera los PDF de una unidad de trabajo a partir de los documento.typ y los deja en la carpeta entrega.
---

Genera los PDF de una unidad de trabajo a partir de sus `documento.typ` y los guarda en `<curso>/<ut>/entrega/`.

Argumentos: `<curso>`, `<ut>` y, si se indica, `<nombre>`. Recibido: $ARGUMENTS
Si faltan el curso o la unidad, pídelos. El nombre no se sanea: se usa tal cual, con mayúsculas, acentos y guiones. Si no se indica, se compone con el formato del curso.

Antes de compilar, mira qué estructura tiene la unidad:

- Documento único: existe `<curso>/<ut>/tarea/typst/documento.typ`. Genera un solo PDF en `<curso>/<ut>/entrega/<nombre>.pdf`.
- Por partes: no existe el anterior y sí hay `<curso>/<ut>/tarea/partes/p*/typst/documento.typ`. Genera un PDF por cada parte en la misma carpeta `<curso>/<ut>/entrega/`, con el nombre base y el sufijo `_pNN` (por ejemplo, `<nombre>_p01.pdf`). No generes un PDF común.
- Si no hay ninguno, avisa y termina.

Formato del nombre:

- Busca en el `AGENTS.md` del proyecto el apartado `## Entrega` y la línea del curso, con el formato `- \`<curso>\`: \`<formato>\``.
- Si no existe la línea del curso, pide el formato al usuario y añádelo a la lista del apartado `## Entrega`; si no existe el apartado, créalo al final con esta presentación y la lista:

  ```markdown
  ## Entrega

  Las entregas son los PDF de cada unidad de trabajo. Se guardan en la carpeta `entrega` de la unidad y siguen el formato de nombre de cada curso:

  - `<curso>`: `<formato>`
  ```

  No sanes el formato. Un ejemplo es `apellido1_apellido2_nombre_CURSO{numero}_Tarea`, con la abreviatura del curso y el número de la unidad. Si el usuario no da un formato, no sigas. Si no existe el `AGENTS.md`, avisa y termina.
- Compón el nombre con ese formato, sustituyendo `{numero}` por el número de la unidad a dos dígitos (`ut01` → `01`). Si el usuario ha dado un nombre, úsalo como base tal cual en lugar de componerlo.
- Si el nombre acaba en `.pdf`, quita la extensión antes de montar las rutas; al final se añade una sola vez.

Crea la carpeta de entrega si no existe:

```bash
mkdir -p "<curso>/<ut>/entrega"
```

Si ya existe alguno de los PDFs de destino, pregunta si hay que sobrescribirlos; si dice que no, termina.

Compila desde la raíz del proyecto:

```bash
curso="<curso>"
ut="<ut>"
nombre="<nombre>"
formato="<formato del curso>"

ut_num="${ut#ut}"
ut_num=$(printf '%02d' "$((10#$ut_num))")

if [ -z "$nombre" ]; then
  nombre="${formato//\{numero\}/$ut_num}"
  nombre="${nombre//\{curso\}/$curso}"
fi
nombre="${nombre%.pdf}"

if [ -f "$curso/$ut/tarea/typst/documento.typ" ]; then
  typst compile --root . "$curso/$ut/tarea/typst/documento.typ" "$curso/$ut/entrega/$nombre.pdf"
else
  partes=("$curso/$ut/tarea/partes"/p*/typst/documento.typ)
  if [ ! -e "${partes[0]}" ]; then
    echo "No hay ningún documento.typ en la unidad." >&2
    exit 1
  fi
  for documento in "${partes[@]}"; do
    parte="${documento%/typst/documento.typ}"
    parte="${parte##*/}"
    typst compile --root . "$documento" "$curso/$ut/entrega/${nombre}_${parte}.pdf"
  done
fi
```

Al terminar, comprueba que cada PDF existe y no está vacío y muestra su ruta. Si `typst` falla en alguna parte, muestra el error y no des esa parte por buena.
