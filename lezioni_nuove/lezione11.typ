#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 11 [08/11]

== Disuguaglianza di Fano

Vediamo la disuguaglianza di Fano e cerchiamo di capire a cosa serve.

La sorgente manda un messaggio $XX$ e il ricevente riceve $YY$. Se il canale non ha rumore nessun problema, ma se il canale distorce alcuni bit di informazione potrei ricevere un messaggio che è diverso da quello originale.

Usiamo quindi una funzione $g(YY)$ che cerca di risalire al simbolo $XX$ che è stato spedito. La funzione potrebbe azzeccare il vero simbolo che è stato spedito ma potrebbe anche darmi un'informazione sbagliata, ad esempio quando sono distorti tanti bit.

Chiamiamo $p_e$ la probabilità che la funzione $g$ sbagli a predire il simbolo $XX$ spedito, ovvero $ p_e = P(g(YY) eq.not XX) . $

Ovviamente, più è alto il livello di distorsione del canale, più la funzione $g$ sbaglia.

Non è detto che i due insiemi di simboli $X,Y$ abbiano lo stesso numero di elementi. Ad esempio, se $X = {x_1, dots, x_n}$ e $Y = {y_1, dots, y_m}$ basta scegliere $n eq.not m$ per avere due insiemi differenti.

#theorem([Disuguaglianza di Fano])[
  Siano $XX,YY$ due variabili casuali con valori in $X,Y$ insiemi finiti. Sia $g : Y arrow.long X$ una funzione che mappa valori di $Y$ in valori di $X$. Sia $p_e$ la probabilità di errore quando uso $g(YY)$ per predire $XX$, ovvero $p_e = P(g(YY) eq.not XX)$. Allora $ p_e gt.eq frac(H(XX bar.v YY) - 1, log_2 (abs(X))) . $
]

#proof()[
  Introduciamo una variabile bernoulliana $EE$ che indica il comportamento di $g$: quest'ultima o trova la $XX$ giusta, o trova una $XX$ sbagliata. In poche parole: $ EE = cases(1 & "se" g(YY) eq.not XX, 0 quad & "se" g(YY) = XX) . $

  Per la chain rule dell'entropia sappiamo che: $ H(EE,XX bar.v YY) &=_("CR") H(EE bar.v YY) + H(XX bar.v EE,YY) = \ &=_("CR") H(XX bar.v YY) + H(EE bar.v XX,YY) . $

  Consideriamo solo i due membri di destra, ovvero: $ H(EE bar.v YY) + H(XX bar.v EE,YY) = H(XX bar.v YY) + H(EE bar.v XX,YY) $

  Osserviamo che:
  - $H(EE bar.v YY) lt.eq H(EE)$ perché il condizionamento non aumenta l'entropia, lo vediamo dai diagrammi di Venn della lezione09 oppure osservando che il condizionamento può rilasciare o meno delle informazioni, ma sicuramente non ne toglie;
  - $H(EE bar.v XX,YY) = 0$ perché conoscendo $XX$ e $YY$ posso calcolare $g(YY)$ e vedere se è uguale a $XX$, e quindi sapere subito il valore di $EE$.

  Siamo quindi nella seguente situazione: $ H(EE) + H(XX bar.v EE,YY) gt.eq_("OSS1") H(EE bar.v YY) + H(XX bar.v EE,YY) = H(XX bar.v YY) + underbracket(H(EE bar.v XX,YY), =0 "per OSS2") . $

  Consideriamo solo i due membri esterni, e quindi: $ H(EE) + H(XX bar.v EE,YY) gt.eq H(XX bar.v YY) . $

  Valutiamo la quantità $ H(XX bar.v EE,YY) &= sum_(e in EE) p_e H(XX bar.v EE = e, YY) = \ &= p(EE = 0) H(XX bar.v EE = 0, YY) + p(EE = 1) H(XX bar.v EE = 1, YY) = \ &= (1 - p_e) underbracket(H(XX bar.v EE = 0, YY), = 0 "perché ricavo da" g) + p_e H(XX bar.v EE = 1, YY) = \ &= p_e H(XX bar.v EE = 1, YY) . $

  L'entropia è maggiorata dalla quantità $log_2(abs(X))$, ma se $EE = 1$ allora devo pescare da $X$ tutti i valori tranne uno, quello corretto, perché appunto sto sbagliando a predire $XX$. Ma allora $ p_e H(XX bar.v EE = 0, YY) lt.eq log_2(abs(X)-1) . $

  Osserviamo infine che $H(EE) lt.eq 1$ perché $EE$ è una variabile bernoulliana.

  Viste queste ultime due valutazioni abbiamo ottenuto: $ 1 + p_e log_2(abs(X)-1) gt.eq H(XX bar.v YY) arrow.long.double p_e gt.eq frac(H(XX bar.v YY) - 1, log_2(abs(X))) . qedhere $
]

