---
description: Crea un curso nuevo desde la plantilla del kit (con su primera unidad de trabajo, ut01).
---

Crea un curso nuevo desde las plantillas del kit.

Abreviación del curso (si falta, pídela): $ARGUMENTS

La abreviación se usa como `<curso>` en todos los comandos y rutas, y es el nombre de la carpeta (`curso-1`, `curso-2`). Sanea ese valor: pásalo a ASCII, minúsculas, cambia espacios y caracteres raros por `-` y quita los guiones sobrantes:

```bash
curso="<curso>"
saneado=$(printf '%s' "$curso" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed -E 's/[^A-Za-z0-9]+/-/g; s/^-+//; s/-+$//; s/.*/\L&/')
```

Si el resultado no coincide con lo que ha escrito el usuario, enséñale las dos versiones y pregúntale si se queda con el saneado o prefiere escribir otro. Si prefiere escribir otro, vuelve a sanearlo. Si queda vacío, pídelo otra vez. No sigas hasta que `<curso>` esté confirmado.

Comprueba que no exista ya el directorio `<curso>/`. Si existe, avisa de que ese curso ya está creado y termina ahí el comando: no sobrescribas nada, no actualices el `AGENTS.md` ni crees la unidad `ut01`.

Antes de crear nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes:

- El nombre completo del curso. Va en `<curso>/.typst/curso.typ` como `nombre` y en la lista del `AGENTS.md`.
- El nombre del profesor o de la profesora (`profesor` o `profesora`; el que no se use queda en `none`).
- Primera tarea (`ut01`), para `<curso>/ut01/tarea/typst/tarea.typ`: `titulo`, `subtitulo` (por ejemplo «TAREA 1»), `dia`, `mes` y `anyo`.

Antes de copiar nada, comprueba que existe el `AGENTS.md` del proyecto y que tiene el apartado `## Ciclo`, o que puedes crearlo con el `ciclo` de `.typst/base.typ`. Si no, para y avisa.

Crea el curso copiando `{{KIT}}/typst/plantillas/curso` al directorio `<curso>` y rellena su `.typst/curso.typ` con el nombre completo y el profesor o la profesora.

Actualiza el apartado `## Ciclo` del `AGENTS.md` del proyecto, con una línea por curso y el formato `- \`<curso>\`: <nombre completo>.`:

- Si ya hay una línea con ese mismo valor de `<curso>`, actualiza el nombre completo si hace falta; no añadas otra línea.
- Si no existe, añade la línea a la lista de cursos, después del resto.
- No cambies el nombre del ciclo ni el resto de líneas.

Si el `AGENTS.md` no tiene el apartado `## Ciclo`, créalo usando el valor de `ciclo` de `.typst/base.typ` y el formato de `{{KIT}}/typst/plantillas/inicio/AGENTS.md`; si falta ese dato, para y avisa. No inventes el nombre del ciclo.

Después crea la primera unidad de trabajo (`ut01`) con los mismos pasos que el comando `/crear-unidad`: copia `{{KIT}}/typst/plantillas/unidad` a `<curso>/ut01`, añade la documentación en `.txt` (con `pdftotext`) y rellena `<curso>/ut01/tarea/typst/tarea.typ`.

Los ficheros de datos se vuelcan en el `thesis.with` de cada `documento.typ`; los parámetros de centro, logo, autor, etc. salen del `.typst/base.typ` de la raíz.
