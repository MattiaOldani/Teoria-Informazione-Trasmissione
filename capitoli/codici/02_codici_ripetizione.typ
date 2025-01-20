// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codici a ripetizione

I codici a ripetizioni sono molto semplici, noi vedremo il *codice a ripetizione tripla*.

Come funziona: mando dei bit di informazione, ma ognuno di questi viene triplicato in un bit di informazione e in due bit di controllo. Quindi, se $x = x_1$ allora ho $ CR(x) = x_1 x_2 x_3 = cases(x_2 = x_3 = 0 & "se" x_1 = 0, x_2 = x_3 = 1 quad & "se" x_1 = 1) . $

Come riconosco gli errori:
- il dato è OK quando $x_1 + x_2 = 0$ e $x_1 + x_3 = 0$;
- il dato non è OK quando cade almeno una delle due condizioni precedenti.

Siamo in presenza di rumore bianco, quindi abbiamo una probabilità $p$ di commettere un errore, mentre abbiamo probabilità $(1-p)$ di non commettere errori. Sia $p lt.double (1-p)$, ovvero faccio pochissimi errori.

#example()[
  Usando un codice a ripetizione tripla spedisco $x = 000$. Noi dall'altra parte riceviamo $001$. Quanto vale: $ P(w(000) and r(001)) = P(w(000)) P(r(001) bar.v w(000)) = frac(p (1-p)^2, 2) . $ Invece quanto vale: $ P(w(111) and r(001)) = P(w(111)) P(r(001) bar.v w(111)) = frac(p^2 (1-p), 2) . $ Infine, quanto vale: $ P(r(001)) &= P(r(001) bar.v w(000)) P(w(000)) + P(r(001) bar.v w(111)) p(w(111)) = \ &= frac(p^2(1-p),2) + frac(p(1-p)^2,2) = p^2(1-p) + p(1-p)^2 . $
]

Un codice $C$ di tipo $(n,k)$, dove $n$ sono i bit totali e $k$ sono i bit di informazione, ha *code rate* $ coderate = k/n . $ Questa quantità definisce la percentuale di bit di informazione che sono utilizzati rispetto al totale dei bit che definiscono il codice. Rappresenta in poche parole la *bontà* del nostro codice.

In generale, i codici a ripetizione fanno schifo come code rate. Nel nostro caso, il codice a ripetizione tripla è di tipo $(3,1)$ e quindi il code rate è $ coderate = 1/3 . $

Vediamo infine come avvengono i calcoli per questo codice a ripetizione tripla.

Definiamo $G$ la *matrice generatrice* e $H$ la *matrice di parità* del nostro codice.

Nel nostro caso, la *matrice generatrice* $G$ è la matrice che moltiplica $s$ nella seguente formula: $ mat(x_1 x_2 x_3) = s mat(1 1 1) . $ Il valore $s$ indica il carattere che sto mandando, mentre le $x_i$ sono le possibili parole del codice.

La *matrice di parità* $H$ invece è $ mat(1,1,0;1,0,1) . $ Questa rappresenta il sistema di equazioni lineare omogeneo che mi definisce il codice, ovvero i due check che abbiamo messo sopra.

Quando riceviamo una parola $x = (x_1 x_2 x_3)$ dobbiamo verificare che $ H x^T = mat(0;0) . $

Questo codice è molto carino, ma se c'è un doppio errore non lo riusciamo a riconoscere.
