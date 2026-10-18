#!/usr/bin/env bash
# Revisión ortográfica del entregable Typst.
#
#   bash "$FP_KIT/typst/revisar.sh"                      # todo el entregable
#   bash "$FP_KIT/typst/revisar.sh" ruta/del/fichero.typ  # solo lo que se indique
#
# FP_KIT es la ruta al kit y la exporta el plugin del kit en opencode; si lo
# ejecutas fuera de opencode, usa la ruta del kit en su lugar.
#
# El diccionario es la unión de dos: el genérico que acompaña a este script en
# el kit y el específico del proyecto en `typst/.aspell.es.pwl` (si existe).
#
# Antes de llegar a aspell se quita el marcado de Typst: se van comentarios,
# bloques de código, líneas de marcado y código en línea; se queda la prosa
# (párrafos, texto de encabezados, celdas de tabla y pies de figura). De las
# entradas .bib solo se conserva el valor de cada campo (títulos, autores…),
# no los nombres de campo ni las llaves.

set -euo pipefail

directorio="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
origen="$PWD"

repo="$(git rev-parse --show-toplevel)"
cd "$repo"

generico="$directorio/.aspell.es.pwl"
especifico="$repo/typst/.aspell.es.pwl"

if [ "$#" -gt 0 ]; then
  ficheros=()
  for f in "$@"; do
    if [ -e "$f" ]; then
      ficheros+=("$f")
    elif [ -e "$origen/$f" ]; then
      ficheros+=("$origen/$f")
    else
      echo "No existe el fichero: $f" >&2
      exit 1
    fi
  done
else
  mapfile -t ficheros < <(git ls-files | grep -E 'ut[0-9]+/tarea/.*\.(typ|bib)$')
  if [ "${#ficheros[@]}" -eq 0 ]; then
    echo "No hay ficheros de entregable que revisar." >&2
    exit 1
  fi
fi

# Se unen el diccionario genérico del kit y el específico del proyecto en una
# sola lista, sin duplicados ni líneas vacías.
lista="$(mktemp)"
tmp="$(mktemp)"
trap 'rm -f "$lista" "$tmp"' EXIT

{
  [ -f "$generico" ] && cat "$generico"
  [ -f "$especifico" ] && cat "$especifico"
} | sed '/^[[:space:]]*$/d' | LC_ALL=C sort -u > "$lista"

# aspell lee el diccionario personal en latin-1, así que la lista se mantiene
# en UTF-8 (con acentos) y aquí se convierte con la cabecera que aspell pide.
if grep -qP '[^\x00-\xFF]' "$lista"; then
  echo "El diccionario tiene palabras que aspell no leería (fuera de latin-1):" >&2
  grep -P '[^\x00-\xFF]' "$lista" | sed 's/^/  /' >&2
  exit 1
fi

palabras="$(grep -c '.' "$lista" || true)"
{ printf 'personal_ws-1.1 es %s\n' "$palabras"; cat "$lista"; } | iconv -f UTF-8 -t ISO-8859-1 > "$tmp"

for f in "${ficheros[@]}"; do
  case "$f" in
    *.bib)
      sed -E '
        /^[[:space:]]*(\/\/|%)/d
        /^[[:space:]]*@/d
        /^[[:space:]]*(url|urldate|doi|howpublished|isbn|issn)[[:space:]]*=/Id
        s/^[[:space:]]*[A-Za-z]+[[:space:]]*=[[:space:]]*//
        s/^[[:space:]]*[{}",]+//
        s/[{}",]+[[:space:]]*$//
        /^[[:space:]]*[[:punct:][:digit:]]*$/d
      ' "$f"
      ;;
    *)
      # El código de una sola línea se reconoce por su forma; los bloques de
      # código y de datos quedan en blanco, pero se conserva el contenido que
      # va entre corchetes (celdas de tabla, pies de figura…).
      sed -E '
        /^```/{:a;N;/\n```/!ba;d}
        /^[[:space:]]*(\/\/|%)/d
        /^[[:space:]]*#/d
        s/^=+ //
        s/^[[:space:]]*[a-z][a-z0-9-]*:[[:space:]]*\[([^][]*)\],?[[:space:]]*$/\1/
        /^[[:space:]]*(let|set|show|for|while|if|else|import|include|return|break|continue|context)[[:space:](]/d
        /^[[:space:]]*[a-z][a-z0-9_-]*(\.[a-z][a-z0-9_-]*)*\(/d
        /^[[:space:]]*[a-z][a-z0-9-]*: /d
        /^[[:space:]]*(import [a-z.:]+:|content\[)/d
        /^[[:space:]]*[])}]/d
        /^[[:space:]]*\(/d
        /^[[:space:]]*[[:punct:][:digit:]]*$/d
        s/`[^`]*`//g
        s/\$[^$]*\$//g
        s/@[A-Za-z0-9_.:-]+//g
        s/<[A-Za-z0-9_:-]+>//g
        s/\burl[[:space:]]*=.*//I
      ' "$f"
      ;;
  esac
done | aspell --lang=es --encoding=utf-8 --mode=none --personal="$tmp" list | sort | uniq -c | sort -rn
