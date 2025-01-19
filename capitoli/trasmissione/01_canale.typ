// Setup

#import "../alias.typ": *

#import "@preview/fletcher:0.5.4": diagram, node, edge

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Canale

== Definizione

Per ora ci siamo concentrati sulla prima parte del problema che aveva formulo Shannon, ovvero cercare di comprimere al massimo il messaggio da spedire sul canale. Ora ci concentriamo sul secondo problema, ovvero cercare di codificare il canale stesso per aggiungere ridondanza.

Un *canale* è definito dalla tupla $ canale(X, Y, p(y bar.v x)) $ formata da:
- $X$ insieme dei simboli della sorgente;
- $Y$ insieme dei simboli del ricevente;
- $p(y bar.v x)$ probabilità di ottenere $y in Y$ sapendo che è stato ricevuto $x in X$. Questa probabilità è la *matrice di canale*, che ci consente di definire il comportamento del canale.

Noi useremo un *canale discreto senza memoria*:
- *discreto*: lavoriamo con i simboli della sorgente e del ricevente che sono un numero finito;
- *senza memoria*: sia $x^n = (x_1 dots.c x_n)$ un messaggio di $n$ simboli di $X$ e sia $y^n = (y_1 dots.c y_n)$ un messaggio di $n$ simboli di $Y$. Osserviamo che, per la Chain Rule della probabilità, vale $ p(a,b,c) = p(a bar.v b, c) p(b bar.v c) p(c) . $ Ma allora $ p(y^n bar.v x^n) &= p(y_n bar.v y^(n-1) x^n) p(y_(n-1) bar.v y^(n-2) x^n) dots.c p(y_3 bar.v y^2 x^n) p(y_2 bar.v y^1 x^n) p(y_1 bar.v x^n) . $ Il canale è _senza memoria_, ovvero il canale si disinteressa di quello che è stato spedito prima del carattere appena ricevuto e di quello che verrà spedito dopo il carattere appena ricevuto. Quindi: $ p(y^n bar.v x^n) = p(y_n bar.v x_n) p(y_(n-1) bar.v x_(n-1)) dots.c p(y_1 bar.v x_1) = product_(i=1)^n p(y_i bar.v x_i) . $

Dobbiamo definire un'ultima cosa: la *capacità del canale*. Essa rappresenta la massima informazione che possiamo trasmettere quando accediamo al canale. Se immaginiamo un fiume, la capacità di quest'ultimo è la sua portata, ovvero quanta acqua passa nell'unità di tempo. In un canale, l'informazione è l'acqua e l'accesso al canale è l'unità di tempo.

La capacità di un canale $canale(X,Y,p(y bar.v x))$ è definita come $ C = max_(p(x)) I(XX,YY) , $ ovvero su tutte le distribuzioni di probabilità di $XX$ prendiamo l'informazione mutua massima.

Noi sappiamo che $I(XX,YY) gt.eq 0$, ma anche che $ I(XX,YY) &= H(XX) - H(XX bar.v YY) \ &= H(YY) - H(YY bar.v XX) . $

Nella prima relazione $H(XX) lt.eq log_2(abs(X))$ quindi $H(XX) - H(XX bar.v YY) lt.eq log_2(abs(X))$. Possiamo fare un discorso analogo per la seconda relazione, ovvero $H(YY) - H(YY bar.v XX) lt.eq log_2(abs(Y))$. Per far valere entrambe le relazioni prendiamo il minimo tra le due quantità. Ma allora $ 0 lt.eq C lt.eq min(log_2(abs(X)), log_2(abs(Y))) . $

== Canale binario senza rumore

Un *canale binario senza rumore* è il canale più semplice che possiamo costruire.

#v(12pt)

#align(center)[
  #diagram(
    node-stroke: .1em,
    spacing: 4em,

    node((0, 0), $0$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0), $0$, radius: 2em, fill: green.lighten(50%)),
    node((0, 0.75), $1$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0.75), $1$, radius: 2em, fill: green.lighten(50%)),

    edge((0, 0), (2, 0), $1$, "-|>"),
    edge((0, 0.75), (2, 0.75), $1$, "-|>"),
  )
]

#v(12pt)

#set math.mat(delim: none)

Siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. Essendo in un canale binario, abbiamo che $ X = Y = {0,1} . $

Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1; 0, 1, 0; 1, 0, 1; augment: #(hline: 1, vline: 1)) quad . $

Calcoliamo l'informazione mutua con $ I(XX,YY) = H(XX) - H(XX bar.v YY) = H(XX) . $ La capacità $C$ è il massimo di tutte le informazioni mutue, quindi il massimo delle entropie di $XX$, ma $XX$ è una bernoulliana che ha valore massimo $1$, e quindi anche la capacità è $1$.

== Canale con rumore e uscite disgiunte

Un *canale con rumore e uscite disgiunte* è un esempio di canale che pesca da due insiemi diversi.

#v(12pt)

#align(center)[
  #diagram(
    node-stroke: .1em,
    spacing: 4em,

    node((2, 0), $0$, radius: 2em, fill: green.lighten(50%)),
    node((0, 0.75), $0$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0.75), $1$, radius: 2em, fill: green.lighten(50%)),
    node((0, 1.5), $1$, radius: 2em, fill: red.lighten(50%)),
    node((2, 1.5), $2$, radius: 2em, fill: green.lighten(50%)),
    node((2, 2.25), $3$, radius: 2em, fill: green.lighten(50%)),

    edge((0, 0.75), (2, 0), $1 / 2$, "-|>"),
    edge((0, 0.75), (2, 0.75), $1 / 2$, "-|>"),
    edge((0, 1.5), (2, 1.5), $1 / 2$, "-|>"),
    edge((0, 1.5), (2, 2.25), $1 / 2$, "-|>"),
  )
]

#v(12pt)

Siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. In questo caso abbiamo $ X = {0,1} quad bar.v quad Y = {0,1,2,3} . $

Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1, 2, 3; 0, 0.5, 0.5, 0, 0; 1, 0, 0, 0.5, 0.5; augment: #(hline: 1, vline: 1)) quad . $

Calcoliamo la capacità del canale come $ C = max_(p(x)) I(XX,YY) = max_(p(x)) H(XX) - H(XX bar.v YY) . $ La seconda quantità è $0$ perché sapendo $YY$ sappiamo anche la $XX$. Dobbiamo quindi massimizzare $H(XX)$, ma questa è una bernoulliana che ha valore massimo $1$, quindi la capacità è $1$.

== Macchina da scrivere rumorosa

La *macchina da scrivere rumorosa* è un canale lievemente più complesso di quelli visti per ora.

#v(12pt)

#align(center)[
  #diagram(
    node-stroke: .1em,
    spacing: 4em,

    node((0, 0), $0$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0), $0$, radius: 2em, fill: green.lighten(50%)),
    node((0, 0.75), $1$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0.75), $1$, radius: 2em, fill: green.lighten(50%)),
    node((4, 1.5), $2$, radius: 2em, fill: red.lighten(50%)),
    node((2, 1.5), $2$, radius: 2em, fill: green.lighten(50%)),

    edge((0, 0), (2, 0), $1 / 2$, "-|>"),
    edge((0, 0), (2, 0.75), $1 / 2$, "-|>"),
    edge((0, 0.75), (2, 0.75), $1 / 2$, "-|>"),
    edge((0, 0.75), (2, 1.5), $1 / 2$, "-|>"),
    edge((4, 1.5), (2, 1.5), $1 / 2$, "-|>"),
    edge((4, 1.5), (2, 0), $1 / 2$, "-|>"),
  )
]

#v(12pt)

Siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. In questo caso abbiamo $ X = Y = {0,1,2} . $

Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1, 2; 0, 0.5, 0.5, 0; 1, 0, 0.5, 0.5; 2, 0.5, 0, 0.5; augment: #(hline: 1, vline: 1)) quad . $

Calcoliamo la capacità del canale come $ C = max_(p(x)) I(XX,YY) = max_(p(x)) H(YY) - H(YY bar.v XX) . $ Valutiamo la seconda quantità come $ H(YY bar.v XX) &= p(XX = 0) H(YY bar.v XX = 0) + p(XX = 1) H(YY bar.v XX = 1) + p(XX = 2) H(YY bar.v XX = 2) = \ &= p_0 H(YY bar.v XX = 0) + p_1 H(YY bar.v XX = 1) + p_2 H(YY bar.v XX = 2) . $

