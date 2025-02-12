// Setup

#import "../alias.typ": *

#import "@preview/lovelace:0.3.0": pseudocode-list

#let settings = (
  line-numbering: "1:",
  stroke: 1pt + blue,
  hooks: 0.2em,
  booktabs: true,
  booktabs-stroke: 2pt + blue,
)

#let pseudocode-list = pseudocode-list.with(..settings)

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codici

Sia $X$ un insieme di *simboli* finito. Un/a *messaggio/parola* $ overline(x) = x_1 dot dots dot x_n in X^n $ è una concatenazione di $n$ caratteri $x_i$ di $X$. Dato $d > 1$, definiamo $ D = {0, dots, d-1} $ l'insieme delle *parole di codice*. Definiamo infine $ c : X arrow.long D^+ $ la *funzione di codifica*, la quale associa ad ogni carattere di $X$ una parola di codice.

Non useremo tanto $D$, ci sarà più utile $ D^+ = union.big_(n gt.eq 1)^(infinity) {0, dots, d-1}^n $ insieme di tutte le parole ottenute concatenando parole di $D$.

Voglio *massimizzare la compressione*: sia $l_c (x)$ la lunghezza della parola $x in X$ nel codice $c$. Ci servirà anche la *probabilità* $p(x)$ di estrarre un simbolo: questo perché alle parole estratte spesso andremo a dare una lunghezza breve, mentre alle parole estratte di rado andremo a dare una lunghezza maggiore. Un codice che segue queste convenzioni è ad esempio il *codice morse*.

Definiamo il *modello sorgente* come la coppia $modello(X,p)$.

Il nostro modello è quasi completo, perché ci interessa la probabilità di ottenere una parola di codice di $D^+$, non la probabilità dei simboli presenti in $D$. Definiamo quindi $ P_n (overline(x) = x_1 dot dots dot x_n) = product_(i=1)^n p(x_i) . $

Qua vediamo una prima enorme semplificazione di Shannon: stiamo assumendo l'*indipendenza* tra più estrazioni consecutive, cosa che nelle lingue parlate ad esempio non è vera.

Dati il modello $modello(X,p)$, la base $d > 1$ e il codice $c : X arrow.long D^+$ il modello deve essere tale che $ EE[l_c] = sum_(x in X) l_c (x) p(x) $ sia minimo.

Il primo problema che incontriamo sta nella fase di decodifica: se codifico due simboli con la stessa parola di codice come faccio in fase di decodifica a capire quale sia il simbolo di partenza?

#definition([Codice non singolare])[
  Un codice $c$ è non singolare se $c$ è una funzione iniettiva.
]

Imponiamo che il codice $c$ sia *non singolare*. Stiamo imponendo quindi che il codominio sia abbastanza capiente da tenere almeno tutti i simboli di $X$.

Definiamo $C : X^+ arrow.long D^+$ l'*estensione del codice* $c$ che permette di codificare una parola intera. Se il codice $c$ è non singolare, cosa possiamo dire di $C$?

Purtroppo, la non singolarità *non* si trasmette nell'estensione del codice.

#definition([Codice univocamente decodificabile])[
  Un codice $c$ è univocamente decodificabile se la sua estensione $C$ è non singolare.
]

Restringiamo l'insieme dei codici solo a quelli UD. Per dimostrare che un codice è UD esiste l'algoritmo di *Sardinas-Patterson*, che lavora in tempo $ O(m L) quad bar.v quad m = abs(X) and L = sum_(x in X) l_c (x) . $

Come funziona l'algoritmo di Sardinas-Patterson?

