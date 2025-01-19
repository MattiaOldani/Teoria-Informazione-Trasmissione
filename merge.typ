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
