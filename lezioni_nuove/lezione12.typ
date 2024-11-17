#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 12 [15/11]

Oggi si fanno solo esercizi, vamo caraco.

== Esercizi

#set math.mat(delim: none)

#example()[
  Dato un canale $canale(X,Y,p(y bar.v x))$ con:
  - $X$ simboli della sorgente con relative probabilità;
  - $Y$ simboli del ricevente;
  - $p(y bar.v x)$ matrice del canale.

  Siano $X = {0,1}$ e $Y = {0,1,2,3}$. Definiamo la matrice di canale come $ mat(X slash Y, 0, 1, 2, 3; 0, 0.5, 0.5, 0, 0; 1, 0, 0, 0.5, 0.5; augment: #(hline: 1, vline: 1)) quad . $

  Calcolare la capacità del canale.

  Calcoliamo $C = max_(p(x)) H(XX) - H(XX bar.v YY)$, ma la seconda quantità è $0$ perché sapendo $YY$ sappiamo anche la $XX$. Dobbiamo quindi massimizzare $H(XX)$, ma questa è una bernoulliana che ha valore massimo $1$, quindi $ C = 1 . $
]

#example()[
  Dato un canale $canale(X,Y,p(y bar.v x))$, siano:
  - $X = {0,1,2}$;
  - $Y = {0,1,2}$;
  e la matrice di canale $ mat(X slash Y, 0, 1, 2; 0, 0.5, 0.5, 0; 1, 0, 0.5, 0.5; 2, 0.5, 0, 0.5; augment: #(hline: 1, vline: 1)) quad . $

  Calcolare la capacità del canale.

  Calcoliamo $C = max_(p(x)) H(YY) - H(YY bar.v XX)$. Valutiamo la seconda quantità come $ H(YY bar.v XX) &= p(XX = 0) H(YY bar.v XX = 0) + p(XX = 1) H(YY bar.v XX = 1) + p(XX = 2) H(YY bar.v XX = 2) = \ &= p_0 H(YY bar.v XX = 0) + p_1 H(YY bar.v XX = 1) + p_2 H(YY bar.v XX = 2) . $

  Non conosciamo $p_0,p_1,p_2$ ma sappiamo che l'entropia viene massimizzata quando le probabilità dei simboli sono distribuite uniformemente, quindi assumiamo $p_0 = p_1 = p_2 = 1/3$.

  Qui abbiamo due modi di procedere:
  - ogni simbolo si comporta come una variabile bernoulliana, visto che si _"spezza"_ in due simboli, e quindi ha entropia $1$;
  - calcoliamo ogni entropia come $ H(YY bar.v XX = i) = sum_(k=0)^2 p(y_k bar.v XX = i) log_2(1 / p(y_k bar.v XX = i)) . $ In entrambi i casi si ottiene il valore $1$.

  Ma allora $ H(YY bar.v XX) = p_0 + p_1 + p_2 = 1 . $

  Rimane solo $H(YY)$. Scegliamo anche qua qualcosa che massimizzi l'entropia, una distribuzione uniforme, quindi $ p(YY = 0) = p(YY = 1) = p(YY = 2) = (1/3 1/2) + (1/3 1/2) = 1/3 . $

  L'entropia diventa quindi $ H(YY) = sum_(i=0)^2 p(y_i) log_2(1/p(y_i)) = 3 (1/3 log_2(3)) = log_2(3) . $

  La capacità è quindi $ C = log_2(3) - 1 approx 0.585 . $
]

