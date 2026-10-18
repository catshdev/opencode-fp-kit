#let titulo = [Título de la tarea]
#let subtitulo = "TAREA N"

#let dia = 1
#let mes = 1
#let anyo = 2026

// ---- Bibliografia (opcional) ----
#let bibliografia = bibliography("references.bib", style: "apa") // none

// ---- Capitulos del cuerpo principal (numeración arábiga) ----
#let capitulos = [
  #include "chapters/01-introduction.typ"
  #include "chapters/02-methodology.typ"
  #include "chapters/03-results.typ"
  #include "chapters/04-discussion.typ"
]

// ---- Apendices (opcional) ----
#let apendices = none /* [
  #include "chapters/a-appendix.typ"
]*/

// Lista de Abreviaciones (opcional): pares (corto, largo).
#let abreviaciones = none /*(
  ("DNA", "Ácido desoxirribonucleico"),
  ("API", "Interfaz de programación de aplicaciones"),
)*/
