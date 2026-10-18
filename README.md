# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

El kit puede estar en cualquier sitio: el plugin se localiza solo por su propia ruta, así que la única ruta al kit que se escribe en el proyecto es la entrada `plugin` del `opencode.json`.

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `commands/*.md`: comandos de opencode: `/crear-modulo`, `/crear-unidad`, `/documentar` y `/revisar`.
- `plugin.ts`: plugin de opencode que registra esos comandos, las instrucciones y el LSP de Typst (`tinymist`) en el proyecto, y exporta la variable `FP_KIT` (ruta absoluta del kit) a los shells.
- `index.ts`: reexporta `plugin.ts` para que la entrada `plugin` pueda apuntar a la carpeta del kit, no solo al fichero.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario del kit, solo con palabras de la sintaxis de Typst. Cada proyecto añade su vocabulario propio en su `typst/.aspell.es.pwl`.

## Cómo engancharlo en un proyecto

En el `opencode.json` del proyecto, junto a `$schema`, añade la ruta al kit (la carpeta o el `plugin.ts`):

```json
{
  "plugin": ["{env:HOME}/opencode-fp-kit"]
}
```

La ruta puede ser relativa (respecto al propio `opencode.json`), absoluta o `file://`. La tilde `~` no se expande, así que para el home usa `{env:HOME}` como arriba.

El plugin localiza el kit por su cuenta (por su propia ruta) y lo engancha todo: los comandos (sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que no dependen de dónde esté el proyecto), las instrucciones (`AGENTS.md` del kit) y el LSP `tinymist` para los ficheros `.typ`. El proyecto no necesita declarar nada de eso; si quiere otro LSP, lo declara en su `opencode.json` y el suyo gana. Esa entrada `plugin` es la única ruta al kit que se escribe en el proyecto: lo demás sale de ella. Además, el plugin exporta `FP_KIT` con esa ruta a los shells, para que `AGENTS.md` y el script de revisión no repitan la ruta.

Reinicia opencode para que tome los cambios y compruébalo con `opencode debug config`: deben aparecer los cuatro comandos, `AGENTS.md` del kit en `instructions` y `lsp.tinymist`.

## Notas

- `FP_KIT` (ruta del kit) está en los shells que abre opencode. Fuera de opencode no existe, así que el script de revisión se lanza con la ruta del kit.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`README.md`, `_plantilla`, `documentacion/`, `1_descripcion.pdf`) son relativas al proyecto.
