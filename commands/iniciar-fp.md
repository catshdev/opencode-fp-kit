---
description: Inicia las entregas de un proyecto copiando la plantilla 'inicio' del kit y rellenando sus datos.
---

Prepara el proyecto con la plantilla `inicio` del kit: los ficheros del proyecto Typst van a `.typst/` y el `.gitignore` a la raíz.

Antes de copiar nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes. Son los de `.typst/data.typ`:

- `logo`: el fichero de imagen (dentro de `.typst/logo/`) y su ancho en porcentaje.
- `centro`: el nombre del centro.
- `programa`: el nombre de la formación.
- `autor` o `autora`: el nombre de quien entrega; el que no se use queda en `none`.
- `ubicacion`: la ubicación del centro.

Después ejecuta:

```bash
src={{KIT}}/typst/templates/inicio
mkdir -p .typst
cp -R "$src"/. .typst/
mv .typst/.gitignore ./.gitignore
```

Y rellena `.typst/data.typ` con esos datos: `logo` como `image("logo/<fichero>", width: <ancho>%)`, y `centro`, `programa`, `autor` o `autora` y `ubicacion` como cadenas. Queda además `.typst/lib.typ` (la plantilla `thesis`) y el diccionario `.typst/.aspell.es.pwl`. Si `.typst` o el `.gitignore` ya existen, avisa antes de sobrescribir y espera confirmación.
