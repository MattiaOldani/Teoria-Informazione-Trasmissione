// Setup

#import "@preview/commute:0.2.0": node, arr, commutative-diagram

// Appunti

= Lezione 11

== Canale binario a cancellazione

L'altro canale che introduciamo è il *canale binario a cancellazione*, detto anche *BEC* (_binary erased channel_).

#align(center)[
  #commutative-diagram(
    node-padding: (50pt, 50pt),
    arr-clearance: 0.5em,
    padding: 1em,
    debug: false,

    node((0,0), [$0$]),
    node((0,1), [$0$]),
    node((1,1), [$e$]),
    node((2,0), [$1$]),
    node((2,1), [$1$]),

    arr((0,0), (0,1), [$1-alpha$]),
    arr((0,0), (1,1), [$alpha$]),
    arr((2,0), (1,1), [$alpha$]),
    arr((2,0), (2,1), [$1-alpha$]),
  )
]

Il termine $e$ indica l'errore: con probabilità $1-alpha$ riceviamo il simbolo giusto, mentre con probabilità $alpha$ si verifica un errore.

Calcoliamo la capacità di questo canale osservando che $ H(Y bar.v Chi = 0) = H(Y bar.v X = 1) = H(alpha) $ e quindi che $ H(alpha) = H(Y bar.v Chi) . $

Lo possiamo osservare graficamente questo risultato.

#align(center)[
  #commutative-diagram(
    node-padding: (30pt, 30pt),
    arr-clearance: 0.5em,
    padding: 1em,
    debug: false,

    node((1,0), [$0$]),
    node((0,1), [$0$]),
    node((2,1), [$e$]),
    node((1,2), [$1$]),
    node((0,3), [$1$]),
    node((2,3), [$e$]),
    node((1,4), []),
    node((1,5), [$H(alpha)$]),

    arr((1,0), (0,1), [$$]),
    arr((1,0), (2,1), [$$]),
    arr((1,2), (0,3), [$$]),
    arr((1,2), (2,3), [$$]),
    arr((1,4), (1,5), [$$]),
  )
]

Questo implica che $ I(Chi,Y) = H(Y) - H(alpha) . $

Dobbiamo quindi calcolare il valore massimo di $H(Y)$. Introduciamo la variabile aleatoria $Z$ tale che $ Z("bho") = cases(1 & "se" YY = e, 0 quad & "altrimenti") quad . $

Questa variabile vale $1$ se c'è errore, altrimenti vale $0$. Notiamo che $ H(Y,Z) = H(Y) + H(Z bar.v Y), $ ma $H(Z bar.v Y) = 0$ quindi $ H(Y,Z) = H(Y) . $ Vale anche che $ H(Y,Z) = H(Z) + H(Y,Z), $ ma allora $ H(Y) = H(Z) + H(Y bar.v Z) . $

Dopo questa bella catena di uguaglianze osserviamo che $ p(Z = 1) & = p(Z = 1 bar.v Chi = 0) p(Chi = 0) + p(Z = 1 bar.v Chi = 1) p(Chi = 1) = \ & = alpha p(Chi = 0) + alpha p(Chi = 1) = alpha . $

Ne consegue che $p(Z = 0) = 1 - alpha$ e quindi che $H(alpha) = H(Z)$. Manca da calcolare $H(Y bar.v Z)$. Sappiamo che $p(Y = 1 bar.v Z = 0) = p(X = 1)$ e quindi che $H(Y bar.v Z = 0) = H(Chi)$. Possiamo allora scrivere che $ H(Y bar.v Z) = H(Y bar.v Z = 0) underbracket(p(Z = 0), 1-alpha) + underbracket(H(Y bar.v Z = 1), 0) p(Z = 1) = H(Chi) (1-alpha) . $

Concludiamo quindi dicendo che $ C = max_(p(Chi)) H(Y) - H(alpha) = max_(p(Chi)) (H(alpha) + H(Chi)(1-alpha)) - H(alpha) = (1-alpha) max_(p(Chi)) H(Chi) = 1 - alpha . $

== Codice di Fano

=== Definizione

Presentiamo l'algoritmo per costruire un codice di Fano.

Per costruire un *codice di Fano* seguiamo i seguenti passi:
+ ordiniamo le probabilità in maniera decrescente;
+ dividiamo le probabilità in due gruppi $G_1,G_2$ tali che $ sum_(g_1 in G_1) p_g_1 =^tilde sum_(g_2 in G_2) p_g_2 , $ ovvero due gruppi che hanno più o meno la stessa somma di probabilità;
+ assegniamo valore $0$ agli eventi del primo gruppo $G_1$ e valore $1$ agli eventi del secondo gruppo $G_2$;
+ applichiamo ricorsivamente i punti 1,2,3 finché ci sono ancora simboli da assegnare.

=== Esempio

Dati i simboli ${A,B,C,D,E}$ con probabilità ${0.35,0.25,0.15,0.15,0.1}$.

Applichiamo l'algoritmo passo passo:
+ dividiamo in due gruppi con probabilità più o meno uguali, ad esempio ${A,B}$ e ${C,D,E}$;
+ assegniamo $0$ a ${A,B}$;
  + dividiamo in due gruppi con probabilità più o meno uguali, ad esempio ${A}$ e ${B}$;
  + assegniamo $0$ a ${A}$;
  + assegniamo $1$ a ${B}$;
+ assegniamo $1$ a ${C,D,E}$;
  + dividiamo in due gruppi con probabilità più o meno uguali, ad esempio ${C}$ e ${D,E}$;
  + assegniamo $0$ a ${C}$;
  + assegniamo $1$ a ${D,E}$;
    + dividiamo in due gruppi con probabilità più o meno uguali, ad esempio ${D}$ e ${E}$;
    + assegniamo $0$ a ${D}$;
    + assegniamo $1$ a ${E}$.

Abbiamo ottenuto il seguente codice:
- $A arrow.long 00$;
- $B arrow.long 01$;
- $C arrow.long 10$;
- $D arrow.long 110$;
- $E arrow.long 111$.

Notiamo come questo codice non sia ottimale: il problema è che partiamo dalla radice e già assegniamo i prefissi, quindi il contrario di quello che fa Huffman.
