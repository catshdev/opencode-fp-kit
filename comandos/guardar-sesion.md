---
description: Guarda la sesión actual de opencode en .opencode/sesion.json, sobrescribiendo el backup anterior.
---

Guarda la sesión actual en `.opencode/sesion.json`. No hagas histórico ni copies el fichero a otro sitio: cada vez que se ejecuta, sustituye el anterior.

El ID de la sesión está en `OPENCODE_SESSION_ID`. Exporta a un temporal y muévelo al final para no dejar el backup anterior a medias si algo falla:

```bash
set -euo pipefail
: "${OPENCODE_SESSION_ID:?No hay OPENCODE_SESSION_ID: ejecuta esto dentro de opencode}"
mkdir -p .opencode
tmp=$(mktemp .opencode/.sesion.XXXXXX.json)
trap 'rm -f "$tmp"' EXIT
opencode session export "$OPENCODE_SESSION_ID" > "$tmp"
jq -e '.info.id' "$tmp" >/dev/null
mv "$tmp" .opencode/sesion.json
trap - EXIT
```

Después comprueba el resultado y di la ruta y el tamaño. Si el comando falla, el backup anterior tiene que seguir intacto.
