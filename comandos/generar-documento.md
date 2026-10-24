---
description: Genera el PDF de una unidad de trabajo desde su documento.typ, con el nombre acordado.
---

Genera el PDF de una unidad de trabajo de documento único a partir de `<curso>/<ut>/tarea/typst/documento.typ`.

Argumentos: `<curso>`, `<ut>` y el nombre del fichero. Recibido: $ARGUMENTS
Si falta alguno, pídelo. No sanes el nombre: se usa tal cual, con mayúsculas, acentos y guiones.

Antes de compilar, comprueba que existe `<curso>/<ut>/tarea/typst/documento.typ`. Si no existe, avisa y termina: este comando no sirve para las tareas por partes, que tienen su `documento.typ` en `tarea/partes/pNN/typst/`.

Formato del nombre:

- Busca en el `AGENTS.md` del proyecto una línea que empiece por `Formato del nombre del PDF:`. Si existe, usa ese formato como referencia.
- Si no existe, pide el formato al usuario y guárdalo en el `AGENTS.md`: si ya hay un apartado `## Entrega`, añade la línea a su lista; si no, créalo al final. La línea es:

  ```markdown
  ## Entrega

  - Formato del nombre del PDF: `<formato>`
  ```

  No sanes el formato. Un ejemplo es `apellido1_apellido2_nombre_CURSO{numero}_Tarea`, con la abreviatura del curso y el número de la unidad. Si el usuario no da un formato, no sigas. Si no existe el `AGENTS.md`, avisa y termina.
- Pide el nombre del fichero si no lo tienes. Se usa exactamente como lo escriba el usuario, sin sanear. Si no acaba en `.pdf`, añade la extensión y no la dupliques si ya la lleva. Comprueba que sea un nombre de fichero y no una ruta; si queda vacío, pídelo otra vez.

Si ya existe el PDF de destino, pregunta si hay que sobrescribirlo; si dice que no, termina.

Compila desde la raíz del proyecto:

```bash
nombre="<nombre>"
case "$nombre" in
  *.pdf) ;;
  *) nombre="$nombre.pdf" ;;
esac
destino="<curso>/<ut>/tarea/$nombre"

typst compile --root . "<curso>/<ut>/tarea/typst/documento.typ" "$destino"
```

Al terminar, comprueba que el PDF existe y no está vacío y muestra su ruta. Si `typst` falla, muestra el error y no des la generación por buena.
