// Setup

#import "../alias.typ": *

#import "@preview/plotst:0.2.0": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Entropia

== Codice di Shannon-Fano

Il nostro obiettivo rimane quello di cercare il codice migliore, quello che minimizza il valore atteso delle lunghezze di tale codice, ovvero vogliamo trovare delle lunghezze $l_1, dots, l_m$ tali che $ min_(l_1, dots, l_m) space sum_(i=1)^m l_i p_i . $

Non voglio solo minimizzare, ora abbiamo a disposizione anche la disuguaglianza di Kraft: la andiamo ad imporre, così da avere anche un CI. Devono valere contemporaneamente $ cases(limits(min)_(l_1, dots, l_m) space limits(sum)_(i=1)^m l_i p_i, limits(sum)_(i=1)^m d^(-l_i) lt.eq 1) . $

Notiamo che $ sum_(i=1)^m d^(-l_i) lt.eq 1 = sum_(i=1)^m p_i . $ Per comodità, associamo $p_i$ al simbolo $x_i$ con lunghezza $l_i$. Allora guardiamo tutti i singoli valori della sommatoria, perché _"se rispetto i singoli rispetto anche le somme"_, quindi $ d^(-l_i) lt.eq p_i quad forall i = 1, dots, m \ l_i gt.eq log_d (1/p_i) . $

Con questa relazione ho appena detto come sono le lunghezze $l_i$ del mio codice: sono esattamente $ l_i = ceil(log_d (1/p_i)) . $ Posso quindi costruire un codice mettendo in relazione le lunghezze del codice con la probabilità di estrarle dalla sorgente. Il valore atteso ora diventa $ EE[l_c] = sum_(i=1)^m p_i ceil(log_d (1/p_i)) . $ grazie alla nuova definizione delle lunghezze delle parole di codice. Notiamo come il valore atteso delle lunghezze dipenda solo dalla distribuzione di probabilità dei simboli sorgente.

La tecnica che associa ad ogni lunghezza un valore in base alla probabilità ci consente di generare un codice chiamato *codice di Shannon* (_o Shannon-Fano_).

Questa costruzione dei codici di Shannon-Fano è molto bella:
- se ho una probabilità _bassa_ di estrarre il simbolo $x_i$ allora la sua codifica è molto lunga;
- se ho una probabilità _alta_ di estrarre il simbolo $x_i$ allora la sua codifica è molto corta.

Purtroppo, i codici di Shannon-Fano *non sono ottimali*.

SISTEMA DA QUA

#example()[
  Sia $X$ una sorgente di due simboli $x_1$ e $x_2$ con probabilità $ p_1 = 0.1 quad bar.v quad p_2 = 0.9 . $ Il codice di Shannon risultante ha lunghezze $ l_1 = ceil(log_2(1/0.1)) = 4 quad bar.v quad l_2 = ceil(log_2(1/0.9)) = 1 . $ Questo sicuramente non è ottimale: basta dare $0$ a $x_0$ e $1$ a $x_1$ per avere un codice ottimo.
]

== Entropia e tanti teoremi carini

La quantità $ sum_(i=1)^m p_i log_d (1/p_i) $ viene chiamata *entropia*. Come vedremo, sarà una misura che definisce quanto i nostri codici possono essere compressi, una sorta di misura di *compattezza*: oltre quella soglia non posso andare sennò perdo informazione.

Data la sorgente $modello(X,p)$ associamo ad essa la variabile casuale $ XX : X arrow.long {a_1, dots, a_m} $ tale che $P(XX = a_1) = p_i$. Abbiamo l'entropia $d$-aria $ H_d (XX) = sum_(i=1)^m p_i log_d (1/p_i) $ che dipende solamente dalla distribuzione di probabilità della mia sorgente.

Vogliamo cambiare la base dell'entropia, come facciamo? Ricordiamo che $ log_d (p) = frac(ln(p), ln(d)) = frac(ln(p), ln(d)) dot frac(ln(a), ln(a)) = frac(ln(p), ln(a)) dot frac(ln(a), ln(d)) = log_a (p) log_d (a) $ quindi $ H_d (XX) = log_d (a) H_a (XX) , $ ovvero per cambiare la base dell'entropia pago una costante moltiplicativa $log_d (a)$.

