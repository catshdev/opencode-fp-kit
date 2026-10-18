# AGENTS.md

Convenios compartidos del kit (`opencode-fp-kit`) para los repos de entregas de un ciclo formativo. Nos comunicamos y escribimos siempre en español de España.

## Estructura

- Un directorio por módulo. La lista de módulos y los pasos para crear un módulo o una unidad de trabajo están en el `README.md`.
- Nunca uses los nombres reales de esos módulos para poner ejemplos. En ejemplos, comandos y rutas de muestra se usan nombres genéricos: `modulo-1`, `modulo-2`, …
- Cada módulo tiene unidades de trabajo (ut): `ut01/`, `ut02/`, …. Cada una tiene tres partes:
  - `ut01/documentacion/`: documentación de la unidad en `.txt`, sacada de los PDF con `pdftotext`. Las tareas se hacen en base a ella. Puede estar vacía.
  - `ut01/tarea/`: los enunciados en PDF (`0_info.pdf`, `1_descripcion.pdf`, `2_informacion.pdf`, `3_evaluacion.pdf`, …).
  - `ut01/tarea/typst/`: la entrega escrita (`main.typ`, `data.typ`, `chapters/NN-nombre.typ`, `references.bib`, `figures/`). El contenido de los capítulos se saca de `1_descripcion.pdf`.
- Una tarea de una unidad puede estar dividida en partes: la documentación de la unidad va en `ut01/documentacion/`, los datos de la tarea en `ut01/tarea/typst/data.typ` y cada parte en `ut01/tarea/partes/p01`, `p02`, …, con su propio `1_descripcion.pdf` y su proyecto `typst/` completo. Los `main.typ` de las partes importan los datos en cadena: `../../../../../../typst/lib.typ` y `../../../../../../typst/data.typ` (raíz, 6 niveles), `../../../../../typst/data.typ` (asignatura, 5), `../../../typst/data.typ` (tarea, 4) y `data.typ` (la propia parte).
- En las tareas de documento único los imports son más cortos: `../../../../typst/lib.typ` (plantilla) y `../../../../typst/data.typ` (raíz) con 4 niveles, `../../../typst/data.typ` (asignatura) con 3 y `data.typ` en la carpeta del proyecto.
- La plantilla para módulos y unidades nuevas vive en el kit, en `typst/template/` (los pasos, en el `README.md`): es un esqueleto de módulo, con `ut00/` (`documentacion/` y `tarea/`, y el proyecto Typst en `tarea/typst/`) y `typst/data.typ` con los datos de la asignatura. Los comandos `/crear-modulo` y `/crear-unidad` la copian al proyecto. No compila en su sitio actual (dentro del kit).
- `typst/lib.typ` es la plantilla compartida (función `thesis`): es local, no la re-inicialices con `typst init`. Cualquier cambio ahí afecta a todas las tareas. Los capítulos que usen `flex-caption` lo importan de `typst/lib.typ` con los `../` que correspondan, no de `@preview/classic-uni-thesis` (que solo queda como referencia anticuada en la plantilla del kit, `typst/template/`).
- `typst/data.typ` son los datos raíz compartidos (logo, centro, programa, autor…); `typst/base/` y `typst/subject/` quedan para datos de asignatura.
- El script de revisión ortográfica vive en el kit (`typst/revisar.sh`, junto a este AGENTS.md), con un diccionario que solo lleva palabras de la sintaxis de Typst; los dos están fuera del repo de entregas. En `typst/` del proyecto queda el diccionario con el vocabulario propio de estos módulos.
- Registrar cada capítulo nuevo en el `#include` de su `main.typ`.
- Los apéndices no van como un capítulo: se definen en el `data.typ` del proyecto (`#let apendices = [ #include "chapters/a-appendix.typ" ]`, o `none` si no hay) y `main.typ` los referencia con `apendices: tarea.apendices` (documento único) o `apendices: parte.apendices` (tarea en partes).

## Crear un módulo

