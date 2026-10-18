---
description: Crea un módulo nuevo desde _plantilla (directorio, datos de la asignatura y primera unidad ut01).
---

Crea un módulo nuevo siguiendo los pasos del `README.md`.

Nombre del módulo (si falta, pídelo): $ARGUMENTS

Antes de crear nada, pide al usuario los datos mínimos que falten y espera su respuesta; no los inventes:

- Asignatura, para `<modulo>/typst/data.typ`: `nombre` y `profesor` o `profesora`.
- Primera tarea, para `<modulo>/ut01/tarea/typst/data.typ`: `titulo`, `subtitulo`, `dia`, `mes` y `anyo`.

Con eso: copia `_plantilla` al directorio del módulo, rellena los dos `data.typ`, renombra `ut00` a `ut01` y añade el módulo a la lista de «Módulos» del `README.md`. El volcado a `thesis.with` y el resto de pasos están en el `README.md` y en `AGENTS.md`.
