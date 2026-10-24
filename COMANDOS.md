# Comandos

Esta guía sigue el orden normal de una entrega: preparar el proyecto, crear la estructura, documentar, escribir, revisar, generar los PDF y gestionar la sesión. Todos los comandos se lanzan desde la raíz del proyecto y en los ejemplos se usan nombres genéricos (`curso-1`, `ut01`).

En cada comando se indica la plantilla que se copia o se toma como referencia; si no usa ninguna, se dice.

Los comandos se cargan al arrancar el servicio de opencode. Si cambias un fichero de `comandos/`, ejecuta `opencode reload`; cerrar y abrir la TUI no recarga el servicio.

## 1. Preparar el proyecto

### `/iniciar-ciclo`

Plantilla: [`typst/plantillas/inicio`](typst/plantillas/inicio/).

Se ejecuta una vez por proyecto. Comprueba que estén las herramientas obligatorias, copia la plantilla `inicio` a `.typst/` y crea el `.gitignore` y el `AGENTS.md` del proyecto. Pide los datos que falten. Al terminar, si `fish` está instalado y no existe el alias `opencode-fp`, lo crea con `/crear-alias-fish`; si no puede, avisa y sigue, porque el alias es opcional.

## 2. Crear la estructura

### `/crear-curso <curso>`

Plantillas: [`typst/plantillas/curso`](typst/plantillas/curso/) y [`typst/plantillas/unidad`](typst/plantillas/unidad/), esta última para `ut01`.

Crea el curso y su primera unidad (`ut01`) desde las plantillas. Pide la abreviación del curso, la sanea y la confirma antes de usarla como `<curso>`; después pide el nombre completo, el del profesor o la profesora y los datos de la primera tarea, incluida la fecha de entrega. Añade o actualiza el curso en el apartado `Ciclo` del `AGENTS.md` del proyecto.

### `/crear-unidad <curso> <ut>`

Plantilla: [`typst/plantillas/unidad`](typst/plantillas/unidad/).

Añade una unidad de documento único: `documentacion/` y `tarea/typst/`, con `documento.typ`, `tarea.typ`, capítulos, figuras y bibliografía. Pide la documentación y la fecha de entrega.

### `/crear-unidad-particionada <curso> <ut>`

Plantilla: [`typst/plantillas/unidad-particionada`](typst/plantillas/unidad-particionada/).

Crea una unidad con la tarea dividida en partes. Pide el número de partes; los datos comunes van en `tarea/.typst/tarea.typ` y cada parte es un proyecto Typst completo en `tarea/partes/pNN/typst/`.

## 3. Preparar la documentación

### `/documentar-unidad <curso> <ut>`

Plantilla: ninguna.

Convierte a `.txt` los PDF de `documentacion/` con `pdftotext`, con nombres saneados. Pregunta si hay que borrar los PDF originales.

## 4. Escribir el contenido

### `/crear-capitulo <curso> <ut> <número> <nombre>`

Plantilla: ninguna (cabecera vacía).

Crea `capitulos/NN-nombre.typ` con su cabecera y lo registra en la lista `capitulos` de `tarea.typ` o de `parte.typ`. No redacta el contenido.

### `/realizar-capitulo <curso> <ut> <número> [<nombre>]`

Plantilla: ninguna; reutiliza `/crear-capitulo` y `/revisar-capitulo`.

Si el capítulo no existe, lo crea y lo redacta entero desde cero con el enunciado y la documentación. Si ya existe, pregunta antes de revisarlo; si aceptas, aplica la revisión de `/revisar-capitulo`.

### `/crear-apendice <curso> <ut> <letra> <nombre>`

Plantilla: ninguna (cabecera vacía).

Crea `capitulos/<letra>-nombre.typ` y lo añade a `apendices` de `tarea.typ` o de `parte.typ`. La letra no puede repetirse entre los ficheros de `capitulos/`. No redacta el contenido.

### `/crear-referencia <curso> <ut>`

Plantilla: ninguna; toma como referencia [`typst/plantillas/unidad/tarea/typst/referencias.bib`](typst/plantillas/unidad/tarea/typst/referencias.bib).

Añade una entrada a `referencias.bib`. Pregunta el tipo, el nombre y los campos; si no se rellenan, los completa con valores de ejemplo. En las `@online`, rellena `urldate` con la fecha de entrega y, si hay `author`, usa llaves dobles. La clave de cita sale del nombre saneado.

## 5. Revisar

### `/revisar-unidad <curso> <ut>`

Plantilla: ninguna; usa [`typst/revisar.sh`](typst/revisar.sh).

Revisa todos los capítulos de la unidad y su bibliografía. No acepta un capítulo suelto; para eso está el comando siguiente.

### `/revisar-capitulo <curso> <ut> <capítulo>`

Plantilla: ninguna; usa [`typst/revisar.sh`](typst/revisar.sh).

Revisa un solo capítulo. El capítulo puede ser un número (`3` → `03-*.typ`) o el nombre del fichero.

## 6. Generar las entregas

### `/generar-entrega <curso> <ut> [<patrón>]`

Plantilla: ninguna.

Genera los PDF de una unidad a partir de su `documento.typ` y los deja en `<curso>/<ut>/entrega/`, creando la carpeta si no existe. Si es de documento único, genera un PDF; si va por partes, genera uno por cada `partes/pNN/typst/documento.typ` en la misma carpeta, con el número de parte en el nombre. Consulta el apartado `Entrega` del `AGENTS.md`; elige el patrón de documento único o por partes y, si hay varios del mismo tipo, pregunta cuál usar por su número. Si falta, lo pide y lo guarda, sin deducirlo de otro curso. El patrón de documento único debe incluir `{unidad}` y el de partes, `{unidad}` y `{parte}`. No sanea el patrón.

## 7. Sesión

### `/guardar-sesion`

Plantilla: ninguna.

Guarda la sesión actual comprimida en `.opencode/sesion.json.gz`, sobrescribiendo el backup anterior y sin dejar el `.json` antiguo. No guarda historial.

### `/cargar-sesion`

Plantilla: ninguna.

Importa la sesión guardada en `.opencode/sesion.json.gz`; la descomprime en un temporal y la importa. Si aún existe un `.opencode/sesion.json` antiguo, también lo acepta. Si no hay ninguno, avisa y no importa nada.

### `/crear-alias-fish`

Plantilla: ninguna.

Crea el alias de fish `opencode-fp` para abrir el proyecto actual en la sesión actual. El alias recarga la configuración antes de abrir, para que los comandos nuevos estén disponibles. Si ya existía, borra su fichero de funciones y lo vuelve a generar con `funcsave`. Necesita `fish` instalado.
