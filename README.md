# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

El kit puede estar en cualquier sitio: el plugin se localiza solo por su propia ruta, así que la única ruta al kit que se escribe en el proyecto es la entrada `plugin` del `opencode.json`.

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `commands/*.md`: comandos de opencode: `/iniciar-fp`, `/crear-modulo`, `/crear-unidad`, `/documentar` y `/revisar`.
- `plugin.ts`: plugin de opencode que registra esos comandos, las instrucciones y el LSP de Typst (`tinymist`) en el proyecto, exporta la variable `FP_KIT` (ruta absoluta del kit) a los shells y autoriza la ruta del kit como directorio externo (permiso `external_directory`), para poder leerlo y editarlo desde cualquier proyecto.
- `index.ts`: reexporta `plugin.ts` para que la entrada `plugin` pueda apuntar a la carpeta del kit, no solo al fichero.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario del kit, solo con palabras de la sintaxis de Typst. Cada proyecto añade su vocabulario propio en su `.typst/.aspell.es.pwl`.
- `typst/examples.typ`: ejemplos de tablas de la plantilla (incluido `flex-caption`).
- `typst/templates/`: esqueletos que copian los comandos: `inicio/` (el arranque del proyecto: `lib.typ`, `data.typ`, `logo/` y el diccionario), `modulo/` (los `data.typ` de la asignatura) y `unidad-trabajo/` (una unidad con su proyecto Typst).

## Cómo engancharlo en un proyecto

En el `opencode.json` del proyecto (en la raíz o dentro de `.opencode/`), junto a `$schema`, añade la ruta al kit (la carpeta o el `plugin.ts`):

```json
{
  "plugin": ["{env:HOME}/opencode-fp-kit"]
}
```

La ruta puede ser relativa (respecto al propio `opencode.json`), absoluta o `file://`. La tilde `~` no se expande, así que para el home usa `{env:HOME}` como arriba.

El plugin localiza el kit por su cuenta (por su propia ruta) y lo engancha todo: los comandos (sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que no dependen de dónde esté el proyecto), las instrucciones (`AGENTS.md` del kit) y el LSP `tinymist` para los ficheros `.typ`. El proyecto no necesita declarar nada de eso; si quiere otro LSP, lo declara en su `opencode.json` y el suyo gana. Esa entrada `plugin` es la única ruta al kit que se escribe en el proyecto: lo demás sale de ella. Además, el plugin exporta `FP_KIT` con esa ruta a los shells, para que `AGENTS.md` y el script de revisión no repitan la ruta, y autoriza esa ruta como directorio externo, para no repetir el permiso en cada proyecto.

Reinicia opencode para que tome los cambios y compruébalo con `opencode debug config`: deben aparecer los cuatro comandos, `AGENTS.md` del kit en `instructions` y `lsp.tinymist`.

## Notas

- `FP_KIT` (ruta del kit) está en los shells que abre opencode. Fuera de opencode no existe, así que el script de revisión se lanza con la ruta del kit.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`documentacion/`, `1-descripcion.pdf` o `descripcion.pdf`) son relativas al proyecto; la plantilla se copia desde el kit (`typst/templates/`).
- El kit es el único directorio externo autorizado. Aun así, el agente avisa antes de escribir ahí por iniciativa propia (ver `AGENTS.md`).
