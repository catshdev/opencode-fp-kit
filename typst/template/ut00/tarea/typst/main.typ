#import "../../../../typst/lib.typ": abbrev-table, flex-caption, thesis

#import "../../../../typst/data.typ" as base
#import "../../../typst/data.typ" as asignatura
#import "data.typ" as tarea

#show: thesis.with(
  // Comun
  logo: base.logo,
  centro: base.centro,
  programa: base.programa,
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
