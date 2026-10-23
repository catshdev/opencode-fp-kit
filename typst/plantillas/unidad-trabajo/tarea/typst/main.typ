#import "../../../../.typst/lib.typ": abbrev-table, flex-caption, thesis

#import "../../../../.typst/base.typ" as base
#import "../../../.typst/asignatura.typ" as asignatura
#import "tarea.typ" as tarea

#show: thesis.with(
  // Comun
  logo: base.logo,
  centro: base.centro,
  programa: base.curso,
  autor: base.autor,
  autora: base.autora,
  ubicacion: base.ubicacion,
  // Asignatura
  tipo-tesis: asignatura.nombre,
  profesor: asignatura.profesor,
  profesora: asignatura.profesora,
  // Tarea
  titulo: tarea.titulo,
  subtitulo: tarea.subtitulo,
  fecha: datetime(day: tarea.dia, month: tarea.mes, year: tarea.anyo),
  abreviaciones: tarea.abreviaciones,
  apendices: tarea.apendices,
  bibliografia: tarea.bibliografia,
)

// Capitulos
#tarea.capitulos
