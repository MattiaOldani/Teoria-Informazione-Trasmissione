// Setup

#import "template.typ": *

#show: project.with(title: "Teoria dell'Informazione e della Trasmissione")

#pagebreak()

// Appunti

// Introduzione

#include "capitoli/00_introduzione.typ"
#pagebreak()

// Teoria dell'informazione

#parte("Teoria dell'Informazione")
#pagebreak()

#include "capitoli/informazione/01_codici.typ"
#pagebreak()

#include "capitoli/informazione/02_kraft.typ"
#pagebreak()

#include "capitoli/informazione/03_entropia.typ"
#pagebreak()

#include "capitoli/informazione/04_primo-teorema-shannon.typ"
#pagebreak()

#include "capitoli/informazione/05_codice-huffman.typ"
#pagebreak()

#include "capitoli/informazione/06_kraft-mcmillan.typ"
#pagebreak()

#include "capitoli/informazione/07_parenti-entropia.typ"

// Teoria della trasmissione

#parte("Teoria della Trasmissione")
#pagebreak()

#include "capitoli/trasmissione/01_canale.typ"
#pagebreak()

#include "capitoli/trasmissione/02_secondo-teorema-shannon.typ"

// Codici

#parte("Codici")
#pagebreak()

#include "capitoli/codici/01_introduzione-matematica.typ"
#pagebreak()

#include "capitoli/codici/02_codici-semplici.typ"
#pagebreak()

#include "capitoli/codici/03_codici-ripetizione.typ"
#pagebreak()

#include "capitoli/codici/04_codice-hamming.typ"
#pagebreak()

#include "capitoli/codici/05_codici-lineari.typ"
#pagebreak()

#include "capitoli/codici/06_codici-ciclici.typ"
