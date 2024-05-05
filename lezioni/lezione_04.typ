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

= Lezione 04

== Entropia

=== Introduzione

La scorsa lezione abbiamo introdotto il concetto di *entropia*, ovvero la quantità $ H_D(Chi) = sum_(i=1)^m p_i log_D (1 / p_i). $ L'entropia dipende da $D$: se questo vale $2$ l'entropia calcolata è quella *binaria* e non ha il pedice vicino alla $H$.

L'entropia fa solo riferimento alla distribuzione di probabilità, non c'entra niente con i simboli: come vediamo, nella definizione compare solo $D$ assieme alle probabilità dei singoli simboli.

=== Cambio di base

Sappiamo che con i logaritmi possiamo cambiare base. _E se volessi fare un cambio base nell'entropia?_ Quello che sto facendo è cambiare l'entropia binaria in una che magari mi risulta più comoda.

Ricordando che $ log_b p = (log_c p) / (log_c b) , $ se fissiamo $c = e$ otteniamo $ log_b p = (ln p) / (ln b) = (ln p) / (ln b) dot (ln a) / (ln a) = (ln p) / (ln a) dot (ln a) / (ln b) = log_a p dot log_b a . $

In poche parole, _cambiare base_ significa _cambiare base e portarsi dietro una costante_.

Modifichiamo quindi l'entropia, ottenendo $ H_b (Chi) = sum_(i=1)^m p_i log_b 1 / p_i arrow.long H_a (Chi) = sum_(i=1)^m p_i log_a 1 / p_i log_b a = log_b a dot H_a (Chi) . $

=== Esempio

Disegniamo l'entropia binaria usando $XX$ variabile aleatoria bernoulliana.

Sia quindi $P(XX = 1) = p$ e $P(XX = 0) = 1 - p$. Allora vale $ H(Chi) = p log_2 1/p + (1-p) log_2 1 / (1-p) . $

// Sistemare sicuramente

#v(12pt)

#figure(
    image("../assets/04_entropia-binaria.svg", width: 60%)
)

#v(12pt)

Notiamo come in $p = 0\/1$ l'entropia vale $H(0\/1) = 0$, mentre è massima in $p = 1 / 2$ e vale $H(1/2) = 1$.

Infine, introduciamo la relazione $ 1 - 1 / x lt.eq ln x lt.eq x - 1 $ che ci sarà utile dopo per alcune dimostrazioni.

// Sistemare sicuramente

#v(12pt)

#figure(
    image("../assets/04_disuguaglianza.svg", width: 60%)
)

#v(12pt)

=== Proprietà

Diamo prima di tutto un upper bound all'entropia.

#lemma(numbering: none)[
  $H_D (Chi) lt.eq log_D m$.
]

#proof[
  \ Dimostriamo che $H_D (Chi) - log_D m lt.eq 0$.

  $ H_D (Chi) - log_D m & = sum_(i=1)^m p_i log_D 1 / p_i - log_D m dot underbracket(sum_(i=1)^m p_i, =1) = \ & = sum_(i=1)^m p_i log_D 1 / p_i - p_i log_D m = sum_(i=1)^m p_i dot (log_D 1 / p_i - log_D m) = \ & = sum_(i=1)^m p_i dot log_D 1 / (p_i dot m) quad . $

  Ricordiamo che $ln x lt.eq x - 1$, quindi:

  $ sum_(i=1)^m p_i dot ln underbracket(1 / (p_i dot m), x) dot 1 / (ln D) & lt.eq sum_(i=1)^m p_i (1 / (p_i dot m) - 1) 1 / (ln D) \ & lt.eq 1 / (ln D) sum_(i=1)^m 1 / m - p_i = 1 / (ln D) underbracket([ underbracket(sum_(i=1)^m 1 / m, 1) - underbracket(sum_(i=1)^m p_i, 1) ], 0) = 0 . $

  Se $H_D (Chi) - log_D m lt.eq 0$ allora $ H_D (Chi) lt.eq log_D m . $
]

#corollary(numbering: none)[
  Se $P(X = a_i) = 1 / m quad forall i = 1, dots, m$ allora $ H_D (Chi) = log_D m. $
]

#proof[
  \ Se $P(X = a_i) = 1 / m quad forall i = 1, dots, m$ allora $ H_D (Chi) = sum_(i=1)^m p_i log_D 1 / p_i = sum_(i=1)^m 1 / m log_D m = log_D m underbracket(sum_(i=1)^m 1 / m, 1) = log_D m . $
]

Introduciamo ora l'*entropia relativa*: indicata con $Delta(Chi bar.v.double Y)$ misura la distanza tra $Chi$ e $Y$, ovvero la diversità tra $Chi$ e $Y$ in termini delle due distribuzioni di probabilità.

Definiamo quindi l'entropia relativa come $ Delta(Chi bar.v.double Y) = sum_(s in S) p_X (s) log_D (p_Chi (s)) / (p_Y (s)). $

L'insieme $S$ indica il *dominio* sul quale $Chi$ e $Y$ lavorano.

#theorem(numbering: none)[
  Per ogni coppia di variabili casuali $Chi,Y$ definite sullo stesso dominio $S$ vale la disuguaglianza $ Delta(Chi bar.v.double Y) gt.eq 0 . $
]

