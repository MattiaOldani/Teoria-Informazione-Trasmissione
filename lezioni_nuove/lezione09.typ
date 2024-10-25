#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 09 [25/10]

== Parenti dell'entropia

L'*entropia congiunta* indica la quantità di informazione media che serve per comunicare due messaggi a partire dai simboli di una stessa sorgente. Data la sorgente $modello(X,p)$ e date le variabili aleatorie $XX$ e$YY$, essa è definita come $ H(XX,YY) = sum_(x in X) sum_(y in X) p(x,y) log(1/p(x,y)) . $

L'*entropia condizionata* indica invece la quantità di informazione media che serve per comunicare un messaggio estratto da $YY$ sapendo che ho già mandato un messaggio estratto da $XX$ dalla stessa sorgente. Data la sorgente $modello(X,p)$ e date le variabili aleatorie $XX$ e$YY$, essa è definita come $ H(YY bar.v XX) &= sum_(x in X) p(x) H(YY bar.v XX = x) = \ &= sum_(x in X) p(x) (sum_(y in X) p(y bar.v x) log(1/p(y bar.v x))) = \ &= sum_(x in X) sum_(y in X) p(x) p(y bar.v x) log(1/p(y bar.v x)) . $ Sapendo che $ p(y bar.v x) = frac(p(x,y),p(x)) $ e che la _probabilità marginale_ (servirà dopo) è $ p(x) = sum_(y in Y) p(x,y) $ allora $ H(YY bar.v XX) = sum_(x in X) sum_(y in X) p(x,y) log(1/p(y bar.v x)) . $

Se $XX = f(YY)$ allora $H(XX bar.v YY) = 0$ perché la variabile $XX$ la posso ricavare facilmente dalla $YY$ che è già stata spedita.

#example()[
  Sia $XX$ una variabile e sia $YY = XX + 2$ un'altra variabile casuale. Quanto vale $H(YY bar.v XX)$?

  Data la dipendenza di $XX$ da $YY$, allora $H(YY bar.v XX) = 0$.
]

#example()[
  Sia $XX$ una variabile e sia $YY = XX^2$ un'altra variabile casuale. Entrambe pescano dall'insieme ${-1,0,1}$. Quanto vale $H(YY bar.v XX)$?

  Data la dipendenza di $XX$ da $YY$, allora $H(YY bar.v XX) = 0$.

  Quanto vale invece $H(XX bar.v YY)$?

  Sicuramente $H(XX bar.v YY) > 0$ perché il valore $1$ estratto da $YY$ può essere ottenuto sia da $1$ che da $-1$.
]

#theorem([Chain rule per l'entropia])[
  $ H(XX,YY) = H(XX) + H(YY bar.v XX) = H(YY) + H(XX bar.v YY) . $
]

#proof()[
  Verifichiamo che $ H(XX,YY) &= sum_(x in X) sum_(y in X) p(x,y) log(1/p(x,y)) = \ &= -sum_(x in X) sum_(y in X) p(x,y) log(p(x) p(y bar.v x)) = \ &= sum_(x in X) underbracket(sum_(y in X) p(x,y), "congiunta") log(1/p(x)) + sum_(x in X) sum_(y in X) p(x,y) log(1/p(y bar.v x)) = \ &= sum_(x in X) p(x) log(1/p(x)) + H(YY bar.v XX) = H(XX) + H(YY bar.v XX) . $

  Odio il quadratino.
]

// Da rivedere
Questa regola vale anche negli spazi condizionati, ovvero $ H(XX, YY bar.v WW) = H(XX bar.v WW) + H(YY bar.v XX, WW) . $

Un altro parente, penso il prozio o il cugino, è l'*informazione mutua*: essa ci indica la quantità di informazione media che rilascia $YY$ rispetto a $XX$. Si calcola con $ I(XX,YY) = sum_(x in X) sum_(y in X) p(x,y) log(frac(p(x,y), p(x) p(y))) . $

