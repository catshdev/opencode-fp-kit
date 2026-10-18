---
description: Inicia las entregas de un proyecto copiando la plantilla 'inicio' del kit a .typst.
---

Copia la plantilla `inicio` del kit al directorio `.typst` del proyecto, tal cual, sin renombrar ni transformar nada. Ejecuta:

```bash
mkdir -p .typst
cp -R {{KIT}}/typst/templates/inicio/. .typst/
```

Queda `.typst/lib.typ` (la plantilla `thesis`), `.typst/data.typ` (datos del centro y del autor), `.typst/logo/` y el diccionario `.typst/.aspell.es.pwl`. Los valores de `.typst/data.typ` (`logo`, `centro`, `programa`, `autor`, `autora`, `ubicacion`) se ajustan después al proyecto. Si `.typst` ya existe con contenido, avisa antes de sobrescribir y espera confirmación.
