// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Primo teorema di Shannon

Nello scorso capitolo abbiamo visto come il codice di Shannon obbedisca ai seguenti bound: $ H_d (XX) lt.eq EE[l_c] lt.eq H_d (XX) + 1 . $

Iniziamo a vedere però qualche problematica: questa risiede nel $+1$ dell'upper bound. Ogni volta che facciamo la codifica di un singolo carattere perdiamo poco, e questo _"poco"_ è dato da quel $+1$. È una perdita locale, ma quando consideriamo un'intera parola o un intero messaggio la perdita conta.

Shannon si accorge di questa problematica perché usando l'estensione $C : X^+ arrow.long D^+$ la lunghezza delle parole di codice è data da $ l_C (x_1 dot dots dot x_n) = sum_(i=1)^n ceil(log_d (1/p_i)) . $

Shannon allora propone una soluzione, che come vedremo non funzionerà nel caso reale. Vediamo un esempio per capire tutto ciò.

#example()[
  Siano:
  - $l_c (x_1) = ceil(2.5) arrow.long 3$;
  - $l_c (x_2) = ceil(2.1) arrow.long 3$;
  - $l_c (x_3) = ceil(2.1) arrow.long 3$.

  Come lunghezza totale della parola $x = x_1 x_2 x_3$ abbiamo $9$.

  Se pago al più un bit su ogni oggetto, il trucco che posso fare è fare il $ceil(space)$ della somma delle lunghezze, non la somma dei $ceil(space)$ delle lunghezze. In questo caso otteniamo $ceil(2.5 + 2.1 + 2.1) = ceil(6.7) = 7$, che è minore di $9$. In poche parole ho _"spostato"_ la sommatoria dentro $ceil(space)$.
]

Creiamo un nuovo codice: sia $C_n$ un *codice a blocchi*, ed è un codice tale che $ C_n : X^n arrow.long D^+ . $

Sembra una soluzione fantastica, ma cosa ci nasconde Shannon? Vediamolo con un altro esempio.

#example()[
  Sia $X = {0, dots, 9}$, ho i codici $c$ e $C$ e mi viene chiesto di scrivere $C_n$ con $d = 2$ e $n = 5$. Dove risiede il problema?

  Dovrei codificare un numero enorme di parole di codice, in questo caso abbiamo $10^5$.
]

Ecco cosa stava nascondendo Shannon: la *complessità* del codice è enorme.

Prendiamo un messaggio e lo dividiamo in blocchi di dimensione $n$ numerandoli da $1$ a $m$. Questi blocchi sono estratti dalla nostra sorgente $modello(X,p)$. Ogni blocco è nella forma $(x_1, dots, x_n)$ e contiene $n$ simboli estratti tramite estrazioni indipendenti e identicamente distribuite, ovvero $ p(x_1, dots, x_n) = product_(i=1)^n p_i . $ Questa quantità verrà indicata con $ P_n (x_1, dots, x_n) . $

Definisco una nuova sorgente $modello(X^n, P_n)$ sulla quale definisco il mio codice a blocchi $C_n$. È una sorgente che pesca $n$ oggetti da $modello(X,p)$. Vediamo cosa succede all'entropia di questa nuova sorgente.

Ho $n$ variabili casuali (_mani_), ognuna che estrae un simbolo da $X$: devo calcolare quindi $ H_d (XX_1, dots, XX_n) &= sum_(x_1, dots, x_n) P_n (x_1, dots, x_n) log_d (1/(P_n (x_1, dots, x_n))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (log_d (1/(product_(i=1)^n p(x_i)))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (log_d (product_(i=1)^n p(x_i)^(-1))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (sum_(i=1)^n log_d (1/p(x_i))) . $

Come semplificare questo schifo? Vediamo il caso generale con un esempio.

#example()[
  Sia $n = 2$, andiamo a calcolare l'entropia come $ H_d (XX_1, XX_2) &= sum_(x_1) sum_(x_2) (product_(i=1)^2 p(x_i)) (sum_(i=1)^2 log_d (1/p(x_i))) = \ &= sum_(x_1) sum_(x_2) (p(x_1) p(x_2)) (log_d (1/p(x_1)) + log_d (1/p(x_2))) = \ &= sum_(x_1) sum_(x_2) (p(x_1) p(x_2)) log_d (1/p(x_1)) + p(x_1) p(x_2) log_d (1/p(x_2)) = \ &= sum_(x_1) sum_(x_2) (p(x_1) p(x_2)) log_d (1/p(x_1)) + sum_(x_1) sum_(x_2) p(x_1) p(x_2) log_d (1/p(x_2)) = \ &= (sum_(x_1) p(x_1) log_d (1/p(x_1))) (sum_(x_2) p(x_2)) + \ &+ (sum_(x_1) p(x_1)) (sum_(x_2) p(x_2) log_d (1/p(x_2))) = \ &= H_d (XX_1) dot 1 + 1 dot H_d (XX_2) = H_d (XX_1) + H_d (XX_2) . $
]

Ma allora $ H_d (XX_1, dots, XX_n) &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (sum_(i=1)^n log_d (1/p(x_i))) = \ &= H_d (XX_1) + dots + H_d (XX_n) = n H_d (XX) . $

L'ultimo passaggio è vero perché tutte le variabili casuali stanno pescando dalla stessa sorgente con le stesse probabilità.

#theorem("Primo teorema di Shannon")[
  Sia $C_n : X^n arrow.long D^+$ codice a blocchi di Shannon $d$-ario per la sorgente $modello(X,p)$ con $ l_(C_n) (x_1, dots, x_n) = ceil(log_d 1/(P_n (x_1, dots, x_n))) , $ allora $ lim_(n arrow infinity) 1/n EE[l_(C_n)] = H_d (XX) . $
]

#proof()[
  La dimostrazione è banale: $ H_d (XX_1, dots, XX_n) lt.eq &EE[l_(C_n)] < H_d (XX_1, dots, XX_n) + 1 \ n H_d (XX) lt.eq &EE[l_(C_n)] lt.eq n H_d (XX) + 1 \ 1/n (n H_d (XX)) lt.eq 1/n &EE[l_(C_n)] lt.eq 1/n (n H_d (XX) + 1) \ H_d (XX) lt.eq 1/n &EE[l_(C_n)] lt.eq H_d (XX) + 1/n . $

  Se passo al limite per $n arrow infinity$, per il teorema dei due carabinieri vale $ lim_(n arrow infinity) 1/n EE[l_(C_n)] = H_d (XX) . qedhere $
]

Questo teorema ci dice che se tendiamo a $infinity$ la grandezza del blocco $n$ allora il codice è ottimale, perché è uguale al lower bound che avevamo definito per $EE[l_(C_n)]$.
