#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 07 [19/10]

== Codice di Huffman

Il codice di Shannon era un codice interessante, aveva dei buoni bound ma non era il CI ottimale. Inoltre, era impraticabile se la grandezza del blocco cresceva.

Vediamo il *codice di Huffman*. Data una sorgente $modello(X,p)$ e dato $d > 1$, l'algoritmo per creare il codice di Huffman per la sorgente esegue i seguenti passi:
- ordina le probabilità $p_i$ in maniera decrescente;
- rimuovi i $d$ simboli meno probabili da $X$ e crea una nuova sorgente aggiungendo un nuovo simbolo che abbia come probabilità la somma delle probabilità dei simboli rimossi;
- se la nuova sorgente ha più di $d$ simboli torna al punto $1$.

Come funziona nella realtà? Vediamolo con un esempio.

#example()[
  Data la sorgente $modello(S,p)$ con:
  - $S = {s_1, dots, s_7}$ e
  - $P = {0.3, 0.2, 0.2, 0.1, 0.1, 0.06, 0.04}$,
  trovare il codice di Huffman ternario per questa sorgente.

  Nella prima fase andiamo a comprimere i simboli meno probabili arrivando a definire la sorgente $S''$ dopo due iterazioni dell'algoritmo.

  #v(12pt)

  #figure(
    image("../assets/07_huffman-compressione.svg", width: 70%),
  )

  #v(12pt)

  Nella seconda fase invece andiamo a fare un rollback: a partire dall'ultima sorgente creata andiamo ad assegnare i simboli di $D$ ai simboli sorgente correnti, propaghiamo i simboli alla sorgente precedente e andiamo ad eseguire lo stesso procedimento per i $d$ simboli che sono stati compattati.

  #v(12pt)

  #figure(
    image("../assets/07_huffman-generazione.svg", width: 70%),
  )

  #v(12pt)
]

Questo codice è un codice che a noi piace molto perché rispetta due condizioni per noi fondamentali: minimizza il valore atteso delle lunghezze delle parole di codice e rispetta Kraft. Infatti: $ "CH" = cases(min_(l_1, dots, l_m) sum_(i=1)^m l_i p_i, sum_(i=1)^m d^(-l_i) lt.eq 1) . $

#lemma()[
  Sia $c$ un codice $d$-ario di Huffman per la sorgente $modello(X',p')$ con $X' = {x_1, dots, x_(m-d+1)}$ e probabilità $p_1 gt.eq dots gt.eq p_(m-d+1)$. Data ora la sorgente $modello(X,p)$ con $X = {x_1, dots, x_m}$ costruita da $X'$ togliendo il simbolo $x_k$ e aggiungendo $d$ simboli $x_(m-d+2), dots, x_m$ con probabilità $p_k gt.eq p_(m-d+2) gt.eq dots gt.eq p_m$ tali che $sum_(i=2)^d p_(m-d+i) = p_k$. Allora $ c(x) = cases(c'(x) & "se" x eq.not x_k, c'(x_k) dot i quad & "se" k in {m-d+2, dots, m} and forall i in D) $ è un codice di Huffman per la sorgente $X$.
]

Grazie a questo lemma ora possiamo dimostrare un risultato importante sul codice di Huffman.

#theorem()[
  Data la sorgente $modello(X,p)$ e dato $d > 1$, il codice $d$-ario di Huffman $c$ minimizza $EE[l_c]$ tra tutti i codici $d$-ari per la medesima sorgente.
]

