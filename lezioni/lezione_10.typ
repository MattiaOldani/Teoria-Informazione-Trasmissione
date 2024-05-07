// Setup

#import "@preview/commute:0.2.0": node, arr, commutative-diagram

// Appunti

= Lezione 10

== Canale

=== Introduzione

Dobbiamo codificare un messaggio sul *canale*. Definiamo quest'ultimo come una tripla $ C equiv angle.l XX, YY, p(y bar.v x) $ dove:
- $XX$ *insieme dei simboli di input*;
- $YY$ *insieme dei simboli di output*;
- $p(y bar.v x)$ *probabilità* di ottenere $y$ dato $x$. Formalmente sarebbe più corretto scrivere $ p(Y = y bar.v X = x) $ visto che $x$ e $y$ sono due _realizzazioni_ delle variabili aleatorie $Chi$ e $Y$.

Non è detto che $XX = YY$: potremmo avere due diversi insiemi di simboli.

Useremo *canali discreti e senza memoria*, ovvero canali dove il bit ricevuto dipende solamente dal bit appena inviato.

Se un canale viene usato $n$ volte, qual è la probabilità che, inviato il messaggio $x^n = {x_1, dots, x_n}$, riceviamo il messaggio $y^n = {y_1, dots, y_n}$?

Scriviamo questa probabilità come $p(y^n bar.v x^n)$, ma visto che i simboli sono indipendenti tra loro vale $ p(y_n bar.v y^(n-1), x^n) dot.op p(y_(n-1) bar.v y^(n-2), x^n) dot.op dots.c dot.op p(y_1 bar.v y^0, x^n) . $

Visto che il canale è senza memoria allora $ p(y_n bar.v x_n) dot.op dots.c dot.op p(y_1 bar.v x_1) = product_(i=1)^n p(y_i bar.v x_i) . $

In poche parole, consideriamo solo l'ultimo simbolo inviato.

=== Canale binario senza rumore

Il *canale binario senza rumore* è il più facile e ha due rappresentazioni possibili.

==== Rappresentazione grafica

// Puoi usare la arrow duplicata
$ 0 arrow.long.squiggly 0 \ 1 arrow.long.squiggly 1 $

==== Rappresentazione matriciale

// Sistemare
$ mat(X \\ Y, 0, 1; 0, 1, 0; 1, 0, 1;) $

=== Canale binario simmetrico

Anche il *canale binario simmetrico* ha due rappresentazioni possibili.

==== Rappresentazione grafica

// Sistemare perché non è bellissimo
#align(center)[
  #commutative-diagram(
    node-padding: (120pt, 120pt),
    arr-clearance: 0.5em,
    padding: 1em,
    debug: false,

    node((0,0), [$0$]),
    node((0,1), [$0$]),
    node((1,0), [$1$]),
    node((1,1), [$1$]),
    arr((0,0), (0,1), [$1-p$]),
    arr((0,0), (1,1), [$p$]),
    arr((1,0), (0,1), [$p$]),
    arr((1,0), (1,1), [$1-p$])
  )
]

==== Rappresentazione matriciale

// Sistemare
$ mat(X \\ Y, 0, 1; 0, 1-p, p; 1, p, 1-p;) $

=== Capacità del canale

La *capacità del canale* indica quanta informazione possiamo mandare sul canale. Formalmente è definita come $ C = max_(p(Chi)) I(Chi,Y), $ dove $max_(p(x))$ prende in considerazione tutte le possibili distribuzioni di $p(x)$, ovvero la probabilità di generare un simbolo sorgente.

==== Canale binario senza rumore

Ricaviamo la capacità riscrivendo l'informazione mutua come $ C = max_(p(Chi)) (H(Chi) - H(Chi bar.v Y)) . $

Visto che $Y$ non ci dà incertezza su $Chi$, allora $H(X bar.v Y) = 0$ e quindi $ C = max_(p(Chi)) H(X) . $

Scegliendo $p(0) = p(1) = 1/2$ massimizziamo l'entropia e quindi anche la capacità del canale, che raggiunge il valore $C = 1$.

==== Canale binario simmetrico

Osserviamo prima di tutto che $ I(Chi,Y) = H(Y) - H(Y bar.v Chi) = H(Y)  H(Y bar.v Chi = 0)p(Chi = 0) - H(Y bar.v Chi = 1)p(Chi = 1) . $

// Troppo lungo, sistema
Notiamo poi che $ H(Y bar.v Chi = 0) & = -p (y = 0 bar.v x = 0) log_2 p(y = 0 bar.v x = 0) - p(y = 1 bar.v x = 0) log_2 p(y = 1 bar.v x = 0) = \ & = - (1-p) log_2 (1-p) - p log_2 p = H(p), $ dove $H(p)$ rappresenta l'entropia di una variabile aleatoria bernoulliana di parametro $p$. Analogamente, possiamo dimostrare che $H(Y bar.v X = 1) = H(p)$.

La capacità del canale si riduce quindi a $ C = max_(p(Chi)) H(Y) - H(p) . $

Cerchiamo il massimo valore di $H(Y)$: analizziamo per ora $P(Y = 1)$. $ P(Y = 1) & = P(Y = 1 bar.v Chi = 0) P(Chi = 0) + P(Y = 1 bar.v Chi = 1) P(Chi = 1) = \ & = p P(Chi = 0) + (1-p) P(Chi = 1). $

Notiamo che quando $P(X = 1) = 1/2$ abbiamo $P(Y = 1) = 1/2$: grazie a questa scelta massimizziamo $H(Y) = 1$, quindi concludiamo che $ C = 1 - H(p) . $
