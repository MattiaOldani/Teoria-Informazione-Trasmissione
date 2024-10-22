#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)

#import emoji: square


= Lezione 08 [22/10]

== Disuguaglianza di Kraft-McMillan

Per ora abbiamo sempre considerato dei CI perché ci davano una serie di proprietà belle, ma ce l'abbiamo un codice UD che abbia lunghezze minime e che magari sia meglio di un CI? Se rilasso il vincolo _no-stream_ esiste negli UD una cosa buona come Huffman o anche di meglio?

Riprendiamo alcuni concetti utili per il prossimo teorema.

Che codici abbiamo visto fin'ora? Ne abbiamo visti tre:
- $c : X arrow.long D^+$ codifica iniziale;
- $C : X^+ arrow.long D^+$ estensione di $c$;
- $C_n : X^n arrow.long D^+$ codice a blocchi.

A noi ora non serve il codice a blocchi ma solo l'estensione, ma modifichiamola leggermente: sia $C_k : X^k arrow.long D^+$ l'estensione $k$-esima del codice $c$, con $k gt.eq 1$, tale che $ C_k (x_1, dots, x_k) = c(x_1) dot dots dot c(x_k) . $

Il codice $c$ deve essere sicuramente non singolare, ma anche $C_k$ lo deve essere, quindi il codice è UD.

Le lunghezze di $C_k$ sono $ l_(C_k)(x_1 dots x_k) = sum_(i=1)^k l_c (x_i) . $ Per convenzione sia $ l_max = max_(i = 1, dots, k) l_c (x_i) . $ Ma allora $ l_(C_k)(x_1, dots, x_k) lt.eq k l_max . $

Siamo pronti per dimostrare il seguente teorema.

#theorem([Disuguaglianza di Kraft-McMillan])[
  Data una sorgente $X = {x_1, dots, x_m}$, data $d > 1$ base del codice e dati $m$ interi $l_1, dots, l_m > 0$ che mi rappresentano le lunghezze dei simboli del codice, esiste un codice UD $c : X arrow.long D^+$ tale che $ l_c (x_i) = l_i quad forall i = 1, dots, m $ se e solo se $ sum_(i=1)^m d^(-l_i) lt.eq 1 . $
]

Uguale alla disuguaglianza di Kraft nei CI, ma qua viene definiti negli UD.

#proof()[
  Dimostriamo la doppia implicazione.

  {$arrow.long.double.l$}

  Pezzo gratis: per la disuguaglianza di Kraft sui CI esiste un CI, ma i CI sono anche UD, quindi questa implicazione è vera.

  {$arrow.long.double.r$}

  Partiamo dal valore $ sum_(i=1)^m d^(-l_i) = sum_(x in X) d^(-l_c (x)) . $ e vediamo che valori assume la quantità $ (sum_(x in X) d^(-l_c (x)))^k . $ Come possiamo riscrivere la potenza di una sommatoria? Vediamolo con un esempio.

  #example()[
    $ (sum_(i) a_i)^2 = sum_i a_i sum_j a_j = sum_i sum_j a_i a_j . $
  ]

  Visto questo esempio, possiamo dire che $ (sum_(x in X) d^(-l_c (x)))^k &= sum_(x_1 in X) dots.c sum_(x_k in X) d^(-l_c (x_1)) dot dots dot d^(-l_c (x_k)) = \ &= sum_(x_1, dots, x_k in X^k) d^(-(l_c (x_1) + dots + l_c (x_k))) = \ &= sum_(x_1 dots x_k in X^k) d^(-l_(C_k)(x_1, dots, x_k)) . $

  Cosa abbiamo dentro l'insieme $X^k$? Abbiamo tutte le possibili combinazioni (_in realtà disposizioni_) di $k$ simboli, ma come sono le lunghezze di queste parole?

  La minima è sicuramente $k$, e questo succede quando ad ogni simbolo $x_i bar.v i = 1, dots, k$ assegno la lunghezza $1$ (_in questo caso dovrei avere_ $m lt.eq d$ _sennò il codice è singolare e non va bene_), mentre la massima è $k l_max$, come abbiamo mostrato prima.

  Andiamo a partizionare l'insieme $X^k$ in insiemi $X_t^k$, ognuno dei quali contiene delle parole di $k$ simboli lunghi in totale $t gt.eq 1$. In poche parole $ X_t^k = {(x_1, dots, x_k) in X^k bar.v l_(C_k)(x_1, dots, x_k) = t} . $ Nell'insieme $X_(k l_max)^k$ abbiamo le parole di lunghezza massima.

  Riscriviamo la sommatoria come $ sum_(x_1 dots x_k in X^k) d^(-l_(C_k)(x_1, dots, x_k)) &= sum_(n=1)^(k l_max) space sum_((x_1, dots, x_k) in X_n^k) d^(-l_(C_k)(x_1, dots, x_k)) = \ &= sum_(n=1)^(k l_max) sum_((x_1, dots, x_k) in X_n^k) d^(-n) = \ &= sum_(n=1)^(k l_max) abs(X_n^k) d^(-n) . $

  La nostra funzione $C_k$ è iniettiva (_non singolare_) perché il codice è UD, quindi il codominio di questo codice deve essere più grande o al massimo uguale al dominio. Il dominio è $X_t^k$, il codominio è $D^n$, quindi $abs(X_n^k) lt.eq abs(D^n) = d^n$, quindi $ sum_(n=1)^(k l_max) abs(X_n^k) d^(-n) lt.eq sum_(n=1)^(k l_max) d^n d^(-n) = sum_(n=1)^(k_max) 1 = k l_max . $

  Siamo arrivati ad avere, dopo tutta sta catena, alla relazione $ (sum_(x in X) d^(-l_c (x)))^k lt.eq k l_max . $ Chiamo $M = sum_(x in X) d^(-l_c (x))$, quindi devo verifica che $ M^k lt.eq k l_max . $

  #v(12pt)

  #figure(
    image("../assets/08_kraft.svg", width: 70%),
  )

  #v(12pt)

  Se disegno $M^k$ ottengo due grafici diversi:
  - se $M > 1$ ho un esponenziale crescente, che da un certo punto $k_0$ rende falsa la relazione;
  - se $0 M lt.eq 1$ ho un esponenziale decrescente, che da un certo punto $k_0$ rende vera la relazione.

  Ma allora $ M lt.eq 1 arrow.long.double sum_(i=1)^m d^(-l_c (x_i)) lt.eq 1 . qedhere $
]

