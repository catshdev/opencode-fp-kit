---
description: Inicia las entregas de un proyecto copiando la plantilla 'inicio' del kit.
---

Prepara el proyecto con la plantilla `inicio` del kit: los ficheros del proyecto Typst van a `.typst/` y el `.gitignore` a la raíz. Ejecuta:

```bash
src={{KIT}}/typst/templates/inicio
mkdir -p .typst
cp -R "$src"/. .typst/
mv .typst/.gitignore ./.gitignore
```

Queda `.typst/lib.typ` (la plantilla `thesis`), `.typst/data.typ` (datos del centro y del autor), `.typst/logo/` y el diccionario `.typst/.aspell.es.pwl`; el `.gitignore` en la raíz (ignora los PDF compilados salvo los enunciados). Los valores de `.typst/data.typ` (`logo`, `centro`, `programa`, `autor`, `autora`, `ubicacion`) se ajustan después al proyecto. Si `.typst` o el `.gitignore` ya existen, avisa antes de sobrescribir y espera confirmación.
