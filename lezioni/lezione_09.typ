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

// Appunti

= Lezione 09

== Informazione mutua

L'*informazione mutua* è un parametro che fa riferimento a due variabili casuali e indica quanta informazione viene rilasciata da una rispetto all'altra. È definita come $ I(Chi,Y) = sum_(x in Chi) sum_(y in Y) p(x,y) log frac(p(x,y), p(x) p(y)) . $

#lemma(numbering: none)[
  L'informazione mutua è non negativa, ovvero $ I(Chi,Y) gt.eq 0 . $
]

#proof[
  \ Applicando la definizione di probabilità congiunta otteniamo $ I(Chi,Y) & = sum_(x in Chi) sum_(y in Y) p(x,y) log frac(p(y) p(x bar.v y), p(x) p(y)) = \ & = sum_(x in Chi) sum_(y in Y) p(x,y) log 1/p(x) + sum_(x in Chi) sum_(y in Y) p(x,y) log p(x bar.v y) = \ & = H(Chi) - H(Chi bar.v Y) gt.eq 0 . $
]

Se $Chi$ e $Y$ sono *indipendenti* quanto vale l'informazione mutua? Ovviamente zero: infatti, $ H(Chi bar.v y) = H(Chi) arrow.long.double I(Chi,Y) = H(Chi) - H(Chi) = 0 . $

E se invece $Chi = g(Y)$? In questo caso $H(Chi bar.v Y) = 0$, quindi $ I(Chi,Y) = H(X) - underbracket(H(Chi bar.v Y), 0) = H(Chi) . $

// Da capire il grafico da mettere

// Da rileggere
Infine, vale anche $ I(Chi, Y bar.v Z) = sum_(x in Chi) sum_(y in Y) p(x, y bar.v z) log frac(p(x,y bar.v z), p(y bar.v z) p(x bar.v z)) . $

// Qua c'erano esercizi

== Data processing inequality

Introduciamo un teorema molto importante, che però non dimostreremo.

#theorem(
  name: "Data processing inequality",
  numbering: none
)[
  Siano $Chi,Y,Z$ variabili casuali a dominio finito tali che $p(x,y,z)$ soddisfa $ p(x, y bar.v z) = p(x bar.v y) p(z bar.v y) quad forall x,y,z , $ cioè $x,z$ sono indipendenti dato $y$. Allora l'informazione mutua tra $Chi$ e $Y$ è non minore dell'informazione mutua tra $Chi$ e $Z$. Formalmente, $ I(Chi,Y) gt.eq I(Chi,Z) . $
]

#corollary(numbering: none)[
  Vale la disequazione $ I(Chi, Y) gt.eq I(Chi, Y bar.v Z) . $
]

// Qua c'erano esercizi

== Disuguaglianza di Fano

Un altro teorema importante che enunciamo ma che non dimostriamo è la *disuguaglianza di Fano*.

#theorem(
  name: "Disuguaglianza di Fano",
  numbering: none
)[
  Siano $Chi,Y$ variabili casuali su domini $XX,YY$ finiti. Sia $g : YY arrow.long XX$ la funzione di decodifica e $p_e$ la probabilità di errore $p_e = p(g(Y) eq.not Chi)$, allora $ p_e gt.eq frac(H(Chi bar.v Y) - 1, log_2 |XX|) . $
]
