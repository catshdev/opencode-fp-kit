= Table examples

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    table.header([*Dato observado*], [*Valor*]),
    [ID], [application_1791804177654_0012],
    [Estado], [FINISHED],
    [Usuario], [hadoop],
    [Tipo], [MAPREDUCE],
    [Duración], [14sec],
  ),
  caption: [Hadoop Streaming Job - Application Info],
)

#figure(
  table(
    columns: (auto, 1fr, 2fr),
    align: (left, left, left),
    table.header(
      [*Necesidad*],
      [*Procesamiento*],
      [*Motivo*],
    ),
    [Consulta de envíos],
    [Tiempo real],
    [Actualizar rápidamente el estado de los paquetes.],
    [Alertas de incidencias],
    [Streaming],
    [Analizar continuamente los datos de los sensores y detectar problemas.],
    [Informes semanales],
    [Batch],
    [Procesar los datos acumulados al cierre del domingo.],
    [Predicción de retrasos],
    [Batch y streaming],
    [Entrenar el modelo con datos históricos y actualizar las predicciones con datos actuales.],
  ),
  caption: flex-caption(
    [Estrategias de procesamiento según las necesidades de la empresa],
    [Estrategias de procesamiento],
  ),
)
