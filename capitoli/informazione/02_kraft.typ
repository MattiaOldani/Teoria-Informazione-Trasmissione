// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Disuguaglianza di Kraft

Cosa possiamo dire sui CI? Sono molto graditi perché, oltre a identificare un CI in maniera molto semplice guardando i prefissi, possiamo capire *se esiste* un codice istantaneo senza vedere il codice, ovvero guardando solo le lunghezze delle parole di codice.

Questa è una differenza abissale: prima guardavamo le parole di codice e controllavo i prefissi, ora non ho le parole, posso guardare solo le lunghezze delle parole di codice e, in base a queste, posso dire se esiste un CI con quelle lunghezze. Il problema principale è che non so che codice è quello istantaneo con quelle lunghezze, sto solo dicendo che sono sicuro della sua esistenza.

Come mai seguire questa via e non quelle dei prefissi? Se il codice è molto grande, guardare questa proprietà è meno oneroso rispetto al guardare i prefissi.

La proprietà che stiamo blaterando da un po' è detta *disuguaglianza di Kraft*.

#theorem([Disuguaglianza di Kraft])[
  Dati una sorgente $X = {x_1, dots, x_m}$ di $m$ simboli, $d > 1$ base del codice e $m$ interi $l_1, dots, l_m > 0$ che mi rappresentano le lunghezze dei simboli del codice, esiste un CI $ c : X arrow.long D^+ $ tale che $ l_c (x_i) = l_i quad forall i = 1, dots, m $ se e solo se $ sum_(i=1)^m d^(-l_i) lt.eq 1 . $
]

#proof()[
  Dimostriamo la doppia implicazione.

  ($arrow.long.double.r$) Esiste un CI con quelle proprietà, dimostro che vale la disuguaglianza di Kraft.

  Sia $c$ il nostro CI e $d$ la base di $c$, dobbiamo definire la profondità del nostro codice. Possiamo usare un albero di codifica, ovvero un albero $d$-ario che rappresenta come sono codificate le varie parole di codice. Vediamo un breve esempio.

  #v(12pt)

  #figure(image("assets/02_albero.svg", width: 90%))

  #v(12pt)

  Vogliamo sapere $ l_max = max_(i = 1, dots, m) l_c (x_i) . $

  Costruiamo l'albero di codifica per il nostro CI e mettiamo dentro questo albero le parole del nostro codice. Come lo costruiamo? Creiamo l'albero $d$-ario alto $l_max$ completo e scegliamo, in questo albero, delle parole ad altezza $l_i quad forall i = 1, dots, m$.

  Dividiamo il nostro albero in sotto-alberi grazie alle parole che abbiamo inserito: ogni sotto-albero ha come radice una delle parole che abbiamo scelto. Contiamo quante foglie sono coperte da ogni sotto-albero. Sono tutti alberi disgiunti, visto che non posso avere prefissi essendo $c$ un CI. Il numero massimo di foglie è $d^(l_max)$, ma noi potremmo non coprirle tutte, quindi $ sum_(i=1)^m abs(A_i) lt.eq d^(l_max) , $ con $A_i$ sotto-albero con radice la parola $x_i$. Notiamo che $ sum_(i=1)^m d^(l_max - l_i) = sum_(i=1)^m abs(A_i) lt.eq d^(l_max) . $ Ora possiamo dividere tutto per $d^(l_max)$ e ottenere $ sum_(i=1)^m frac(d^(l_max - l_i), d^(l_max)) = sum_(i=1)^m d^(-l_i) lt.eq 1 . $

  ($arrow.long.double.l$) Vale la disuguaglianza di Kraft, dimostro che esiste un CI con quelle proprietà.

  Abbiamo le lunghezze che rendono vera la disuguaglianza di Kraft, quindi costruiamo l'albero di codifica: scegliamo un nodo ad altezza $l_i$ e poi proibiamo a tutti gli altri nodi ancora da inserire di:
  - inserirsi nel sotto-albero di nodi già selezionati;
  - scegliere nodi presenti nel cammino da un nodo già selezionato fino alla radice.

  Una volta costruito l'albero vedo che esso rappresenta un CI, perché tutti i nodi non hanno nodi nel loro sotto-albero, quindi non ho prefissi per costruzione, quindi questo è un CI.
]
