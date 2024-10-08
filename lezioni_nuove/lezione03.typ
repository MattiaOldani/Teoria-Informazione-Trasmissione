#import "alias.typ": *

#import "theorems.typ": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 03 [04/10]

Dalla lezione scorsa abbiamo capito che dobbiamo fare due cose:
+ massimizzare l'informazione trasmessa ad ogni utilizzo del canale; il "ogni utilizzo" è importante perché ogni volta che utilizzo il canale devo essere top, adesso lo devo essere. Se devo mandare $n$ informazioni lo posso fare in $n$ accessi oppure in $1$ accesso, in entrambi i casi massimizzo l'informazione trasmessa ma non uso sempre tutta la banda possibile;
+ minimizzare il numero di errori di trasmissione.

Shannon userà la tecnica del Divide Et Impera, ovvero risolverà le due task separatamente e poi unirà i due risultati parziali. Per puro culo, questa soluzione sarà ottima (_non sempre succede_).

Il punto $1$ riguarda la sorgente, il punto $2$ riguarda la codifica e il canale.

== Codici

Prima di vedere un po' di teoria dei codici diamo alcune basi matematiche.

Sia $X$ un insieme di *simboli* finito. Un/a *messaggio/parola* $overline(x) = x_1 dot dots dot x_n in X^n$ è una concatenazione di $n$ caratteri $x_i$ di $X$.

Dato $d > 1$, definiamo $D = {0, dots, d-1}$ insieme delle *parole di codice*.

Definiamo infine $c : X arrow.long D^+$ *funzione di codifica* che associa ad ogni carattere di $X$ una parola di codice. Questa è una codifica in astratto: a prescindere da come è formato l'insieme $X$ io uso le parole di codice che più mi piacciono (????). L'insieme $D^+$ è tale che $ D^+ = union.big_(n gt.eq 1)^(infinity) {0, dots, d-1}^n . $

Voglio massimizzare la compressione: sia $l_c (x)$ la lunghezza della parola $x in X$ nel codice $c$.

Quello che ho ora mi basta? NO: mi serve anche la *probabilità* $p(x)$ di estrarre un simbolo. Questo perché alle parole estratte molto spesso andremo a dare una lunghezza breve, mentre alle parole estratte di rado andremo a dare una lunghezza maggiore. Un codice che segue queste convenzioni è il codice morse.

Definiamo quindi il *modello sorgente* la coppia $modello(X,p)$.

Ora va bene? NON ANCORA: noi non vogliamo la probabilità di estrarre un simbolo perché noi lavoriamo con le parole, non con i simboli.

Definiamo quindi $P_n (overline(x) = x_1 dot dots dot x_n) = product_(i=1)^n p(x_i) $

Qua vediamo una prima enorme semplificazione di Shannon: stiamo assumendo l'indipendenza tra più estrazioni consecutive, cosa che nelle lingue invece non è vera.

Il codice ZIP invece non assume l'indipendenza e lavora con la lingua che sta cercando di comprimere.

Dati il modello $modello(X,p)$ e la base $d > 1$, dato il codice $c : X arrow.long D^+$ il modello deve essere tale che $ EE[l_c] = sum_(x in X) l_c (x) p(x) $ sia minimo.

Il primo problema che incontriamo sta nella fase di decodifica: se codifico due simboli con la stessa parola di codice come faccio in fase di decodifica a capire quale sia il simbolo di partenza?

Imponiamo che il codice sia un *codice non singolare*, ovvero che la funzione $c$ sia iniettiva. Stiamo imponendo quindi che il codominio sia abbastanza capiente da tenere almeno tutti i simboli di $X$.

Definiamo $C : X^+ arrow.long D^+$ l'*estensione del codice* $c$ che permette di codificare una parola intera.

Se $c$ è non singolare, come è $C$?

Purtroppo, la non singolarità non si trasmette nell'estensione del codice.

