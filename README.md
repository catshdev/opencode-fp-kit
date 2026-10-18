# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

Está pensado para vivir como repo hermano del proyecto: `../opencode-fp-kit`.

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `commands/*.md`: comandos de opencode: `/crear-modulo`, `/crear-unidad`, `/documentar` y `/revisar`.
- `plugin.ts`: plugin de opencode que registra esos comandos en el proyecto.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario genérico (vocabulario común a cualquier proyecto). El proyecto puede añadir lo suyo en su propio `typst/.aspell.es.pwl`.

## Cómo engancharlo en un proyecto

En el `opencode.json` del proyecto, junto a `$schema`, añade:

```json
{
  "instructions": ["../opencode-fp-kit/AGENTS.md"],
  "plugin": ["../opencode-fp-kit/plugin.ts"]
}
```

El plugin localiza el kit por su cuenta y registra los comandos sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que las rutas de los comandos no dependen de dónde esté el proyecto.

Reinicia opencode para que tome los cambios y compruébalo con `opencode debug config`: deben aparecer los cuatro comandos y `AGENTS.md` en `instructions`.

## Notas

- Si el plugin no puede deducir su ubicación, busca el kit en `../opencode-fp-kit`.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`README.md`, `_plantilla`, `documentacion/`, `1_descripcion.pdf`) son relativas al proyecto.