#example()[
  Dato un canale $canale(X,Y,p(y bar.v x))$, siano:
  - $X = {0,1}$;
  - $Y = {0,1}$;
  e la matrice di canale $ mat(X slash Y, 0, 1; 0, 1-p, p; 1, p, 1-p; augment: #(hline: 1, vline: 1)) quad . $

  Calcolare la capacità del canale.

  Calcoliamo $C = max_(p(x)) H(YY) - H(YY bar.v XX)$. Valutiamo la seconda quantità come $ H(YY bar.v XX) = sum_(i=0)^1 p(XX = i) H(YY bar.v XX = i) . $

  Calcoliamo $H(YY bar.v XX = i)$ per $i = 0,1$: $ H(YY bar.v XX = 0) &= p(YY = 0 bar.v XX = 0) log_2(1 / p(YY = 0 bar.v XX = 0)) + \ &+ space p(YY = 1 bar.v XX = 0) log_2(1 / p(YY = 1 bar.v XX = 0)) = \ &= (1-p) log_2(1/(1-p)) + p log_2(1/p) = H(p) \ \ H(YY bar.v XX = 1) &= "stessa cosa" = H(p) . $

  In poche parole, so che $H(YY bar.v XX = i)$ vale come l'entropia di una bernoulliana di parametro $p$, che però non conosco.

  Ma allora $ H(YY bar.v XX) = p(XX = 0) H(p) + p(XX = 1) H(p) = (p(XX = 0) + p(XX = 1)) H(p) = H(p) . $

  Il calcolo di $H(YY)$ ricade nuovamente sull'entropia di una variabile distribuita uniformemente. Calcoliamo le $p(YY)$ singolarmente: $ p(YY = 0) &= p(XX = 0) p(YY = 0 bar.v XX = 0) + p(XX = 1) p(YY = 0 bar.v XX = 1) = 1/2 (1-p) + 1/2 p = 1/2 \ p(YY = 1) &= "uguale" = 1/2 . $

  Ma allora $ H(YY) = sum_(i=0)^1 p(y_i) log_2(1/p(y_i)) = 1/2 1 + 1/2 1 = 1 . $

  La capacità è quindi $ C = 1 - H(p) . $
]

#example()[
  Dato un canale $canale(X,Y,p(y bar.v x))$, siano:
  - $X = {0,1}$;
  - $Y = {0,1}$;
  e la matrice di canale $ mat(X slash Y, 0, 1, e; 0, 1-alpha, 0, alpha; 1, 0, 1-alpha, alpha; augment: #(hline: 1, vline: 1)) quad . $

  Calcolare la capacità del canale.

  Calcoliamo $C = max_(p(x)) H(YY) - H(YY bar.v XX)$. Valutiamo la seconda quantità, notando che $XX$ è una variabile bernoulliana di parametro $alpha$, quindi come l'esercizio precedente $H(YY bar.v XX) = H(alpha)$.

  Introduciamo una variabile $WW$ tale che $ WW = cases(1 & "se" YY = e, 0 quad & "altrimenti") quad . $

  Sappiamo, per la Chain Rule, che $H(YY,WW) = H(YY) + H(WW bar.v YY) = H(WW) + H(YY bar.v WW)$. Consideriamo l'uguaglianza di destra e isoliamo $H(YY)$ ottenendo $ H(YY) = H(WW) + H(YY bar.v WW) - H(WW bar.v YY) . $

  Notiamo che $H(WW bar.v YY) = 0$ perché se conosco $YY$ posso dire con precisione il valore di $WW$.

  Calcoliamo $H(WW)$ con la formula classica di entropia, calcolando però prima le singola probabilità $p(WW = i)$ come $ p(WW = 1) &= p(XX = 0) p(WW = 1 bar.v XX = 0) + p(XX = 1) p(WW = 1) p(WW = 1 bar.v XX = 1) = \ &= p(XX = 0) alpha + p(XX = 1) alpha = alpha (p(XX = 0) + p(XX = 1)) = alpha \ p(WW = 0) &= 1 - p(WW = 1) = 1 - alpha . $

  Allora $ H(WW) = sum_(i=0)^1 p(w_i) log_2(1/p(w_i)) = (1-alpha) log_2(1/(1-alpha)) + alpha log_2(1/alpha) = H(alpha) . $

  Calcoliamo infine $H(YY bar.v WW)$ come $ H(YY bar.v WW) &= p(WW = 0) H(YY bar.v WW = 0) + p(WW = 1) H(YY bar.v WW = 1) = \ &= H(XX) (1 - alpha) + 0 dot alpha = H(XX) (1 - alpha) . $

  Questo vale perché:
  - se $WW = 0$ vuol dire che non ho errore, ma se non ho errori quello che mando è quello che ricevo, quindi dipende solo dalla sorgente;
  - se $WW = 1$ vuol dire che ho avuto errore e che conosco già il valore di $YY$.

  Possiamo calcolare, FINALMENTE, il valore di $H(YY)$ come $ H(YY) = H(alpha) + H(XX) (1 - alpha) - 0 = H(alpha) + H(XX) (1 - alpha) . $

  La capacità del canale è quindi $ C = max_(p(x)) H(YY) - H(YY bar.v XX) = H(alpha) + H(XX) (1 - alpha) - H(alpha) = H(XX) (1 - alpha) = 1 - alpha $ perché $H(XX)$ è l'entropia di una bernoulliana, che ha valore massimo $1$.
]
