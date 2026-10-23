#let subtitulo = [TAREA 1\ PARTE 1]

// ---- Bibliografia (opcional) ----
#let bibliografia = bibliography("referencias.bib", style: "apa") // none

// ---- Capitulos del cuerpo principal (numeración arábiga) ----
#let capitulos = [
  #include "capitulos/01-introduction.typ"
  #include "capitulos/02-methodology.typ"
  #include "capitulos/03-results.typ"
  #include "capitulos/04-discussion.typ"
]

// ---- Apendices (opcional) ----
#let apendices = none /* [
  #include "capitulos/a-appendix.typ"
]*/

// Lista de Abreviaciones (opcional): pares (corto, largo).
#let abreviaciones = none /*(
  ("DNA", "Ácido desoxirribonucleico"),
  ("API", "Interfaz de programación de aplicaciones"),
)*/
