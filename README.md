# opencode-fp-kit

Kit compartido para los repos de entregas de FP. Reúne los convenios de redacción, los comandos de opencode y las herramientas de revisión, para no repetirlos en cada proyecto.

El kit puede estar en cualquier sitio: el plugin se localiza solo por su propia ruta, así que las únicas rutas al kit que se escriben en el proyecto son las del `opencode.json` (el plugin y sus instrucciones).

## Qué contiene

- `AGENTS.md`: convenios de redacción y estructura. Se cargan como instrucciones del proyecto.
- `comandos/*.md`: comandos de opencode: `/iniciar-fp`, `/crear-curso`, `/crear-unidad`, `/documentar`, `/revisar`, `/guardar-sesion` y `/cargar-sesion`.
- `plugin.ts`: plugin de opencode que registra esos comandos y exporta la variable `FP_KIT` (ruta absoluta del kit) a los shells. El LSP de Typst (`tinymist`) se resuelve en el editor (o con `tinymist` a mano) y el permiso `external_directory` se declara en el `opencode.json` del proyecto.
- `index.ts`: reexporta `plugin.ts` como exportación por defecto, que es la entrada que carga opencode.
- `typst/revisar.sh`: script de revisión ortográfica del entregable.
- `typst/.aspell.es.pwl`: diccionario del kit, solo con palabras de la sintaxis de Typst. Cada proyecto añade su vocabulario propio en su `.typst/.aspell.es.pwl`.
- `typst/ejemplos.typ`: ejemplos de tablas de la plantilla (incluido `flex-caption`).
- `typst/plantillas/`: esqueletos que copian los comandos: `inicio/` (el arranque del proyecto: los ficheros de `.typst/` más el `.gitignore` y el `AGENTS.md`), `curso/` (los datos del curso, en `curso.typ`) y `unidad-trabajo/` (una unidad con su proyecto Typst).

## Herramientas del sistema

Para que el kit funcione en NixOS, el sistema tiene que tener instalado:

| Herramienta | Para qué | En NixOS |
|---|---|---|
| `opencode` | Ejecutar el agente, cargar el plugin y los comandos. | Instalador oficial de opencode. |
| `typst` | Compilar los entregables. | `typst`. |
| `pdftotext` | Pasar los PDF de documentación a `.txt` en `/documentar`, `/crear-curso` y `/crear-unidad`. | `poppler-utils`. |
| `aspell` + diccionario español | Revisión ortográfica de `/revisar`. | `aspellWithDicts [ aspellDicts.es ]`. |
| `jq` | Leer el ID de `.opencode/sesion.json` en `/guardar-sesion` y `/cargar-sesion`. | `jq`. |
| `git` | `revisar.sh` localiza el repositorio y los ficheros versionados. | `git`. |
| `bash`, `coreutils`, `grep`, `sed`, `iconv` | Scripts y revisión. | `bash`, `coreutils`, `gnugrep`, `gnused` y `glibc`. |

`tinymist` es opcional: solo hace falta para tener diagnósticos de Typst en el editor; el plugin no lo usa.

El kit no necesita Node, Bun ni `npm install`: `plugin.ts` se carga directamente dentro de opencode y no hay `package.json` ni dependencias que instalar. La primera vez que se compile un documento con `cetz`, `fletcher` o `meander`, Typst descarga esos paquetes de `@preview` y los cachea; sin red, tienen que estar ya cacheados.

Para comprobar que no falta ninguno:

```bash
for c in opencode typst pdftotext aspell jq git bash iconv; do
  command -v "$c" >/dev/null 2>&1 || echo "Falta: $c"
done
```

`/iniciar-fp` valida estas herramientas antes de pedir datos o copiar nada; si falta algo, no continúa.


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
    { "action": "external_directory", "resource": "/tmp/*", "effect": "allow" },
    { "action": "external_directory", "resource": "~/path-to/opencode-fp-kit/*", "effect": "ask" }
  ]
}
```

Uso de permisos más permisivos para desarrollar a la vez sobre el kit:

```json
{
  "permissions": [
    { "action": "external_directory", "resource": "*", "effect": "ask" },
    { "action": "external_directory", "resource": "/tmp/*", "effect": "allow" },
    { "action": "external_directory", "resource": "~/path-to/opencode-fp-kit/*", "effect": "allow" }
  ]
}
```

La ruta del plugin puede ser relativa (respecto al propio `opencode.json`), absoluta o `file://`. Para el home usa `{env:HOME}` (como en el ejemplo), que funciona igual en `plugins` y en `instructions`; la `~` no está documentada para la ruta del plugin (sí para los recursos de `permissions`).

El plugin localiza el kit por su cuenta (por su propia ruta) y registra los comandos (sustituyendo `{{KIT}}` por la ruta absoluta del kit, así que no dependen de dónde esté el proyecto). El proyecto solo tiene que declarar el plugin, las instrucciones y el permiso del kit. Además, el plugin exporta `FP_KIT` con esa ruta a los shells, para que `AGENTS.md` y el script de revisión no repitan la ruta.

Las instrucciones van en `instructions` y el permiso del kit en `permissions`. En el primer ejemplo no se deja entrar en ningún directorio externo y el kit queda en `ask`: la primera vez pregunta y, si autorizas, lo guarda. La variante de abajo es la cómoda para desarrollar sobre el kit: pregunta por cualquier directorio externo y autoriza el kit directamente.

Reinicia opencode para que tome los cambios y compruébalo con `opencode plugin list` (debe aparecer la ruta del kit) y con el log (`~/.local/share/opencode/log/opencode.log`), donde no debe salir `failed to load plugin`.

## Notas

- `FP_KIT` (ruta del kit) está en los shells que abre opencode. Fuera de opencode no existe, así que el script de revisión se lanza con la ruta del kit.
- Los comandos se ejecutan en la raíz del proyecto, así que sus rutas (`documentacion/`, `1-descripcion.pdf` o `descripcion.pdf`) son relativas al proyecto; la plantilla se copia desde el kit (`typst/plantillas/`).
- El kit y `/tmp/*` son los directorios externos autorizados por la configuración de ejemplo. Aun así, el agente avisa antes de escribir en el kit por iniciativa propia (ver `AGENTS.md`).
- `/guardar-sesion` guarda la sesión actual en `.opencode/sesion.json` y sobrescribe el backup anterior; `/cargar-sesion` la importa desde ese mismo fichero.
- Para diagnósticos de Typst, usa el LSP de tu editor o ejecuta `tinymist` a mano.
