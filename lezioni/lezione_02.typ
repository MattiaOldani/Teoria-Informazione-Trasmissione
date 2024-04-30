// Setup

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "lemma"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

// Appunti

= Lezione 02

== Codici

Come detto nella scorsa lezione, andiamo a considerare dei codici non singolari per risolvere la problematica dei due _codici banali_, che minimizzavano sì il valore atteso delle lunghezze delle parole di codice $l_c (x)$, ma rendevano impossibile la decodifica.

Andiamo ora a raffinare ulteriormente i codici singolari presi in considerazione.

=== Codice univocamente decodificabile

Come detto nella scorsa lezione, siamo interessati alle parole che vengono generate dalla mia sorgente, e non ai singoli caratteri.

Andiamo a definire:
- $Chi = {suit.heart, suit.diamond, suit.club, suit.spade}$ insieme dei simboli sorgente;
- $c : Chi arrow.long.r {0,1}^+$ funzione di codifica;
- $c(suit.heart) = 0$;
- $c(suit.diamond) = 01$;
- $c(suit.club) = 010$;
- $c(suit.spade) = 10$.

La codifica $c$ scelta è sicuramente non singolare, però abbiamo delle problematiche a livello di decodifica: infatti, possiamo scrivere $01001$ come
- $c(suit.club, suit.diamond)$;
- $c(suit.diamond, suit.heart, suit.diamond)$;
- $c(suit.heart, suit.spade, suit.diamond)$
e lato ricevente questo è un problema, perché "unendo" le singole codifiche non otteniamo una parola che è generabile in modo unico.

Introduciamo quindi l'*estensione* di un codice $c$: essa è un codice $C : Chi^+ arrow.long.r DD^+$ definito come $C(x_1, dots, x_n) = c(x_1) dots c(x_n)$ che indica la sequenza ottenuta giustapponendo le parole di codice $c(x_1), dots, c(x_n)$.

L'estensione $C$ di un codice $c$ non eredita in automatico la proprietà di non singolarità di $c$.

Un codice $c$ è *univocamente decodificabile* quando la sua estensione $C$ è non singolare.

Tramite l'*algoritmo di Sardinas-Patterson* siamo in grado di stabilire se un codice è univocamente decodificabile in tempo $O(\m\L)$, dove $m = abs(Chi)$ e $L = limits(sum)_(x in Chi) l_c (x)$ 

=== Codice istantaneo

I codici univocamente decodificabili sono ottimali? Sto minimizzando al meglio $EE[l_c]$?

Prima di chiederci questo vogliamo creare un codice che rispetti un'altra importante proprietà: permetterci di decodificare _subito_ quello che mi arriva dal canale senza dover aspettare tutto il flusso.

Andiamo a definire:
- $Chi = {suit.heart, suit.diamond, suit.club, suit.spade}$ insieme dei simboli sorgente;
- $c : Chi arrow.long.r {0,1}^+$ funzione di codifica;
- $c(suit.heart) = 10$;
- $c(suit.diamond) = 00$;
- $c(suit.club) = 11$;
- $c(suit.spade) = 110$.

Supponiamo di spedire sul canale la stringa $11000 dots 00$, e poniamoci lato ricevente. In base al numero di $0$ inviati abbiamo due possibili decodifiche:
- $\#0$ pari: decodifichiamo con $suit.club suit.diamond dots suit.diamond$;
- $\#0$ dispari: decodifichiamo con $suit.spade suit.diamond dots suit.diamond$.

Nonostante si riesca perfettamente a decodificare, e questo è dato dal fatto che $c$ è un codice univocamente decodificabile, dobbiamo aspettare di ricevere tutta la stringa per poterla poi decodificare, ma in ambiti come lo _streaming_ questa attesa non è possibile.

Un altro problema lo riscontriamo a livello di memoria: supponiamo che lato sorgente vengano codificati dei dati dell'ordine dei terabyte, per il ricevente sarà impossibile tenere in memoria una quantità simile di dati per fare la decodifica alla fine della ricezione.

Introduciamo quindi i *codici istantanei*, particolari codici che permettono di decodificare quello che arriva dal canale, appunto, in modo _istantaneo_ senza aspettare.

Un codice si dice istantaneo se nessuna parola di codice è _prefissa_ di altre.

Andiamo a definire:
- $Chi = {suit.heart, suit.diamond, suit.club, suit.spade}$ insieme dei simboli sorgente;
- $c : Chi arrow.long.r {0,1}^+$ funzione di codifica;
- $c(suit.heart) = 0$;
- $c(suit.diamond) = 10$;
- $c(suit.club) = 110$;
- $c(suit.spade) = 111$.

Il seguente codice è istantaneo, e lo notiamo osservando l'_albero_ che dà origine a questo codice.

#v(12pt)

#figure(
    image("../assets/02_albero-istantaneo.svg", width: 25%)
)

#v(12pt)

Quello che otteniamo è un albero molto sbilanciato.

=== Gerarchia dei codici

Cerchiamo infine di definire una *gerarchia* tra i codici analizzati fin'ora: se siamo sicuri che i codici non singolari siano sotto-insieme di tutti i codici (_banale_), e che i codici univocamente decodificabili siano sotto-insieme dei codici non singolari (_banale_), siamo sicuri che i codici istantanei siano un sotto-insieme dei codici univocamente decodificabili?

#lemma(numbering: none)[
  Se $c$ è istantaneo allora è anche univocamente decodificabile.
]

#proof[
    \ Andiamo a dimostrare che se $c$ non è univocamente decodificabile allora non è istantaneo. Visto che $c$ non è univocamente decodificabile (supponiamo sia almeno non singolare) esistono due messaggi distinti $x_1, x_2 in Chi^+$ tali che $C(x_1) = C(x_2)$. 
    
    Ci sono solo due modi per avere $x_1$ e $x_2$ distinti:
    + un messaggio è prefisso dell'altro: se $x_1$ è formato da $x_2$ e altri $m$ caratteri, vuol dire che i restanti $m$ caratteri di $x_1$ devono essere codificati con la parola vuota, che per definizione di codice non è possibile, e soprattutto la parola vuota sarebbe prefissa di ogni altra parola di codice, quindi il codice $c$ non è istantaneo;
    + esiste almeno una posizione in cui i due messaggi differiscono: sia $i$ la prima posizione dove i due messaggi differiscono, ovvero $x_1[i] eq.not x_2[i]$ e $x_1[j] = x_2[j]$ per $1 lt.eq j lt.eq i - 1$, ma allora $c(x_1[i]) eq.not c(x_2[i])$ e $c(x_1[j]) = c(x_2[j])$ perché $c$ è non singolare, quindi sto dicendo che $x_1$ deve avere $x_2$ come prefisso (o viceversa), ma, come al punto precedente, otteniamo che $c$ non è istantaneo.
	Quindi il codice $c$ non è istantaneo.
]

Abbiamo quindi stabilito una gerarchia di questo tipo: $ "codici istantanei" subset "codici univocamente decodificabili" subset "codici non singolari" subset "codici" . $

Una cosa che possiamo notare è come, aumentando di volta in volta le proprietà di un codice, il valore atteso $EE[l_c]$ che vogliamo minimizzare peggiora, o al massimo rimane uguale: questo perché aggiungendo delle proprietà al nostro codice imponiamo dei limiti che aumentano in modo forzato la lunghezza delle nostre parole di codice.

== Disuguaglianza di Kraft

=== Definizione

I codici istantanei soddisfano la *disuguaglianza di Kraft*, che ci permette, solo osservando le lunghezze delle parole di codice $l_c (x)$, di dire _se esiste_ un codice istantaneo con quelle lunghezze.

#theorem(
    name: "Disuguaglianza di Kraft",
    numbering: none
)[
    Dati $Chi = {x_1, dots, x_n}$, $D > 1$ e $n$ valori interi positivi $l_1, dots, l_n$, esiste un codice istantaneo $c : Chi arrow DD^+$ tale che $l_c (x_i) = l_i$ per $i = 1, dots, n$ se e solo se $ sum_(i=1)^(n) D^(-l_i) lt.eq 1. $
]

