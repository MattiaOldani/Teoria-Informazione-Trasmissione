#import "alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


= Lezione 14 [03/12]

== Introduzione ai codici

Il *rumore* è quel merdone che distorce le informazioni che passano sul canale. Noi vogliamo usare dei codici che rilevino gli errori e, non sarebbe male, che li correggano anche.

Noi considereremo il *rumore bianco*. Esso ha le seguenti due proprietà:
- il rumore arriva in maniera indipendente sui bit, cioè la probabilità di avere un bit errato non dipende dalle probabilità di trovare errori nelle altre posizioni. Nella realtà la situazione è praticamente opposta: gli errori in una zona mi indicano grande probabilità di averne altri nelle vicinanze;
- la probabilità di avere un bit errato è fissata a $p$ e questa quantità è uguale per tutte le posizioni che stiamo considerando. Nella realtà, ovviamente, è totalmente diverso: la probabilità di errore potrebbe variare nel tempo.

#example()[
  Vogliamo trasmettere un messaggio di $n$ bit, se $p$ è la probabilità di avere un errore, quanto vale la probabilità di spedire $n$ bit e non avere nessun errore?

  La probabilità di non avere un bit errato è $(1-p)$, iterato per $n$ posizioni ci dà $ P(0 "errori") = (1-p)^n . $
]

#example()[
  Vogliamo trasmettere un messaggio di $n$ bit, se $p$ è la probabilità di avere un errore, quanto vale la probabilità di spedire $n$ bit e avere esattamente un errore?

  La probabilità di avere il primo bit errato e i restanti bit corretti è $p (1-p)^(n-1)$, iterato per $binom(n,1) = n$ visto che l'errore può capitare in ogni posizione, ci dà $ P(1 "errore") = n p (1-p)^(n-1) . $
]

#example()[
  Vogliamo trasmettere un messaggio di $n$ bit, se $p$ è la probabilità di avere un errore, quanto vale la probabilità di spedire $n$ bit e avere al massimo $l$ errori?

  Dobbiamo sommare le probabilità di avere $0$ errori, $1$ errore, eccetera, fino a $l$ errori, ovvero $ P(max l "errori") &= P(0 "errori") + P(1 "errori") + dots + P(l "errori") = \ &= binom(n,0) p^0 (1-p)^n + binom(n,1) p^1 (1-p)^(n-1) + dots + binom(n,l) p^l (1-p)^(n-l) = \ &= sum_(i=0)^l binom(n,i) p^i (1-p)^(n-i) . $
]

#example()[
  Vogliamo trasmettere un messaggio di $n$ bit, se $p$ è la probabilità di avere un errore, quanto vale la probabilità di spedire $n$ bit e avere un numero pari di errori?

  Dobbiamo sommare le probabilità di avere $0$ errori, $2$ errori, eccetera, fino al massimo numero pari di errori, ovvero $ P(2k "errori") &= P(0 "errori") + P(2 "errori") + dots + P(2k "errori") = \ &= binom(n,0) p^0 (1-p)^n + binom(n,2) p^2 (1-p)^(n-2) + dots + binom(n,2k) p^(2k) (1-p)^(n-2k) = \ &= sum_(i=0)^(floor(n/2)) binom(n,2i) p^(2i) (1-p)^(n - 2i) . $
]

=== Bit di parità

Vediamo il buon vecchio *bit di parità*. Questo bit si calcola sommando tutti i bit del numero e poi $mod 2$. In poche parole, date $n-1$ cifre, il bit di parità lo calcoliamo come $ x_n = sum_(i=1)^(n-1) x_i mod 2 . $

Come facciamo a capire se abbiamo un problema sul canale e dobbiamo rispedire il messaggio? Prendiamo i dati ricevuti, calcoliamo il bit di parità e vediamo se otteniamo $0$.

Questo codice viene usato per rilevare l'errore, ma non per correggerlo. Inoltre, se l'errore si spalma su un numero pari di bit, il bit di parità non riesce nemmeno a rilevare l'errore.

#example()[
  Vogliamo trasmettere un messaggio di $n-1$ bit, se $p$ è la probabilità di avere un errore, quanto vale la probabilità di spedire $n-1$ bit più un bit di parità e non riuscire a riconoscere gli errori?

  Dobbiamo sommare le probabilità di avere $2$ errori, $4$ errori, eccetera, fino al massimo numero pari di errori, ovvero $ P("non riconosce") &= P(2 "errori") + dots + P(2k "errori") = \ &= binom(n,2) p^2 (1-p)^(n-2) + dots + binom(n,2k) p^(2k) (1-p)^(n-2k) = \ &= sum_(i=1)^(floor(n/2)) binom(n,2i) p^(2i) (1-p)^(n - 2i) . $
]

