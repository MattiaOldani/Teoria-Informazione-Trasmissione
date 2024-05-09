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

// Appunti

= Lezione 15

== Correzione codici ciclici

Assumiamo di voler trasmettere il messaggio $x^6 + x^5 + x^4 + x^3 + x^2 + x + 1$ e che, grazie al rumore, $x^4$ viene trasmesso sbagliato. _Come lo correggiamo?_

Diamo la definizione di *peso di Hamming* $w(s(x))$ come il numero di $1$ che la parola $s(x)$ ha, quindi $ w(s(x)) = \#_1 (s(x)) . $

Rinominiamo inoltre il resto $r(x)$ tra $p(x)$ e $q(x)$ come *sindrome*, e lo indichiamo da ora con $s(x)$.

Data una parola $p(x)$, per correggerla utilizziamo il seguente algoritmo:
+ calcoliamo $s(x)$;
+ se $w(s(x)) lt.eq t$, con $t$ numero di errori, allora possiamo correggere la parola, altrimenti continuiamo con l'algoritmo;
+ se appunto $w(s(x)) > t$ prendiamo $k=0$, lo incrementiamo di $1$, facciamo uno shift ciclico a destra (o sinistra?) ottenendo $p'(x)$;
+ calcoliamo $s'(x)$;
+ ripartiamo dal punto 2.

#theorem(numbering: none)[
  Dopo un certo numero di passi il codice ciclico è tale che $w(s(x)) lt.eq t$.
]

Una volta terminato, per correggere la parola dobbiamo fare $ p(x) = y(x) + "LSHIFT"_k (s_f (x)) = y(x) + "RSHIFT"_(n-k) (s_f (x)), $ con $y(x)$ parola ricevuta, $k$ è il contatore e $s_f$ è l'ultima sindrome calcolate.

// Ha fatto un esempio ma non si capisce niente

== Codici BCH

=== Introduzione

I codici BCH vengono costruiti in base a quanti errori vogliamo correggere: se vogliamo correggere $t$ errori le parole devono essere distanti almeno $2t + 1$ tra loro.

// Ci sarebbe un'immagine
Se le *sfere di collisione* di due parole collidono o non sono almeno di raggio $t$ non riusciamo a correggerle.

=== Ampliamento algebrico

Dato un polinomio che non ha radice nel campo gliene imponiamo una noi. Prendiamo un polinomio irriducibile e supponiamo che abbia come soluzione una certa radice. Le radici devono essere tali che $ beta_1, beta_2, dots, beta_m equiv_n 1 . $

_Quante radici ci servono?_ Dipende dal numero di errori e dal campo: se siamo in $"GF"(11)$ e vogliamo correggere $2$ errori il numero $M$ di radici è il più piccolo numero tale che $ 2^M equiv_11 1 . $

Trovato $M$ troviamo gli elementi del campo e costruiamo $g(x)$ come il minimo comune multiplo tra gli elementi del campo.

// Esempio che non voglio fare

// Non capisco
#theorem(numbering: none)[
  $forall n in NN$, dato $r$ numero primo e $"GF"(r^(phi.alt(n)))$, con $phi.alt$ funzione di Eulero, siano $beta_1, dots, beta_n$ radici per costruire il codice ciclico. Allora $omega(t)$ è l'insieme dei polinomi $ omega(w) = omega_0 + omega_1 x + dots + omega_(n-1) x^(n-1) $ tali che hanno radici $omega(beta_1) = omega(beta_2) = dots = omega(beta_n) = 0$. Queste formano esattamente un codice ciclico che corregge $n$ errori.
]
