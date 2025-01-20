// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codici lineari

Sia $C$ un codice $(n,k)$ che mappa $k$ bit di informazione della parola $s$ in $n$ bit della parola $x$. Diciamo che $C$ è un *codice lineare* se esiste una *matrice generatrice* $G$ di dimensione $k times n$ e una *matrice di parità* $H$ di dimensione $n-k times n$ tale che $ mat(x_1, dots, x_n) = mat(s_1, dots, s_k) G $ e il controllo di appartenenza sulle parole del codice avviene con $ H mat(x_1, dots, x_n)^T = underline(0)^T . $

Il codice di Hamming e il codice a ripetizione tripla sono codici lineari.

== Definizione rigorosa

Dato $A$ un campo finito, definiamo $M_n$ lo *spazio dei messaggi* di ordine $n$ su $A$, ovvero lo spazio lineare $ M_n = {x = (x_1, dots, x_n) bar.v x_i in A} $ nel quale valgono due regole:
+ presi $x, x' in M_n$ allora $x + x' = (x_1 + x'_1, dots, x_n + x'_n) in M_n$;
+ preso $x in M_n$ e preso $s in A$ allora $s dot x = (s dot x_1, dots, s dot x_n) in M_n$.

Lo spazio $M_n$ ha dimensione $n$ e ha cardinalità $2^n$ (_siamo in binario_).

Un *codice* $P$ è un sottospazio di $M_n$ di dimensione $k$ e di cardinalità $2^k$ (_siamo sempre in binario_).

Fissata una base $ cal(B) = {e_1, dots, e_k} $ per il codice $P$, per definizione di base ogni elemento $x$ di $P$ potrà essere scritto come combinazione lineare dei vettori della base, ovvero $ exists! u in ZZ_2^k bar.v x = u mat(e_1; dots.v; e_k) . $

Il vettore formato dagli elementi della base $cal(B)$ lo possiamo vedere come la *matrice generatrice* che abbiamo visto a inizio capitolo. Quello che abbiamo definito ora è un codice di tipo $(n,k)$.

Un *codice lineare* è definito come l'insieme delle soluzioni $x = (x_1, dots, x_n)$ del sistema lineare di $n-k$ equazioni e $n$ incognite $ H x = underline(0) . $

Dato $x in P$ spedito sul canale e dato $y in M_n$ valore ricevuto, chiamiamo *scheda d'errore* $e$ il polinomio/vettore differenza tra quello ricevuto e quello inviato, ovvero $ e = y - x . $

Il *resto* della divisione tra la parola ricevuta $y(x)$ e il generatore $g(x)$ è detto *sindrome*, e si indica con $r(x)$. Sembra un concetto nuovo, ma l'abbiamo già visto, senza nome, nel codice di Hamming: se $H x^T eq.not underline(0)^T$ allora il risultato è una colonna di $H$ che indica il bit errato. Questa colonna è esattamente la sindrome che abbiamo appena definito.

Abbiamo citato più volte $H$ ma non l'abbiamo ancora definita. Facciamolo allora.

Sia $H$ la *matrice di parità* di $P$, formata dai coefficienti del sistema lineare $(n-k) times n$ che definisce il codice $P$, ovvero l'insieme di regole che devono essere verificate per essere dentro $P$. Notiamo come la matrice $H$ non sia unica, perché posso scambiare tra loro le righe, ma anche sommarle e tanto altro, ma sempre nei limiti definiti dal buon vecchio Gauss.

Abbiamo citato anche $G$, ma ancora non l'abbiamo definita pienamente. Faccio anche questo ora.

Definiamo $G$ *matrice generatrice* di $P$ come la matrice di dimensione $k times n$ le cui righe sono i $k$ vettori di una base $cal(B)$ di $P$. Come abbiamo detto prima, allora $ forall x in P quad exists! u in ZZ_2^k bar.v x = u G . $

#set math.mat(delim: "[")

Una matrice $G$ è in *forma canonica* se è nella forma $ G_(k times n) = mat(I_(k times k), bar.v, D_(k times (n - k))) . $

Ogni matrice $G$ può essere messa in forma canonica usando Gauss o metodi simili.

Esiste una sorte di relazione tra le matrici $G$ e $H$? Ebbene si.

Data $G$ in forma canonica, la matrice $H$ associata è $ H_((n-k) times n) = mat(-D_((n-k) times k)^T, bar.v, I_((n - k) times (n - k))) . $
