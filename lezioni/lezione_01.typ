// Setup

#import emoji: suit

// Appunti

= Lezione 01

== Introduzione

=== Storia

La *teoria dell'informazione* nasce nel 1948 grazie a *Claude Shannon* (1916-2001), un impiegato alla "Telecom" americana al quale sono stati commissionati due lavori: data una comunicazione su filo di rame, si voleva sfruttare tutta la capacità del canale, ma al tempo stesso correggere gli errori di trasmissione dovuti al rumore presente.

Nel luglio 1948 infatti viene pubblicato l'articolo "_A Mathematical Theory of Communication_" da parte di Bell Labs, dove Shannon pone le basi della teoria dell'informazione.

Ma non è l'unico personaggio che lavora in questo ambito: infatti, nel 1965, tre matematici russi pubblicano degli articoli che vanno a perfezionare il lavoro fatto anni prima da Shannon.

I tre matematici sono Gregory Chaitin (1947-), Ray Solomonoff (1926-2009) e *Andrey Kolmogorov* (1903-1987), ma si considerano solo gli articoli di quest'ultimo poiché ai tempi era molto più famoso dei primi due.

=== Shannon vs Kolmogorov

La situazione generica che troveremo in quasi la totalità dei nostri studi si può ridurre alla comunicazione tra due entità tramite un *canale affetto da rumore*.

#v(12pt)

#figure(
    image("../assets/01_canale.svg", width: 50%)
)

#v(12pt)

Quello che distingue Shannon da Kolmogorov è l'approccio: il primo propone un *approccio ingegneristico*, ovvero tramite un modello formato da una distribuzione di probabilità si va a definire cosa fa _in media_ la sorgente, mentre il secondo propone un *approccio rigoroso e formale*, dove sparisce la nozione di media e si introduce la nozione di sorgente in modo _puntuale_.

In poche parole, dato un messaggio da comprimere:
- Shannon direbbe "lo comprimo _in media_ così, e lo comprimerei così anche se il messaggio fosse totalmente diverso";
- Kolmogorov direbbe "lo comprimo _esattamente_ così, ma lo comprimerei in modo totalmente diverso se il messaggio fosse diverso".

=== Obiettivi di Shannon

Gli obiettivi che Shannon vuole perseguire sono due:
- *massimizzare* l'informazione trasmessa _ad ogni utilizzo del canale_;
- *minimizzare* il numero di errori di trasmissione dovuti alla presenza del rumore nel canale.

La parte "_ad ogni utilizzo del canale_" viene inserita per dire che, ogni volta che si accede al canale, deve essere utilizzato tutto, mentre senza questa parte una sorgente potrebbe mandare l'1% del messaggio ad ogni accesso al canale, mandandolo sì tutto ma senza sfruttare a pieno la banda.

Shannon risolverà questi due problemi con due importantissimi teoremi:
- *$I$° teorema di Shannon*, che riguarda la _source coding_, ovvero la ricerca di un codice per rappresentare i messaggi della sorgente che massimizzi l'informazione spedita sul canale, ovvero massimizzi la sua *compressione*;
- *$\I\I$° teorema di Shannon*, che riguarda la _channel coding_, ovvero la ricerca di un codice per rappresentare i messaggi della sorgente che minimizzi gli errori di trasmissione dovuti alla presenza del rumore nel canale.

L'approccio che viene usato è quello _divide-et-impera_, che in questo caso riesce a funzionare bene e riesce ad unire i risultati dei due teoremi di Shannon grazie al *teorema di codifica congiunta sorgente-canale* e ad alcune relazioni che legano i due problemi descritti.

In un caso generale del _divide-et-impera_ si ricade in una soluzione sub-ottimale.

=== Primo teorema di Shannon

Il primo problema da risolvere è il seguente: come è distribuita l'informazione all'interno di un documento?

Vediamo due esempi dove un documento viene spedito su un canale e alcune informazioni vengono perse per colpa del rumore presente nel canale.

#v(12pt)

#figure(
    image("../assets/01_poca-informazione.svg", width: 75%)
)

#v(12pt)

In questo primo esempio notiamo che, nonostante l'informazione persa sia sostanziosa, possiamo in qualche modo "risalire" a quello perso per via delle informazioni che troviamo "nelle vicinanze".

#v(12pt)