Non conosciamo $p_0,p_1,p_2$ ma sappiamo che l'entropia viene massimizzata quando le probabilità dei simboli sono distribuite uniformemente, quindi assumiamo l'uniformità $ p_0 = p_1 = p_2 = 1/3 . $

Calcoliamo ogni entropia come $ forall i in {0,1,2} quad H(YY bar.v XX = i) = sum_(k=0)^2 p(y_k bar.v XX = i) log_2(1 / p(y_k bar.v XX = i)) . $

Non abbiamo voglia di fare i conti, quindi qualcuno ci dice che le entropie valgono $1$. Ma allora $ H(YY bar.v XX) = p_0 + p_1 + p_2 = 1 . $

Rimane solo $H(YY)$. Scegliamo una distribuzione uniforme che massimizzi l'entropia, quindi $ p(YY = 0) = p(YY = 1) = p(YY = 2) =_("TPT") (1/3 dot 1/2) + (1/3 dot 1/2) = 1/3 . $

L'entropia diventa quindi $ H(YY) = sum_(i=0)^2 p(y_i) log_2(1/p(y_i)) = 3 dot 1/3 log_2(3) = log_2(3) . $

La capacità è quindi $ C = log_2(3) - 1 approx 0.585 . $

== Canale binario simmetrico

Vediamo ora due canali ancora più complessi: partiamo dal *canale binario simmetrico*.

#v(12pt)

#align(center)[
  #diagram(
    node-stroke: .1em,
    spacing: 4em,

    node((0, 0), $0$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0), $0$, radius: 2em, fill: green.lighten(50%)),
    node((4, 0.75), $1$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0.75), $1$, radius: 2em, fill: green.lighten(50%)),

    edge((0, 0), (2, 0), $1 - p$, "-|>"),
    edge((0, 0), (2, 0.75), $p$, "-|>"),
    edge((4, 0.75), (2, 0.75), $1 - p$, "-|>"),
    edge((4, 0.75), (2, 0), $p$, "-|>"),
  )
]

#v(12pt)

Siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. In questo caso abbiamo $ X = Y = {0,1} . $

Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1; 0, 1-p, p; 1, p, 1-p; augment: #(hline: 1, vline: 1)) quad . $

Calcoliamo la capacità del canale come $ C = max_(p(x)) I(XX,YY) = max_(p(x)) H(YY) - H(YY bar.v XX) . $ Valutiamo la seconda quantità come $ H(YY bar.v XX) = sum_(i=0)^1 p(XX = i) H(YY bar.v XX = i) . $

Calcoliamo $H(YY bar.v XX = i)$ per $i in {0,1}$: $ H(YY bar.v XX = 0) &= p(YY = 0 bar.v XX = 0) log_2(1 / p(YY = 0 bar.v XX = 0)) + \ &+ space p(YY = 1 bar.v XX = 0) log_2(1 / p(YY = 1 bar.v XX = 0)) = \ &= (1-p) log_2(1/(1-p)) + p log_2(1/p) = H(p) \ \ H(YY bar.v XX = 1) &= "idem con patate" = H(p) . $

In poche parole, so che $H(YY bar.v XX = i)$ vale come l'entropia di una bernoulliana di parametro $p$, che però non conosco in questo momento. Ma allora $ H(YY bar.v XX) = p(XX = 0) H(p) + p(XX = 1) H(p) = (p(XX = 0) + p(XX = 1)) H(p) = H(p) . $

Il calcolo di $H(YY)$ ricade nuovamente sull'entropia di una variabile distribuita uniformemente. Calcoliamo le $p(YY)$ singolarmente: $ p(YY = 0) &= p(XX = 0) p(YY = 0 bar.v XX = 0) + p(XX = 1) p(YY = 0 bar.v XX = 1) = 1/2 (1-p) + 1/2 p = 1/2 \ p(YY = 1) &= "idem con patate" = 1/2 . $

Ma allora $ H(YY) = sum_(i=0)^1 p(y_i) log_2(1/p(y_i)) = 1/2 dot 1 + 1/2 dot 1 = 1 . $