Cuando se pida crear un módulo o una unidad de trabajo, seguir el flujo del `README.md` o los comandos `/crear-modulo` y `/crear-unidad`. Antes de crear nada, pedir al usuario el nombre y los datos mínimos que falten, sin inventarlos:

- Asignatura, en `modulo-1/typst/data.typ`: `nombre` y `profesor` o `profesora`.
- Tarea, en `modulo-1/ut01/tarea/typst/data.typ`: `titulo`, `subtitulo`, `dia`, `mes` y `anyo`.

Se vuelcan en `thesis.with` desde esos `data.typ`; el resto de parámetros (`logo`, `centro`, `programa`, `autor`, `autora`, `ubicacion`) sale del `typst/data.typ` de la raíz. Al crear un módulo, añadirlo a la lista de «Módulos» del `README.md`; si se borra a mano, quitarlo de la lista.

## Compilar Typst

Siempre desde la raíz del repo y con `--root .` (obligatorio):

```bash
typst compile --root . modulo-1/ut01/tarea/typst/main.typ
typst compile --root . modulo-2/ut01/tarea/partes/p01/typst/main.typ
typst watch --root . modulo-1/ut01/tarea/typst/main.typ
```

- `typst compile main.typ` ejecutado dentro de `typst/` (como afirma la cabecera de los archivos) FALLA: los imports relativos a `typst/lib.typ` se salen del project root.
- Typst 0.15.1 viene en el perfil del sistema; no hay que instalar ni fijar nada más.
- Los PDF generados (`main.pdf`) están en `.gitignore`: se compilan en local y no se commitean. Los únicos PDFs versionados son los enunciados: `ut*/tarea/*.pdf` y, en tareas por partes, `ut*/tarea/partes/p*/*.pdf`.

## Convenciones de redacción

Escribe como un alumno real de FP: vocabulario cotidiano, frases normales y nada de tono académico pomposo. La meta es que el texto se lea como lo escribiría una persona, no como lo generaría una IA.

### Voz

- Cuando el enunciado pida una opinión, una decisión o lo que harías, contéstalo en primera persona y sin rodeos. La voz la marca cómo plantee el trabajo el enunciado: si es una propuesta de un equipo, un departamento o una empresa, todo el texto va en primera persona del plural y no se pasa a la singular en ningún apartado; si el trabajo es individual y pide tu opinión, va en singular. No mezcles las dos voces ni te escondas detrás de un impersonal. Ayudan expresiones de habla normal ("yo usaría…", "en mi opinión…", "me decantaría por…", "nos quedaríamos con…", "la verdad es que…", "lo que sí tengo claro es…"), sin abusar de ellas.
- Moja el texto: toma partido y deja ver alguna preferencia o duda. Un texto neutro y equidistante también delata a la IA.
- Si no sabes algo o no encuentras un dato, dilo con naturalidad ("de esto no tengo ni idea", "no encontré una cifra clara"). Inventarse detalles con seguridad es peor que reconocer el hueco.

### Tono y naturalidad

- No hace falta pulir cada frase hasta que suene a corregida por un editor; se admite alguna imperfección leve y natural (una concordancia un poco laxa, un enlace mejorable), pero no se fuerzan a propósito. Si una frase no se entiende a la primera, suena rara o se queda coja (por ejemplo, sin el verbo que le toca), se arregla. Nunca una falta de ortografía.
- De vez en cuando, un giro coloquial o de calle da verosimilitud y humaniza el texto (p. ej., "irlos corrigiendo" en lugar de "ir corrigiéndolos", "darle una vuelta", "no comerse la cabeza"). Que sea sutil, bien traído y sin abusar, y que no caiga en vulgarismo ni chirríe en un texto formal.
- Varía la longitud de las frases y de los párrafos: alguna corta, otra más larga, y de cuando en cuando un párrafo de una sola frase. Si todos miden lo mismo, canta.

### Tics y muletillas que hay que evitar