È molto simile all'entropia relativa: con questa condivide la proprietà di essere $gt.eq 0$, infatti non possiamo togliere informazioni da $XX$ avendo anche $YY$. Inoltre, a differenza dell'entropia relativa, l'informazione mutua è simmetrica.

#lemma()[
  $ I(XX,YY) = H(XX) - H(XX bar.v YY) . $
]

#proof()[
  Valutiamo $ I(XX,YY) &= sum_(x in X) sum_(y in X) p(x,y) log(frac(p(x,y), p(x) p(y))) = \ &= sum_(x in X) sum_(y in X) p(x,y) log(frac(p(y) p(x bar.v y), p(x) p(y))) = \ &= sum_(x in X) underbracket(sum_(y in X) p(x,y), "marginale") log(1/p(x)) - sum_(x in X) sum_(y in X) p(x,y) log(1/p(x bar.v y)) = \ &= sum_(x in X) p(x) log(1/p(x)) - H(XX bar.v YY) = H(XX) - H(XX bar.v YY) . $

  Quadratino di merda.
]

Se $XX$ e $YY$ sono indipendenti allora $I(XX,YY) = 0$ perché $YY$ non rilascia informazioni su $XX$. Se invece le due variabili sono dipendenti allora $I(XX,YY) = H(XX)$ perché $XX$ è ricavabile totalmente da $YY$.

Un modo forse più comodo di scrivere l'informazione mutua è $ I(XX,YY) = H(XX) - H(XX bar.v YY) = H(XX) - (H(YY) + H(XX,YY)) = H(XX) + H(YY) - H(XX,YY) , $ che è molto simile alla probabilità dell'unione di due eventi.

#v(12pt)

#figure(
  image("../assets/09_venn.svg", width: 70%),
)

#v(12pt)

#theorem([Data Processing Inequality])[
  Siano $XX,YY,WW$ variabili aleatorie con codominio finito tali che $p(x,y,w)$ soddisfa $p(x, w bar.v y) = p(x bar.v y) p(w bar.v y) quad forall x,y,w$ (ovvero $x,w$ indipendenti dalla $y$ condizionante) allora $ I(XX,YY) gt.eq I(XX,WW) . $
]

#proof()[
  Valutiamo $ I(XX, (YY,WW)) &= sum_(x,y,w in X) p(x,y,w) log(frac(p(x,y,w), p(x) p(y,z))) = \ &= sum_(x,y,w in X) p(x,y,w) log(frac(p(y bar.v x,w) p(x,w), p(x) p(y bar.v w) p(w))) = \ &= sum_(x,w in X) underbracket(sum_(y in X) p(x,y,w), "marginale") log(frac(p(x,w), p(x) p(w))) + sum_(x,y,w in X) p(x,y,w) log(frac(p(y bar.v x,w), p(y bar.v w))) = \ &= sum_(x,w in X) p(x,w) log(frac(p(x,w), p(x) p(w))) + sum_(x,y,w in X) p(x,y,w) log(frac(p(x,y bar.v w), p(y bar.v w) p(x bar.v w))) = \ &= I(XX,WW) + I(XX,YY bar.v WW) . $

  Questo vale per ogni terna $XX,YY,WW$ quindi vale anche $I(XX,(YY,WW)) = I(XX,YY) + I(XX, WW bar.v YY)$ quindi $ I(XX,YY) + underbracket(I(XX,WW bar.v YY, 0)) = I(XX,WW) + underbracket(I(XX, YY bar.v WW), gt.eq 0) $ ma allora $ I(XX,YY) gt.eq I(XX,WW) . qedhere $
]

A cosa serve questo teorema? Abbiamo $ XX arrow.long^("rumore") YY arrow.long^("algoritmo") WW , $ ovvero sappiamo che $WW$ è indipendente da $XX$ e quindi il $WW$ processato non può essere più informativo di $YY$ su $XX$.
