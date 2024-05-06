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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

// Appunti

= Lezione 05

== Upper bound valore atteso

La scorsa lezione abbiamo mostrato che $H_D (Chi) lt.eq EE[l_c]$, ma _quanto sono vicini questi due valori?_

Se la distanza è alta vuol dire che il nostro codice è poco efficiente.

#theorem(numbering: none)[
  Dato $c$ codice istantaneo di Shannon con lunghezze $l_1, dots, l_m$ tali che $ l_i = ceil(log_D 1/p_i) quad forall i in {1, dots, m} $ allora $ EE[l_c] < H_D (Chi) + 1 . $
]

#proof[
  \ $ EE[l_c] & = sum_(i=1)^m p_i l_i = sum_(i=1)^m p_i ceil(log_D 1/p_i) \ & < sum_(i=1)^m p_i (log_D 1/p_i + 1) = sum_(i=1)^m p_i log_D 1/p_i + sum_(i=1)^m p_i = H_D (Chi) + 1 quad . $
]

Questo teorema ci dice che il massimo spreco per simbolo rispetto all'ottimo è di un bit: sembra un ottimo risultato, ma se ho a disposizione tanti simboli si perdono molti bit.

== Estrazione a blocchi

Dati $c : Chi arrow.long DD^+$ e $C : Chi^+ arrow.long D^+$ cerchiamo di dare una definizione dell'*estrazione a blocchi* di $n$ con la funzione $C_n : Chi^n arrow.long D^+$.

#lemma(numbering: none)[
  $l_c (x_1, dots, x_n) gt.eq l_C_n (x_1, dots, x_n)$.
]

#proof[
  \ $ l_C (x_1, dots, x_n) & = sum_(i=1)^n ceil(log_D 1/p_i) \ & gt.eq ceil(sum_(i=1)^m log_D 1/p_i) = ceil(log_D 1 / (product_i p_i)) = ceil(log_D 1 / p(x_1, dots, x_n)) = l_C_n (x_1, dots, x_n) . $
]

In poche parole, la lunghezza di un messaggio trattato con i singoli simboli è non minore della lunghezza del messaggio stesso trattato a blocchi.

Infatti, definiamo $ C_n : Chi^n arrow.long D^+ $ come la funzione che estrae messaggi di $n$ simboli. Prima avevamo l'estrazione di $n$ simboli, ora l'estrazione di _un messaggio_ di $n$ simboli.

In questo modo paghiamo 1 bit ogni $n$ simboli, ma abbiamo un modello sorgente più complesso.

Esiste una relazione tra $H(x_1, dots, x_n)$ e $H(x)$?

Definiamo prima di tutto $H(x_1, dots, x_n)$ come $ H(x_1, dots, x_n) = sum_(x_1, dots, x_n) p_n (x_1, dots, x_n) log_2 1/(p_n (x_1, dots, x_n)) . $

Inoltre, sapendo che $ p_n (x_1, dots, x_n) = product_i p(x_i) $ e che $ log_2 1 / (product_(i=1)^n p(x_i)) = log_2 product_(i=1)^n p(x_i)^(-1) = sum_(i=1)^n log_2 p(x_1)^(-1) = sum_(i=1)^n log_2 1/p(x_i), $ possiamo affermare che $ H(x_1, dots, x_n) = sum_x_1 dots.c sum_x_n product_(i=1)^n p(x_i) sum_(i=1)^n log_2 1/p(x_i) . $

Vediamo il caso $n=2$ per semplicità, poi diamo una versione generale.

$ H(x_1, dots, x_n) & = sum_x_1 sum_x_2 product_(i=1)^2 p(x_i) (log_2 1/p(x_1) + log_2 1/p(x_2)) = \ & = sum_x_1 sum_x_2 p(x_1) p(x_2) log_2 1/p(x_1) + p(x_1) p(x_2) log_2 1/p(x_2) = \ & = sum_x_1 sum_x_2 p(x_1) p(x_2) log_2 1/p(x_1) + sum_x_1 sum_x_2 p(x_1) p(x_2) log_2 1/p(x_2) = \ & = sum_x_1 p(x_1) log_2 1/p(x_1) sum_x_2 p(x_2) + sum_x_1 p(x_1) sum_x_2 p(x_2) log_2 1/p(x_2) = \ & = H(x_1) + H(x_2) . $

In generale possiamo affermare che $ H(x_1, dots, x_n) = n H(Chi) . $

== Primo teorema di Shannon

#theorem(
  numbering: none,
  name: "Primo teorema di Shannon"
)[
  Sia $C_n : Chi_n arrow.long D^+$ un codice di Shannon $D$-ario a blocchi per la sorgente $angle.l Chi, p angle.r$, ovvero $ l_C_n (x_1, dots, x_n) = ceil(log_D 1/(p_n (x_1, dots, x_n))) . $ Allora $ lim_(n arrow infinity) 1/n EE[l_C_n] = H_D (Chi) . $
]

#proof[
  \ Sappiamo che $ n H_D (Chi) = H_D (X_1, dots, X_n) lt.eq EE[l_C_n] < H_D (X_1, dots, X_n) + 1 = n H_D (Chi) + 1 . $

  Dividiamo entrambi i membri per $n$ e otteniamo $ H_D (Chi) lt.eq 1/n EE[l_C_n] < H_D (Chi) + 1/n . $

  Se $n arrow infinity$ allora $H_D (Chi) = H_D (Chi) + 1/n$ e quindi $ 1/n EE[l_C_n] = H_D (Chi) $ per il teorema degli sbirri.
]

Il primo teorema di Shannon ci indica che il valore atteso si "schiaccia" sull'entropia col crescere della dimensioni dei blocchi: quindi, se facciamo crescere la dimensione del blocco paghiamo poco in termini di bit.

== Approssimare i modelli sorgente

A volte non conosciamo a priori il modello $angle.l Chi, p angle.r$ che abbiamo a disposizione, quindi dobbiamo stimare quest'ultimo con un altro modello $angle.l Y, q angle.r$.

Abbiamo a disposizione l'entropia relativa $Delta(Chi bar.v.double Y)$: infatti, quest'ultima ci dice quanto sono distanti i due modelli.

#theorem(numbering: none)[
  Dato il modello sorgente $angle.l Chi, p angle.r$, se $c : Chi arrow.long D^+$ è un codice di Shannon con $l_c (x) = ceil(log_D 1/q(x))$, dove $q$ è una distribuzione di probabilità su $Chi$, allora $ EE[l_c] < Delta(Chi bar.v.double Y) + H_D (Chi) + 1 . $
]

#proof[
  \ $ EE[l_c] & = sum_(x in Chi) p(x) ceil(log_D 1/q(x)) \ & < sum_(x in Chi) p(x) (log_D 1/q(x) + 1) = sum_(x in Chi) p(x) log_D 1/q(x) + sum_(x in Chi) p(x) \ & = sum_(x in Chi) p(x) log_D (1/q(x) p(x)/p(x)) + 1 = sum_(x in Chi) p(x) log_D p(x)/q(x) + sum_(x in Chi) p(x) log_D 1/p(x) + 1 \ & = Delta(Chi bar.v.double Y) + H_D (Chi) + 1 . $
]
