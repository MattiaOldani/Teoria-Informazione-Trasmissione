#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 10 [29/10]

#v(12pt)

#align(center)[
  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,

    [*APPELLI INVERNALI: 24-01 / 07-02 / 21-02*],
  )
]

== Teoria

Prendiamo il teorema precedente e vediamo cosa succede se $ZZ$ non è indipendente da $XX$ dato $YY$.

#example()[
  Siano $XX,YY$ variabili casuali indipendenti e sia $ZZ = XX + YY$. Se $XX,YY = {0,1}$, con $p_XX = p_YY = 0.5$, allora $ZZ = {0,1,2}$. Vediamo quanto valgono $ I(XX,YY) = H(XX) - H(XX bar.v YY) = H(XX) - H(XX) = 0 $ e $ I(XX,YY bar.v ZZ) &= H(XX bar.v ZZ) - H(XX bar.v YY,ZZ) = \ &= p(ZZ = 0) H(XX bar.v ZZ = 0) +p(ZZ = 1) H(XX bar.v ZZ = 1) + \ &+ space p(ZZ = 2) H(XX bar.v ZZ = 2) + 0 = \ &= 0 + p(ZZ = 1) H(XX bar.v ZZ = 1) + 0 = \ &= p(ZZ = 1) = 1/2 = epsilon $ perché gli eventi sono $0+0 slash 0+1 slash 1+0 slash 1+1$ e a noi ne vanno bene $2$ su $4$. Rimane quindi che $ I(XX,YY) gt.eq I(XX,ZZ) + epsilon arrow.long.double 0 gt.eq I(XX,ZZ) + 1/2 . $

  Quindi questa cosa non funziona, visto che ho dipendenza tra $XX,YY$ e $ZZ$ e quindi non va più la disuguaglianza, ha cambiato verso.
]

== Esercizi

#set math.mat(delim: "[")

#example([TDE 01/04/2003])[
  Abbiamo un sistema sorgente-canale-ricevente tale che $ modello(S,p) quad bar.v quad S = {s_1, s_2, s_3, s_4} quad bar.v quad P = {0.2, 0.3, 0.1, 0.4} . $ Ci viene data la matrice stocastica del canale, ovvero cosa succede al dato quando viene immesso sul canale. Essa è definita da $ M = mat(0.2, 0.2, 0.3, 0.2, 0.1; 0.2, 0.5, 0.1, 0.1, 0.1; 0.6, 0.1, 0.1, 0.1, 0.1; 0.3, 0.1, 0.1, 0.1, 0.4) . $ Sulle righe ho indice $i = 1, dots, 4$ e sulle colonne ho indice $j = 1, dots, 5$.

  *DOMANDA 1*: calcolare $H(R bar.v S)$.

  Usiamo le formule dell'entropia condizionata, ovvero $ H(R bar.v S) = sum_(i=1)^4 p(s_i) H(R bar.v S = s_i) $ e $ H(R bar.v S = s_i) = sum_(j=1)^5 p(r_j bar.v s_i) log(1/p(r_j bar.v s_i)) . $

  Andiamo a calcolare le quantità $H(R bar.v S = s_i)$:
  - $s_1: 0.2 log(5) + 0.2 log(5) + 0.3 log(10/3) + 0.2 log(5) + 0.1 log(10) = 2.247$;
  - $s_2: 0.2 log(5) + 0.5 log(2) + 0.1 log(10) + 0.1 log(10) + 0.1 log(10) = 1.961$;
  - $s_3: 0.6 log(5/3) + 0.1 log(10) + 0.1 log(10) + 0.1 log(10) + 0.1 log(10) = 1.771$;
  - $s_4: 0.3 log(10/3) + 0.1 log(10) + 0.1 log(10) + 0.1 log(10) + 0.4 log(5/2) = 2.046$.

  Moltiplichiamo questi valori per le probabilità e otteniamo l'entropia richiesta: $ H(R bar.v S) = 0.2 dot 2.247 + 0.3 dot 1.961 + 0.1 dot 1.771 + 0.4 dot 2.046 = 2.033 "bit". $

  *DOMANDA 2*: calcolare $H(S bar.v R)$.

  /* Sappiamo che $ H(R) + H(S | R) = H(S) + H(R | S) . $ Di questa relazione conosco $H(S)$ (_da calcolare_) e $H(R bar.v S)$, quindi $ H(S bar.v R) = H(S) + H(R bar.v S) - H(R) . $ Devo calcolare solo $H(R)$. Sappiamo che $ H(R) = sum_(j=1)^5 p(r_j) log(1/p(r_j)) . $ */

  Non so come fare.
]
