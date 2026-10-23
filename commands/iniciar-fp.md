---
description: Inicia las entregas de un proyecto copiando la plantilla 'inicio' del kit y rellenando sus datos.
---

Prepara el proyecto con la plantilla `inicio` del kit: los ficheros del proyecto Typst van a `.typst/`, y el `.gitignore` y el `AGENTS.md` a la raíz.

Antes de copiar nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes. Son los de `.typst/base.typ`:

- `logo`: el fichero de imagen (dentro de `.typst/logo/`) y su ancho en porcentaje.
- `centro`: el nombre del centro.
- `curso`: el nombre de la formación.
- `autor` o `autora`: el nombre de quien entrega; el que no se use queda en `none`.
- `ubicacion`: la ubicación del centro.

Y los módulos para el `AGENTS.md` de la raíz: el código de cada uno y su asignatura.

Después ejecuta:

```bash
src={{KIT}}/typst/plantillas/inicio
mkdir -p .typst
cp -R "$src"/. .typst/
mv .typst/.gitignore ./.gitignore
mv .typst/AGENTS.md ./AGENTS.md
```

Y rellena `.typst/base.typ` con esos datos: `logo` como `image("logo/<fichero>", width: <ancho>%)`, y `centro`, `curso`, `autor` o `autora` y `ubicacion` como cadenas. En el `AGENTS.md`, sustituye el ciclo y la lista de módulos por los del proyecto. Queda además `.typst/lib.typ` (la plantilla `thesis`) y el diccionario `.typst/.aspell.es.pwl`. Si `.typst`, el `.gitignore` o el `AGENTS.md` ya existen, avisa antes de sobrescribir y espera confirmación.