#proof()[
  Dimostriamo per induzione su $m$.

  Il passo base è $m = 2$, quindi abbiamo due simboli $x_1,x_2$ che, indipendentemente dalla probabilità assegnatagli, avranno $0$ e $1$ come codifica, che è minima.

  Assumiamo ora che Huffman sia ottimo per sorgenti di grandezza $m-1$ e dimostriamo che sia ottimo per sorgenti di grandezza $m$.

  Fissata $modello(X,p)$ sorgente di $m$ simboli, siano $u,v in X$ i due simboli con le probabilità minime. Costruiamo la sorgente $modello(X',p')$ dove $u,v$ sono sostituiti da $z$ tale che $ p'(x) = cases(p(x) & "se" x eq.not z, p(u) + p(v) quad & "se" x = z) . $

  Ho $m-1$ simboli, quindi per ipotesi induttiva $c'$ è un codice di Huffman ottimo. Per il lemma precedente, anche il codice $c$ è di Huffman ed è tale che $ c(x) = cases(c'(x) & "se" x eq.not u and x eq.not v, c'(x) dot 0 & "se" x = u, c'(x) dot 1 quad & "se" x = v) . $

  Dimostriamo che il codice $c$ è ottimo.
  
  Calcoliamo il valore atteso delle lunghezze delle parole del codice $c$ come $ EE[l_c] &= sum_(x in X) l_c (x) p(x) = \ &= sum_(x in X') l_(c') (x) p'(x) - l_(c') (z) p'(z) + l_c (u) p(u) + l_c (v) p(v) = \ &= EE[l_(c')] - l_(c') (z) p'(z) + (l_(c') (z) + 1) p(u) + (l_(c') (z) + 1) p(v) = \ &= EE[l_(c')] - l_(c') (z) p'(z) + (l_(c') (z) + 1) (p(u) + p(v)) = \ &= EE[l_(c')] - l_(c') (z) p'(z) + (l_(c') (z) + 1) p'(z) = \ &= EE[l_(c')] - l_(c') (z) p(z) + l_(c') (z) p'(z) + p'(z) = \ & = EE[l_(c')] + p'(z) . $

  Per dimostrare l'ottimalità di $c$ consideriamo un altro codice $c_2$ per la sorgente $modello(X,p)$ e verifichiamo che $EE[l_c] lt.eq EE[l_(c_2)]$. Sia $c_2$ istantaneo per $modello(X,p)$ e siano $r,s in X$ tali che $l_(c_2) (r)$ e $l_(c_2) (s)$ sono massime. Senza perdita di generalità assumiamo che $r,s$ siano fratelli nell'albero di codifica di $c_2$. Infatti:
  - se sono fratelli GG, godo;
  - se non sono fratelli ma uno tra $r$ e $s$ ha un fratello (sia $f$ fratello di $s$ ad esempio) andiamo a scegliere $s$ e $f$ al posto di $s$ e $r$;
  - se non sono fratelli perché sono su due livelli diversi (_a distanza uno_) possiamo sostituire la codifica di quello più basso con quella del padre e ritornare in una delle due situazioni precedenti.

  Definiamo il codice $overline(c)_2$ tale che $ overline(c)_2 = cases(c_2 (x) & "se" x in.not {u,v,r,s}, c_2 (u) & "se" x = r, c_2 (r) & "se" x = u, c_2 (v) & "se" x = s, c_2 (s) quad & "se" x = v) . $

  In poche parole, abbiamo scambiato $r$ con $u$ e $s$ con $v$.

  Analizziamo $EE[l_(overline(c)_2)] - EE[l_(c_2)]$ per dimostrare che il primo è minore o uguale del secondo. Notiamo prima di tutto che i simboli $x in.not {u,v,r,s}$ non compaiono nel conto successivo: questo perché nei due codici hanno lo stesso contributo in probabilità e lunghezza, quindi consideriamo solo i simboli appena citati visto che vengono scambiati.

  $ EE[l_(overline(c)_2)] - EE[l_(c_2)] &= p(r) l_(c_2) (u) + p(u) l_(c_2) (r) + p(s) l_(c_2) (v) + p(v) l_(c_2) (s) \ & space - p(r) l_(c_2) (r) - p(u) l_(c_2) (u) - p(s) l_(c_2) (s) - p(v) l_(c_2) (v) = \ &= p(r) (l_(c_2) (u) - l_(c_2) (r)) + p(u) (l_(c_2) (r) - l_(c_2) (u)) + \ & space + p(s) (l_(c_2) (v) - l_(c_2) (s)) + p(v) (l_(c_2) (s) - l_(c_2) (v)) = \ & = (p(r) - p(u))(l_c_2 (u) - l_c_2 (r)) + (p(s) - p(v))(l_c_2 (v) - l_c_2 (s)) . $

  Ma noi sappiamo che:
  - $p(r) - p(u) gt.eq 0$ dato che $u$ è un simbolo a probabilità minima;
  - $l_c_2 (u) - l_c_2 (r) lt.eq 0$ dato che $r$ è un simbolo a lunghezza massima;
  - $p(s) - p(v) gt.eq 0$ dato che $v$ è un simbolo a probabilità minima;
  - $l_c_2 (v) - l_c_2 (s) lt.eq 0$ dato che $s$ è un simbolo a lunghezza massima.

  Stiamo sommando due quantità negative, quindi $ EE[l_(overline(c)_2)] - EE[l_c_2] lt.eq 0 arrow.long.double EE[l_(overline(c)_2)] lt.eq EE[l_c_2] . $

  Introduciamo ora il codice $c'_2$ fatto come segue: $ c'_2 = cases(overline(c)_2 (x) quad & "se" x eq.not z, omega & "se" x = z) quad . $

  Questo codice è definito sulla sorgente $modello(X',p')$. Ma allora $ EE[l_(overline(c)_2)] & = sum_(x in X' bar.v x eq.not z) p'(x) l_(overline(c)_2) (x) + p(u) (l_(c'_2) (z) + 1) + p(v) (l_(c'_2) (z) + 1) = \ &= sum_(x in X' bar.v x eq.not z) p'(x) l_(overline(c)_2) (x) + p'(z) l_(c'_2) (z) + p'(z) = \ &= EE[l_(c'_2)] + p'(z) \ & gt.eq EE[l_c'] + p'(z) . $

  Mettendo insiemi i due risultati otteniamo $ EE[l_c] = EE[l_c'] + p'(z) lt.eq EE[l_(c'_2)] + p'(z) = EE[l_(overline(c)_2)] lt.eq EE[l_c_2] . $

  Ma allora $ EE[l_c] lt.eq EE[l_(c_2)] . qedhere $
]