Andiamo a restringere l'insieme dei codici "buoni": chiamiamo codici *univocamente decodificabili* (_UD_) i codici che hanno $C$ non singolare.

Per dimostrare che un codice è UD esista l'algoritmo di Sardinas-Patterson, che lavora in tempo $O(m L)$, con $m = abs(X)$ e $L = limits(sum)_(x in X) l_c (x)$.

Ora però abbiamo un altro problema: gli UD non sono *stream*. In poche parole, un codice UD non ci garantisce di decodificare istantaneamente una parola di codice in un carattere di $X$ quando mi arrivano un po' di bit, ma dovrei prima ricevere tutta la stringa e poi decodificare.

Sono ottimi codici eh, però ogni tanto aspetteremo tutta la codifica prima di poterla decodificare. Eh ma non va bene: in una stream non posso permettermi tutto ciò, e inoltre, se la codifica è veramente grande potrei non riuscire a tenerla tutta in memoria.

Potremmo utilizzare i *codici a virgola*, ovvero codici che hanno un carattere di terminazione per dire quando una parola è finita, e quindi risolvere il problema stream negli UD, ma noi faremo altro.

Restringiamo per l'ultima volta, definendo i *codici istantanei* (_CI_). Questi codici hanno la proprietà che stiamo cercando, ovvero permettono una decodifica stream, quindi non dobbiamo aspettare tutta la codifica prima di passare alla decodifica, ma possiamo farla appena riconosciamo una parola di codice.

Per capire se un codice è CI devo guardare i prefissi: nessuna parola di codice deve essere prefissa di un'altra. Questo controllo è molto più veloce rispetto al controllo che dovevo fare nei codici UD.

Ho quindi la seguente gerarchia: $ "CI" subset "UD" subset "NS" subset "codici" . $

Ritorniamo all'obiettivo di prima: minimizzare la quantità $ EE[l_c] = sum_(x in X) l_c (x) p(x) . $ Vediamo come, mettendo ogni volta dei nuovi vincoli sul codice, questo valore atteso aumenta, visto che vogliamo dei codici con buone proprietà ma questo va sprecato in termini di bit utilizzati. Inoltre, il codice che abbiamo sotto mano è il migliore?

A noi gli UD andavano bene (_stream esclusi_), quanto pago per andare nei codici istantanei?

#theorem()[
  Se un codice è istantaneo allora è anche univocamente decodificabile.
]

#proof()[
  Dimostro il contrario, ovvero che se un codice non è UD allora non è CI.

  Sia $c : X arrow.long D^+$ e sia $C$ la sua estensione. Assumiamo che $c$ sia non singolare. Se $c$ non è UD allora esistono due messaggi $x_1 e x_2$ diversi che hanno la stessa codifica $C(x_1) = C(x_2)$.

  Per mantenere i due messaggi diversi possono succede due cose:
  - un messaggio è prefisso dell'altro: se $x_1$ è formato da $x_2$ e altri $m$ caratteri, vuol dire che i restanti $m$ caratteri di $x_1$ devono essere codificati con la parola vuota, che per definizione di codice non è possibile, e soprattutto la parola vuota sarebbe prefissa di ogni altra parola di codice, quindi il codice $c$ non è istantaneo;
  - esiste almeno una posizione in cui i due messaggi differiscono: sia $i$ la prima posizione dove i due messaggi differiscono, ovvero $x_1[i] eq.not x_2[i]$ e $x_1[j] = x_2[j]$ per $1 lt.eq j lt.eq i - 1$, ma allora $c(x_1[i]) eq.not c(x_2[i])$ e $c(x_1[j]) = c(x_2[j])$ perché $c$ è non singolare, quindi per avere la stessa codifica devo tornare al punto $1$ e avere $x_1$ come prefisso di $x_2$ (o viceversa), ma, quindi otteniamo che $c$ non è istantaneo.

  Ma allora il codice non è istantaneo.
]
