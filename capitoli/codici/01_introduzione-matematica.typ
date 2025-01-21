// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Introduzione matematica

Partiamo dai numeri interi $ZZ$: esso è un *insieme infinito*, ma che non ci piace tanto perché la nostra macchina fa i conti con i numeri finiti.

Trasformiamo $ZZ$ nell'insieme $ZZ_n$ con la relazione di equivalenza della *congruenza*, che contiene i numeri interi modulo $n$ e quindi è un *insieme finito*.

Lavorando su $n$ non ci va tanto bene perché in generale siamo su un *anello*, nel quale non tutti gli elementi hanno inverso. Questo è un problema, non posso fare le divisioni non avendo l'inverso, che è roba da pazzi se pensiamo di non poter dividere per $2$ in un calcolatore. Passiamo quindi a $ZZ_p$, che è definito in modo analogo a $ZZ_n$ solo che $p$ è un numero primo e quindi questo insieme è un *campo*, che mi garantisce la presenza di un inverso per ogni elemento dell'insieme.

Un calcolatore lavora con i byte, quindi ho $2^8$ possibili valori, ma questo è ancora un problema perché $2^8$ non è primo. Risolviamo scrivendo il byte come un *polinomio* a coefficienti in $ZZ_p$, creando l'insieme $ZZ_p [x]$.

Siamo nella stessa situazione di prima: sono ancora con un insieme infinito. Infatti, il grado di questi polinomi può anche essere infinito, quindi diamo un tetto al grado facendo il modulo con un polinomio, creando l'insieme finito $ZZ_p [x] mod m(x)$.

Infine, ultimo problema che risolviamo, è quello dell'anello. Stiamo quozientando su un polinomio random, quindi non tutti gli elementi siamo sicuri abbiano un inverso. Per risolvere quest'ultimo problema cambiamo $m(x)$ in $p(x)$ *polinomio irriducibile* sul campo, e otteniamo l'insieme finale $ZZ_p [x] mod p(x)$.

Quest'ultimo insieme è esattamente il *campo di Galois*. Un campo di Galois $GF(p^m)$ è un campo che contiene un numero di elementi uguale a $p^m$ e ognuno di questi è un polinomio che grado massimo $m-1$ a coefficienti in $ZZ_p$. Il valore $m$ indice anche il grado di $p(x)$.
