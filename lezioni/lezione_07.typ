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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

// Appunti

= Lezione 07

== Codici di Huffman

Non abbiamo finito la dimostrazione pookie!

#proof[
  \ Introduciamo ora il codice $overline(c)_2'$ fatto come segue: $ overline(c)_2' = cases(overline(c)_2 (x) quad & "se" x eq.not z, omega & "se" x = z) quad . $

  Questo codice è definito sulla sorgente $angle.l Chi',p' angle.r$. Inoltre, dopo aver scambiato $r$ e $s$ con $u$ e $v$, questi ultimi sono fratelli, quindi:
  - $overline(c)_2 (u) = omega dot.op 0$;
  - $overline(c)_2 (v) = omega dot.op 1$.

  Ma allora $ EE[l_(overline(c)_2)] & = sum_(x in Chi' bar.v x eq.not z) p'(x) l_(overline(c)_2) (x) + p(u) (l_(overline(c)_2') + 1) + p(v) (l_(overline(c)_2') (z) + 1) = \ & = sum_(x in Chi' bar.v x eq.not z) p'(x) l_(overline(c)_2) (x) + p'(z) l_(overline(c)_2') (z) + p'(z) = EE[l_(overline(c)_2')] + p'(z) \ & gt.eq EE[l_c'] + p'(z) quad . $

  Mettendo insiemi i due risultati otteniamo $ EE[l_c] = EE[l_c'] + p'(z) lt.eq EE[l_c_2'] + p'(z) = E[l_(overline(c)_2)] lt.eq EE[l_c_2] quad . $

  Quindi $ EE[l_c] lt.eq EE[l_c_2] quad . $
]

== Disuguaglianza di Kraft-McMillan

Per cercare il codice ottimo ci siamo ristretti ai codici istantanei, ma così facendo rischiamo di lasciare fuori dei codici che potrebbero essere ottimi nonostante non siano istantanei.

Vedremo però che questi codici non esistono, dato che anche i codici univocamente decodificabili seguono la disuguaglianza di Kraft.

#theorem(
  name: "Disuguaglianza di Kraft-McMillan",
  numbering: none,
)[
  Siano $l_1, dots, l_m$ lunghezze positive. Allora queste ultime sono lunghezze delle parole di codice di un codice $D$-ario univocamente decodificabile per una sorgente di $m$ simboli se e solo se $ sum_(i=1)^m D^(-l_i) lt.eq 1 . $
]

Per dimostrare questo teorema ci servirà l'estensione $k$-esima di un codice $c$ definita come $ C_k : Chi^k arrow.long D^+ . $

#proof[
  \ [$arrow.long.double.l$] Questa implicazione è banale: infatti, se vale la disuguaglianza di Kraft, le lunghezze $l_1, dots, l_m$ sono le lunghezze di un codice istantaneo, che è anche univocamente decodificabile.

  // Per me va usata la m e non la k
  [$arrow.long.double$] Vale $forall k gt.eq 1$ l'uguaglianza $ (sum_(x in Chi) D^(-l_c (x)))^k = sum_x_1 dots.c sum_(x_k) D^(-l_c (x_1)) dot.op dots dot.op D^(-l_c (x_k)) quad . $

  // Dovresti aggiungere che vale per k=2

  Andiamo avanti dicendo che $ sum_x_1 dots.c sum_(x_k) D^(-l_c (x_1)) dot.op dots dot.op D^(-l_c (x_k)) = sum_(x_k in Chi^k) D^(-(l_c (x_1) + dots + dots l_c (x_k))) = sum_(x_k in Chi^k) D^(-l_C_k (x_k)) quad . $

  In questo caso $ l_C_k (x_k) = l_c (x_1) + dots + l_c (x_k) . $

  Introduciamo l'insieme $Chi_n^k$ come $ {x_k in Chi^k bar.v l_C_k (x_k) = n} . $

  Andiamo ancora avanti con l'uguaglianza: $ sum_(x_k in Chi^k) D^(-l_C_k (x_k)) = sum_(n=1)^(k l_max) sum_(x_k in Chi^k) D^(-l_C_k (x_k)) = sum_(n=1)^(k l_max) |X_n^k| D^(-n) quad . $

  Visto che $c$ è univocamente decodificabile $C$ è iniettiva, quindi $|X_n^k| lt.eq |D^n|$, e quindi $ sum_(n=1)^(k l_max) |X_n^k| D^(-n) lt.eq sum_(n=1)^(k l_max) D^n D^(-n) lt.eq k l_max , $ ma allora $ (sum_(x in Chi) D^(-l_c (x)))^k lt.eq k l_max . $

  Poniamo $sum_(x in Chi) D^(-l_c (x)) = M$ e vediamo quanto vale questa quantità.

  // Qua ci va un grafico che non ho capito

  Visto che vogliamo $M^x$ sotto $x l_max$, allora $M$ deve stare tra $0$ e $1$, quindi $ (sum_(x in Chi) D^(-l_c (x)))^k lt.eq 1 . $
]
