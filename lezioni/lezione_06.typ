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

= Lezione 06

== Algoritmo di Huffman

Avevamo già visto l'algoritmo di Huffman  per la costruzione di un codice di Huffman, ma visto che non ce lo ricordiamo lo rivediamo.

Per costruire un codice di Huffman bisogna:
+ ordinare i simboli sorgente in base alla probabilità decrescente;
+ crea un modello fittizio in cui i $D$ simboli meno probabili vengono raggruppati e sostituiti con un nuovo simbolo la cui probabilità è la somma delle probabilità dei simboli sostituiti;
+ ripeti dal punto $1$ se la sorgente contiene più di $D$ simboli.

Avevamo inoltre aggiunto un numero $k$ di simboli a probabilità $0$ per verificare che $ m + k mod D - 1 equiv 1, $ con $m$ numero di simboli sorgente.

== Codici di Huffman

Presentiamo adesso un teorema permette di capire se il codice di Huffman, generato con l'algoritmo appena ripreso, sia buono o meno.

#theorem(numbering: none)[
  Dati una sorgente $angle.l Chi, p angle.r$ e $D > 1$, il codice $D$-ario $c$ di Huffman minimizza $EE[l_c]$ tra tutti i codici istantanei per la medesima sorgente.
]

Per dimostrare questo teorema dobbiamo prima enunciare un fatto.

// Cerca come renderlo un fatto
#lemma(numbering: none)[
  Sia $c'$ un codice $D$-ario di Huffman per la sorgente $Chi' = {x_1, dots, x_(m-D+1)}$ con probabilità $p_1 gt.eq dots gt.eq x_(m-D+1)$. Sia $Chi$ la sorgente ottenuta togliendo da $Chi'$ il simbolo $x_k$ e aggiungendo $D$ nuovi simboli $x_(m-D+2), dots, x_(m+1)$ con probabilità $p_(m-D+2), dots, p_(m+1) < p_(m - D + 1)$. Inoltre, deve valere $p_(m-D+2) + dots + p_(m+1) = p_k$. Allora vale $ c(x) = cases(c'(x) & "se" x eq.not x_k, i c'(x_k) quad & "se" k in {m-D+2, m+1} quad forall i in {0, dots, D-1}) $ è un codice di Huffman per la sorgente.
]

Grazie a questo fatto dimostriamo il teorema precedente.

#proof[
  \ Dimostriamo per induzione su $m$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [Passo base: $m = 2$]
  )

  Huffman produce il codice $c(x_1) = 0$ e $c(x_2) = 1$ che p ottimo, qualunque sia la distribuzione di probabilità.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [Passo induttivo: $m > 2$]
  )

  Supponiamo ora Huffman ottimo per $k lt.eq m - 1$ e dimostriamolo per $m$.

  Fissiamo $angle.l Chi, p angle.r$ sorgente di $m$ simboli. Sia $Chi = {dots, u, dots, v}$, con $p(u),p(v)$ minime. Definiamo $angle.l Chi', p' angle.r$ con $u,v in Chi$ rimpiazzate da $z in Chi'$. La funzione $p'$ è tale che $ p'(x) = cases(p(x) & "se" x = z, p(u) + p(v) quad & "se" x = z) quad . $

  Sia $c'$ il codice di Huffman per $angle.l Chi', p angle.r$. Dato che $|Chi'| = m - 1$ allora $c'$ è ottimale per ipotesi induttiva.

  Il codice $c$ per $Chi$ è definito come $ c(x) = cases(c'(x) & "se" x in.not {u,v}, c'(z) dot.op 0 & "se" x = u, c'(z) dot.op 1 quad & "se" x = v) quad . $

  Dimostriamo che il codice $c$ è ottimo.

  Esprimiamo il valore atteso $ EE[l_c] = sum_(x in Chi) l_c (x) p(x) $ in termini di $Chi'$ come $ EE[l_c] & = sum_(x in Chi') l_(c') (x) p'(x) - l_(c') (z) p'(z) + l_c (u) p(u) + l_c (v) p(v) = \ & = EE[l_(c')] - l_(c') (z) p'(z) + (l_(c') (z) + 1) p(u) + (l_(c') (z) + 1) p(v) = \ & = EE[l_(c')] - l_(c') (z) p(z) + (l_(c') (z) + 1) (p(u) + p(v)) = \ & = EE[l_(c')] - l_(c') (z) p(z) + (l_(c') (z) + 1) p'(z) = EE[l_(c')] - l_(c') (z) p(z) + l_(c') (z) p'(z) + p'(z) = \ & = EE[l_(c')] + p'(z) quad . $

  Per dimostrare l'ottimalità di $c$ consideriamo un codice $c_2$ per $angle.l Chi, p angle.r$ e verifichiamo che $EE[l_c] lt.eq EE[l_c_2]$.

  Sia $c_2$ istantaneo per $angle.l Chi,p angle.r$ e siano $r,s in Chi$ tali che $l_c_2 (r)$ e $l_c_2 (s)$ sono massimi. Senza perdita di generalità assumiamo che $r,s$ siano fratelli nell'albero di codifica di $c_2$. Infatti:
  // Sistemare perché dagli appunti non si capisce
  - se non fossero fratelli e avessero un altro fratello (chiamato $f$ fratello di $s$) scegliamo $s$ e $f$ al posto di $s$ e $r$;
  - se non avessero fratelli possiamo sostituire le loro codifiche con quelle del padre fino a riportarci in una situazione in cui abbiano un fratello.

  Definiamo il codice $overline(c)_2$ tale che $ overline(c)_2 = cases(c_2 (x) & "se" x in.not {u,v,r,s}, c_2 (u) & "se" x = r, c_2 (r) & "se" x = u, c_2 (v) & "se" x = s, c_2 (s) & "se" x = v) quad . $

  Abbiamo scambiato la codifica di $r$ con quella di $u$ e quella di $s$ con quella di $v$.

  Analizziamo $EE[l_(overline(c)_2)] - EE[l_c_2]$ per dimostrare che il primo valore è minore o uguale del secondo.

  $ EE[l_c_2] - EE[l_c_2] & = p(r) l_c_2 (u) + p(u) l_c_2 (r) + p(s) l_c_2 (v) + p(v) l_c_2 (s) \ & space - p(r) l_c_2 (r) - p(u) l_c_2 (u) - p(s) l_c_2 (s) - p(v) l_c_2 (v) = \ & = p(r) (l_c_2 (u) - l_c_2 (r)) + p(u) (l_c_2 (r) - l_c_2 (u)) + \ & space + p(s) (l_v_2 (v) - l_c_2 (s)) + p(v) (l_c_2 (s) - l_c_2 (v)) = \ & = (p(r) - p(u))(l_c_2 (u) - l_c_2 (r)) + (p(s) - p(v))(l_c_2 (v) - l_c_2 (s)) . $

  Sapendo che:
  - $p(r) - p(u) gt.eq 0$ dato che $u$ è minimo;
  - $l_c_2 (u) - l_c_2 (r) lt.eq 0$;
  - $p(s) - p(v) gt.eq 0$ dato che $v$ è minimo;
  - $l_c_2 (v) - l_c_2 (s) lt.eq 0$.

  Stiamo sommando due quantità negative, quindi $ EE[l_(overline(c)_2)] - EE[l_c_2] lt.eq 0 arrow.long.double EE[l_(overline(c)_2)] lt.eq EE[l_c_2] . $
]