- Muletillas y conectores de relleno: "es importante destacar", "cabe mencionar", "asimismo", "por consiguiente", "en primer lugar", "por un lado… por otro lado", "en este sentido", "de igual manera", "del mismo modo", "en definitiva", "en resumen", "en conclusión". Si cae uno, quítalo y reescribe la idea sin él.
- Aperturas de relleno: "Hoy en día", "En la actualidad", "En el mundo actual", "Con el avance de la tecnología", "La IA está transformando…". Entra directo en el tema.
- No repitas el mismo conector para empezar párrafos seguidos ("Además…", "También…", "Así…", "De esta forma…").
- Adjetivos de folleto: "crucial", "fundamental", "clave" (como comodín), "robusto", "innovador", "puntero", "óptimo", "versátil", "integral". El adjetivo, solo cuando diga algo concreto.
- Adverbios de énfasis que no añaden nada: "sin duda", "claramente", "evidentemente", "realmente", "ciertamente".
- Verbos de relleno que no aportan: "realizar", "llevar a cabo", "gestionar", "optimizar", "implementar", "potenciar", "dotar de". Mejor el verbo concreto: hacer, usar, montar, programar, revisar.
- Verbos de folleto: "permitir", "ofrecer", "brindar", "aprovechar" cuando valdría "dejar", "tener" o el verbo concreto de la acción.
- Giros de despacho en vez de un simple "para": "con el fin de", "a fin de", "con objeto de", "de cara a", "a nivel de", "en función de". Si "para" vale, usa "para".
- Cuantificadores vagos: "diversos", "múltiples", "numerosos", "un amplio abanico de", "un sinfín de". Si no sabes la cifra, dilo (unos cuantos, tres o cuatro); y si pones un número, que sea creíble.
- Anáforas de despacho: "el mismo", "dicha", "dicho", "el citado", "el mencionado". Repite la palabra o tira de "eso", "este".
- No encadenes matices tipo "podría", "permitiría", "facilitaría", "sería conveniente" en casi todas las frases. Cuando tengas claro algo, dilo sin tantos matices.
- No abuses del "se" impersonal ni de la pasiva ("se realizarán", "se llevará a cabo"): mejor un sujeto concreto y un verbo en activo.
- Evita las construcciones de manual "no solo… sino también", "tanto… como" y "más allá de" cuando no aporten nada.
- Nada de anglicismos ni calcos traducidos a lo bruto ("aplicar para", "soportar" por "ser compatible con", "customizar"). Si existe la palabra en español, se usa.

### Estructura y ritmo

- No repitas la estructura de los apartados. Si varios seguidos se abren o cierran igual, o llevan la misma lista con las mismas etiquetas, reescribe unos u otros o fúndelos. Que cada apartado tenga la forma que pida su contenido, no una plantilla fija.
- No conviertas cada idea en una lista ni en un "Concepto: explicación" con dos puntos. Reserva las listas para enumerar elementos independientes; si cada elemento es una frase seguida, suele quedar mejor en prosa.
- Alterna párrafo y lista, frases cortas y largas: que el conjunto no se lea como una plantilla rellenada.
- No empieces muchos párrafos con la misma construcción ni con el mismo sujeto; varía el orden y el tipo de frase.
- Cuidado con las enumeraciones de tres (tres cosas, tres adjetivos seguidos): si siempre caen tres, se nota buscado.
- No abuses de los incisos entre rayas ni del punto y coma; una puntuación sencilla (puntos y comas) canta menos.
- No cierres cada apartado con una frase-resumen que repita lo dicho, ni con un cierre comodín, ni con una floritura final.
- No abras el capítulo repitiendo el título, explicando lo obvio ni con una frase genérica de encuadre; entra ya en el contenido. Y no repitas la pregunta del enunciado antes de contestarla ni anuncies lo que vas a contar.
- No encadenes pasos con marcadores temporales rígidos ("primero…, después…, por último…") salvo que sea un procedimiento de verdad.
- No lo escribas todo en futuro ("se realizará", "será necesario"). Lo que se planea o lo que se haría se cuenta mejor en presente o en condicional ("hablamos con la empresa", "integraríamos el modelo").
- No abras los apartados con una definición de manual ("La ciberseguridad es…"); mejor arranca con la idea concreta que toca.
- Si una frase se va de largo (tres comas y dos "que"), pártela en dos.
- Encabezados llanos y descriptivos, no titulares llamativos.

