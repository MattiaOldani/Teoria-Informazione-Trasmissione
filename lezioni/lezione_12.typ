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

// Appunti

= Lezione 12

== Introduzione

Il problema iniziale che ci eravamo posti era suddiviso in due parti:
- compressione del messaggio;
- ridondanza del messaggio compresso.

$ "MSG" arrow.long.squiggly "compressione" arrow.long.squiggly "ridondanza" . $

La parte di *ridondanza* è suddivisa in due sottoparti:
- *rilevazione* dell'errore;
- *correzione* dell'errore.

Suddividiamo gli errori in due categorie:
- *errori singoli*: colpiscono un certo numero di bit _singoli_ nella parola, ad esempio $1010x 01010x$;
- *errori burst*: colpiscono una serie di bit _consecutivi_, ad esempio $1x x x 01x x x x 01$.

Definiamo infine il *rumore bianco* come il rumore che ha effetto su tutti i bit allo stesso modo.

// Come sempre, non li faccio ora
== Esercizi di probabilità

Siano:
- $n$ numero di bit;
- $p$ probabilità di errore;
- $(1-p)^n$ probabilità di avere $n$ bit giusti.

=== Esercizio 01

Qual'è la probabilità di avere esattamente un errore?

RISPOSTA:

=== Esercizio 02

Qual è la probabilità di avere esattamente $l$ errori?

RISPOSTA:

=== Esercizio 03

Qual è la probabilità di avere al massimo $l$ errori?

RISPOSTA:

=== Esercizio 04

Qual è la probabilità di avere un numero pari di errori?

RISPOSTA:

== Codici di correzione

Consideriamo alcuni codici noti che permettono di rilevare errori in fase di trasmissioni e, in alcuni casi, di correggerli.

=== Single parity check code

Il *single parity check code* permette di identificare _un solo errore_ all'interno della stringa.

Questo codice calcola la *parità* della stringa di bit come $ p = sum_(i=1)^n x_i mod 2 $ e la manda insieme alla stringa per permettere al ricevente di fare un check.

Non possiamo però correggere: infatti, se cambiamo due $1$ in due $0$ otteniamo la stessa parità e il ricevente avrà un check positivo.

Per avere dei codici di rilevazione+correzione bisogna aggiungere dei bit. Il numero di bit aggiunti è chiamata *ridondanza* ed è definita come $ frac("BIT SPEDITI", "BIT DI INFORMAZIONE"), $ dove il denominatore indica il numero di bit che avremmo inizialmente spedito sul canale senza ridondanza.

// Secondo me è diverso, secondo me è (n+1)/n
In questo caso, la ridondanza è $ n/(n-1) = 1 + 1/(n-1) . $

Il valore $1/(n-1)$ è detto *ridondanza aggiunta*.

Dobbiamo trovare un compromesso tra esattezza (affidabilità) e lunghezza del messaggio (efficienza), ovvero dobbiamo sì aggiungere bit per essere affidabili ma dobbiamo anche essere efficienti.

=== Codice ASCII

==== Definizione

Il *codice ASCII* fu inizialmente pensato per $7$ bit. In questa versione viene aggiunto un ottavo bit a quelli di informazione, chiamato bit di parità, come in precedenza.

// Sistema
Il codice ASCII viene usato per errori burst ma il side effect è che errori multipli possono auto-cancellarsi.

Il codice ASCII si costruisce nel seguente modo:
+ prendere il messaggio e convertirlo in binario;
+ per ogni parola aggiungiamo un bit di parità;
+ per ogni colonna calcoliamo la checksum e aggiungiamo la parola ottenuta al messaggio.

==== Esempio

Data la stringa "Hello NCTU" calcoliamo bit di parità e conversione in binario.

#align(center)[
  #table(
    align: center + horizon,
    columns: (33%, 33%, 33%),
    inset: 10pt,

    [*LETTERA*], [*PAROLA IN BINARIO*], [*BIT DI PARITÀ*],

    [H], [$1001000$], [$0$],
    [e], [$1100101$], [$0$],
    [l], [$1101100$], [$0$],
    [l], [$1101100$], [$0$],
    [o], [$1101111$], [$0$],
    [], [$0100000$], [$1$],
    [N], [$1001110$], [$0$],
    [C], [$1000011$], [$1$],
    [T], [$1010100$], [$1$],
    [U], [$1010101$], [$0$],
  )
]

La checksum delle parole in binario è $1101110$.

=== Codici pesati

==== Definizione

I *codici pesati* aggiungono una checksum al messaggio calcolata considerando la posizione dei simboli all'interno del messaggio. Proprio per questa particolarità sono detti pesati.

Procediamo nel seguente modo per calcolare la checksum.