#example([Entropia binaria])[
  Sia $XX$ una variabile aleatoria bernoulliana tale che $ P(XX = 1) = p quad bar.v quad P(XX = 0) = 1 - p . $

  Calcoliamo l'entropia $ H_2(XX) = p log_2 (1/p) + (1-p) log_2 (1/(1-p)) $ e vediamo quanto vale nell'intervallo $(0,1)$.

  #figure(image("assets/03_entropia-binaria.svg", width: 80%))

  Ce lo potevamo aspettare? *SI*: nel caso di evento certo e evento impossibile io so esattamente quello che mi aspetta, quindi l'informazione è nulla, mentre in caso di totale incertezza l'informazione che posso aspettarmi è massima.
]

Vediamo ora due bound del logaritmo che ci permetteranno di dimostrare tanti bei teoremi.

#v(12pt)

#figure(image("assets/03_disuguaglianza.svg", width: 85%))

#v(12pt)

Come vediamo dal grafico abbiamo che $ 1 - 1/x lt.eq ln(x) lt.eq x - 1 . $

#theorem()[
  Sia $XX$ una variabile casuale che assume i valori ${a_1, dots, a_m}$, allora $ H_d (XX) lt.eq log_d (m) quad forall d > 1 . $ In particolare, $ H_d (XX) = log_d (m) $ se e solo se $XX$ è distribuita secondo un modello uniforme su ${a_1, dots, a_m}$.
]

#proof()[
  Andiamo a valutare $H_d (XX) - log_d (m)$ per vedere che valore assume.

  Consideriamo base dell'entropia e $d$ come lo stesso valore: se così non fosse avremmo un fattore moltiplicativo davanti all'entropia che però non cambia la dimostrazione successiva.

  Valutiamo quindi $ H_d (XX) - log_d (m) &= sum_(i=1)^m p_i log_d (1 / p_i) - log_d (m) = \ &= sum_(i=1)^m p_i log_d (1 / p_i) - underbracket(sum_(i=1)^m p_i, = 1) log_d (m) = \ &= sum_(i=1)^m p_i (log_d (1/p_i) - log_d (m)) = \ &= sum_(i=1)^m p_i log_d (1/(p_i m)) . $

  Sappiamo che $ln(n) lt.eq x - 1$, quindi $ H_d (XX) - log_d (m) lt.eq sum_(i=1)^m p_i (1/(p_i m) - 1) = sum_(i=1)^m 1/m - sum_(i=1)^m p_i = 1 - 1 = 0 . $

  Ma allora $ H_d (XX) - log_d (m) lt.eq 0 arrow.long.double H_d (XX) lt.eq log_d (m) . $

  In particolare, se $ P(X = a_i) = 1/m quad forall i = 1, dots, m $ allora $ H_d (XX) = sum_(i=1)^m 1/m log_d (m) = m 1/m log_d (m) = log_d (m) . qedhere $
]

Abbiamo detto che l'entropia ci dice quanto possiamo compattare il nostro messaggio prima che iniziamo a perdere informazioni: per dimostrare questo bound introduciamo prima la nozione di entropia relativa.

Siano $XX,WW$ due variabili aleatorie definite sullo stesso dominio $S$, e siano $p_XX$ e $p_WW$ le distribuzioni di probabilita delle due variabili aleatorie, allora l'*entropia relativa* $ enrel(XX,WW) = sum_(s in S) p_XX (s) log_d (frac(p_XX (s), p_WW (s))) $ è la quantità che misura la distanza che esiste tra le variabili aleatorie $XX$ e $WW$. In generale vale $ enrel(XX,WW) eq.not enrel(WW,XX) $ perché essa non è una distanza metrica, ma solo una distanza in termini di diversità.

#theorem([Information inequality])[
  $ enrel(XX,WW) gt.eq 0 . $
]

#proof()[
  Come nella dimostrazione precedente, se volessimo cambiare la base del logaritmo avremmo un fattore moltiplicativo davanti alla sommatoria, che però non cambia la dimostrazione. Noi manteniamo la base $d$ in questa dimostrazione.

  Valutiamo, sapendo che $1 - 1/x lt.eq ln(x)$, la quantità $ sum_(s in S) p_XX (s) log_d (frac(p_XX (s), p_WW (s))) &gt.eq sum_(s in S) p_XX (s) (1 - frac(p_WW (s), p_XX (s))) = \ &= sum_(s in S) p_XX (s) - p_WW (s) = \ &= sum_(s in S) p_XX (s) - sum_(s in S) p_WW (s) = 1 - 1 = 0 . $

  Ma allora $ enrel(XX,WW) gt.eq 0 . qedhere $
]

