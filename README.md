# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

Está pensado para vivir como repo hermano del proyecto: `../opencode-fp-kit`.

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `commands/*.md`: comandos de opencode: `/crear-modulo`, `/crear-unidad`, `/documentar` y `/revisar`.
- `plugin.ts`: plugin de opencode que registra esos comandos y el LSP de Typst (`tinymist`) en el proyecto.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario del kit, solo con palabras de la sintaxis de Typst. Cada proyecto añade su vocabulario propio en su `typst/.aspell.es.pwl`.

## Cómo engancharlo en un proyecto

En el `opencode.json` del proyecto, junto a `$schema`, añade:

```json
{
  "plugin": ["../opencode-fp-kit/plugin.ts"]
}
```

El plugin localiza el kit por su cuenta y lo engancha todo: los comandos (sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que no dependen de dónde esté el proyecto), las instrucciones (`AGENTS.md` del kit) y el LSP `tinymist` para los ficheros `.typ`. El proyecto no necesita declarar nada de eso; si quiere otro LSP, lo declara en su `opencode.json` y el suyo gana.

Reinicia opencode para que tome los cambios y compruébalo con `opencode debug config`: deben aparecer los cuatro comandos, `AGENTS.md` del kit en `instructions` y `lsp.tinymist`.

## Notas

- Si el plugin no puede deducir su ubicación, busca el kit en `../opencode-fp-kit`.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`README.md`, `_plantilla`, `documentacion/`, `1_descripcion.pdf`) son relativas al proyecto.
