---
description: Crea un alias de fish para reabrir el proyecto actual en la sesión actual.
---

Crea el alias de fish `opencode-fp` para abrir el proyecto actual en la sesión actual.

Comprueba que existe `OPENCODE_SESSION_ID`; si no, para y avisa de que el comando tiene que ejecutarse dentro de opencode. Comprueba también que `fish` está instalado.

Borra el alias anterior si existe y genera el nuevo con la ruta actual y el ID de la sesión:

```bash
set -euo pipefail
: "${OPENCODE_SESSION_ID:?No hay OPENCODE_SESSION_ID: ejecuta esto dentro de opencode}"
command -v fish >/dev/null 2>&1 || { echo "Falta fish"; exit 1; }

config=$(fish --no-config -c 'printf %s $__fish_config_dir')
[ -n "$config" ] || config="$HOME/.config/fish"
funcion="$config/functions/opencode-fp.fish"

rm -f "$funcion"
mkdir -p "$config/functions"

fish --no-config -c 'set ruta (string escape -- $argv[1]); set sesion (string escape -- $argv[2]); alias opencode-fp "opencode reload >/dev/null 2>&1; opencode $ruta -s $sesion"; funcsave opencode-fp' -- "$PWD" "$OPENCODE_SESSION_ID"

test -f "$funcion"
printf 'Alias creado en %s\n' "$funcion"
```

El alias recarga la configuración antes de abrir, así que los comandos nuevos están disponibles al volver a entrar. Muestra el contenido del fichero. Indica que el alias ya funciona en una fish nueva; si hay una fish abierta, hay que cargar el fichero o abrir otra shell.