=== Codice ASCII

Vediamo il *codice ASCII*. Eh si fratello, il codice ASCII è un codice.

Come funziona questo codice? Esso utilizza $7$ bit per codificare un carattere e un bit di parità, posto in testa della codifica,

=== Burst di errori

Vediamo un *burst* di errori, ovvero una zona di errori definita da un inizio e una fine. Faremo il controllo usando il bit di parità.

#example()[
  Prendiamo il messaggio "Hello NCTU". Aggiungiamo un *carattere di parità*, non più un bit, che mettiamo alla fine. Questo carattere fa check di correttezza. Divido il messaggio in caratteri, scrivo in binario e poi calcolo i singoli bit di parità facendo il controllo di parità sulla colonna.

  Otteniamo $ mat(H space, 0,1,0,0,1,0,0,0; e space, 0,1,1,0,0,1,0,1; l space, 0,1,1,0,1,1,0,0; l space, 0,1,1,0,1,1,0,0; o space, 0,1,1,0,1,1,1,1;space space, 0,0,1,0,0,0,0,0;N space, 0,1,0,0,1,1,1,0;C space, 0,1,0,0,0,0,1,1;T space, 0,1,0,1,0,1,0,0;U space, 0,1,0,1,0,1,0,1; square.filled space, 0,1,1,0,1,1,1,0) $

  La codifica dell'ultima lettera è $n$.

  Se so che l'errore inizia nelle ultime due colonne della prima riga e finisce nella prime colonne della seconda riga, potrei riuscire a sistemare. Il problema arriva se il burst copre più righe, perché più errori potrebbero annullarsi e quindi non venire rilevati.
]

=== Somma pesata

Sto spedendo un messaggio di $n$ caratteri. I *codici a somma pesata* richiedono di calcolare la *somma* e la *somma della somma*.

#example()[
  Vogliamo spedire il messaggio $w x y z$. Calcoliamo somma e somma della somma.

  La *somma* si calcola come valore della cifra corrente più somma precedente. La *somma della somma* si calcola come somma corrente più somma della somma precedente.

  Otteniamo quindi $ mat("C", "somma", "somma della somma"; w, w, w; x, w + x, 2w + x; y, w + x + y, 3w + 2x + y; z, w + x + y + z,4w + 3x + 2y + z) $

  Il *carattere di controllo* aggiunto alla fine deve far si che la sua somma di somma sia congrua a $0$ modulo numero dei caratteri.
]

#example()[
  Supponiamo di avere $37$ lettere che codifico con:
  - $[0,9]$ per i numeri da 0 a 9:
  - $[10,35]$ per le lettere maiuscole;
  - $36$ per lo spazio.

  Il messaggio da spedire sul canale è "$"3b 8"$". La tabella è: $ mat(C, "valore", "somma", "somma della somma"; 3, 3, 3, 3; B, 11, 14, 17; "spazio", 36, 50, 67; 8, 8, 58, 125; "check", ?, 58 + ?, 183 + ?) $

  Il numero da aggiungere è $2$, codificato con $2$, quindi la stringa che spediamo sul canale è "$"3b 82"$" con l'ultimo carattere che è di controllo.

  Cosa succede se mi arriva la stringa "$"3b82"$"? Calcolo: $ mat(C, "valore", "somma", "somma della somma"; 3, 3, 3, 3; B, 11, 14, 17; 8, 8, 22, 39; 2, 2, 24, 63) $

  Il carattere di controllo dovrebbe essere $D$ perché $63 + 11 equiv 0 mod 37$, ma noi abbiamo ottenuto $2$ quindi richiederemo la stringa.
]

=== Codice ISBN

Il *codice ISBN* (_International Standard Book Nigga_) è un codice di controllo usato per identificare in maniera univoca un libro. Di solito ha due formati, a $10$ o $13$ cifre (_a volte entrambi assieme_).

Consideriamo il codice a $10$ cifre, che usa le somme pesate. Esso è definito da:
- prima cifra che identifica il country ID;
- seconda cifra e terza cifra che identificano il publisher ID;
- cifre dalla quarta alla nona che identificano book number;
- decima cifra che è la cifra di controllo, il *check digit*.

L'alfabeto usato contiene $11$ caratteri (_perché $11$ è primo e va bene con i moduli_): i numeri da $0$ a $9$ sono codificati con loro stessi, mentre il decimo carattere è la $Chi$.

=== Codice UPC

