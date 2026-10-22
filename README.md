# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

El kit puede estar en cualquier sitio: el plugin se localiza solo por su propia ruta, así que las únicas rutas al kit que se escriben en el proyecto son las del `opencode.json` (el plugin y sus instrucciones).

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `commands/*.md`: comandos de opencode: `/iniciar-fp`, `/crear-modulo`, `/crear-unidad`, `/documentar` y `/revisar`.
- `plugin.ts`: plugin de opencode que registra esos comandos y exporta la variable `FP_KIT` (ruta absoluta del kit) a los shells. El LSP de Typst (`tinymist`) se resuelve en el editor (o con `tinymist` a mano) y el permiso `external_directory` se declara en el `opencode.json` del proyecto.
- `index.ts`: reexporta `plugin.ts` como exportación por defecto, que es la entrada que carga opencode.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario del kit, solo con palabras de la sintaxis de Typst. Cada proyecto añade su vocabulario propio en su `.typst/.aspell.es.pwl`.
- `typst/examples.typ`: ejemplos de tablas de la plantilla (incluido `flex-caption`).
- `typst/templates/`: esqueletos que copian los comandos: `inicio/` (el arranque del proyecto: los ficheros de `.typst/` más el `.gitignore` y el `AGENTS.md`), `modulo/` (los `data.typ` de la asignatura) y `unidad-trabajo/` (una unidad con su proyecto Typst).

## Cómo engancharlo en un proyecto

Crea el `opencode.json` del proyecto (en la raíz o dentro de `.opencode/`) con la ruta al kit en `plugins` y el `AGENTS.md` del kit en `instructions`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugins": [
    "{env:HOME}/path-to/opencode-fp-kit"
  ],
  "instructions": [
    "{env:HOME}/path-to/opencode-fp-kit/AGENTS.md"
  ],
  "permissions": [
    { "action": "external_directory", "resource": "*", "effect": "deny" },
    { "action": "external_directory", "resource": "~/path-to/opencode-fp-kit/*", "effect": "ask" }
  ]
}
```

Uso de permisos más permisivos para desarrollar a la vez sobre el kit:

```json
{
  "permissions": [
    { "action": "external_directory", "resource": "*", "effect": "ask" },
    { "action": "external_directory", "resource": "~/path-to/opencode-fp-kit/*", "effect": "allow" }
  ]
}
```

La ruta puede ser relativa (respecto al propio `opencode.json`), absoluta o `file://`; también se admite `~/` para el home. En el ejemplo se usa `{env:HOME}`, que funciona igual en `plugins` y en `instructions`.

El plugin localiza el kit por su cuenta (por su propia ruta) y registra los comandos (sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que no dependen de dónde esté el proyecto). El proyecto solo tiene que declarar el plugin, las instrucciones y el permiso del kit. Además, el plugin exporta `FP_KIT` con esa ruta a los shells, para que `AGENTS.md` y el script de revisión no repitan la ruta.

Las instrucciones van en `instructions`, y el permiso del kit en `permissions`: la primera regla pide permiso para cualquier directorio externo y la segunda autoriza el kit. Si no quieres que te pregunte por el resto de rutas externas, quita la primera regla.

Reinicia opencode para que tome los cambios y compruébalo con `opencode plugin list` (debe aparecer la ruta del kit) y con el log (`~/.local/share/opencode/log/opencode.log`), donde no debe salir `failed to load plugin`.

## Notas

- `FP_KIT` (ruta del kit) está en los shells que abre opencode. Fuera de opencode no existe, así que el script de revisión se lanza con la ruta del kit.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`documentacion/`, `1-descripcion.pdf` o `descripcion.pdf`) son relativas al proyecto; la plantilla se copia desde el kit (`typst/templates/`).
- El kit es el único directorio externo autorizado por la configuración de ejemplo. Aun así, el agente avisa antes de escribir ahí por iniciativa propia (ver `AGENTS.md`).
- Para diagnósticos de Typst, usa el LSP de tu editor o ejecuta `tinymist` a mano.