### Contenido y enfoque

- No repitas una idea o una frase en varios apartados; si ya se dijo, se nombra y se sigue.
- Baja siempre al caso concreto. Si un apartado se queda en describir la norma o la teoría en general, sin aplicarla al proyecto, se recorta o se funde con otro.
- Mete algún detalle que solo saldría de haber mirado el caso: una cifra concreta, una pega que hayas visto, un ejemplo propio. Es lo que más delata que detrás hay una persona.
- Cuando el enunciado pida comparar, no hagas dos listas gemelas: di en qué se diferencian y cuál gana (o por qué no hay un ganador claro).
- Cuando pida ventajas y desventajas, evita dos bloques simétricos de tres y tres; cuenta las que importen.
- Cuando expliques un concepto de la documentación, no copies la definición: cuéntalo con tus palabras y pon un ejemplo.

### Citas y referencias

- Citas: `bibliography(..., style: "apa")` y referencias `@online` con `author = {{Nombre}}` (doble llave si no es persona), `title`, `year`, `url`, `urldate`; se citan con `@clave`. Varios `references.bib` aún tienen entradas de plantilla sin sustituir.
- La cita (`@clave`) va pegada a la frase que respalda, dentro de un enunciado con sentido completo. No la cuelgues del final de un gerundio o de un añadido forzado solo para cuadrar la frase: si al quitar la cita queda rara, reescríbela.
- No metas una cita en cada párrafo como adorno; cita lo que de verdad respalde una afirmación concreta.

### Formato Typst

- El texto generado se entrega como bloque de código Typst (cabeceras, negrita, cursiva, listas). La numeración es automática: no números las cabeceras a mano.
- Tablas con el patrón `#figure(table(...), caption: [...])` y `table.header`; ejemplos reales en `typst/examples.typ`.
- Diagramas y gráficos: siempre resueltos con Typst, nunca generes imágenes. Se usan paquetes de `@preview` (`cetz`, `fletcher`, `meander`…), que Typst descarga y cachea al compilar: sin red, esos documentos fallan si no están cacheados.
- Abreviaciones (tupla `abreviaciones` de `main.typ`): siglas en español tal cual; siglas en inglés con el valor en inglés y la traducción al español en cursiva entre paréntesis.
- Figuras del entregable en `typst/figures/`, nombradas `NN-descripcion.png`, y referenciadas desde los capítulos como `../figures/...`.

### Revisión y brevedad

- Sé breve: explica lo justo para responder a lo que se pide, sin relleno ni justificaciones de más. Si un párrafo se puede acortar sin perder información, se acorta.
- La brevedad también se mide en el capítulo completo:
  - Al cerrar un capítulo, compararlo con lo que pide el enunciado (`1_descripcion.pdf`): cada bloque debe corresponderse con un punto de la rúbrica, y si no, preguntarse si sobra o falta.
  - Si varios bloques del capítulo repiten la misma idea o la misma estructura (cierres iguales, frases repetidas), fusionarlos o recortarlos.
  - Cubrir la rúbrica no es desarrollarla de más: si un apartado se queda en describir la norma o la teoría en general, sin bajarla al caso concreto, o repite lo que ya se dijo, se recorta o se funde con otro. Una entrega que cumple los puntos no gana por rellenarlos.
  - Si una idea ya se explicó en otro capítulo, no repetirla: nombrarla y seguir.
  - Antes de aplicar un recorte grande, proponerlo con el ahorro de palabras estimado y esperar confirmación.
