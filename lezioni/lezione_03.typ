// Setup

#import emoji: square

// Appunti

= Lezione 03

== Codice di Shannon

=== Definizione

Abbiamo trovato un modo per verificare se un codice è istantaneo (osservare i prefissi) e un modo per verificare se $n$ lunghezze positive possono essere usate come lunghezze di un codice istantaneo (disuguaglianza di Kraft), ma quale di questi codici istantanei è il migliore possibile?

Andiamo a vedere un modo per *costruire* un codice istantaneo a partire dai simboli sorgente e dalle loro probabilità di essere estratti dalla sorgente.

Dati il modello $angle.l Chi, p angle.r$ e $D > 1$, vogliamo trovare $n$ lunghezze positive $l_1, dots, l_n$ per costruire un codice istantaneo con le lunghezze appena trovate minimizzando $EE[l_c]$, ovvero: $ cases(limits("minimize")_(l_1, dots, l_n) limits(sum)_(i=1)^n l_i p_i, "tale che" limits(sum)_(i=1)^n D^(-l_i) lt.eq 1) quad . $

Quello che vogliamo fare è cercare $n$ lunghezze positive $l_1, dots, l_n$ che minimizzino il valore atteso della lunghezza delle parole di codice e che soddisfino la disuguaglianza di Kraft.

Abbiamo a disposizione:
- $Chi = {x_1, dots, x_n}$ insieme dei simboli sorgente, con $abs(Chi) = n$;
- $P = {p_i, dots, p_n}$ insieme delle probabilità, con $p_i = p(x_i)$ e $limits(sum)_(i=1)^n p_i = 1$.

Vogliamo trovare $L = {l_1, dots, l_n}$ insieme delle lunghezze delle parole di codice.

Andiamo ad unire la disuguaglianza di Kraft con la definizione di probabilità: infatti, sapendo che $limits(sum)_(i=1)^n p_i = 1$, andiamo a sostituire questa sommatoria al posto del valore $1$ all'interno della disuguaglianza di Kraft, ottenendo $ sum_(i=1)^m D^(-l_i) lt.eq sum_(i=1)^m p_i = 1. $ Sicuramente questa disuguaglianza vale se imponiamo $ D^(-l_i) lt.eq p_i quad forall i = 1, dots, n $ ma allora $ D^(l_i) dot D^(-l_i) lt.eq p_i dot D^(l_i) arrow.double.long D^(l_i) gt.eq 1 / p_i arrow.double.long l_i gt.eq log_D 1 / p_i . $

Non sempre però il logaritmo mi rappresenta delle quantità intere, quindi andiamo ad arrotondare per eccesso questo conto: $ l_i = ceil(log_D 1 / p_i) . $

Abbiamo così trovato le lunghezze del mio codice istantaneo, legate in modo stretto alla probabilità di estrarre un simbolo.

Il codice così trovato viene detto *codice di Shannon*, o _codice di Shannon-Fano_, e siamo sicuri che è un codice "che fa bene": infatti, usa tante parole di codice per simboli che vengono estratti raramente, e poche parole di codice per simboli che vengono estratti frequentemente.

// Aggiungere un grafico?
Questa proprietà viene dal fatto che il logaritmo, essendo una funzione monotona crescente, produce:
- valori "grandi" quando viene calcolato con numeri "grandi", quindi quando $1/p_i$ è "grande" e quindi $p_i$ è "piccolo";
- valori "piccoli" quando viene calcolato con numeri "piccoli", quindi quando $1/p_i$ è "piccolo" e quindi $p_i$ è "grande".

=== Esempi

==== Base / migliore

Supponiamo che la sorgente $S$ emetta $n = 4$ simboli con probabilità $P = {1/2, 1/4. 1/8, 1/8}$, vogliamo costruire un codice binario istantaneo.

Calcoliamo le lunghezze con l'algoritmo proposto da Shannon:
#v(6pt)
- $l_1 = ceil(log_2 1 / (1/2)) = ceil(log_2 2) = 1$;
#v(6pt)
- $l_2 = ceil(log_2 1 / (1/4)) = ceil(log_2 4) = 2$;
#v(6pt)
- $l_(3,4) = ceil(log_2 1 / (1/8)) = ceil(log_2 8) = 3$.

Calcoliamo il valore atteso come $EE[l_c] = limits(sum)_(i = 1)^4 l_i p_i = 1 dot 1/2 + 2 dot 1/4 + 3 dot 1/8 + 3 dot 1/8 = 7/4$.