#proof[
    \ ($arrow.long.double$) Sia $l_(max)$ la lunghezza massima delle parole di $c$, ovvero $l_(max) = limits(max)_(i = 1, dots, n) (l_c (x_i))$. Si consideri l'albero $D$-ario completo di profondità $l_(max)$ nel quale posizioniamo ogni parola di codice di $c$ su un nodo dell'albero, seguendo dalla radice il cammino corrispondente ai simboli della parola. Dato che il codice è istantaneo, nessuna parola apparterrà al sotto-albero avente come radice un'altra parola di codice, altrimenti avremmo una parola di codice prefissa di un'altra. Andiamo ora a partizionare le foglie dell'albero in sottoinsiemi disgiunti $A_1, dots, A_n$, dove $A_i$ indica il sottoinsieme di foglie associate alla radice contenente la parola $c(x_i)$. \
	Nel seguente esempio consideriamo un albero binario di altezza $3$, e in rosso sono evidenziate le parole di codice $1$, $00$, $010$, e $011$. \
    #v(12pt)
    #figure(
        image("../assets/02_albero-dimostrazione.svg", width: 100%)
    )
    #v(12pt)
    Il numero massimo di foglie di un sotto-albero di altezza $l_i$ è $D^(l_(max) - l_i)$, ma il numero massimo di foglie nell'albero è $D^(l_(max))$, quindi $ underbracket(sum_(i=1)^n abs(A_i) = sum_(i=1)^n D^(l_(max) - l_i), "#foglie coperte") = sum_(i=1)^n D^(l_(max)) dot D^(-l_i) = D^(l_(max)) sum_(i=1)^n D^(-l_i) lt.eq D^(l_(max)). $
    Dividendo per $D^(l_(max))$ entrambi i membri otteniamo la disuguaglianza di Kraft.
    
    ($arrow.long.double.l$) Assumiamo di avere $n$ lunghezze positive $l_1, dots, l_n$ che soddisfano la disuguaglianza di Kraft e sia $l_(max) = limits(max)_(i = 1, dots, n) (l_i)$ la profondità dell'albero $D$-ario ordinato e completo usato prima. Associamo ad ogni simbolo $x_i in Chi$ la parola di codice $c(x_1)$, e la inseriamo al primo nodo di altezza $l_i$ che troviamo in ordine lessicografico. Durante l'inserimento delle parole $c(x_i)$ dobbiamo escludere tutti i nodi che appartengono a sotto-alberi con radice una parola di codice già inserita o che includono un sotto-albero con radice una parola di codice già inserita. Il codice così costruito è istantaneo, e visto che rispetta la disuguaglianza di Kraft, la moltiplichiamo da entrambi i membri per $D^(l_(max))$ per ottenere $ sum_(i=1)^n D^(l_(max) - l_i) lt.eq D^(l_(max)), $ ovvero il numero di foglie necessarie a creare il codice non eccede il numero di foglie disponibili nell'albero.
]

=== Applicazione

Andiamo a definire:
- $Chi = {suit.heart, suit.diamond, suit.club, suit.spade}$ insieme dei simboli sorgente;
- $c : Chi arrow.long.r {0,1}^+$ funzione di codifica;
- $l_c (suit.heart) = 3$;
- $l_c (suit.diamond) = 1$;
- $l_c (suit.club) = 3$;
- $l_c (suit.spade) = 2$.

Vogliamo sapere se esiste un codice istantaneo, definito come $c$, aventi le lunghezze sopra definite. Controlliamo quindi se esse soddisfano la disuguaglianza di Kraft: $ sum_(x in Chi) 2^(-l_c (x)) = 2^(-3) + 2^(-1) + 2^(-3) + 2^(-2) = 1 / 8 + 1 / 2 + 1 / 8 + 1 / 4 = 1 lt.eq 1. $

Andiamo a costruire quindi un codice istantaneo con queste lunghezze costruendo il suo albero.

#v(12pt)

#figure(
    image("../assets/02_albero-kraft-1.svg", width: 100%)
)

#v(12pt)

Il codice ottenuto è l'unico possibile?

#v(12pt)

#figure(
    image("../assets/02_albero-kraft-2.svg", width: 100%)
)

#v(12pt)

Come vediamo, "specchiando" il sotto-albero sinistro con radice ad altezza $1$ otteniamo un codice istantaneo diverso dal precedente, ma comunque possibile.

Possiamo concludere quindi che, date $n$ lunghezze positive $l_1, dots, l_n$ che soddisfano la disuguaglianza di Kraft, in generale _non è unico_ il codice istantaneo che si può costruire.
