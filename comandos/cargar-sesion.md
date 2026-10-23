---
description: Importa la sesión guardada en .opencode/sesion.json y muestra cómo abrirla.
---

Recupera la sesión guardada en `.opencode/sesion.json`. No hagas un backup nuevo ni borres el fichero.

Si no existe, di que primero hay que ejecutar `/guardar-sesion` y no importes nada.

```bash
set -euo pipefail
test -f .opencode/sesion.json || { echo "No existe .opencode/sesion.json; ejecuta /guardar-sesion primero."; exit 1; }
id=$(jq -er '.info.id' .opencode/sesion.json)
opencode session import .opencode/sesion.json --directory "$PWD"
printf 'Sesión importada: %s\n' "$id"
```

Para entrar en ella, hay que salir de esta sesión y ejecutar:

```bash
opencode --session <id>
```

Usa el ID que has leído del JSON. Si el `import` dice que la sesión ya existe, no pasa nada: ya está en el equipo y se abre con ese mismo ID.