Il valore che abbiamo trovato è il migliore possibile?

La risposta è sì, e questo vale perché tutte le probabilità sono _potenze negative_ della base $D$ scelta, nel nostro caso $D = 2$.

Possiamo affermare questo perché le lunghezze $l_i$ saranno esattamente uguali a $log_D 1 / p_i$ senza eseguire nessuna approssimazione.

==== Degenere

Supponiamo che la sorgente $S$ emetta $n = 4$ simboli con probabilità $P = {1, 0, 0, 0}$, vogliamo costruire un codice binario istantaneo.

Calcoliamo le lunghezze con l'algoritmo proposto da Shannon:
#v(6pt)
- $l_1 = ceil(log_2 1 / 1) = ceil(log_2 1) = 0$;
#v(6pt)
- $l_(2,3,4) = ceil(limits(lim)_(t arrow 0^+) log_2 1 / t) = ceil(lim_(t arrow 0^+) log_2 +infinity) = +infinity$.

Calcoliamo il valore atteso come $EE[l_c] = limits(sum)_(i = 1)^4 l_i p_i = 0 dot 1 + underbracket(0 dot (+infinity) + 0 dot (+infinity) + 0 dot (+infinity),  0 "per" t arrow 0^+)$ = 0.

==== Equiprobabile

Supponiamo che la sorgente $S$ emetta $n = 4$ simboli con probabilità $P = {1/n, 1/n, 1/n, 1/n}$, vogliamo costruire un codice binario istantaneo.

Calcoliamo le lunghezze con l'algoritmo proposto da Shannon:
#v(6pt)
- $l_(1,2,3,4) = ceil(log_2 1 / (1 / 4)) = ceil(log_2 4) = 2$.

Calcoliamo il valore atteso come $EE[l_c] = limits(sum)_(i = 1)^4 l_i p_i = 2 dot 1 / 4 + 2 dot 1 / 4 + 2 dot 1 / 4 + 2 dot 1 / 4 = 2$.

=== Entropia

Nel codice di Shannon andiamo a definire $l_i = ceil(log_D 1 / p_i)$, quindi sostituiamo $l_i$ nel valore atteso che stiamo cercando di minimizzare, ottenendo $EE[l_c] = limits(sum)_(i=1)^n p_i log_D 1 / p_i$.

La quantità che abbiamo appena scritto si chiama *entropia*, e la usiamo perché è in stretta relazione con la codifica ottimale che possiamo realizzare. In particolare, l'entropia è il _limite inferiore_ alla compattezza del codice.

Tutti i valori attesi che abbiamo calcolato negli esempi precedenti sono anche le entropie delle varie sorgenti, ma che valori assume questa entropia?

Sicuramente è una quantità _positiva o nulla_, visto la somma di prodotti di fattori _positivi o nulli_.

Inoltre, raggiunge il proprio massimo quando la distribuzione di probabilità è *uniforme*, e vale $ sum_(i=1)^n p_i log_D 1/p_i = sum_(i=1)^n 1/m log_D m = cancel(m) dot 1 / cancel(m) dot log_D m = log_D m. $

In questo caso otteniamo un _albero perfettamente bilanciato_ con le codifiche a livello delle ultime foglie.

Questo mi va a dire che il codice è _compatto_ e bilanciato, non spreco bit, mentre in altre situazioni ho un albero _sbilanciato_ e potrei perdere dei bit.

== Codice di Huffman

Supponiamo che la sorgente $S$ emetta $n = 7$ simboli con probabilità $P = {0.3, 0.2, 0.2, 0.1, 0.1, 0.06, 0.04}$. Vogliamo costruire un codice ternario istantaneo.

Qui abbiamo due diversi approcci:
- codice di Shannon: otteniamo come lunghezze $2,2,2,3,3,3,3$;
- _grafico_: dato un albero ternario, associamo ai nodi più in alto le parole di codice dei simboli con probabilità maggiore.

#v(12pt)

#figure(
    image("../assets/03_approccio-grafico.svg", width: 100%)
)

#v(12pt)

Nell'immagine vediamo come prima inseriamo i simboli con probabilità $0.3$ e $0.2$, poi come terzo nodo mettiamo un "checkpoint" e iniziamo la procedura di nuovo da quest'ultimo nodo.

=== Definizione

