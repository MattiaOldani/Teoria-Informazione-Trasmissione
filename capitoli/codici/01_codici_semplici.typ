// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codici semplici

== Introduzione

Il *rumore* è l'entità che distorce le informazioni che passano sul canale. Noi vogliamo usare dei codici che rilevino gli errori e, non sarebbe male, che li correggano anche.

Noi considereremo il *rumore bianco*. Esso ha le seguenti due proprietà:
- il rumore arriva in maniera indipendente sui bit, cioè la probabilità di avere un bit errato non dipende dalle probabilità di trovare errori nelle altre posizioni. Nella realtà la situazione è opposta: gli errori in una zona mi indicano grande probabilità di averne altri nelle vicinanze;
- la probabilità di avere un bit errato è fissata a $p$ e questa quantità è uguale per tutte le posizioni che stiamo considerando. Nella realtà, ovviamente, è totalmente diverso: la probabilità di errore potrebbe variare nel tempo.

== Bit di parità

Vediamo il buon vecchio *bit di parità*. Questo bit si calcola sommando tutti i bit del numero e la si fa $mod 2$. In poche parole, date $n-1$ cifre, il bit di parità lo calcoliamo come $ x_n = sum_(i=1)^(n-1) x_i mod 2 . $

Come facciamo a capire se abbiamo un problema sul canale e dobbiamo rispedire il messaggio? Prendiamo i dati ricevuti, calcoliamo il bit di parità e vediamo se otteniamo $0$.

Questo codice viene usato per rilevare l'errore, ma non per correggerlo. Inoltre, se l'errore si spalma su un numero pari di bit, il bit di parità non riesce nemmeno a rilevare l'errore.

== Codice ASCII

Vediamo il *codice ASCII*. Eh si fratello, il codice ASCII è un codice, assurdo.

Come funziona questo codice? Esso utilizza $7$ bit per codificare un carattere e un bit di parità, posto in testa della codifica, molto facile.

== Burst di errori

Vediamo un *burst* di errori, ovvero una zona di errori definita da un inizio e una fine. Faremo il controllo usando il bit di parità.

#example()[
  Prendiamo il messaggio "Hello NCTU". Aggiungiamo un *carattere di parità*, non più un bit, che mettiamo alla fine. Questo carattere fa check di correttezza. Divido il messaggio in caratteri, scrivo in binario e poi calcolo i singoli bit di parità facendo il controllo di parità sulla colonna.

  Otteniamo $ mat(H space, 0,1,0,0,1,0,0,0; e space, 0,1,1,0,0,1,0,1; l space, 0,1,1,0,1,1,0,0; l space, 0,1,1,0,1,1,0,0; o space, 0,1,1,0,1,1,1,1;space space, 0,0,1,0,0,0,0,0;N space, 0,1,0,0,1,1,1,0;C space, 0,1,0,0,0,0,1,1;T space, 0,1,0,1,0,1,0,0;U space, 0,1,0,1,0,1,0,1; square.filled space, 0,1,1,0,1,1,1,0) $

  La codifica dell'ultima lettera è $n$.

  Se so che l'errore inizia nelle ultime due colonne della prima riga e finisce nella prime colonne della seconda riga, potrei riuscire a sistemare. Il problema arriva se il burst copre più righe, perché più errori potrebbero annullarsi e quindi non venire rilevati.
]

== Somma pesata

Sto spedendo un messaggio di $n$ caratteri. I *codici a somma pesata* richiedono di calcolare la *somma* e la *somma della somma*, due valori che serviranno per fare i controlli lato ricevente.

Facciamo l'esempio con un messaggio di $4$ caratteri. Vogliamo spedire il messaggio $"wxyz"$. Calcoliamo somma e somma della somma.

La *somma* si calcola come valore della cifra corrente più la somma precedente. La *somma della somma* si calcola come somma corrente più la somma della somma precedente.

#set math.mat(delim: "[")

Otteniamo quindi $ mat("C", "somma", "somma della somma"; w, w, w; x, w + x, 2w + x; y, w + x + y, 3w + 2x + y; z, w + x + y + z,4w + 3x + 2y + z) $

Il *carattere di controllo* aggiunto alla fine deve far si che la sua somma di somma sia congrua a $0$ modulo numero dei caratteri.

#example()[
  Supponiamo di avere $37$ lettere che codifico con:
  - $[0,9]$ per i numeri da $0$ a $9$:
  - $[10,35]$ per le lettere maiuscole;
  - $[36]$ per lo spazio.

  Il messaggio da spedire sul canale è "$"3b 8"$". La tabella è: $ mat(C, "valore", "somma", "somma della somma"; 3, 3, 3, 3; B, 11, 14, 17; , 36, 50, 67; 8, 8, 58, 125; "check", ?, 58 + ?, 183 + ?) $

  Il numero da aggiungere è $2$, codificato con $2$, quindi la stringa che spediamo sul canale è "$"3b 82"$" con l'ultimo carattere che è di controllo.

  Cosa succede se mi arriva la stringa "$"3b82"$"? Calcolo: $ mat(C, "valore", "somma", "somma della somma"; 3, 3, 3, 3; B, 11, 14, 17; 8, 8, 22, 39; 2, 2, 24, 63) $

  Il carattere di controllo dovrebbe essere $B$ perché $63 + 11 equiv 0 mod 37$, ma noi abbiamo ottenuto $2$ quindi richiederemo la stringa.
]

== Codice ISBN

Il *codice ISBN* (_International Standard Book Nigga_) è un codice di controllo usato per identificare in maniera univoca un libro. Di solito ha due formati, a $10$ o $13$ cifre (_a volte entrambi assieme_).

Consideriamo il codice a $10$ cifre, che usa le somme pesate. Esso è definito da:
- prima cifra che identifica il *country ID*;
- seconda cifra e terza cifra che identificano il *publisher ID*;
- cifre dalla quarta alla nona che identificano *book number*;
- decima cifra che è la cifra di controllo, il *check digit*.

L'alfabeto usato contiene $11$ caratteri (_perché $11$ è primo e va bene con i moduli_): i numeri da $0$ a $9$ sono codificati con loro stessi, mentre il decimo carattere è la $Chi$.

== Codice UPC

Il *codice UPC* (_Universal Product Code_) è il comunissimo *codice a barre*. Anche lui è un codice pesato. Ogni codice UPC è diviso in $3$ blocchi:
- *manifacturer ID* (_chi ha prodotto l'oggetto_) di $6$ cifre;
- *numero dell'oggetto* di $5$ cifre;
- *check digit*.

Indicizzando i caratteri da $1$, il check digit si calcola come $ 3 sum_(i "dispari") x_i + sum_(i "pari") x_i mod 10 . $

Quando ricevo un codice a barre, controllo se questa somma pesata modulo $10$ è uguale a $0$.
