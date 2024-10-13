#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 05 [11/10]

== Entropia e tante dimostrazioni

Data la sorgente $modello(X,p)$ associamo ad essa la variabile casuale $XX : X arrow.long {a_1, dots, a_m}$ tale che $P(XX = a_1) = p_i$. Abbiamo l'entropia $d$-aria $H_d (XX) = sum_(i=1)^m p_i log_d (1/p_i)$ che dipende solamente dalla distribuzione di probabilità della mia sorgente.

Cosa succede se vogliamo cambiare la base dell'entropia? Ricordiamo che $ log_d (p) = frac(ln(p), ln(d)) = frac(ln(p), ln(d)) dot frac(ln(a), ln(a)) = frac(ln(p), ln(a)) dot frac(ln(a), ln(d)) = log_a (p) log_d (a) $ quindi $ H_d (XX) = log_d (a) H_a (XX) , $ ovvero per cambiare la base dell'entropia pago una costante moltiplicativa $log_d (a)$.

#example()[
  Sia $XX : X arrow.long {0,1}$ variabile aleatoria bernoulliana tale che $ P(XX = 1) = p quad bar.v quad P(XX = 0) = 1 - p . $

  Calcoliamo l'entropia $ H(XX) = p log_2 (1/p) + (1-p) log_2 (1/(1-p)) $ e vediamo quanto vale nell'intervallo $[0,1]$.

  // Sistemare l'immagine
  #v(12pt)

  #figure(
    image("../assets/05_entropia-binaria.svg", width: 50%),
  )

  #v(12pt)

  Ce lo potevamo aspettare? _SI_: nel caso di evento certo e evento impossibile io so esattamente quello che mi aspetta, quindi l'informazione è nulla, mentre in caso di totale incertezza l'informazione che posso aspettarmi è massima.
]

Vediamo ora due bound del logaritmo che ci permetteranno di dimostrare tanti bei teoremi.

#v(12pt)

#figure(
  image("../assets/05_disuguaglianza.svg", width: 50%),
)

#v(12pt)

Come vediamo dal grafico (_senza label lol non sono capace_) abbiamo che $ 1 - 1/x lt.eq ln(x) lt.eq x - 1 . $

#theorem()[
  Sia $XX$ una variabile casuale che assume i valori ${a_1, dots, a_m}$, allora $ H_d (XX) lt.eq log_d (m) quad forall d > 1 . $ In particolare, $ H_d (XX) = log_d (m) $ se e solo se $XX$ è distribuita secondo un modello uniforme su ${a_1, dots, a_m}$.
]

#proof()[
  Andiamo a valutare $H_d (XX) - log_d (m)$ per vedere che valore assume.

  Consideriamo base dell'entropia e $d$ come lo stesso valore: se così non fosse avremmo un fattore moltiplicativo davanti all'entropia che però non cambia la dimostrazione successiva.

  Valutiamo quindi $ H_d (XX) - log_d (m) &= sum_(i=1)^m p_i log_d (1 / p_i) - log_d (m) = sum_(i=1)^m p_i log_d (1 / p_i) - sum_(i=1)^m p_i log_d (m) = \ &= sum_(i=1)^m p_i (log_d (1/p_i) - log_d (m)) = sum_(i=1)^m p_i (log_d (1/(p_i m))) \ &lt.eq sum_(i=1)^m p_i (1/(p_i m) - 1) = sum_(i=1)^m 1/m - sum_(i=1)^m p_i = 1 - 1 = 0 . $

  Ma allora $ H_d (XX) - log_d (m) lt.eq 0 arrow.long.double H_d (XX) lt.eq log_d (m) . $

  In particolare, se $ P(X = a_i) = 1/m quad forall i = 1, dots, m $ allora $ H_d (XX) = sum_(i=1)^m 1/m log_d (m) = m 1/m log_d (m) = log_d (m) . qedhere $
]

Nella scorsa lezione abbiamo detto che l'entropia ci dice quanto possiamo compattare il nostro messaggio prima che iniziamo a perdere informazioni. Per dimostrare questo bound introduciamo prima l'entropia relativa.

Siano $XX,WW$ due variabili aleatorie definite sullo stesso dominio $S$, e siano $p_XX$ e $p_WW$ le distribuzioni di probabilita delle due variabili aleatorie, allora l'*entropia relativa* $ enrel(XX,WW) = sum_(s in S) p_XX (s) log_d (frac(p_XX (s), p_WW (s))) $ è la quantità che misura la distanza che esiste tra le variabili aleatorie $XX$ e $WW$. In generale $enrel(XX,WW) eq.not enrel(WW,XX)$ perché essa non è una distanza metrica, ma solo una distanza in termini di diversità.

