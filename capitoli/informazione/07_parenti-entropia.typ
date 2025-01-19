// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Parenti dell'entropia

L'*entropia congiunta* indica la quantità di informazione media che serve per comunicare due messaggi a partire dai simboli di una stessa sorgente. Data la sorgente $modello(X,p)$ e date le variabili aleatorie $XX$ e$YY$, essa è definita come $ H(XX,YY) = sum_(x in X) sum_(y in X) p(x,y) log(1/p(x,y)) . $

L'*entropia condizionata* indica invece la quantità di informazione media che serve per comunicare un messaggio estratto da $YY$ sapendo che ho già mandato un messaggio estratto da $XX$ dalla stessa sorgente. Data la sorgente $modello(X,p)$ e date le variabili aleatorie $XX$ e$YY$, essa è definita come $ H(YY bar.v XX) &= sum_(x in X) p(x) H(YY bar.v XX = x) = \ &= sum_(x in X) p(x) (sum_(y in X) p(y bar.v x) log(1/p(y bar.v x))) = \ &= sum_(x in X) sum_(y in X) p(x) p(y bar.v x) log(1/p(y bar.v x)) . $

Sapendo che $ p(y bar.v x) = frac(p(x,y),p(x)) $ allora l'entropia condizionata vale $ H(YY bar.v XX) = sum_(x in X) sum_(y in X) p(x,y) log(1/p(y bar.v x)) . $

Se $XX = f(YY)$ allora $H(XX bar.v YY) = 0$ perché la variabile $XX$ la posso ricavare facilmente dalla $YY$.

#theorem([Chain rule per l'entropia])[
  $ H(XX,YY) = H(XX) + H(YY bar.v XX) = H(YY) + H(XX bar.v YY) . $
]

Qua abbiamo bisogno della *probabilità marginale*: essa è definita come $ p(x) = sum_(y in Y) p(x,y) . $

#proof()[
  Verifichiamo che $ H(XX,YY) &= sum_(x in X) sum_(y in X) p(x,y) log(1/p(x,y)) = \ &= sum_(x in X) sum_(y in X) p(x,y) log(1 / p(x) dot 1 / p(y bar.v x)) = \ &= sum_(x in X) underbracket(sum_(y in X) p(x,y), "congiunta") log(1/p(x)) + sum_(x in X) sum_(y in X) p(x,y) log(1/p(y bar.v x)) = \ &= sum_(x in X) p(x) log(1/p(x)) + H(YY bar.v XX) = H(XX) + H(YY bar.v XX) . $

  Lo stesso ragionamento lo possiamo fare invertendo $XX$ e $YY$.
]

Questa regola vale anche negli spazi condizionati, ovvero $ H(XX, YY bar.v WW) = H(XX bar.v WW) + H(YY bar.v XX, WW) . $

Un altro parente dell'entropia, penso il prozio o il cugino, è l'*informazione mutua*: essa ci indica la quantità di informazione media che rilascia $YY$ rispetto a $XX$. Si calcola con $ I(XX,YY) = sum_(x in X) sum_(y in X) p(x,y) log(frac(p(x,y), p(x) p(y))) . $

È molto simile all'entropia relativa: con questa condivide la proprietà di essere $gt.eq 0$, infatti non possiamo togliere informazioni da $XX$ avendo anche $YY$. Inoltre, a differenza dell'entropia relativa, l'informazione mutua è simmetrica.

#lemma()[
  $ I(XX,YY) = H(XX) - H(XX bar.v YY) . $
]

#proof()[
  Valutiamo $ I(XX,YY) &= sum_(x in X) sum_(y in X) p(x,y) log(frac(p(x,y), p(x) p(y))) = \ &= sum_(x in X) sum_(y in X) p(x,y) log(frac(p(y) p(x bar.v y), p(x) p(y))) = \ &= sum_(x in X) underbracket(sum_(y in X) p(x,y), "marginale") log(1/p(x)) - sum_(x in X) sum_(y in X) p(x,y) log(1/p(x bar.v y)) = \ &= sum_(x in X) p(x) log(1/p(x)) - H(XX bar.v YY) = H(XX) - H(XX bar.v YY) . $

  Lo stesso ragionamento lo possiamo fare invertendo $XX$ e $YY$ (_credo_).
]

