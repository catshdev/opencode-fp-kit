---
description: Guarda la sesión actual de opencode comprimida en .opencode/sesion.json.gz, sobrescribiendo el backup anterior.
---

Guarda la sesión actual en `.opencode/sesion.json.gz`. No hagas histórico ni copies el fichero a otro sitio: cada vez que se ejecuta, sustituye el anterior. Deja solo el fichero comprimido; si queda un `.opencode/sesion.json` antiguo, bórralo cuando el nuevo backup esté listo.

El ID de la sesión está en `OPENCODE_SESSION_ID`. Exporta a un temporal, valida, comprime y mueve al final para no dejar el backup anterior a medias si algo falla:

```bash
set -euo pipefail
: "${OPENCODE_SESSION_ID:?No hay OPENCODE_SESSION_ID: ejecuta esto dentro de opencode}"
mkdir -p .opencode
tmp_json=$(mktemp .opencode/.sesion.XXXXXX.json)
tmp_gz="$tmp_json.gz"
trap 'rm -f "$tmp_json" "$tmp_gz"' EXIT

opencode session export "$OPENCODE_SESSION_ID" > "$tmp_json"
jq -e '.info.id' "$tmp_json" >/dev/null

gzip -9 -c "$tmp_json" > "$tmp_gz"
chmod 600 "$tmp_gz"
gzip -t "$tmp_gz"
gzip -dc "$tmp_gz" | jq -e '.info.id' >/dev/null

mv "$tmp_gz" .opencode/sesion.json.gz
rm -f .opencode/sesion.json "$tmp_json"
trap - EXIT
```

Después comprueba el resultado y di la ruta y el tamaño. Si el comando falla, el backup anterior tiene que seguir intacto.
