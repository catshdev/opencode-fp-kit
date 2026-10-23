#import "../../../../.typst/lib.typ": abbrev-table, flex-caption, thesis

#import "../../../../.typst/base.typ" as base
#import "../../../.typst/curso.typ" as curso
#import "tarea.typ" as tarea

#show: thesis.with(
  // Base
  logo: base.logo,
  centro: base.centro,
  programa: base.ciclo,
  autor: base.autor,
  autora: base.autora,
  ubicacion: base.ubicacion,
  // Curso
  tipo-tesis: curso.nombre,
  profesor: curso.profesor,
  profesora: curso.profesora,
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