Abbiamo mostrato che l'entropia è anche un *lower bound* per la probabilità di errore, oltre che per il valore atteso delle lunghezze del codice. Questo lower bound però è modulato sulla grandezza della sorgente, ma è comunque un lower bound.

== Canale

Per ora ci siamo concentrati sulla prima parte del problema che aveva formulo Shannon, ovvero cercare di comprimere al massimo il messaggio da spedire sul canale. Ora ci concentriamo sul secondo problema, ovvero cercare di codificare il canale stesso per aggiungere ridondanza

Un *canale* è definito dalla tupla $ canale(X, Y, p(y bar.v x)) $ formata da:
- $X$ insieme dei simboli della sorgente;
- $Y$ insieme dei simboli del ricevente;
- $p(y bar.v x)$ probabilità di ottenere $y in Y$ sapendo che è stato ricevuto $x in X$. Questa probabilità è la *matrice di canale*, che ci consente di definire il comportamento del canale.

Noi useremo un *canale discreto senza memoria*:
- _discreto_: lavoriamo con i simboli della sorgente e del ricevente che sono un numero finito;
- _senza memoria_: sia $x^n = (x_1 dots.c x_n)$ un messaggio di $n$ simboli di $X$ e sia $y^n = (y_1 dots.c y_n)$ messaggio di $n$ simboli di $Y$. Osserviamo che $ p(a,b,c) = p(a bar.v b c) p(b bar.v c) p(c) . $ Ma allora $ p(y^n bar.v x^n) &= p(y_n bar.v y^(n-1) x^n) p(y_(n-1) bar.v y^(n-2) x^n) dots.c p(y_3 bar.v y^2 x^n) p(y_2 bar.v y^1 x^n) p(y_1 bar.v x^n) . $ Il canale è senza memoria, ovvero il canale si disinteressa di quello che è stato spedito prima del carattere appena ricevuto e di quello che verrà spedito dopo il carattere appena ricevuto. Quindi: $ p(y^n bar.v x^n) = p(y_n bar.v x_n) p(y_(n-1) bar.v x_(n-1)) dots.c p(y_1 bar.v x_1) = product_(i=1)^n p(y_i bar.v x_i) . $ Questo è il prodotto di tutti (_circa_) gli elementi della matrice di canale.

Dobbiamo definire un'ultima cosa: la *capacità del canale*. Essa rappresenta la massima informazione che possiamo trasmettere quando accediamo al canale. Se immaginiamo un fiume, la capacità di quest'ultimo è la sua portata, ovvero quanta acqua passa nell'unità di tempo. In un canale, l'informazione è l'acqua e l'accesso al canale è l'unità di tempo.

La capacità di un canale $canale(X,Y,p(y bar.v x))$ è definita come $ C = max_(p(x)) I(XX,YY) , $ ovvero su tutte le distribuzioni di probabilità di $XX$ prendiamo l'informazione mutua massima.

Noi sappiamo che $I(XX,YY) gt.eq 0$, ma anche che $ I(XX,YY) &= H(XX) - H(XX bar.v YY) \ &= H(YY) - H(YY bar.v XX) . $

Nella prima relazione $X(XX) lt.eq log_2(abs(X))$ quindi $H(XX) - H(XX bar.v YY) lt.eq log_2(abs(X))$. Possiamo fare un discorso analogo per la seconda relazione, ovvero $H(YY) - H(YY bar.v XX) lt.eq log_2(abs(Y))$. Per far valere entrambe le relazioni prendiamo il minimo tra le due quantità. Ma allora $ 0 lt.eq C lt.eq min(log_2(abs(X)), log_2(abs(Y))) . $

