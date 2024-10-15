#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 06 [15/10]

== Molti teoremi

#theorem()[
  Per ogni sorgente $modello(X,p)$ con:
  - $X = {x_1, dots, x_m}$ insieme dei simboli sorgente;
  - $P = {p_1, dots, p_m}$ probabilità associate ai simboli di $X$;
  - $c : X arrow.long D^+$ codice di Shannon con lunghezze $l_1, dots, l_m$ tali che $l_i = l_c (x_i) quad forall i = 1, dots m$ costruite con $ l_i = ceil(log_d (1/p_i)) quad forall i = 1, dots, m $.

  Vale $ EE[l_c] < H_d (XX) + 1 . $
]

#proof()[
  Verifichiamo che $ EE[l_c] &= sum_(i=1)^m p_i l_i = sum_(i=1)^m p_i ceil(log_d (1/p_i)) \ &< sum_(i=1)^m p_i (log_d (1 / p_i) + 1) = sum_(i=1)^m p_i log_d (1 / p_i) + sum_(i=1)^m p_i = H_d (XX) + 1 . $

  Che fastidio questo quadrato.
]

Ho trovato quindi un bound superiore alle lunghezze delle parole di codice di un codice di Shannon. Se lo uniamo al bound trovato nelle scorse lezioni otteniamo $ H_d (XX) lt.eq EE[l_c] lt.eq H_d (XX) + 1 . $

Iniziamo a vedere però qualche problematica: questa risiede nel $+1$ dell'upper bound. Ogni volta che facciamo la codifica di un singolo carattere perdiamo poco, e questo _"poco"_ è dato da quel $+1$. È una perdita locale, ma quando consideriamo un'intera parola o un intero messaggio la perdita si accumula.

Shannon si accorge di questa problematica perché usando l'estensione $C : X^+ arrow.long D^+$ la lunghezza delle parole di codice è data da $ l_C (x_1 dots.c x_n) = sum_(i=1)^n ceil(log_d (1/p_i)) . $

Shannon allora propone una soluzione, che come vedremo non funzionerà nel caso reale.

Cosa fa Shannon? Vediamo un esempio.

#example()[
  Siano:
  - $l_c (x_1) = ceil(2.5) arrow.long 3$;
  - $l_c (x_2) = ceil(2.1) arrow.long 3$;
  - $l_c (x_3) = ceil(2.1) arrow.long 3$.

  Come lunghezza totale della parola $x = x_1 x_2 x_3$ abbiamo $9$.

  Se pago al più un bit su ogni oggetto, il trucco che posso fare è fare il $ceil(space)$ della somma delle lunghezze, non la somma dei $ceil(space)$ delle lunghezze.

  In questo caso otteniamo $ceil(2.5 + 2.1 + 2.1) = ceil(6.7) = 7$, che è minore di $9$.

  In poche parole ho _"spostato"_ la sommatoria dentro $ceil(space)$.
]

Creiamo un nuovo codice: sia $C_n$ un *codice a blocchi*, ed è un codice tale che $ C_n : X^n arrow.long D^+ . $

Sembra una soluzione fantastica, ma cosa ci nasconde Shannon? Vediamolo con un altro esempio.

#example()[
  Sia $X = {0, dots, 9}$, ho i codici $c$ e $C$ e mi viene chiesto di scrivere $C_n$ con $d = 2$ e $n = 5$. Dove risiede il problema?

  Dovrei codificare un numero enorme di parole di codice, in questo caso abbiamo $10^5$.
]

Ecco cosa stava nascondendo Shannon: la complessità del codice è enorme.

Vedremo dopo che se la dimensione del blocco cresce all'infinito il codice di Shannon che sto costruendo è ottimale, altrimenti stiamo sprecando delle informazioni.

Prendiamo un messaggio e lo dividiamo in blocchi di dimensione $n$ numerandoli da $1$ a $m$. Questi blocchi sono estratti dalla nostra sorgente $modello(X,p)$. Ogni blocco è nella forma $(x_1, dots, x_n)$, e contiene $n$ simboli estratti tramite estrazioni indipendenti e identicamente distribuite, ovvero $ p(x_1, dots, x_n) = product_(i=1)^n p_i . $ Questa quantità verrà indicata con $ P_n (x_1, dots, x_n) . $

Definisco una nuova sorgente $modello(X^n, P_n)$ sulla quale definisco il mio codice a blocchi $C_n$. È una sorgente che pesca $n$ oggetti da $modello(X,p)$.

