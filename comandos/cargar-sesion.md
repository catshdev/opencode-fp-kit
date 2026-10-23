---
description: Importa la sesión guardada y comprimida en .opencode/sesion.json.gz y muestra cómo abrirla.
---

Recupera la sesión guardada en `.opencode/sesion.json.gz`. No hagas un backup nuevo ni borres el fichero.

Si no existe `.opencode/sesion.json.gz` ni un `.opencode/sesion.json` antiguo, di que primero hay que ejecutar `/guardar-sesion` y no importes nada. Si solo queda el `.json` antiguo, se importa igual y se avisa de que conviene volver a guardar para comprimirlo.

`opencode session import` no acepta `.gz` directamente, así que descomprime el backup a un temporal y lo importa:

```bash
set -euo pipefail
origen=.opencode/sesion.json.gz
if [ ! -f "$origen" ]; then
  if [ -f .opencode/sesion.json ]; then
    origen=.opencode/sesion.json
    echo "Aviso: el backup está sin comprimir; se importa igual. Vuelve a ejecutar /guardar-sesion para comprimirlo."
  else
    echo "No existe .opencode/sesion.json.gz; ejecuta /guardar-sesion primero."
    exit 1
  fi
fi

tmp=$(mktemp .opencode/.sesion.XXXXXX.json)
trap 'rm -f "$tmp"' EXIT
case "$origen" in
  *.gz) gzip -dc "$origen" > "$tmp" ;;
  *) cp "$origen" "$tmp" ;;
esac
jq -e '.info.id' "$tmp" >/dev/null
id=$(jq -r '.info.id' "$tmp")
opencode session import "$tmp" --directory "$PWD"
printf 'Sesión importada: %s\n' "$id"
```

Para entrar en ella, hay que salir de esta sesión y ejecutar:

```bash
opencode --session <id>
```

Usa el ID que has leído del JSON. Si el `import` dice que la sesión ya existe, no pasa nada: ya está en el equipo y se abre con ese mismo ID.
