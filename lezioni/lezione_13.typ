// Setup

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "lemma"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "corollary"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#import emoji: square, suit

// Appunti

= Lezione 13

== Codici di rilevazione errori

=== ISBN-10

==== Definizione

Il codice *ISBN-10* è un codice univoco di identificazione dei libri (esiste anche _ISBN-13_). L'alfabeto usato è $ Sigma = {0,1,2,3,4,5,6,7,8,9,x} , $ con $x = 10$. Questo codice è un _codice pesato_.

==== Esempio

Il codice $0\-471\-24195\-4$ è un codice ISBN-10, ed è tale che:
- $0$ è la *nazione*, in questo caso paese anglofono;
- $471$ è l'*id-publisher*;
- $24195$ è il *book-number*;
- $4$ è l'*error detection*.

// Zio non si capisce niente
Il codice $0\-52\-18\-4868\-7$ è anch'esso un codice ISBN-10, con $18\-4868$ uguale al publisher id. Per controllare se è corretto usiamo la procedura dei codici pesati.

#align(center)[
  #table(
    align: center + horizon,
    columns: (22%, 39%, 39%),
    inset: 10pt,

    [*MESSAGGIO*], [$bold(sum)$], [$bold(sum sum)$],

    [$5$], [$5$], [$5$],
    [$2$], [$7$], [$12$],
    [$1$], [$8$], [$20$],
    [$8$], [$16$], [$36$],
    [$4$], [$20$], [$56$],
    [$8$], [$28$], [$84$],
    [$6$], [$34$], [$118$],
    [$8$], [$42$], [$160$],
    [$7$], [$49$], [$209$],
  )
]

Il codice è corretto se e solo se $ 209 equiv_11 0 , $ e questo vale, quindi il codice è corretto.

=== UPC

==== Definizione

Il codice *UPC* (_Universal Product Code_) è il comune codice a barre. È un codice di parità a 12 cifre.

==== Esempio

Un codice UPC è nella forma $ underbracket(036000, "ID produttore") quad underbracket(29145, "ID prodotto") quad underbracket(2, "checksum") . $

Il codice è corretto se:
- sommiamo le cifre dispari e le moltiplichiamo per $3$;
- sommiamo le cifre pari;
- la somma di queste due quantità deve essere $0$ modulo $12$.

Si conta da sinistra a partire da $1$.

Controlliamo l'esempio: $ 3(0 + 6 + 0 + 2 + 1 + 5) + (3 + 0 + 0 + 9 + 4 + 2) = 42 + 18 = 60 equiv_11 0 . $

== Codici di rilevazione e correzione errori

Fin'ora abbiamo visto solo codici che rilevano gli errori ma non li correggono. Proviamo a creare un codice che corregga gli errori di trasmissione.

Sia $(x_1,x_2,x_3)$ messaggio da spedire. Aggiungiamo $(x_4,x_5,x_6)$ *bit di controllo* definiti come $ cases(x_4 = x_1 + x_2, x_5 = x_1 + x_3, x_6 = x_2 + x_3) quad . $

Spediamo quindi $(x_1,x_2,x_3,x_4,x_5,x_6)$ nel canale.

Lato ricevente deve valere $ cases(y_4 = y_1 + y_2, y_5 = y_1 + y_3, y_6 = y_2 + y_3) quad . $

Cosa succede:
- se sbaglio $x_1$ vengono errati $y_4$ e $y_5$;
- se sbaglio $x_2$ vengono errati $y_4$ e $y_6$;
- se sbaglio $x_3$ vengono errati $y_5$ e $y_6$;
- se sbaglio $x_4$ vengono errati $y_4$;
- se sbaglio $x_5$ vengono errati $y_5$;
- se sbaglio $x_6$ vengono errati $y_6$.

Questo codice riesce a correggere un errore solo, non di più. Riesce a rilevare il doppio errore ma non lo riesce a correggere.

Infatti, cosa succede:
- se sbaglio $x_1$ e $x_2$ vengono errati $y_5$ e $y_6$;
- se sbaglio $x_1$ e $x_3$ vengono errati $y_4$ e $y_6$;
- se sbaglio $x_1$ e $x_4$ vengono errati $y_5$;
- se sbaglio $x_1$ e $x_5$ vengono errati $y_4$;
- se sbaglio $x_1$ e $x_6$ vengono errati $y_4$, $y_5$ e $y_6$.

=== Codice a ripetizione tripla

// Scritto da cani, fratello non si capisce niente

Facciamo una copia del bit iniziale, mentre il ricevitore mantiene il bit che compare più volte.

// Esercizi che non voglio fare

=== Codici di tipo (n,k)

Sia $C$ un codice di tipo $(n,k)$, ovvero un codice che mappa una stringa $s$ di $k$ bit in una stringa binaria di $n$ bit.

$C$ è lineare se esistono le matrici $G_(k times n)$ e $H_((n-k) times n)$ tali che $ x = (x_1, dots, x_n) = (s_1, dots, s_k) G $ e $ H x^T = 0^T , $ dove $x$ è la parola del codice e $s$ il messaggio binario associato.

Il *rate* $ R = n / k $ indica il numero di bit inviati per bit di informazione.

==== Codice di Hamming

Il *codice di Hamming* è un codice di tipo $(7,4)$ con rate $R = 1.75$. Ha le stesse caratteristiche del codice a rilevazione tripla, ma usa meno bit.

Abbiamo quindi $(underbracket(p_1\,p_2\,p_3, "controllo"), underbracket(s_1\,s_2\,s_3\,s_4, "informazione")) . $

I _bit di controllo_ sono calcolati come $ cases(p_1 = s_1 + s_3 + s_4, p_2 = s_1 + s_2 + s_3, p_3 = s_2 + s_3 + s_4) quad . $

In forma matriciale abbiamo $ H = mat(p_1,p_2,p_3,s_1,s_2,s_3,s_4; 1,0,0,1,0,1,1; 0,1,0,1,1,1,0; 0,0,1,0,1,1,1) $ e la matrice generatrice $ G = mat(,p_1,p_2,p_3; s_1,1,1,0,1,0,0,0; s_2,0,1,1,0,1,0,0; s_3,1,1,1,0,0,1,0; s_4,1,0,1,0,0,0,1) quad . $

Ricevuto un messaggio $p_1 p_2 p_3$, il vettore risultante (detto *sindrome*) deve essere composto da soli $0$. Se nella $i$-esima posizione c'è un $1$ allora $p_i$ è errato. 

Per capire il bit errato usiamo il digramma di *McEliece*.

// Aggiungi foto

// Aggiungi spiegazione, lo zio non sa scrivere