== Esercizi

#example()[
  Dato un canale binario senza rumore, calcolare la capacità del canale.

  #set math.mat(delim: none)

  Possiamo calcolare la capacità in due modi:
  - oldani-style (_non so se corretto_): visto che il canale è binario allora $X = Y = {0.1}$, quindi $ 0 lt.eq C lt.eq max(log_2(2), log_2(2)) = 1 ; $
  - visconti-style: siano $XX,YY$ due variabili casuali che pescano dagli insiemi $X$ e $Y$. Costruiamo la matrice $p(y bar.v x)$ come $ mat(X slash Y, 0, 1; 0, 1, 0; 1, 0, 1; augment: #(hline: 1, vline: 1)) $ Calcoliamo l'informazione mutua con $I (XX,YY) = H(XX) - H(XX bar.v YY) = H(XX) . $ La capacità $C$ è il massimo di tutte le informazioni mutue, quindi il massimo delle entropie di $XX$, ma $XX$ è una bernoulliana quindi ha valore massimo $1$, e quindi anche la capacità è $1$.
]

#example()[
  Abbiamo un sistema sorgente-canale-ricevente tale che $ modello(S,p) quad bar.v quad S = {s_1, s_2, s_3, s_4} quad bar.v quad P = {0.2, 0.3, 0.1, 0.4} . $ Ci viene data la matrice stocastica del canale, ovvero cosa succede al dato quando viene immesso sul canale. Essa è definita da $ M = mat(0.2, 0.2, 0.3, 0.2, 0.1; 0.2, 0.5, 0.1, 0.1, 0.1; 0.6, 0.1, 0.1, 0.1, 0.1; 0.3, 0.1, 0.1, 0.1, 0.4) . $ Sulle righe ho indice $i = 1, dots, 4$ e sulle colonne ho indice $j = 1, dots, 5$.

  La prima domanda della scorsa lezione chiedeva di trovare $H(S bar.v R)$, che abbiamo fatto in modo facile con la definizione di entropia condizionata.

  Il modo difficile è calcolare la stessa quantità con $ H(S bar.v R) = H(R) + H(S bar.v R) = H(S) + H(R bar.v S) $ considerando i due membri di destra. L'unica quantità che conosciamo (_da calcolare in realtà_) è $H(S)$.

  Calcoliamo la quantità $H(S bar.v R)$. Noi sappiamo che $ H(S bar.v R) = sum_(j=1)^5 p(b_j) H(S bar.v b_j) = sum_(j=1)^5 p(b_j) sum_(i=1)^4 p(a_i bar.v b_j) log(1/p(a_i bar.v b_j)) . $

  Sapendo che $p(a,b) = p(a bar.v b) p(b) = p(b bar.v a) p(a)$, possiamo calcolare $ p(b_j, a_i) = p(b_j bar.v a_i) p(a_i) = mat(0.04, 0.04, 0.06, 0.04, 0.02; 0.06, 0.15, 0.03, 0.03, 0.03; 0.06, 0.01, 0.01, 0.01, 0.01; 0.12, 0.04, 0.04, 0.04, 0.16) . $ Calcoliamo la probabilità dei simboli di $R$, sommando sulle colonne, ovvero $ p(b in R) = mat(0.28, 0.24, 0.14, 0.12, 0.22) . $

  Sapendo che $p(a_i bar.v b_j) = p(a_i, b_j) / p(b_j)$, calcoliamo la matrice $ p(a_i bar.v b_j) = mat(0.14, 0.17, 0.43, 0.33, 0.09; 0.21, 0.63, 0.21, 0.25, 0.14; 0.21, 0.04, 0.07, 0.08, 0.05; 0.42, 0.17, 0.29, 0.33, 0.73) $ ovvero prendo la matrice fatta prima e divido per le probabilità del ricevente. Facendo tutti i conti (_non ho voglia_) si trova $H(S bar.v R)$.

  Ora devo solo trovare $H(R)$ visto che ora abbiamo le probabilità.
]
