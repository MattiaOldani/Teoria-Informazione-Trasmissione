// Setup

#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Introduzione

Lo schema di riferimento che andremo ad usare durante tutto il corso è il seguente:

#v(12pt)

#figure(image("assets/00_canale.svg", width: 70%))

#v(12pt)

La prima persona che lavorò alla teoria dell'informazione fu *Claude Shannon*, un impiegato della TNT (_Telecom americana_) al quale è stato commissionato un lavoro: massimizzare la quantità di dati che potevano essere trasmessi sul canale minimizzando il numero di errori che potevano accadere durante la trasmissione.

Nel $1948$ Shannon pubblica un lavoro intitolato _"A mathematical theory of comunication"_, un risultato molto teorico nel quale modella in maniera astratta il canale e capisce come l'informazione può essere spedita _"meglio"_ se rispetta certe caratteristiche. Ci troviamo quindi di fronte ad un risultato che non ci dice cosa fare nel caso specifico o che codice è meglio, ma è probabilistico, ti dice nel caso medio cosa succede.

Questo approccio è sicuramente ottimale, ma rappresenta un problema: va bene il caso medio, ma a me piacerebbe sapere cosa succede nel caso reale. Questo approccio più reale è quello invece seguito dal russo *Kolmogorov*, un accademico che vuole capire cosa succede nei singoli casi senza usare la probabilità. A metà degli anni $'60$ propone la sua idea di teoria dell'informazione, focalizzandosi quindi sui casi reali e non sui casi medi.

Questi due mostri sacri della teoria dell'informazione, nel nostro schema di lavoro, si posizionano nei rettangoli di sorgente e codifica, mentre la teoria della trasmissione si concentra sui rettangoli sottostanti, quindi nella parte di canale.

Altri due personaggi che hanno lavorato allo stesso problema di Kolmogorov sono due russi, che lavoravano uno in America e uno nell'est del mondo, ma non sono ricordati perché Kolmogorov era il più famoso dei tre.

Un altro personaggio importante è *Richard Hamming*, un ricercatore di Bell Lab che doveva risolvere un problema: i job mandati in esecuzione dalle code batch delle macchine aziendali se si piantavano durante il weekend potevano far perdere un sacco di tempo. La domanda che si poneva Hamming era _"che maroni, perché se le schede forate hanno errori, e le macchine lo sanno, io non posso essere in grado di correggerli?"_

Lui sarà il primo che, per risolvere un problema pratico, costruisce il primo codice di rilevazione e correzione degli errori, il famosissimo *codice di Hamming*.

Vediamo alcune date che rivelano quanto è stata importante la teoria dell'informazione:
- $1965$: prima foto di Marte in bianco e nero grande $approx 240K$ bit, inviata con velocità $6$ bit al secondo, ci metteva ore per arrivare a destinazione;
- $1969$: stessa foto ma compressa, inviata con velocità $16K$ bit al secondo, ci metteva pochi secondi;
- $1976$: prima foto di Marte a colori da parte di Viking;
- $1979$: prima foto di Giove e delle sue lune a colori da parte di Voyager;
- anni $'80$: prima foto di Saturno e delle sue lune da parte di Voyager.