Se $XX$ e $YY$ sono indipendenti allora $I(XX,YY) = 0$ perché $YY$ non rilascia informazioni su $XX$. Se invece le due variabili sono dipendenti allora $I(XX,YY) = H(XX)$ perché $XX$ è ricavabile totalmente da $YY$.

Un modo forse più comodo di scrivere l'informazione mutua è $ I(XX,YY) = H(XX) - H(XX bar.v YY) = H(XX) - (H(XX,YY) - H(YY)) = H(XX) + H(YY) - H(XX,YY) , $ che è molto simile alla probabilità dell'unione di due eventi.

#v(12pt)

#figure(image("assets/09_venn.svg", width: 70%))

#v(12pt)

#theorem([Data Processing Inequality])[
  Siano $XX,YY,WW$ variabili aleatorie con codominio finito tali che $p(x,y,w)$ soddisfa $ p(x, w bar.v y) = p(x bar.v y) p(w bar.v y) quad forall x,y,w $ ovvero $x,w$ indipendenti dalla $y$ condizionante. Allora $ I(XX,YY) gt.eq I(XX,WW) . $
]

#proof()[
  Valutiamo $ I(XX, (YY,WW)) &= sum_(x,y,w in X) p(x,y,w) log(frac(p(x,y,w), p(x) p(y,w))) = \ &= "scompongo con la congiunta al numeratore e al denominatore" = \ &= sum_(x,y,w in X) p(x,y,w) log(frac(p(y bar.v x,w) p(x,w), p(x) p(y bar.v w) p(w))) = \ &= sum_(x,w in X) underbracket(sum_(y in X) p(x,y,w), "marginale") log(frac(p(x,w), p(x) p(w))) + sum_(x,y,w in X) p(x,y,w) log(frac(p(y bar.v x,w), p(y bar.v w))) = \ &= sum_(x,w in X) p(x,w) log(frac(p(x,w), p(x) p(w))) + sum_(x,y,w in X) p(x,y,w) log(frac(p(x,y bar.v w), p(y bar.v w) p(x bar.v w))) = \ &= I(XX,WW) + I(XX,YY bar.v WW) . $

  Questo vale per ogni terna $XX,YY,WW$ quindi vale anche $I(XX,(YY,WW)) = I(XX,YY) + I(XX, WW bar.v YY)$.

  Unendo i due risultati otteniamo $ I(XX,YY) + underbracket(I(XX,WW bar.v YY), =0) = I(XX,WW) + underbracket(I(XX, YY bar.v WW), gt.eq 0) , $ ma allora $ I(XX,YY) gt.eq I(XX,WW) . qedhere $
]

A cosa serve questo teorema? Abbiamo $ XX arrow.long.squiggly^("rumore") YY arrow.long.squiggly^("algoritmo") WW , $ ovvero sappiamo che $WW$ è indipendente da $XX$ e quindi il $WW$ processato non può essere più informativo di $YY$ su $XX$.

Vediamo infine la *disuguaglianza di Fano* e cerchiamo di capire a cosa serve.

La sorgente manda un messaggio $XX$ e il ricevente riceve $YY$. Se il canale non ha rumore nessun problema, ma se il canale distorce alcuni bit di informazione potrei ricevere un messaggio che è diverso da quello originale.

Usiamo quindi una funzione $g(YY)$ che cerca di risalire al simbolo $XX$ che è stato spedito. La funzione potrebbe azzeccare il vero simbolo che è stato spedito ma potrebbe anche darmi un'informazione sbagliata, ad esempio quando sono distorti tanti bit.

Chiamiamo $p_e$ la probabilità che la funzione $g$ sbagli a predire il simbolo $XX$ spedito, ovvero $ p_e = P(g(YY) eq.not XX) . $