Se $enrel(XX,WW) = 0$ allora ho spakkato, vuol dire che non ho distanza tra le due variabili aleatorie.

Vediamo finalmente il bound che ci dà l'entropia sulla compattezza del codice.

#theorem()[
  Sia $c : X arrow.long D^+$ un CI $d$-ario per la sorgente $modello(X,p)$, allora $ EE[l_c] gt.eq H_d (XX) . $
]

#proof()[
  Chiamo $WW : X arrow.long RR$ una variabile casuale con una distribuzione di probabilita $q(x)$ tale che $ q(x) = frac(d^(-l_c (x)), sum_(x' in X) d^(-l_c (x'))) . $

  Valutiamo $ EE[l_c] - H_d (XX) &= sum_(x in X) l_c (x) p(x) - sum_(x in X) p(x) log_d (1/p(x)) = \ &= sum_(x in X) p(x) (l_c (x) - log_d (1/p(x))) = \ &= sum_(x in X) p(x) (log_d d^(l_c (x)) - log_d (1/p(x))) = \ &= sum_(x in X) p(x) log_d (p(x) d^(l_c (x))) = \ &= italic("massaggiamo pesantemente la formula") = \ &= sum_(x in X) p(x) log_d (frac(p(x), d^(-l_c (x)))) = \ &= sum_(x in X) p(x) log_d (frac(p(x), d^(-l_c (x))) dot frac(sum_(x' in X) d^(-l_c (x')), sum_(x' in X) d^(-l_c (x')))) = \ &= sum_(x in X) p(x) log_d (frac(p(x), q(x))) + sum_(x in X) p(x) log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) = \ &= enrel(XX,WW) + log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) sum_(x in X) p(x) = \ &= enrel(XX,WW) + log_d (frac(1, sum_(x' in X) d^(-l_c (x')))) . $

  Per l'information inequality sappiamo che $ enrel(XX,WW) gt.eq 0 , $ mentre per la disuguaglianza di Kraft sappiamo che $ sum_(x in X) d^(-l_c (x)) lt.eq 1 $ e quindi possiamo dire che $ 1 / (sum_(x in X) d^(-l_c (x))) gt.eq 1 arrow.long.double log_d (gt.eq 1) gt.eq 0 . $

  Otteniamo quindi che $ EE[l_c] - H_d (XX) gt.eq 0 arrow.long.double EE[l_c] gt.eq H_d (XX) . qedhere $
]

Questo bound ci dice che un codice non può comunicare meno di quanto vale l'entropia di quella sorgente, indipendentemente dal codice scelto.

Vediamo infine una proprietà del codice di Shannon, ora che abbiamo conosciuto abbastanza bene il concetto di entropia e tutti i suoi bound.

#theorem()[
  Per ogni sorgente $modello(X,p)$ con:
  - $X = {x_1, dots, x_m}$ insieme dei simboli sorgente;
  - $P = {p_1, dots, p_m}$ probabilità associate ai simboli di $X$;
  - $c : X arrow.long D^+$ codice di Shannon con lunghezze $l_1, dots, l_m$ tali che $l_i = l_c (x_i)$ costruite con $ l_i = ceil(log_d (1/p_i)) quad forall i = 1, dots, m $. Vale la relazione $ EE[l_c] < H_d (XX) + 1 . $
]

#proof()[
  Verifichiamo che $ EE[l_c] &= sum_(i=1)^m p_i l_i = sum_(i=1)^m p_i ceil(log_d (1/p_i)) \ &< sum_(i=1)^m p_i (log_d (1 / p_i) + 1) = sum_(i=1)^m p_i log_d (1 / p_i) + sum_(i=1)^m p_i = H_d (XX) + 1 . $

  Che fastidio questo quadrato.
]

Ho trovato quindi un bound superiore alle lunghezze delle parole di codice di un codice di Shannon. Se uniamo questo bound a quelli di questo capitolo otteniamo $ H_d (XX) lt.eq EE[l_c] lt.eq H_d (XX) + 1 . $
