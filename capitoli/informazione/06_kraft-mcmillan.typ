// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Disuguaglianza di Kraft-McMillan

Per ora abbiamo sempre considerato dei CI perché ci davano una serie di proprietà belle, ma ce l'abbiamo un codice UD che abbia lunghezze minime e che magari sia meglio di un CI? Se rilasso il vincolo _"no-stream"_ esiste negli UD una cosa buona come Huffman o anche di meglio?

Modifichiamo leggermente l'estensione $C$ di un codice: sia ora $ C_k : X^k arrow.long D^+ $ l'*estensione* $bold(k)$-*esima* del codice $c$, con $k gt.eq 1$, tale che $ C_k (x_1 dot dots dot x_k) = c(x_1) dot dots dot c(x_k) . $

Le lunghezze di $C_k$ sono $ l_(C_k)(x_1 dot dots dot x_k) = sum_(i=1)^k l_c (x_i) . $ Per convenzione sia $ l_max = max_(i = 1, dots, k) l_c (x_i) . $ Ma allora $ l_(C_k)(x_1, dots, x_k) lt.eq k l_max . $

#theorem([Disuguaglianza di Kraft-McMillan])[
  Data una sorgente $X = {x_1, dots, x_m}$, data $d > 1$ base del codice e dati $m$ interi $l_1, dots, l_m > 0$ che mi rappresentano le lunghezze dei simboli del codice, esiste un codice UD $ c : X arrow.long D^+ $ tale che $ l_c (x_i) = l_i quad forall i = 1, dots, m $ se e solo se $ sum_(i=1)^m d^(-l_i) lt.eq 1 . $
]

Uguale alla disuguaglianza di Kraft nei CI, ma qua viene definita negli UD.

#proof()[
  Dimostriamo la doppia implicazione.

  {$arrow.long.double.l$} Pezzo gratis: per la disuguaglianza di Kraft sui CI esiste un CI, ma i CI sono anche UD, quindi questa implicazione è vera.

  {$arrow.long.double.r$} Partiamo dal valore $ sum_(i=1)^m d^(-l_i) = sum_(x in X) d^(-l_c (x)) . $ e vediamo che valori assume la quantità $ (sum_(x in X) d^(-l_c (x)))^k . $ Come possiamo riscrivere la potenza di una sommatoria? Vediamolo con un esempio.

  #example()[
    Se $k = 2$ allora $ (sum_(i) a_i)^2 = sum_i a_i sum_j a_j = sum_i sum_j a_i a_j . $
  ]

  Visto questo esempio, possiamo dire che $ (sum_(x in X) d^(-l_c (x)))^k &= sum_(x_1 in X) dots.c sum_(x_k in X) d^(-l_c (x_1)) dot dots dot d^(-l_c (x_k)) = \ &= sum_(x_1 dot dots dot x_k in X^k) d^(-(l_c (x_1) + dots + l_c (x_k))) = \ &= sum_(x_1 dot dots dot x_k in X^k) d^(-l_(C_k)(x_1 dot dots dot x_k)) . $

  Cosa abbiamo dentro l'insieme $X^k$? Abbiamo tutte le possibili combinazioni (_in realtà disposizioni_) di $k$ simboli, ma come sono le lunghezze di queste parole?

  La minima è sicuramente $k$, e questo succede quando ad ogni simbolo $x_i bar.v i = 1, dots, k$ assegno la lunghezza $1$ (_in questo caso dovrei avere_ $m lt.eq d$ _sennò il codice è singolare e non va bene_), mentre la massima è $k l_max$, come abbiamo mostrato prima.

  Andiamo a partizionare l'insieme $X^k$ in insiemi $X_t^k$, ognuno dei quali contiene delle parole di $k$ simboli lunghi in totale $t gt.eq 1$. In poche parole $ X_t^k = {(x_1, dots, x_k) in X^k bar.v l_(C_k)(x_1, dots, x_k) = t} . $ Nell'insieme $X_(k l_max)^k$ abbiamo le parole di lunghezza massima. Riscriviamo la sommatoria come $ sum_(x_1 dot dots dot x_k in X^k) d^(-l_(C_k)(x_1 dot dots dot x_k)) &= sum_(n=1)^(k l_max) space sum_(x_1 dot dots dot x_k in X_n^k) d^(-l_(C_k)(x_1 dot dots dot x_k)) = \ &= sum_(n=1)^(k l_max) sum_(x_1 dot dots dot x_k in X_n^k) d^(-n) = \ &= sum_(n=1)^(k l_max) abs(X_n^k) d^(-n) . $

  La nostra funzione $C_k$ è iniettiva (_non singolare_) perché il codice è UD, quindi il codominio di questo codice deve essere più grande o al massimo uguale al dominio. Il dominio è $X_n^k$, il codominio è $D^n$, quindi $abs(X_n^k) lt.eq abs(D^n) = d^n$, ma allora (_dominio e codominio un po' sus_) $ sum_(n=1)^(k l_max) abs(X_n^k) d^(-n) lt.eq sum_(n=1)^(k l_max) d^n d^(-n) = sum_(n=1)^(k_max) 1 = k l_max . $

  Siamo arrivati ad avere, dopo tutta sta catena, alla relazione $ (sum_(x in X) d^(-l_c (x)))^k lt.eq k l_max . $ Chiamando $ M = sum_(x in X) d^(-l_c (x)) , $ dobbiamo verificare che $ M^k lt.eq k l_max . $

  #v(12pt)

  #figure(image("assets/06_kraft.svg", width: 57%))

  #v(12pt)

  Se disegno $M^k$ ottengo due grafici diversi:
  - se $M > 1$ ho un esponenziale crescente, che da un certo punto $k_0$ rende falsa la relazione;
  - se $0 lt.eq M lt.eq 1$ ho un esponenziale decrescente, che da un certo punto $k_0$ rende vera la relazione.

  Ma allora $ M lt.eq 1 arrow.long.double sum_(i=1)^m d^(-l_c (x_i)) lt.eq 1 . qedhere $
]
