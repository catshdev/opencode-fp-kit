---
description: Genera los PDF de una unidad de trabajo y los deja en la carpeta entrega.
---

Genera los PDF de una unidad de trabajo a partir de sus `documento.typ` y los guarda en `<curso>/<ut>/entrega/`.

Argumentos: `<curso>`, `<ut>` y, si se indica, `<patrón>`. Recibido: $ARGUMENTS
Si faltan el curso o la unidad, pídelos. El patrón no se sanea: se usa tal cual. Si no se indica, se toma del apartado `## Entrega` del `AGENTS.md`.

Antes de compilar, mira qué estructura tiene la unidad:

- Documento único: existe `<curso>/<ut>/tarea/typst/documento.typ`. Genera un solo PDF en `<curso>/<ut>/entrega/<nombre>.pdf`.
- Por partes: no existe el anterior y sí hay `<curso>/<ut>/tarea/partes/p*/typst/documento.typ`. Genera un PDF por cada parte en la misma carpeta `<curso>/<ut>/entrega/`. Cada parte tiene que llevar su número en el nombre.
- Si no hay ninguno, avisa y termina.

Patrón del nombre:

- Busca en el `AGENTS.md` del proyecto el apartado `## Entrega`. Si no existe el `AGENTS.md`, avisa y termina. Si existe el fichero pero no el apartado, créalo al final con esta cabecera:

  ```markdown
  ## Entrega

  Las entregas son los PDF de cada unidad de trabajo. Se guardan en la carpeta `entrega` de la unidad. Los formatos se documentan por curso, numerados, y pueden ser distintos para documento único y para tareas por partes. En los patrones, `{unidad}` es el número de la unidad y `{parte}` el de la parte.
  ```

- Dentro del apartado, busca el bloque del curso. Tiene esta forma:

  ```markdown
  - `<curso>`:
    1. Documento único: `apellido1_apellido2_nombre_CURSO_Tarea{unidad}`
    2. Por partes: `apellido1_apellido2_nombre_CURSO_Tarea{unidad}_Parte{parte}`
  ```

  Los números son por curso. Cada línea indica el tipo. Puede haber varios patrones del mismo tipo si en otra unidad cambió el formato.
- No deduzcas el patrón de otro curso ni de otro tipo.
- Del bloque del curso, usa solo los del tipo que toca:
  - Documento único: las líneas `Documento único`.
  - Por partes: las líneas `Por partes`.
- Si el bloque del curso no existe, créalo con `- \`<curso>\`:` y el patrón que te dé el usuario en una línea numerada del tipo que toca. Si existe pero no hay ninguno del tipo, pide el patrón y añádelo con el siguiente número, con la etiqueta `Documento único` o `Por partes`.
- Si hay varios del mismo tipo, muéstralos con su número y pregunta cuál prefiere; no elijas por tu cuenta.
- El patrón de documento único debe llevar `{unidad}`. El de partes debe llevar `{unidad}` y `{parte}`. Si no, pide uno válido.
- Si el usuario ha dado `<patrón>`, úsalo tal cual en vez del documentado; también tiene que llevar los marcadores que toquen.
- Sustituye `{unidad}` por la unidad a dos dígitos (`ut01` → `01`) y `{parte}` por la parte a dos dígitos (`p01` → `01`).
- Si el patrón acaba en `.pdf`, quita la extensión antes de montar la ruta; al final se añade una sola vez.

Crea la carpeta de entrega si no existe:

```bash
mkdir -p "<curso>/<ut>/entrega"
```

Si ya existe alguno de los PDFs de destino, pregunta si hay que sobrescribirlos; si dice que no, termina.

Compila desde la raíz del proyecto:

```bash
curso="<curso>"
ut="<ut>"
patron="<patrón>"

ut_num="${ut#ut}"
ut_num=$(printf '%02d' "$((10#$ut_num))")
patron="${patron%.pdf}"

if [ -f "$curso/$ut/tarea/typst/documento.typ" ]; then
  nombre="${patron//\{unidad\}/$ut_num}"
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
    parte_num="${parte#p}"
    parte_num=$(printf '%02d' "$((10#$parte_num))")
    nombre="${patron//\{unidad\}/$ut_num}"
    nombre="${nombre//\{parte\}/$parte_num}"
    typst compile --root . "$documento" "$curso/$ut/entrega/$nombre.pdf"
  done
fi
```

Al terminar, comprueba que cada PDF existe y no está vacío y muestra su ruta. Si `typst` falla en alguna parte, muestra el error y no des esa parte por buena.