Ovviamente, più è alto il livello di distorsione del canale, più la funzione $g$ sbaglia.

#theorem([Disuguaglianza di Fano])[
  Siano $XX,YY$ due variabili casuali con valori in $X,Y$ insiemi finiti. Sia $g : Y arrow.long X$ una funzione che mappa valori di $Y$ in valori di $X$. Sia $p_e$ la probabilità di errore quando uso $g(YY)$ per predire $XX$, ovvero $p_e = P(g(YY) eq.not XX)$. Allora $ p_e gt.eq frac(H(XX bar.v YY) - 1, log_2 (abs(X))) . $
]

#proof()[
  Introduciamo una variabile bernoulliana $EE$ che indica il comportamento di $g$: quest'ultima o trova la $XX$ giusta, o trova una $XX$ sbagliata. In poche parole: $ EE = cases(1 & "se" g(YY) eq.not XX, 0 quad & "se" g(YY) = XX) . $

  Per la chain rule dell'entropia sappiamo che: $ H(EE,XX bar.v YY) &=_("CR") H(EE bar.v YY) + H(XX bar.v EE,YY) = \ &=_("CR") H(XX bar.v YY) + H(EE bar.v XX,YY) . $

  Consideriamo solo i due membri di destra, ovvero: $ H(EE bar.v YY) + H(XX bar.v EE,YY) = H(XX bar.v YY) + H(EE bar.v XX,YY) $

  Osserviamo che:
  - $H(EE bar.v YY) lt.eq H(EE)$ perché il condizionamento non aumenta l'entropia, lo vediamo dai diagrammi di Venn precedenti oppure osservando che il condizionamento può rilasciare o meno delle informazioni, ma sicuramente non ne toglie;
  - $H(EE bar.v XX,YY) = 0$ perché conoscendo $XX$ e $YY$ posso calcolare $g(YY)$ e vedere se è uguale a $XX$, e quindi sapere subito il valore di $EE$.

  Siamo quindi nella seguente situazione: $ H(EE) + H(XX bar.v EE,YY) gt.eq_("OSS1") H(EE bar.v YY) + H(XX bar.v EE,YY) = H(XX bar.v YY) + underbracket(H(EE bar.v XX,YY), =0 "per OSS2") . $

  Consideriamo solo i due membri esterni, e quindi: $ H(EE) + H(XX bar.v EE,YY) gt.eq H(XX bar.v YY) . $

  Valutiamo la quantità $ H(XX bar.v EE,YY) &= sum_(e in EE) p_e H(XX bar.v EE = e, YY) = \ &= p(EE = 0) H(XX bar.v EE = 0, YY) + p(EE = 1) H(XX bar.v EE = 1, YY) = \ &= (1 - p_e) underbracket(H(XX bar.v EE = 0, YY), = 0 "perché ricavo da" g) + p_e H(XX bar.v EE = 1, YY) = \ &= p_e H(XX bar.v EE = 1, YY) . $

  L'entropia è maggiorata dalla quantità $log_2(abs(X))$, ma se $EE = 1$ allora devo pescare da $X$ tutti i valori tranne uno, quello corretto, perché appunto sto sbagliando a predire $XX$. Ma allora $ p_e H(XX bar.v EE = 0, YY) lt.eq log_2(abs(X)-1) . $

  Osserviamo infine che $H(EE) lt.eq 1$ perché $EE$ è una variabile bernoulliana.

  Viste queste ultime due valutazioni abbiamo ottenuto: $ 1 + p_e log_2(abs(X)-1) gt.eq H(XX bar.v YY) arrow.long.double p_e gt.eq frac(H(XX bar.v YY) - 1, log_2(abs(X))) . qedhere $
]

Abbiamo mostrato che l'entropia è anche un *lower bound* per la probabilità di errore, oltre che per il valore atteso delle lunghezze del codice. Questo lower bound però è modulato sulla grandezza della sorgente, ma è comunque un lower bound.