Abbiamo in realtà un terzo approccio al problema precedente, ideato da *David Huffman* nel 1953, che lavora nel seguente modo:
+ ordino le probabilità in ordine decrescente;
+ le ultime $D$ probabilità sono sostituite dalla loro somma, e i simboli corrispondenti sono sostituiti da un simbolo "fantoccio", creando una nuova sorgente "fantoccia";
+ ripeto dal punto $1$ fino a quando non si raggiungono $t$ probabilità, con $t lt.eq D$;
+ scrivo il codice di Huffman facendo un "rollback" alla sorgente iniziale.

Il codice così creato è detto *codice di Huffman*, ed è il _codice istantaneo ottimo_ che possiamo costruire.

Supponiamo che la sorgente $S$ emetta $n = 7$ simboli $s_1, dots, s_7$ con probabilità $P = {0.3, 0.2, 0.2, 0.1, 0.1, 0.06, 0.04}$, vogliamo costruire un codice ternario di Huffman.

#v(12pt)

#figure(
    image("../assets/03_huffman-compressione.svg", width: 65%)
)

#v(12pt)

In questa prima fase andiamo a "compattare" le probabilità minori fino ad avere una situazione con esattamente $D = 3$ simboli.

#v(12pt)

#figure(
    image("../assets/03_huffman-generazione.svg", width: 65%)
)

#v(12pt)

Nella seconda fase invece andiamo ad eseguire un "rollback" delle compressioni, sostituendo ad ogni nodo "compresso" le vecchie probabilità, andando quindi a costruire l'_albero_ di codifica.

#v(12pt)

#figure(
    image("../assets/03_albero-huffman.svg", width: 75%)
)

#v(12pt)

Supponiamo ora che la sorgente $S$ emetta $n = 8$ simboli $s_1, dots, s_7, s_8$ con probabilità $P = {0.3, 0.2, 0.2, 0.1, 0.1, 0.06, 0.02, 0.02}$, vogliamo costruire un codice ternario di Huffman.

Considerando che ad ogni iterazione perdiamo $D = 3$ simboli e ne aggiungiamo uno, in totale perdiamo $D - 1$ simboli. Considerando che l'algoritmo genera il codice istantaneo ottimo quando termina con esattamente $D$ probabilità, in questo esempio alla fine delle iterazioni ci troveremmo con solo due simboli sorgente, e non tre, quindi la codifica non risulta ottimale.

#v(12pt)

#figure(
    image("../assets/03_albero-huffman-errato.svg", width: 75%)
)

#v(12pt)

Infatti, notiamo come alla radice perdiamo un ramo, andando ad aumentare di conseguenza l'altezza dell'albero.

La soluzione proposta da Huffman consiste nell'inserire un numero arbitrario di simboli "fantoccio" con probabilità nulla, così da permettere poi un'ottima "compressione" fino ad avere $D$ simboli.

Ma quanti simboli nuovi dobbiamo inserire? 

Supponiamo di partire da $n$ simboli e rimuoviamo ogni volta $D - 1$ simboli: $ n arrow.long n - (D - 1) arrow.long n - 2 dot (D - 1) arrow.long dots arrow.long n - t dot (D - 1). $ Chiamiamo $square.black = n - t dot (D - 1)$. Siamo arrivati ad avere $square.black$ elementi, con $square.black lt.eq D$, ma noi vogliamo esattamente $D$ elementi per avere un albero ben bilanciato e senza perdita di rami, quindi aggiungiamo a $square.black$ un numero $k$ di elementi tali per cui $square.black + k = D$. Supponiamo di eseguire ancora un passo dell'algoritmo, quindi da $square.black + k$ andiamo a togliere $D - 1$ elementi, lasciando la sorgente con un solo elemento.

Cosa abbiamo ottenuto? Ricordando che $square.black = n - t dot (D - 1)$, abbiamo fatto vedere che: $ square.black + k - (D - 1) &= 1 \ n - t dot (D - 1) + k - (D - 1) &= 1 \ n + k - (t + 1) dot (D - 1) &= 1. $

In poche parole, il numero $n$ di simboli sorgente, aggiunto al numero $k$ di simboli "fantoccio", è congruo ad $1$ modulo $D - 1$, ovvero $ n + k equiv 1 mod D - 1. $

Ripetiamo l'esempio precedente, aggiungendo il simbolo $s_9$ ad $S$ con probabilità $0$.

#v(12pt)

#figure(
    image("../assets/03_albero-huffman-esteso.svg", width: 75%)
)

#v(12pt)

Con che ordine vado a inserire i simboli "compressi" dentro la lista delle probabilità? In modo _random_, quindi non è detto che il codice generato sia unico e ottimo.