#figure(
    image("../assets/01_tanta-informazione.svg", width: 75%)
)

#v(12pt)

In questo secondo esempio notiamo invece che, nonostante l'informazione persa sia molto meno rispetto a quella precedente, "risalire" al contenuto perso è molto più difficile.

Questi due esempi dimostrano come l'informazione contenuta in un documento *non* è uniforme, e quindi che una distorsione maggiore non implica una perdita maggiore di informazioni.

L'obiettivo del primo teorema di Shannon è eliminare le informazioni inutili e ridondanti, comprimendo il messaggio per poter utilizzare il canale per inviare altre informazioni.

Quello che facciamo è concentrare l'informazione, rendendola *equamente distribuita*, quindi impossibile da ridurre ancora e contenente solo informazioni importanti.

Vediamo un altro esempio: supponiamo di avere due dadi a sei facce, uno _normale_ e uno _truccato_, e supponiamo di tirarli assieme per un numero di volte molto grande. Quale dei due dadi mi dà più informazioni?

#v(12pt)

#figure(
    image("../assets/01_dadi.svg", width: 40%)
)

#v(12pt)

La risposta è quello _normale_: nel lungo il dado _normale_ si "normalizzerà" su una probabilità di circa $1/6$ per ogni possibile faccia, quindi è una sorta di evento *regolare* che mi dà tanta informazione, mentre quello truccato posso sapere già cosa produrrà, quindi è una sorta di evento *prevedibile* che mi dà poca informazione.

In poche parole, massimizzo la probabilità di "ottenere" informazioni se le probabilità di estrarre un simbolo sono uguali.

=== Secondo teorema di Shannon

Il secondo teorema di Shannon è quello più rognoso, perché si occupa della _channel coding_, ovvero di una codifica che permetta di minimizzare l'informazione persa durante la trasmissione.

Vogliamo questo perché l'informazione che passa sul canale è compressa, quindi qualsiasi bit perso ci fa perdere molte informazioni, non essendoci ridondanza.

Quello che viene fatto quindi è aggiungere *ridondanza*, ovvero più copie delle informazioni da spedire così che, anche perdendo un bit di informazione, lo si possa recuperare usando una delle copie inviate.

La ridondanza che aggiungiamo però è *controllata*, ovvero in base al livello di distorsione del canale utilizzato si inviano un certo numero di copie.

In un *canale ideale* la ridondanza è pari a 0, mentre per canali con rumore viene usata una matrice stocastica, che rappresenta la distribuzione probabilistica degli errori.

#align(center)[
    #table(
        align: center + horizon,
        columns: (13%, 13%, 13%, 13%, 13%, 13%),
        inset: 10pt,

        [IN/OUT], [$a$], [$b$], [$c$], [$d$], [$e$],
        [$a$], [0.7], [0.0], [0.1], [0.1], [0.1],
        [$b$], [0.2], [0.8], [0.0], [0.0], [0.0],
        [$c$], [0.1], [0.0], [0.6], [0.2], [0.1],
        [$d$], [0.0], [0.0], [0.2], [0.5], [0.3],
        [$e$], [0.0], [0.0], [0.0], [0.0], [1.0]
    )
]

Ogni riga $i$ rappresenta una distribuzione di probabilità che definisce la probabilità che, spedito il carattere $i$, si ottenga uno dei valori $j$ presenti nelle colonne. Ovviamente, la somma dei valori su ogni riga è uguale a 1.

Se il canale è ideale la matrice risultante è la matrice identità.

== Codifica della sorgente

Andiamo a modellare e formalizzare il primo problema con un modello statistico, utilizzando però un approccio _semplice e bello_: assumiamo che le regole di compressione non siano dipendenti dalle proprietà di un dato linguaggio.

Ad esempio, data la lettera "H" nella lingua italiana, ho più probabilità che esca la lettera "I" piuttosto che la lettera "Z" come successiva di "H", ma questa probabilità nel nostro modello non viene considerata.

Il codice _zip_ invece prende in considerazione questo tipo di distribuzione statistica dipendente, e infatti è molto più complicato.

=== Introduzione matematica