La capacità è quindi $ C = 1 - H(p) . $

== Canale binario a cancellazione

Terminiamo la carrellata di canali con il *canale binario a cancellazione*.

#v(12pt)

#align(center)[
  #diagram(
    node-stroke: .1em,
    spacing: 4em,

    node((0, 0), $0$, radius: 2em, fill: red.lighten(50%)),
    node((2, 0), $0$, radius: 2em, fill: green.lighten(50%)),
    node((2, 0.75), $e$, radius: 2em, fill: blue.lighten(50%)),
    node((0, 1.5), $1$, radius: 2em, fill: red.lighten(50%)),
    node((2, 1.5), $1$, radius: 2em, fill: green.lighten(50%)),

    edge((0, 0), (2, 0), $1 - alpha$, "-|>"),
    edge((0, 0), (2, 0.75), $alpha$, "-|>"),
    edge((0, 1.5), (2, 0.75), $alpha$, "-|>"),
    edge((0, 1.5), (2, 1.5), $1 - alpha$, "-|>"),
  )
]

#v(12pt)

Siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. Essendo in un canale binario, abbiamo che $ X = Y = {0,1} . $

Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1, e; 0, 1-alpha, 0, alpha; 1, 0, 1-alpha, alpha; augment: #(hline: 1, vline: 1)) quad . $

Calcoliamo la capacità del canale come $ C = max_(p(x)) I(XX,YY) = max_(p(x)) H(YY) - H(YY bar.v XX) . $ Osserviamo che la seconda quantità, visto che $XX$ è una variabile bernoulliana di parametro $alpha$, si comporta come la quantità del canale precedente, quindi $H(YY bar.v XX) = H(alpha)$.

Introduciamo una variabile $WW$ tale che $ WW = cases(1 & "se" YY = e, 0 quad & "altrimenti") quad . $

Sappiamo, per la Chain Rule dell'entropia, che $ H(YY,WW) = H(YY) + H(WW bar.v YY) = H(WW) + H(YY bar.v WW) . $ Consideriamo l'uguaglianza di destra e isoliamo $H(YY)$ ottenendo $ H(YY) = H(WW) + H(YY bar.v WW) - H(WW bar.v YY) . $

Notiamo che $H(WW bar.v YY) = 0$ perché se conosco $YY$ posso dire con precisione il valore di $WW$.

Abbiamo tolto un fattore. Calcoliamo ora $H(WW)$ con la formula classica di entropia, calcolando però prima le singole probabilità $p(WW = i)$ come $ p(WW = 1) &= p(XX = 0) p(WW = 1 bar.v XX = 0) + p(XX = 1) p(WW = 1) p(WW = 1 bar.v XX = 1) = \ &= p(XX = 0) alpha + p(XX = 1) alpha = alpha (p(XX = 0) + p(XX = 1)) = alpha \ p(WW = 0) &= 1 - p(WW = 1) = 1 - alpha . $

Ma allora $ H(WW) = sum_(i=0)^1 p(w_i) log_2(1/p(w_i)) = (1-alpha) log_2(1/(1-alpha)) + alpha log_2(1/alpha) = H(alpha) . $

Calcoliamo infine $H(YY bar.v WW)$ come $ H(YY bar.v WW) &= p(WW = 0) H(YY bar.v WW = 0) + p(WW = 1) H(YY bar.v WW = 1) = \ &= (1 - alpha) H(XX) + alpha dot 0 = H(XX) (1 - alpha) . $

Questo vale perché:
- se $WW = 0$ vuol dire che non ho errore, ma se non ho errori quello che mando è quello che ricevo, quindi dipende solo dalla sorgente;
- se $WW = 1$ vuol dire che ho avuto errore e che conosco già il valore di $YY$.

Possiamo calcolare, *FINALMENTE*, il valore di $H(YY)$ come $ H(YY) = H(alpha) + H(XX) (1 - alpha) . $

La capacità del canale è quindi $ C = max_(p(x)) H(YY) - H(YY bar.v XX) = H(alpha) + H(XX) (1 - alpha) - H(alpha) = H(XX) (1 - alpha) = 1 - alpha $ perché $H(XX)$ è l'entropia di una bernoulliana, che ha valore massimo $1$.