#align(center)[
  #table(
    align: center + horizon,
    columns: (22%, 39%, 39%),
    inset: 10pt,

    [*MESSAGGIO*], [$bold(sum)$], [$bold(sum sum)$],

    [$w$], [$w$], [$w$],
    [$x$], [$w + y$], [$2w + x$],
    [$y$], [$w + x + y$], [$2w + 2x + y$],
    [$z$], [$w + x + y + z$], [$2w + 2x + 2y + z$],
    [checksum?], [$w + x + y + z$], [$2w + 2x + 2y + z + (w + x + y + z)$],
  )
]

// Sistema
Una volta ottenuto $t = 2w + 2x + 2y + z + (w + x + y + z)$ possiamo ricavare la checksum: infatti, siano $n$ il numero di simboli dell'alfabeto e $r$ il resto tra $t$ e $n$, la checksum è quel numero tale che $ r + "checksum" equiv_n 0 . $

==== Esempio

Data la stringa $3 B beta 8$, trovare la sua checksum.

Prima di tutto notiamo che $n = |{0, dots, 9, A, dots, Z, beta}| = 37$.

// Sistema assolutamente
Calcoliamo le somme pesate come definito poco fa:
- $3$: ha indice $3$ nell'insieme, ha $sum = 3$ e $sum sum = 3$;
- $B$: ha indice $11$ nell'insieme, ha $sum = 14$ e $sum sum = 17$;
- $beta$: ha indice $36$ nell'insieme, ha $sum = 50$ e $sum sum = 67$;
- $8$: ha indice $8$ nell'insieme, ha $sum = 58$ e $sum sum = 125$;
- checksum: ha $sum = 58$ e $sum sum = 183$.

Facciamo $183 / 37 = 4$ con resto $35$: devo trovare quel numero che, sommato a $35$, è uguale a $0$ modulo $37$.

In caso caso, la checksum vale $2$.

Come controlliamo che sia giusto? Pesiamo l'indice della lettera nell'insieme con la posizione decrescente, quindi $ 3 dot 5 + 11 dot 4 + 36 dot 3 + 8 dot 2 + 2 dot 1 = 185 $ e controlliamo se questo valore è congruo a 0 modulo $n$.

// C'erano esercizi ma non ho voglia

=== Codici (M,N)

Abbiamo dato la definizione di canale come la tripla $ angle.l XX, YY, p(y bar.v x) . $ Diamo ora la definizione di canale su cui vengono spediti $n$ messaggi come la tripla $ angle.l XX^n, YY^n, p(y^n bar.v x^n) . $

Siccome siamo su canali senza memoria sappiamo che $ p(y^n bar.v x^n) = product_(i=1)^n p(y_i bar.v x_i) . $

Un codice $(M,N)$ è tale che:
- $M$ è la lunghezza del messaggio spedito sul canale. Il messaggio è formato da simboli numerati da $1$ a $M$;
- $N$ è il numero di volte che viene utilizzato il canale. Ad ogni utilizzo posso scrivere $0$ o $1$, quindi utilizzandolo $N$ volte scriviamo $N$ bit, e quindi un messaggio di dimensione massima di $2^N$.

Introduciamo le funzioni di *codifica* $ x^q : {1, dots, M} arrow.long XX^q $ e *decodifica* $ g : YY^q arrow.long {1, dots, M} . $

Sia $ x_i = p(q(y^q) eq.not i bar.v XX^q = x^q (i)) $ la *probabilità di errore* sull'i-esimo simbolo. Allora la *probabilità massima* di errore è $ x^((n)) = max_i x_i . $ La *probabilità media* invece è $ p_e^((n)) = 1/m sum_(i=1)^m x_i . $

Introdotte queste grandezze, vale la seguente disequazioni: $ p_e^((n)) lt.eq x^((n)) . $

Il *tasso di trasmissione* di un codice $(M,N)$ è dato da $ R = frac(log_2 M, N) . $ Nel caso di canale senza rumore abbiamo $R = 1$, negli altri casi invece non vale.

== Secondo teorema di Shannon

#theorem(
  name: "Secondo teorema di Shannon",
  numbering: none
)[
  Sia $angle.l XX, YY, p(y bar.v x) angle.r$ un canale con capacità $c$. Allora $forall R < c quad exists k_1, k_2, dots$ sequenza di codici dove $k_n$ è di tipo $(2^(n R_n), n)$ tale che $ lim_(n arrow infinity) R_n = R $ e $ lim_(n arrow infinity) x^((n)) k_n = 0 . $
]

$R_n$ indica il rumore: se uguale a $1$ non c'è rumore, mentre più ci avviciniamo a $0$ più ne abbiamo.

Questo teorema ci dice che:
+ più il messaggio è grande, più il rumore (sempre minore di $c$) diventa trascurabile;
+ la probabilità massima di errore tende a $0$ con il crescere della lunghezza del messaggio.
