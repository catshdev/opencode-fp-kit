---
description: Inicia las entregas de un proyecto copiando la plantilla 'inicio' del kit y rellenando sus datos.
---

Prepara el proyecto con la plantilla `inicio` del kit: los ficheros del proyecto Typst van a `.typst/`, y el `.gitignore` y el `AGENTS.md` a la raíz.

Antes de pedir datos o copiar nada, valida que el sistema tiene todo lo necesario. Ejecuta esto y, si falla, no continúes: muestra qué falta y espera a que esté instalado.

```bash
set -uo pipefail
faltan=()
for c in opencode typst pdftotext aspell jq gzip git bash cp mkdir mv mktemp cat sort rm basename dirname grep sed awk iconv; do
  command -v "$c" >/dev/null 2>&1 || faltan+=("$c")
done
if [ "${#faltan[@]}" -ne 0 ]; then
  printf 'Faltan herramientas: %s\n' "${faltan[*]}"
  exit 1
fi

if ! aspell dicts 2>/dev/null | grep -qx es; then
  echo "Falta el diccionario español de aspell"
  exit 1
fi

if ! printf 'a\n' | grep -qP 'a'; then
  echo "grep no soporta -P"
  exit 1
fi
```

Antes de copiar nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes. Son los de `.typst/base.typ`:

- `logo`: el fichero de imagen (dentro de `.typst/logo/`) y su ancho en porcentaje.
- `centro`: el nombre del centro.
- `ciclo`: el nombre de la formación.
- `autor` o `autora`: el nombre de quien entrega; el que no se use queda en `none`.
- `ubicacion`: la ubicación del centro.

Y los cursos para el `AGENTS.md` de la raíz: la abreviación y el nombre completo de cada uno.

Después ejecuta:

```bash
src={{KIT}}/typst/plantillas/inicio
mkdir -p .typst
cp -R "$src"/. .typst/
mv .typst/.gitignore ./.gitignore
mv .typst/AGENTS.md ./AGENTS.md
```

Y rellena `.typst/base.typ` con esos datos: `logo` como `image("logo/<fichero>", width: <ancho>%)`, y `centro`, `ciclo`, `autor` o `autora` y `ubicacion` como cadenas. En el `AGENTS.md`, sustituye el ciclo y la lista de cursos por los del proyecto. Queda además `.typst/lib.typ` (la plantilla `thesis`) y el diccionario `.typst/.aspell.es.pwl`. Si `.typst`, el `.gitignore` o el `AGENTS.md` ya existen, avisa antes de sobrescribir y espera confirmación.

Al terminar, si `fish` está instalado, comprueba si existe el alias `opencode-fp` en su directorio de funciones; para localizarlo, usa `fish --no-config -c 'printf %s $__fish_config_dir'` (por defecto, `~/.config/fish/functions/opencode-fp.fish`). Si hay `OPENCODE_SESSION_ID` y el alias no existe, lanza `/crear-alias-fish`: lee `{{KIT}}/comandos/crear-alias-fish.md` y sigue sus instrucciones. Si falta `fish` o `OPENCODE_SESSION_ID`, avisa y no lo crees; el alias es opcional y su fallo no invalida la inicialización.
