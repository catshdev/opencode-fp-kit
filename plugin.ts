import { Plugin } from "@opencode/plugin"
import { readFile, readdir } from "node:fs/promises"
import { dirname, join } from "node:path"
import { fileURLToPath } from "node:url"

type Comando = { description?: string; template: string }

// El plugin vive en la raíz del kit, así que su propia ruta indica dónde está:
// el proyecto no repite la del kit en ningún otro sitio.
function directorioDelKit(): string {
  return dirname(fileURLToPath(import.meta.url))
}

async function leerComandos(kit: string): Promise<Record<string, Comando>> {
  const comandos: Record<string, Comando> = {}
  const directorio = join(kit, "commands")

  let ficheros: string[]
  try {
    ficheros = await readdir(directorio)
  } catch {
    return comandos
  }

  for (const fichero of ficheros) {
    if (!fichero.endsWith(".md")) continue
    const crudo = await readFile(join(directorio, fichero), "utf8")
    const partes = crudo.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?([\s\S]*)$/)
    const cabecera = partes?.[1] ?? ""
    const cuerpo = partes?.[2] ?? crudo
    const descripcion = cabecera.match(/^description:\s*(.+)$/m)?.[1]?.trim()

    comandos[fichero.replace(/\.md$/, "")] = {
      description: descripcion,
      template: cuerpo.replaceAll("{{KIT}}", kit),
    }
  }
  return comandos
}

const kit = directorioDelKit()

export default Plugin.define({
  id: "fp-kit",
  async setup(ctx) {
    const comandos = await leerComandos(kit)

    // Los comandos se registran como transformaciones y cada uno lleva su propio
    // `execute`: la plantilla del kit se envía al hilo como prompt.
    await ctx.command.transform((editor) => {
      for (const [name, comando] of Object.entries(comandos)) {
        editor.add({
          name,
          description: comando.description,
          async execute({ sessionID, prompt, delivery }) {
            const texto = comando.template.includes("$ARGUMENTS")
              ? comando.template.replaceAll("$ARGUMENTS", prompt.text)
              : prompt.text
                ? `${comando.template}\n\n${prompt.text}`
                : comando.template

            await ctx.session.prompt({ ...prompt, sessionID, text: texto, delivery })
          },
        })
      }
    })

    // Exporta la ruta del kit a los shells que abre opencode (agente y terminal
    // integrada).
    await ctx.shell.hook("create.before", (event) => {
      event.env.FP_KIT = kit
    })
  },
})