Vediamo cosa succede all'entropia di questa nuova sorgente. Ho $n$ variabili casuali (_n mani_), ognuna che estrae un simbolo da $X$: devo calcolare quindi $ H_d (XX_1, dots, XX_n) &= sum_(x_1, dots, x_n) P_n (x_1, dots, x_n) log_d (1/(P_n (x_1, dots, x_n))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (log_d (1/(product_(i=1)^n p(x_i)))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (log_d (product_(i=1)^n p(x_i)^(-1))) = \ &= sum_(x_1) dots.c sum_(x_n) (product_(i=1)^n p(x_i)) (sum_(i=1)^n log_d (1/p(x_i))) . $

Come semplificare questo schifo? Vediamo il caso generale con un esempio.

// Non mi piace tanto la penultima riga
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

Cosa succede se per la sorgente $modello(X,p)$ non ho la distribuzione $p$ ma ho una distribuzione $q$ di una variabile casuale $YY$ che ha campionato $XX$?

#theorem()[
  Data una sorgente $modello(X,p)$, se $c : X arrow.long D^+$ è un codice di Shannon avente lunghezze $ l_c (x) = ceil(log_d 1/q(x)) $ dove $q$ è una distribuzione di probabilità su $X$ campionata con $YY$, allora $ EE[l_c] < H_d (XX) +1 + enrel(XX,YY) . $
]

#proof()[
  Banale anche questo: $ EE[l_c] &= sum_(x in X) p(x) ceil(log_d (1 / q(x))) \ &< sum_(x in X) p(x) (log_d (1 / q(x)) + 1) = \ &= sum_(x in X) p(x) log_d (1/q(x)) + sum_(x in X) p(x) = \ &= sum_(x in X) p(x) log_d (p(x) / (p(x) q(x))) + 1 = \ &= sum_(x in X) p(x) log_d (p(x) / q(x)) + sum_(x in X) p(x) log_d (1/p(x)) + 1 = \ &= H_d (XX) + 1 + enrel(XX,YY) . $

  Odio il quadratino.
]

== Esercizi

#example()[
  Sia $S_1 = {A, E, C, A B B, C E D, B B E C}$ l'insieme dell'esercizio della scorsa lezione, eseguire Sardinas-Patterson ma non fermarsi quando si trova un elemento che apparteneva a $S_1$.

  - $S_1 = {A, E, C, A B B, C E D, B B E C}$;
  - $S_2 = {B B, E D}$;
  - $S_3 = {D} union {E C} = {D, E C}$;
  - $S_4 = {C} union {emptyset.rev} = {C}$;
  - $S_5 = {E D}$;
  - $S_6 = {D}$;
  - $S_7 = emptyset.rev$.

  L'algoritmo accetterebbe $c$ anche se non è UD.
]

#example()[
  Sia $S_1 = {0, 01, 10}$, il codice $c$ con le parole di codice contenute in $S_1$ è UD?

  - $S_1 = {0, 01, 10}$;
  - $S_2 = {1}$;
  - $S_3 = {0}$.

  Ma $S_1 sect S_3 eq.not emptyset.rev$ quindi $c$ non è UD.

  Se non ci fermiamo quando troviamo un elemento di $S_1$ otteniamo:
  - $S_4 = {1}$.

  Ma $S_4 = S_2$, quindi abbiamo trovato un insieme che abbiamo già visitato e quindi il codice $c$ non viene accettato di nuovo.
]

Va aggiunto infatti un altro caso di terminazione a Sardinas-Patterson, ovvero l'algoritmo termina non accettando il codice $c$ come UD quando trova un insieme che è già stato incontrato precedentemente.

#example()[
  Sia $ P = {1/3, 1/4, 1/6, 1/8, 1/9, x} . $ Calcolare le lunghezze di codice per un codice di Shannon $c$ che abbia $6$ simboli estratti le probabilità di $P$.

  Calcoliamo $ x = 1 - (1 / 3 + 1 / 4 + 1 / 6 + 1 / 8 + 1 / 9) = 1 - frac(24 + 18 + 12 + 9 + 8, 72) = 1 - frac(71,72) = 1/72 . $

  Calcoliamo le lunghezze come:
  - $l_1 = ceil(log_2 3) arrow.long 2$;
  - $l_2 = ceil(log_2 4) arrow.long 2$;
  - $l_3 = ceil(log_2 6) arrow.long 3$;
  - $l_4 = ceil(log_2 8) arrow.long 3$;
  - $l_5 = ceil(log_2 9) arrow.long 4$;
  - $l_6 = ceil(log_2 72) arrow.long 7$.

  L'albero di codifica non copre tutte le foglie: infatti, questo codice non è ottimale perché ci sono dei rami dell'albero che possiamo potare.
]
