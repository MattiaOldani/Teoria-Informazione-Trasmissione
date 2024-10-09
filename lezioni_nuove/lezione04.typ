#import "alias.typ": *

#import "theorems.typ": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 04 [08/10]

== Disuguaglianza di Kraft

I codici UD ci vanno bene (stream escluso), mentre i CI sono perfetti ma perché ci danno di più ma ci fanno spendere più bit: quanti?

Noi stavamo minimizzando il valore atteso delle lunghezze delle parole di codice, ovvero $ min_(c in cal(C)) quad EE[l_c] = sum_(x in X) l_c (x) p(x) . $

Cosa possiamo dire sui CI? Sono molto graditi perché, oltre a identificare un CI in maniera molto semplice guardando i prefissi, possiamo capire *se esiste* un codice istantaneo senza vedere il codice, ovvero guardando solo le lunghezze delle parole di codice.

Questa è una differenza abissale: prima guardavamo le parole di codice e controllavo i prefissi, ora non ho le parole, posso guardare solo le lunghezze delle parole di codice e, in base a queste, posso dire se esiste un CI con quelle lunghezze. Il problema principale è che non so che codice è quello istantaneo con quelle lunghezze, sto solo dicendo che sono sicuro della sua esistenza

Date le lunghezze, l'unica cosa che posso dire è se un CI non esiste (quando sono sbagliate le lunghezze date), ma non posso dire che il codice che ho dato con quelle lunghezze è un CI, perché questo ci dice solo della sua esistenza, non se il codice che ho dato con quelle lunghezze è CI, per quello dovrei guardare i prefissi.

Come mai seguire questa via e non quelle dei prefissi? Se il codice è molto grande, guardare questa proprietà è meno oneroso rispetto al guardare i prefissi.

Questa proprietà è detta *disuguaglianza di Kraft*.

#theorem("Disuguaglianza di Kraft")[
  Data una sorgente $X = {x_1, dots, x_m}$, data $d > 1$ base del codice e dati $m$ interi $l_1, dots, l_m > 0$ che mi rappresentano le lunghezze dei simboli del codice, esiste un CI $c : X arrow.long D^+$ tale che $ l_c (x_i) = l_i quad forall i = 1, dots, m $ se e solo se $ sum_(i=1)^m d^(-l_i) lt.eq 1 . $
]

#proof()[
  \ ($arrow.long.double.r$) Esiste un CI con quelle proprietà, dimostro che vale la disuguaglianza di Kraft.

  Sia $c$ il nostro CI e $d$ la base di $c$, dobbiamo definire la profondità del nostro codice. Possiamo usare un albero di codifica, ovvero un albero $d$-ario che rappresenta come sono codificate le varie parole di codice. Vediamo un breve esempio.

  #v(12pt)

  #figure(
    image("../assets/04_albero-dimostrazione.svg", width: 90%),
  )

  #v(12pt)

  Vogliamo sapere $ l_max = max_(i = 1, dots, m) l_c (x_i) . $

  Costruiamo l'albero di codifica per il nostro CI e mettiamo dentro questo albero le parole del nostro codice. Come lo costruiamo? Creiamo l'albero $d$-ario alto $l_max$ completo e scegliamo, in questo albero, delle parole ad altezza $l_i quad forall i = 1, dots, m$.

  Dividiamo il nostro albero in sotto-alberi grazie alle parole che abbiamo inserito: ogni sotto-albero ha come radice una delle parole che abbiamo scelto. Contiamo quante foglie che ogni nodo copre. Sono tutti alberi disgiunti, visto che non posso avere prefissi essendo $c$ un CI. Il numero massimo di foglie è $d^(l_max)$, noi non le potremmo coprire tutte quindi $ sum_(i=1)^m abs(A_i) lt.eq d^(l_max) , $ con $A_i$ sotto-albero con radice la parola $x_i$. Notiamo che $ sum_(i=1)^m d^(l_max - l_i) = sum_(i=1)^m abs(A_i) lt.eq d^(l_max) . $ Ora possiamo dividere tutto per $d^(l_max)$ e ottenere $ sum_(i=1)^m frac(d^(l_max - l_i), d^(l_max)) = sum_(i=1)^m d^(-l_i) lt.eq 1 . $

  ($arrow.long.double.l$) Vale la disuguaglianza di Kraft, dimostro che esiste un CI con quelle proprietà.

  Abbiamo le lunghezze che rendono vera la disuguaglianza di Kraft, quindi costruiamo l'albero di codifica: scegliamo un nodo ad altezza $l_i$ e poi proibiamo:
  - a tutti gli altri nodi di inserirsi nel suo sotto-albero;
  - di inserire nodi che conterrebbero dei nodi già inseriti.

  Una volta costruito l'albero vedo che rappresenta un CI, perché tutti i nodi non hanno nodi nel loro sotto-albero, quindi non ho prefissi per costruzione, quindi questo è un CI.
]

Il nostro obiettivo rimane sempre e comunque quello di cercare il codice migliore, quello che minimizza il valore atteso delle lunghezze di tale codice, ovvero vogliamo trovare delle lunghezze $l_1, dots, l_m$ tali che $ min_(l_1, dots, l_m) space sum_(i=1)^m l_i p_i . $

Non voglio solo minimizzare, voglio che valga anche Kraft, così da avere un codice che sia istantaneo, quindi devono valere contemporaneamente $ cases(limits(min)_(l_1, dots, l_m) space limits(sum)_(i=1)^m l_i p_i, limits(sum)_(i=1)^m d^(-l_i) lt.eq 1) $ con $p_i = p(x_i) quad forall i = 1, dots, m$. Cosa possiamo dire?