#align(center)[
  #pseudocode-list(title: [Sardinas-Patterson])[
    - *input*
      - insieme $S_1$ contenente le parole del codice $c$
    + for $i = 1, 2, dots$
      + Costruiamo l'insieme $S_(i+1)$
        + for $x in S_1$
          + Se $x y in S_i$ allora $y in S_(i+1)$
        + for $x in S_i$
          + Se $x y in S_1$ allora $y in S_(i+1)$
      + Casi di terminazione:
        + Se $S_(i+1) = emptyset.rev$ allora $c$ è UD
        + Se $S_(i+1)$ è uguale ad almeno un insieme $S_j bar.v j < i+1$ allora $c$ è UD
        + Se $S_(i+1) sect S_1 eq.not emptyset.rev$ allora $c$ non è UD
      + Se siamo arrivati fin qua ricominciamo il ciclo for con un nuovo valore di $i$
  ]
]

Con gli UD abbiamo un altro piccolo problema: non sono *stream*. In poche parole, un codice UD non ci garantisce di decodificare istantaneamente una parola di codice in un carattere di $X$ quando mi arrivano un po' di bit, ma dovrei prima ricevere tutta la stringa e poi decodificare. Sono ottimi codici eh, però ogni tanto aspetteremo tutta la codifica prima di poterla decodificare. Eh, ma non va bene: in una stream non posso permettermi tutto ciò, e inoltre, se la codifica è veramente grande, potrei non riuscire a tenerla tutta in memoria.

Una prima soluzione sono i *codici a virgola*, ovvero codici che hanno un carattere di terminazione per dire quando una parola è finita, e quindi risolvere il problema stream negli UD, ma noi faremo altro.

#definition([Codici istantanei])[
  Un codice $c$ è istantaneo se ogni parola di codice non è prefissa di altre parole di codice.
]

I CI hanno la proprietà che stiamo cercando, ovvero permettono una decodifica stream, quindi non dobbiamo aspettare tutta la codifica prima di passare alla decodifica, ma possiamo farla appena riconosciamo una parola di codice. Inoltre, per verificare se un codice è CI devo solo controllare se vale la regola dei prefissi, e questa è molto più veloce rispetto al controllo che dovevo fare negli UD.

/* Magari fai un diagramma */
Ho quindi la seguente gerarchia: $ "CI" subset "UD" subset "NS" subset "codici" . $

Ritorniamo all'obiettivo di prima: minimizzare la quantità $ EE[l_c] = sum_(x in X) l_c (x) p(x) . $ Vediamo come, mettendo ogni volta dei nuovi vincoli sul codice, questo valore atteso aumenta, visto che vogliamo dei codici con buone proprietà ma questo va sprecato in termini di bit utilizzati.

#theorem()[
  Se $c$ è un CI allora $c$ è un UD.
]

#proof()[
  Dimostro il contrario, ovvero che se un codice non è UD allora non è CI.

  Sia $c : X arrow.long D^+$ e sia $C$ la sua estensione. Assumiamo che $c$ sia non singolare. Se $c$ non è UD allora esistono due messaggi $x_1$ e $x_2$ diversi che hanno la stessa codifica $C(x_1) = C(x_2)$.

  Per mantenere i due messaggi diversi possono succede due cose:
  - un messaggio è prefisso dell'altro: se $x_1$ è formato da $x_2$ e altri $m$ caratteri, vuol dire che i restanti $m$ caratteri di $x_1$ devono essere codificati con la parola vuota, che per definizione di codice non è possibile, e, soprattutto, la parola vuota sarebbe prefissa di ogni altra parola di codice, quindi il codice $c$ non è istantaneo;
  - esiste almeno una posizione in cui i due messaggi differiscono: sia $i$ la prima posizione dove i due messaggi differiscono, ovvero $x_1[i] eq.not x_2[i]$ e $x_1[j] = x_2[j]$ per $1 lt.eq j lt.eq i - 1$, ma allora $c(x_1[i]) eq.not c(x_2[i])$ e $c(x_1[j]) = c(x_2[j])$ perché $c$ è non singolare, quindi per avere la stessa codifica devo tornare al punto $1$ e avere $x_1$ come prefisso di $x_2$. Come visto poco fa, otteniamo che $c$ non è istantaneo.

  Ma allora $c$ non è istantaneo.
]
