# Comandos

Esta guía sigue el orden normal de una entrega: preparar el proyecto, crear la estructura, documentar, escribir, revisar y gestionar la sesión. Todos los comandos se lanzan desde la raíz del proyecto y en los ejemplos se usan nombres genéricos (`curso-1`, `ut01`).

## 1. Preparar el proyecto

### `/iniciar-ciclo`

Se ejecuta una vez por proyecto. Comprueba que estén las herramientas obligatorias, copia la plantilla `inicio` a `.typst/` y crea el `.gitignore` y el `AGENTS.md` del proyecto. Pide los datos que falten. Al terminar, si `fish` está instalado y no existe el alias `opencode-fp`, lo crea con `/crear-alias-fish`; si no puede, avisa y sigue, porque el alias es opcional.

## 2. Crear la estructura

### `/crear-curso <curso>`

Crea el curso y su primera unidad (`ut01`) desde las plantillas. Pide el nombre del curso, el del profesor o la profesora y los datos de la primera tarea, incluida la fecha de entrega.

### `/crear-unidad <curso> <ut>`

Añade una unidad de documento único: `documentacion/` y `tarea/typst/`, con `documento.typ`, `tarea.typ`, capítulos, figuras y bibliografía. Pide la documentación y la fecha de entrega.

### `/crear-unidad-particionada <curso> <ut>`

Crea una unidad con la tarea dividida en partes. Pide el número de partes; los datos comunes van en `tarea/.typst/tarea.typ` y cada parte es un proyecto Typst completo en `tarea/partes/pNN/typst/`.

## 3. Preparar la documentación

### `/documentar-unidad <curso> <ut>`

Convierte a `.txt` los PDF de `documentacion/` con `pdftotext`, con nombres saneados. Pregunta si hay que borrar los PDF originales.

## 4. Escribir el contenido

### `/crear-capitulo <curso> <ut> <número> <nombre>`

Crea `capitulos/NN-nombre.typ` con su cabecera y lo registra en la lista `capitulos` de `tarea.typ` o de `parte.typ`. No redacta el contenido.

### `/realizar-capitulo <curso> <ut> <número> [<nombre>]`

Si el capítulo no existe, lo crea y lo redacta entero desde cero con el enunciado y la documentación. Si ya existe, pregunta antes de revisarlo; si aceptas, aplica la revisión de `/revisar-capitulo`.

### `/crear-apendice <curso> <ut> <letra> <nombre>`

Crea `capitulos/<letra>-nombre.typ` y lo añade a `apendices` de `tarea.typ` o de `parte.typ`. La letra no puede repetirse entre los ficheros de `capitulos/`. No redacta el contenido.

### `/crear-referencia <curso> <ut>`

Añade una entrada a `referencias.bib`. Pregunta el tipo, el nombre y los campos; si no se rellenan, los completa con valores de ejemplo. En las `@online`, rellena `urldate` con la fecha de entrega y, si hay `author`, usa llaves dobles. La clave de cita sale del nombre saneado.

## 5. Revisar

### `/revisar-unidad <curso> <ut>`

Revisa todos los capítulos de la unidad y su bibliografía. No acepta un capítulo suelto; para eso está el comando siguiente.

### `/revisar-capitulo <curso> <ut> <capítulo>`

Revisa un solo capítulo. El capítulo puede ser un número (`3` → `03-*.typ`) o el nombre del fichero.

## 6. Sesión

### `/guardar-sesion`

Guarda la sesión actual en `.opencode/sesion.json`, sobrescribiendo el backup anterior. No guarda historial.

### `/cargar-sesion`

Importa la sesión guardada en `.opencode/sesion.json`. Si no existe, avisa y no importa nada.

### `/crear-alias-fish`

Crea el alias de fish `opencode-fp` para abrir el proyecto actual en la sesión actual. Si ya existía, borra su fichero de funciones y lo vuelve a generar con `funcsave`. Necesita `fish` instalado.