Notiamo che $ sum_(i=1)^m d^(-l_i) lt.eq sum_(i=1)^m p_i = 1 . $ Per comodità, associamo $p_i$ al simbolo $x_i$ con lunghezza $l_i$. Allora guardiamo tutti i singoli valori della sommatoria, perché _"se rispetto i singoli rispetto anche le somme"_, quindi $ d^(-l_i) lt.eq p_i quad forall i = 1, dots, m \ l_i gt.eq log_d (1/p_i) . $

Con questa relazione ho appena detto come sono le lunghezze $l_i$ del mio codice: sono esattamente $ l_i gt.eq ceil(log_d (1/p_i)) . $ Posso quindi costruire un codice mettendo in relazione le lunghezze del codice con la probabilità di estrarle dalla sorgente.

#example()[
  Dati $ X = {x_1, x_2, x_3, x_4} quad bar.v quad P = {1/2, 1/4, 1/8, 1/8} quad bar.v quad d = 2 $ costruire un codice con la tecnica appena vista.

  - $l_1 gt.eq ceil(log_2 (2)) = 1 arrow.long 0$;
  - $l_2 gt.eq ceil(log_2 (4)) = 2 arrow.long 10$;
  - $l_3 gt.eq ceil(log_2 (8)) = 3 arrow.long 110$;
  - $l_4 gt.eq ceil(log_2 (8)) = 3 arrow.long 111$.

  Questo codice ha valore atteso delle lunghezze $ EE[l_c] = 2/4 + 2/4 + 3/4 = 7/4 . $
]

Il valore atteso ora diventa $ EE[l_c] = sum_(i=1)^m p_i log_d (1/p_i) . $ grazie alla nuova definizione delle lunghezze delle parole di codice.

La tecnica che associa ad ogni lunghezza un valore in base alla probabilità ci consente di generare un codice chiamato *codice di Shannon* (_o Shannon-Fano_. Il bro Fano era il dottorando di Shannon).

Inoltre, notiamo come il valore atteso delle lunghezze dipenda solo dalla distribuzione di probabilità dei simboli sorgente.

La quantità $ sum_(i=1)^m p_i log_d (1/p_i) $ viene chiamata *entropia*. Come vedremo, sarà una misura che definisce quanto i nostri codici possono essere compressi, una sorta di misura di compattezza: oltre quella soglia non posso andare sennò perdo informazione.

Questa costruzione dei codici di Shannon-Fano è molto bella:
- se ho una probabilità bassa di estrarre il simbolo $x_i$ allora $1/p_i$ è grande e $log_d (1/p_i)$ è grande;
- se ho una probabilità alta di estrarre il simbolo $x_i$ allora $1/p_i$ è piccolo e $log_d (1/p_i)$ è piccolo.

Purtroppo, i codici di Shannon-Fano non sono ottimali: una sorgente con due simboli a probabilità $p_1 = 0.1$ e $p_2 = 0.9$ darà un codice che non è ottimale.

#example()[
  Siano $ m = 4 quad bar.v quad c : 1, 011, 01, 111 . $ Fai alcune considerazioni su questo codice.

  Sicuramente non è CI: abbiamo dei prefissi che non vanno bene. Non è nemmeno UD: abbiamo una codifica ambigua per $111$.
]

#example()[
  Siano $ m = 5 quad bar.v quad c : 1, 001, 0000, 01, 0001 . $ Fai alcune considerazioni su questo codice.

  Sicuramente è CI: non abbiamo prefissi, quindi è anche UD.

  Posso vederlo come codice a virgola con il simbolo $1$ che fa da separatore tra tutte le sequenze di $0$.
]

#example()[
  Siano $ m = 5 quad bar.v quad c : 000, 001, 01, 111, 110 . $ Fai alcune considerazioni su questo codice.

  Sicuramente è CI: non abbiamo prefissi, quindi è anche UD.

  Non è ottimale perché due foglie dell'albero non vengono coperte. Si potrebbe ridurre $EE[l_c]$ se scambiassimo $110$ con $10$ e $111$ con $11$.
]

#example()[
  Siano $ X = {x_1, dots x_6} quad bar.v quad d = 2 quad bar.v quad P = {1/15, 1/3, 1/6, 1/9, 1/5, 1/29} . $ Costruisci un codice di Shannon per queste lunghezze.

  Le probabilità non sommano a $1$.
]

#example()[
  Siano $ X = {x_1, dots x_6} quad bar.v quad d = 2 quad bar.v quad P = {1/12, 1/3, 1/5, 1/3, 1/72, x} . $ Costruisci un codice di Shannon per queste lunghezze.

  Le probabilità devono sommare a $1$ quindi $ p_6 = 1 - (1/12 + 1/3 + 1/5 + 1/3 + 1/72) = 1 - 347/360 = 13/360 . $

  - $l_1 gt.eq ceil(log_2 (12)) = 4 arrow.long 1100$;
  - $l_2 gt.eq ceil(log_2 (3)) = 2 arrow.long 01$;
  - $l_3 gt.eq ceil(log_2 (5)) = 3 arrow.long 100$;
  - $l_4 gt.eq ceil(log_2 (3)) = 2 arrow.long 00$;
  - $l_5 gt.eq ceil(log_2 (72)) = 7 arrow.long 1111111$;
  - $l_6 gt.eq ceil(log_2 (approx 28)) = 5 arrow.long 11010$.
]
