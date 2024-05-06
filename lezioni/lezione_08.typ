// Setup

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "lemma"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "corollary"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import emoji: square, suit

// Appunti

= Lezione 08

// Non li faccio ora, li scrivo e basta
== Esercizi di probabilità

=== Esercizio 01

Sapendo che la probabilità di ottenere un messaggio corrotto è $1/8$, quanti bit servono per rappresentarlo?

RISPOSTA:

=== Esercizio 02

Qual è la probabilità di ottenere 4 messaggi dove il primo è corretto e gli altri 3 no, sapendo che la probabilità di ottenere un messaggio corretto è uguale a $1/8$?

RISPOSTA:

=== Esercizio 03

Preso l'esercizio precedente, quanti bit ci servono?

RISPOSTA:

=== Esercizio 04

Abbiamo un dato a 6 facce lanciato 20 volte. Qual è la probabilità di:
- fare 20 lanci senza mai ottenere 5?
  - RISPOSTA:
- fare 20 lanci ottenendo 5 solo una volta?
  - RISPOSTA:
- fare 20 lanci ottenendo 5 almeno una volta?
  - RISPOSTA:

== Numero di bit necessari

Quanti bit ci servono per comunicare il risultato di un certo evento?

Se usiamo un codice istantaneo sappiamo che $ H(Chi) < \#"bit" . $

_Se avessimo due variabili?_ Ovvero, _se avessimo due risultati da comunicare?_

Introduciamo l'*entropia congiunta* come $ H(Chi,Y) = sum_(x in Chi) sum_(y in Y) p(x,y) log_2 1/p(x,y) . $

_Se invece avessimo un evento condizionante_? Ovvero, _se il ricevente conosce $Chi$. quanti bit ci servono per comunicare Y?_

// Zio ma che appunti sto guardando
Introduciamo allora l'*entropia condizionata* come $ H(Y bar.v Chi) & = sum_(x in Chi) p(x) H(Y bar.v Chi = x) = \ & = sum_(x in Chi) p(x) (sum_(y in Y) p(y bar.v x) 2 p(y bar.v x)) = \ & = sum_(x in X) sum_(y in Y) p(x,y) 2 p(y bar.v x) . $

In questo caso:
- $p(x,y)$ è detta *probabilità congiunta* ed è la probabilità che avvengano $x$ e $y$;
- $p(x) = sum_(y in Y) p(x,y)$ è detta *probabilità marginale*;
- $p(y bar.v x) = frac(p(x,y), p(x))$ è detta *probabilità condizionale*.

// Non so se maiuscole o no, appunti fatti con il culo
#lemma(
  name: "Chain Rule per l'entropia",
  numbering: none
)[
  Vale la seguente uguaglianza: $ H(Chi,Y) = H(Chi) + H(Y bar.v Chi) = H(Y) + H(Chi bar.v Y) . $

  Vale inoltre, negli spazi condizionati, l'uguaglianza: $ H(Chi, Y bar.v Z) = H(Chi, Z) + H(Y bar.v X, Z) . $
]

// Come prima, non li faccio
== Esercizi su entropia

=== Esercizio 01

Sia $x in Chi$ una variabile rappresentante l’estrazione di un numero tra $0$ e $9$, e sia $Y$ definita come $Y = Chi + 2 mod 10$. Quanto vale $H(Y|Chi)$?

RISPOSTA:

=== Esercizio 02

Siano $Chi = {−1, 0, 1}$ e $Y = X^2$. Quanto vale $H(Y bar.v Chi)$? E invece $H(Chi bar.v Y)$?

RISPOSTA:

=== Esercizio 03

Dato un sistema SCR (sorgente-canale-ricevente), sia $M$ una matrice che rappresenta il canale C.

// Sistema
$ M = mat(, b_1, b_2, b_3, b_4, b_5; a_1, 0.3, 0.1, 0.3, 0.1, 0.1; a_2, 0.2, 0.2, 0.2, 0.2, 0.2; a_3, 0.3, 0.3, 0.1, 0.1, 0.2; a_4, 0.3, 0.3, 0.3, 0.05, 0.05;) . $

Siano inoltre $Chi = {a_1, a_2, a_3, a_4}$ e $p = [0.2, 0.2, 0.2, 0.4]$ per S(?).

Quanto vale $H(R bar.v S)$?

RISPOSTA:

=== Esercizio 04

Calcolare $H(R bar.v S)$ come nell'esercizio precedente usando però $ M = mat(0.2, 0.2, 0.3, 0.2, 0.1; 0.2, 0.5, 0.1, 0.1, 0.1; 0.6, 0.1, 0.1, 0.1, 0.1; 0.3, 0.1, 0.1, 0.1, 0.4) $ e $p = [0.2, 0.3, 0.1, 0.4]$.

RISPOSTA:

=== Esercizio 05

Posso ottenere lo stesso risultato dell'esercizio in un altro modo?

Ad esempio:
- usando la chain rule?
  - RISPOSTA:
- usando la chain rule, regola 1 modificata?
  - RISPOSTA:
