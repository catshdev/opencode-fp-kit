import type { Plugin } from "@opencode-ai/plugin"
import { readdir, stat } from "node:fs/promises"
import { dirname, join } from "node:path"
import { fileURLToPath } from "node:url"

type Comando = { description?: string; template: string }

async function existeDirectorio(ruta: string): Promise<boolean> {
  try {
    return (await stat(ruta)).isDirectory()
  } catch {
    return false
  }
}

async function directorioDelKit(worktree: string): Promise<string> {
  const candidatos: string[] = []
  try {
    candidatos.push(dirname(fileURLToPath(import.meta.url)))
  } catch {}
  candidatos.push(join(worktree, "..", "opencode-fp-kit"))

  for (const candidato of candidatos) {
    if (await existeDirectorio(join(candidato, "commands"))) return candidato
  }
  return candidatos[0]
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

export const FpKit: Plugin = async ({ worktree }) => {
  const kit = await directorioDelKit(worktree)
  return {
    config: async (cfg) => {
      cfg.command = { ...(await leerComandos(kit)), ...(cfg.command ?? {}) }
    },
  }
}