Introduciamo una serie di "personaggi" che saranno utili nella nostra modellazione:
- insieme $Chi$: insieme finito di simboli che compongono i messaggi generati dalla sorgente;
- messaggio $overline(x)$: sequenza di $n$ simboli sorgente; in modo formale, $ overline(x) = (x_1, dots, x_n) in Chi^n, text(" con") x_i in Chi space forall i in {1, dots, n}; $
- base $D$;
- insieme ${0, dots, D-1}$: insieme finito dei simboli che compongono il codice scelto;
- insieme ${0, dots, D-1}^+$: insieme di tutte le possibili parole di codice esprimibili tramite una sequenza non vuota di simboli di codice; in modo formale, $ {0, dots, D-1}^+ = union.big_(n=1)^(infinity) {0, dots, D-1}^n . $ Un altro nome per le parole di codice è sequenze $D$-arie;
- funzione $c$: funzione (nel nostro caso _codice_) che mappa ogni simbolo $x in Chi$ in una parola di codice, ovvero una funzione del tipo $ c : Chi arrow.long {0, dots, D-1}^+. $ Questa funzione va ad effettuare un *mapping indipendente*, ovvero tutto viene codificato assumendo che non esistano relazioni tra due o più estrazioni consecutive.

=== Prima applicazione

Vogliamo trasmettere sul canale i semi delle carte da poker utilizzando il codice binario.

Andiamo a definire:
- $Chi = {suit.heart, suit.diamond, suit.club, suit.spade}$ insieme dei simboli sorgente;
- $c : Chi arrow.long {0,1}^+$ funzione di codifica;
- $c(suit.heart) = 0$;
- $c(suit.diamond) = 01$;
- $c(suit.club) = 010$;
- $c(suit.spade) = 10$.

La codifica proposta è sicuramente plausibile, ma ha due punti deboli:
- _ambiguità_: se ricevo "010" come possibili traduzioni ho:
    - $suit.club$;
    - $suit.heart suit.spade$;
    - $suit.diamond suit.heart$;
- _pessima compressione_: usiamo tre simboli di codice per codificare $suit.club$ e solo uno per codificare $suit.heart$.

Quest'ultimo punto debole viene risolto prima introducendo $l_c (x)$ come lunghezza della parola di codice associata ad $x in Chi$, e poi minimizzando la media di tutte le lunghezze al variare di $x in Chi$.

=== Modello statistico

Per completare il modello abbiamo bisogno di un'altra informazione: la *distribuzione di probabilità*, che definisce la probabilità con la quale i simboli sorgente sono emessi.

Definiamo quindi la sorgente come la coppia $angle.l Chi, p angle.r$, dove $p$ rappresenta la probabilità prima descritta.

Aggiungiamo qualche "protagonista" a quelli già prima introdotti:
- funzione $P_n$: non siamo molto interessati ai singoli simboli sorgente, ma vogliamo lavorare con i messaggi, quindi definiamo $ P_n (overline(x)) = P_n (x_1, dots, x_n) = product_(i=1)^n p(x_i). $ Possiamo applicare la produttoria perché Shannon assume che ci sia _indipendenza_ tra più estrazioni di simboli sorgente;
- variabile aleatoria $XX$: variabile aleatoria $XX : Chi arrow.long RR$ che rappresenta un'estrazione di un simbolo sorgente;
- insieme $DD$: già definito in precedenza come ${0, dots, D-1}$;
- funzione $c$: già definita in precedenza, ma che riscriviamo come $c : Chi arrow.long DD^+$.

Con questo modello, fissando $Chi$ insieme dei simboli sorgente e $D$ base, vogliamo trovare un codice $c : Chi arrow.long.r DD^+$ che realizzi la migliore compressione, ovvero che vada a minimizzare il _valore atteso_ della lunghezza delle parole di codice, definito come $EE[l_c] = limits(sum)_(x in XX) l_c (x) p(x)$.

La strategia che viene utilizzata è quella dell'alfabeto Morse: utilizziamo parole di codice corte per i simboli che sono generati spesso dalla sorgente, e parole di codice lunghe per i simboli che sono generatori raramente dalla sorgente.

Il primo problema che incontriamo è quello di evitare la _codifica banale_: se usassi il codice $ c(x) = 0 \/ 1 quad forall x in Chi $ avrei sì una codifica di lunghezza minima ma sarebbe impossibile da decodificare.

Dobbiamo imporre che il codice $c$ sia *iniettivo*, o _non-singolare_.