- Nada de apartados "Conclusiones"; si hay conclusiones, intégralas ampliando el inicio.
- Autochequeo antes de dar una entrega por buena: ¿hay algún párrafo que empiece como el anterior? ¿alguna lista con las mismas etiquetas de siempre? ¿algún tic de la lista de arriba? ¿alguna frase que no se entienda a la primera o a la que le falte un verbo? ¿algo que solo podría haber escrito quien no ha mirado el caso de cerca?
- Después de redactar o modificar texto, pásalo por el revisor ortográfico y dale además una lectura rápida: la herramienta no detecta frases forzadas de más.

  ```bash
  bash "$FP_KIT/typst/revisar.sh"                                    # todo el entregable
  bash "$FP_KIT/typst/revisar.sh" modulo-1/ut01/tarea/typst/chapters/01-ejemplo.typ   # solo un fichero
  ```

  - `FP_KIT` es la ruta absoluta al kit y la exporta el plugin del kit en los shells que abre opencode (agente y terminal integrada). Si ejecutas el script fuera de opencode, usa la ruta del kit en su lugar.
  - El comando `/revisar <modulo> [capítulo]` lanza esta revisión sobre un módulo entero o sobre un capítulo suelto.
  - Alcance: los proyectos Typst de las entregas (`ut*/tarea/typst/` y, en tareas por partes, `ut*/tarea/partes/p*/typst/`); nunca la carpeta raíz `typst/`.
  - Las revisiones se hacen contra dos fuentes: el enunciado (`1_descripcion.pdf` de `ut*/tarea/`, o el de la parte en `ut*/tarea/partes/p*/`) y la documentación de la unidad (`ut*/documentacion/*.txt`): la entrega tiene que estar en base a ambas, no solo al enunciado.
  - El script quita el marcado y el código Typst antes de revisar (comentarios, bloques de código, líneas de código como `let`/`for`/`if`, llamadas a funciones, argumentos con nombre y código en línea) y deja la prosa: párrafos, encabezados, celdas de tabla y pies. De los `.bib` solo conserva el valor de cada campo, no los nombres. Así que no hace falta meter en el diccionario ni palabras de sintaxis de Typst ni nombres de campo de las entradas `.bib`.
  - El diccionario de palabras admitidas son dos listas que el script une: la del kit (`$FP_KIT/typst/.aspell.es.pwl`, solo palabras de la sintaxis de Typst que el script no quita, iguales para cualquier proyecto) y la del proyecto (`typst/.aspell.es.pwl`, con el vocabulario propio de estos módulos; puede no existir). Formato de ambas: UTF-8, una palabra por línea, sin cabecera y con acentos (`clúster`, `indentación`, `Usabilidad`…). El script las convierte a latin-1 porque aspell la lee en ese encoding; si una palabra no existe en latin-1, aborta y la señala.
  - Al revisar texto, si sale una palabra que está bien escrita y va a seguir apareciendo (tecnicismo, nombre propio, sigla, campo de una API), añádela a la lista que toque en el mismo cambio: a la del kit solo si es de la sintaxis de Typst, y al del proyecto lo propio de estos módulos (lo habitual). Cuanto menos ruido, más se ve una falta real.
  - No se meten a propósito: las palabras españolas escritas sin la tilde (`version`, `maximo`…), para que si aparecen en prosa salten como falta real; y los nombres y el relleno de las entradas de plantilla del `references.bib` (Smith, Jones, Nakamura, `placeholder`…), que se quedan a la vista hasta que esas entradas se sustituyan.

## Control de versiones

No hagas commits ni prepares el índice (`git add`, `git commit`, `git stash`…): deja los cambios sin confirmar para que el usuario los revise. Solo se confirma cuando lo pida de forma explícita.

## Mantenimiento de este archivo

Si un cambio en el kit o en la estructura de los repos de entregas afecta a lo aquí descrito (la plantilla `typst/lib.typ`, el script y los diccionarios del kit, la estructura de las unidades `ut*/`, los comandos de compilación, los comandos de `commands/` o el `plugin.ts`/`index.ts` del kit, o las convenciones de redacción), actualiza este AGENTS.md en el mismo cambio.