Il *codice UPC* (_Universal Product Code_) è il comunissimo *codice a barre*. Anche lui è un codice pesato. Ogni codice UPC è diviso in $3$ blocchi:
- *manifacturer ID* (_chi ha prodotto l'oggetto_) di $6$ cifre;
- *numero dell'oggetto* di $5$ cifre;
- *check digit*.

Indicizzando i caratteri da $1$, il check digit si calcola come $ 3 sum_(i "dispari") x_i + sum_(i "pari") x_i mod 10 . $

Quando ricevo un codice a barre, controllo se questa somma pesata modulo $10$ è uguale a $0$.

== Introduzione matematica

Partiamo partiamo dai numeri interi $ZZ$: esso è un *insieme infinito*, ma che non ci piace tanto perché la nostra macchina fa i conti con i numeri finiti.

Trasformiamo $ZZ$ nell'insieme $ZZ_n$ con la relazione di equivalenza della *congruenza*, che contiene i numeri interi modulo $n$ e quindi è un *insieme finito*.

Lavorando su $n$ non ci va tanto bene perché in generale siamo su un *anello*, nel quale non tutti gli elementi hanno inverso. Questo è un problema, non posso fare le divisioni non avendo l'inverso, che è roba da pazzi se pensiamo di non poter dividere per $2$ in un calcolatore. Passiamo quindi a $ZZ_p$, che è definito in modo analogo a $ZZ_n$ solo che $p$ è un numero primo e quindi questo insieme è un *campo*, che mi garantisce la presenza di un inverso per ogni elemento dell'insieme.

Un calcolatore lavora con i byte, quindi ho $2^8$ possibili valori, ma questo è ancora un problema perché $2^8$ non è primo. Risolviamo scrivendo il byte come un *polinomio* a coefficienti in $ZZ_p$, creando l'insieme $ZZ_p [x]$.

Siamo nella stessa situazione di prima: sono ancora con un insieme infinito. Infatti, il grado di questi polinomi può anche essere infinito, quindi diamo un tetto al grado facendo il modulo con un polinomio, creando l'insieme finito $ZZ_p [x] mod m(x)$.

Infine, ultimo problema che risolviamo, è quello dell'anello. Stiamo quozientando su un polinomio random, quindi non tutti gli elementi siamo sicuri abbiano un inverso. Per risolvere quest'ultimo problema cambiamo $m(x)$ in $p(x)$ *polinomio irriducibile* sul campo, e otteniamo l'insieme finale $ZZ_p [x] mod p(x)$.

Quest'ultimo insieme è esattamente il *campo di Galois*. Un campo di Galois $GF(p^m)$ è un campo che contiene un numero di elementi uguale a $p^m$ e ognuno di questi è un polinomio che grado massimo $m-1$ a coefficienti in $ZZ_p$. Il valore $m$ indice anche il grado di $p(x)$.

#example()[
  Sia $GF(4) = GF(2^2)$ il campo di Galois dei polinomi di grado massimo $1$ con coefficienti in $ZZ_2$. Troviamo un polinomio irriducibile di grado $2$ per questo campo.

  Abbiamo diverse scelte:
  - $x^2$: fattorizzabile come $x dot x$, non va bene;
  - $x^2 + x$: fattorizzabile come $x dot (x+1)$, non va bene;
  - $x^2 + 1$: fattorizzabile come $(x+1) dot (x - 1) = (x + 1)^2 = (x - 1)^2$, non va bene;
  - $x^2 + x + 1$: irriducibile.

  Imponiamo, come dei dittatori, che questo polinomio irriducibile abbia invece una radice $alpha$. Con questa operazione troviamo l'*estensione algebrica*. Stiamo dicendo che $alpha^2 + alpha + 1 = 0$. Ma sono in $ZZ_2$ quindi $ alpha^2 = - alpha - 1 arrow.long alpha^2 = alpha + 1 . $ Questa estensione la chiamo $F[alpha]$.

  Con queste informazioni possiamo costruire le tabelline della somma e del prodotto.

  Per il prodotto ho $ mat(dot,0,1,alpha,alpha+1; 0,0,0,0,0; 1,0,1,alpha,alpha+1; alpha,0,alpha,alpha+1,1; alpha+1,0,alpha+1,1,alpha; augment: #(vline: 1, hline: 1)) $

  La matrice qua è *simmetrica*.

  Per la somma ho $ mat(+,0,1,alpha,alpha+1; 0,0,1,alpha,alpha+1; 1,1,0,alpha+1,alpha; alpha,alpha,alpha+1,0,1; alpha+1,alpha+1,alpha,1,0; augment: #(vline: 1, hline: 1)) $

  Anche in questo caso, la matrice è *simmetrica*.
]