#proof[
  \ $ Delta(Chi bar.v.double Y) & = sum_(s in S) p_Chi (s) log_D (p_Chi (s)) / (p_Y (s)) = sum_(s in S) p_Chi (s) ln (p_Chi (s)) / (p_Y (s)) 1 / (ln D) = \ & = 1 / (ln D) sum_(s in S) p_Chi (s) ln underbracket((p_Chi (s)) / (p_Y (s)), x) = "uso" 1 - 1/x lt.eq ln x = \ & gt.eq 1 / (ln D) sum_(s in S) p_Chi (s) (1 - (p_Y (s)) / (p_Chi (s))) = 1 / (ln D) sum_(s in S) p_Chi (s) - p_Y (s) \ & gt.eq 1 / (ln D) (underbracket(sum_(s in S) p_Chi (s), 1) - underbracket(sum_(s in S) p_Y (S), 1)) = 0 . $
]

Infine, vediamo la relazione tra _valore atteso delle lunghezze del codice_ e _entropia_.

#theorem(numbering: none)[
  Sia $c : Chi arrow DD^+$ un codice istantaneo $D$-ario per una sorgente $angle.l Chi, p angle.r$, allora $ EE[l_c] gt.eq H_D (Chi) . $
]

#proof[
  \ Definisco $ZZ : Chi arrow.long RR$ variabile casuale alla quale associamo una distribuzione di probabilità $ q(x) = frac(D^(-l_c (x)), limits(sum)_(x' in Chi) D^(-l_c (x'))) . $

  Dimostriamo che $EE[l_c] - H_D (Chi) gt.eq 0$.
  
  $ EE[l_c] - H_D (Chi) & = sum_(x in Chi) p(x) l_c (x) - sum_(x in Chi) p(x) log_D 1 / p(x) = sum_(x in Chi) p(x) dot (l_c (x) - log_D 1 / p(x)) = \ & = sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) - log_D 1 / p(x)) = \ & = sum_(x in Chi) p(x) dot (log_D D^(l_c (x)) + log_D p(x)) = sum_(x in Chi) p(x) log_D ( D^(l_c (x)) dot p(x)) = \ & = sum_(x in Chi) p(x) dot (log_D ((p(x)) / (D^(-l_c (x))) dot 1)) = \ & = sum_(x in X) p(x) dot (log_D (p(x) / (D^(-l_c (x))) dot (sum_(x' in Chi) D^(-l_c (x'))) / (sum_(x' in Chi) D^(-l_c (x'))))) = \ & = sum_(x in Chi) p(x) dot (log_D (p(x) (sum_(x' in Chi) D^(-l_c (x'))) / (D^(-l_c (x)))) - log_D (sum_(x' in Chi) D^(-l_c (x')))) = \ & = sum_(x in Chi) p(x) dot (log_D p(x) / q(x) - log_D (sum_(x' in Chi) D^(-l_c (x')))) = \ & = sum_(x in Chi) p(x) log_D p(x) / q(x) - p(x) log_D (sum_(x' in Chi) D^(-l_c (x'))) = \ & = sum_(x in Chi) p(x) log_D p(x) / q(x) - sum_(x in Chi) p(x) log_D (sum_(x' in Chi) D^(-l_c (x'))) = \ & = underbracket(Delta(Chi bar.v.double ZZ), gt.eq 0) underbracket(- underbracket(log_D (sum_(x' in Chi) D^(-l_c (x'))), c "istantaneo" arrow.long log_D (t lt.eq 1) lt.eq 0), gt.eq 0) dot underbracket(sum_(x in Chi) p(x), =1) gt.eq 0 . $
]

== Sardinas-Patterson

L'*algoritmo di Sardinas-Patterson* è un algoritmo che permette di dimostrare se un codice è univocamente decodificabile.

=== Definizione

Dato $A = {x_1, dots, x_n}$ insieme dei simboli usati da un codice $c$, costruiamo l'insieme $S_1 = A$. Per stabilire se $c$ è univocamente decodificabile generiamo una serie di insiemi $S_i$ applicando le due regole seguenti:
// scrivi meglio
- $forall x in S_1 quad (exists y bar.v x y in S_i arrow.long.double y in S_(i+1))$;
- $forall z in S_i quad (exists y bar.v z y in S_1 arrow.long.double y in S_(i+1))$.

Quello che viene fatto è un controllo "incrociato":
+ parto da una parola $x in S_1$;
+ cerco se esiste una parola $w in S_i$ che abbia $x$ come prefisso;
+ se esiste aggiungo $y = w - x$ all'insieme $S_(i+1)$;
+ faccio lo stesso invertendo $S_1$ con $S_i$. 

Fermiamo l'applicazione di queste regole quando:
- $S_i$ contiene un elemento di $A$: il codice $c$ non è univocamente decodificabile;
- $S_i = emptyset.rev$: il codice $c$ è univocamente decodificabile.

=== Esempi

Sia $A = {A, E, C, A B B, C E D, B B E C}$, e sia $S_1 = A$.

Generiamo gli insiemi $S_i$ con le due regole presentate.

- $S_2 = {B B, E D}$;
  - $B B$: $A in S_1 and A B B in S_1$;
  - $E D$: $C in S_1 and C E D in S_1$;
- $S_3 = {D, E C}$;
  - $D$: $E in S_1 and E D in S_2$;
  - $E C$: $B B in S_2 and B B E C in S_1$;
- $S_4 = {C}$;
  - $C$: $E in S_1 and E C in S_3$.

Ci fermiamo perché $C in S_4$ e $C in S_1$, quindi il codice non è univocamente decodificabile.