#theorem("Information inequality")[
  $ enrel(XX,WW) gt.eq 0 . $
]

#proof()[
  Come nella dimostrazione precedente, se volessimo cambiare la base del logaritmo avremmo un fattore moltiplicativo davanti alla sommatoria, che però non cambia la dimostrazione successiva. Noi manteniamo la base $d$ in questa dimostrazione.

  Valutiamo $ sum_(s in S) p_XX (s) log_d (frac(p_XX (s), p_WW (s))) &gt.eq sum_(s in S) p_XX (s) (1 - frac(p_WW (s), p_XX (s))) = sum_(s in S) p_XX (s) - p_WW (s) = \ &= sum_(s in S) p_XX (s) - sum_(s in S) p_WW (s) = 1 - 1 = 0 . $

  Ma allora $ enrel(XX,WW) gt.eq 0 . qedhere $
]

Se $enrel(XX,WW) = 0$ allora ho spakkato, non ho distanza tra le due variabili aleatorie.

Vediamo finalmente il bound che ci dà l'entropia sulla compattezza.

#theorem()[
  Sia $c : X arrow.long D^+$ un CI $d$-ario per la sorgente $modello(X,p)$, allora $ EE[l_c] gt.eq H_d (XX) . $
]

#proof()[
  Chiamo $WW : X arrow.long RR$ una variabile casuale con una distribuzione di probabilita $q(x)$ tale che $ q(x) = frac(d^(-l_c (x)), sum_(x' in X) d^(-l_c (x'))) . $

  Valutiamo $ EE[l_c] - H_d (XX) &= sum_(x in X) l_c (x) p(x) - sum_(x in X) p(x) log_d (1/p(x)) = \ &= sum_(x in X) p(x) (l_c (x) - log_d (1/p(x))) = \ &= sum_(x in X) p(x) (log_d d^(l_c (x)) - log_d (1/p(x))) = \ &= sum_(x in X) p(x) log_d (p(x) d^(l_c (x))) = \ &= italic("massaggiamo pesantemente la formula") = \ &= sum_(x in X) p(x) log_d (frac(p(x), d^(-l_c (x)))) = \ &= sum_(x in X) p(x) log_d (frac(p(x), d^(-l_c (x))) dot frac(sum_(x' in X) d^(-l_c (x')), sum_(x' in X) d^(-l_c (x')))) = \ &= sum_(x in X) p(x) log_d (frac(p(x), q(x))) + sum_(x in X) p(x) log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) = \ &= enrel(XX,WW) + log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) sum_(x in X) p(x) = \ &= enrel(XX,WW) + log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) . $

  Per l'information inequality sappiamo che $ enrel(XX,WW) gt.eq 0 , $ mentre per la disuguaglianza di Kraft sappiamo che $ sum_(x in X) d^(-l_c (x)) lt.eq 1 $ e quindi che $ 1 / (sum_(x in X) d^(-l_c (x))) gt.eq 1 arrow.long.double log_d (gt.eq 1) gt.eq 0 . $

  Otteniamo quindi che $ EE[l_c] - H_d (XX) gt.eq 0 arrow.long.double EE[l_c] gt.eq H_d (XX) . qedhere $
]

Questo bound ci dice che un codice non può comunicare meno di quanto vale l'entropia di quella sorgente, indipendentemente dal codice scelto.

== Esercizi

Vediamo l'algoritmo di Sardinas-Patterson per verificare se un codice dato è UD.

// Package degli algoritmi (????)
Dato l'insieme $S_1$ contenente le parole del codice $c$, l'algoritmo esegue i seguenti passi:
+ si parte da $i = 1$;
+ sia $x in S_1$, se esiste $x y in S_i$ allora $y in S_(i+1)$;
+ sia $z in S_i$, se esiste $z y in S_1$ allora $z in S_(i+1)$;
+ osserviamo $S_(i+1)$:
  - se $S_(i+1) = emptyset.rev$ allora $c$ è UD;
  - se $S_(i+1) sect S_1 eq.not emptyset.rev$ allora $c$ non è UD;
  - se $S_(i+1)$ no rientra nei due casi precedenti ritornare al punto $2$ con $i = i + 1$.

#example()[
  Sia $S_1 = {A, E, C, A B B, C E D, B B E C}$, il codice $c$ con le parole di codice contenute in $S_1$ è UD?

  - $S_1 = {A, E, C, A B B, C E D, B B E C}$;
  - $S_2 = {B B, E D}$;
  - $S_3 = {D} union {E C} = {D, E C}$;
  - $S_4 = {C} union {emptyset.rev} = {C}$.

  Ma $S_1 sect S_4 eq.not emptyset.rev$ quindi $c$ non è UD.
]
