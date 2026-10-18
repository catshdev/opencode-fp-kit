import type { Plugin } from "@opencode-ai/plugin"
import { readdir } from "node:fs/promises"
import { dirname, join } from "node:path"
import { fileURLToPath } from "node:url"

type Comando = { description?: string; template: string }

const LSP = {
  tinymist: {
    command: ["tinymist", "lsp"],
    extensions: [".typ", ".typc"],
  },
}

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
    const crudo = await Bun.file(join(directorio, fichero)).text()
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

export const FpKit: Plugin = async () => {
  const kit = directorioDelKit()
  return {
    config: async (cfg) => {
      cfg.command = { ...(await leerComandos(kit)), ...(cfg.command ?? {}) }
      cfg.lsp = { ...LSP, ...(cfg.lsp ?? {}) }

      const agents = join(kit, "AGENTS.md")
      const instrucciones = cfg.instructions ?? []
      if (!instrucciones.includes(agents)) cfg.instructions = [...instrucciones, agents]
    },
    "shell.env": async (_input, output) => {
      output.env.FP_KIT = kit
    },
  }
}