== Esercizi

#example()[
  Il signor Giovanni Rossi ha $ X = {x_1, x_2, x_3, x_4, x_5} quad bar.v quad D = {000, 001, 01, 110, 111} . $ Giovanni ha costruito il codice migliore usando una certa distribuzione $P_i$ ma il bro non si ricorda quale ha utilizzato tra:
  - $P_1 = {0.2, 0.2, 0.2, 0.2, 0.2}$;
  - $P_2 = {0.4, 0.2, 0.2, 0.1, 0.1}$;
  - $P_3 = {0.1, 0.1, 0.2, 0.4, 0.2}$.

  Quale di queste probabilità è stata utilizzata?

  Calcoliamo i valori attesi: $ EE[l_c bar.v P_1] &= 3/5 + 3/5 + 2/5 + 3/5 + 3/5 = 14/5 \ EE[l_c bar.v P_2] &= 12/10 + 6/10 + 4/10 + 3/10 + 3/10 = 14/5 \ EE[l_c bar.v P_3] &= 3/10 + 3/10 + 4/10 + 12/10 + 6/10 = 14/5 $

  Sono tutte uguali. Soluzione alternativa: con Huffman dovevamo vedere se le lunghezze che uscivano erano uguali a quelle date.
]

#example()[
  Date $ X = {a_1, dots, a_8, a_9, dots, a_12} quad bar.v quad P = {underbracket(0.1\, dots\, 0.1, 1\, dots\, 8), underbracket(0.05\, dots\, 0.05, 9\, dots\, 12)} . $

  Scrivere un CI con $d = 5$.

  Applicando Huffman si ottiene:
  - $a_1 = 2$;
  - $a_2 = 3$;
  - $a_3 = 00$;
  - $a_4 = 01$;
  - $a_5 = 02$;
  - $a_6 = 03$;
  - $a_7 = 04$;
  - $a_8 = 10$;
  - $a_9 = 11$;
  - $a_10 = 12$;
  - $a_11 = 13$;
  - $a_12 = 14$.

  Posso fare meglio perché non ho un numero giusto di simboli, $5$ foglie non vengono coperte. Soluzione alternativa: creare l'albero di codifica cercando di coprire tutte le foglie.
]

Riguardo l'ultimo esercizio, come faccio se devo usare per forza Huffman? Il problema dell'ultimo esercizio è nel numero di simboli, che non sono nel numero corretto. Quale è il numero corretto? Mo ci arrivo, calma.

Supponiamo di partire da $m$ simboli, ad ogni iterazione rimuoviamo $d - 1$ simboli: $ m arrow.long m - (d - 1) arrow.long m - 2 (d - 1) arrow.long dots arrow.long m - t (d - 1). $ Chiamiamo $square.black = m - t (d - 1)$. Siamo arrivati ad avere $square.black$ elementi, con $square.black lt.eq d$.

Noi vorremmo avere esattamente $d$ elementi per avere un albero ben bilanciato e senza perdita di rami, quindi aggiungiamo a $square.black$ un numero $k$ di *simboli dummy* tali per cui $square.black + k = d$. I simboli dummy sono dei simboli particolari che hanno probabilità nulla e che usiamo solo come riempimento. Supponiamo di eseguire ancora un passo dell'algoritmo, quindi da $square.black + k$ andiamo a togliere $d - 1$ elementi, lasciando la sorgente con un solo elemento.

Cosa abbiamo ottenuto? Ricordando che $square.black = m - t (d - 1)$, abbiamo fatto vedere che: $ square.black + k - (d - 1) &= 1 \ m - t (d - 1) + k - (d - 1) &= 1 \ m + k - (t + 1)(d - 1) &= 1. $

In poche parole, il numero $m$ di simboli sorgente, aggiunto al numero $k$ di simboli "fantoccio", è congruo ad $1$ modulo $(d - 1)$, ovvero $ m + k equiv 1 mod d - 1 . $

#example()[
  Rifare l'esercizio precedente sapendo che possiamo utilizzare i simboli dummy.

  Applicando Huffman si ottiene:
  - $a_1 = 2$;
  - $a_2 = 3$;
  - $a_3 = 4$;
  - $a_4 = 00$;
  - $a_5 = 01$;
  - $a_6 = 02$;
  - $a_7 = 03$;
  - $a_8 = 04$;
  - $a_9 = 10$;
  - $a_10 = 11$;
  - $a_11 = 12$;
  - $a_12 = 13$;
  - $a_13 = 14$ (_questo è dummy_).

  Ora l'albero di codifica non ha nessuna foglia scoperta.
]
