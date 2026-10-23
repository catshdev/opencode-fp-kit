#import "../../../../../../.typst/lib.typ": abbrev-table, flex-caption, thesis

#import "../../../../../../.typst/base.typ" as base
#import "../../../../../.typst/curso.typ" as curso
#import "../../../.typst/tarea.typ" as tarea
#import "parte.typ" as parte

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
  fecha: datetime(day: tarea.dia, month: tarea.mes, year: tarea.anyo),
  // Parte
  subtitulo: parte.subtitulo,
  abreviaciones: parte.abreviaciones,
  apendices: parte.apendices,
  bibliografia: parte.bibliografia,
)

// Capitulos
#parte.capitulos
