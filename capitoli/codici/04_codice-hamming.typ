// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codice di Hamming

== Definizione

Il buon *Richard Hamming* lavorava ai Bell Labs negli anni $'40$. Come detto nell'introduzione, si era rotto i maroni di aspettare il lunedì per vedere il fallimento dei suoi job mandati in esecuzione sulle macchine che aveva in laboratorio, quindi ha cercato di creare un codice che riconoscesse l'errore e lo sistemasse, così da evitare altri sbattimenti. Hamming era un matematico nell'Illinois, sapeva come fare tutto ciò, e infatti nel $1950$ pubblica il suo lavoro.

Il *codice di Hamming* è un codice di tipo $(7,4)$. Quello che spediamo sul canale è il vettore $ (p_1, p_2, p_3 bar.v s_1, s_2, s_3, s_4) $ con $s$ vettore che contiene gli $s_i$ e che caratterizza quello che vogliamo spedire _"nudo e crudo"_ sul canale mentre i $p_i$ sono *bit di controllo*.

Il codice di Hamming ha come vincoli le seguenti equazioni lineari: $ cases(p_1 = s_1 + s_3 + s_4, p_2 = s_1 + s_2 + s_3, p_3 = s_2 + s_3 + s_4) . $ Possiamo calcolare la matrice $H$ da questi vincoli come la matrice $ H = mat(1,0,0,1,0,1,1; 0,1,0,1,1,1,0; 0,0,1,0,1,1,1) . $

Nel $1985$ un ingegnere ha proposto una spiegazione molto semplice di quello che Hamming aveva pensato. Ho a disposizione tre sfere, che sono le *sfere di influenza* dei bit di controllo. Con sfera di influenza si intende l'insieme di bit che sono coperti da un certo bit di controllo. Le tre sfere di influenza formano il *grafico di Mc-Eliece*. Vediamolo con un esempio.

#v(12pt)

#figure(image("assets/09_mc-eliece.svg", width: 50%))

#v(12pt)

#example()[
  Abbiamo ricevuto la parola $x = 011 bar.v 1100$ dal canale, è corretta?

  Popoliamo il grafico di Mc-Eliece:
  - per $p_0 = 0$ abbiamo $1 + 0 + 0$, quindi abbiamo un errore;
  - per $p_1 = 1$ abbiamo $1 + 1 + 0$, quindi abbiamo un errore;
  - per $p_2 = 1$ abbiamo $1 + 0 + 0$, quindi questo va bene.

  Prendiamo i due insiemi che sono errati, quindi $p_0$ e $p_1$. Di questi insiemi prendiamo i bit che stanno nelle intersezioni, quindi $s_1$ e $s_3$. Dobbiamo capire quale dei due correggere:
  - se $s_3$ cambia sistemiamo i due insiemi ma rendiamo sbagliato l'insieme $p_2$: infatti, $s_3$ è già corretto come bit;
  - visto questo, dobbiamo sistemare $s_1$.
]

#example()[
  Abbiamo ricevuto la parola $x = 111 bar.v 0100$ dal canale, è corretta?

  Popoliamo il grafico di Mc-Eliece:
  - per $p_0 = 1$ abbiamo $0 + 0 + 0$, quindi abbiamo un errore;
  - per $p_1 = 1$ abbiamo $0 + 1 + 0$, quindi questo va bene;
  - per $p_2 = 1$ abbiamo $1 + 0 + 0$, quindi questo va bene.

  In questo caso abbiamo un solo insieme errato. Quando succede questo, dobbiamo modificare il bit di controllo: infatti, se modificassimo uno dei tre bit coperti da $p_0$ renderemmo sbagliati gli altri insiemi.
]

Come vediamo, il codice di Hamming è molto potente perché riesce a rilevare e correggere anche i propri bit di controllo. Purtroppo, questo codice funziona se assumiamo di avere al più un errore.

Infine, vediamo una bella proprietà del codice di Hamming. Dato $x$ letto dal canale con un errore, se calcoliamo $H x$ otteniamo una colonna di $H$ che mi indica quale era il bit errato.

Infatti, se definiamo $x' = x + e$, con $e$ vettore con un $1$ nella posizione dell'errore, e calcoliamo $ H (x')^T = H x^T + H e^T = 0^T + H e^T $ otteniamo la colonna che identifica l'errore.

== Distanza di Hamming

La *distanza di Hamming* tra due parole di codice $x_0$ e $x_1$ è il numero di bit nel quale differiscono nelle stesse posizioni.

Usiamo questa definizione della distanza di Hamming perché la distanza euclidea in $ZZ_2$ non funziona: infatti, notiamo che $ 00,11 arrow.long.double sqrt((0-1)^2 + (0-1)^2) = sqrt(2) = 0 quad (????) quad . $

Useremo la distanza di Hamming per capire quanti errori un codice può rilevare e correggere.

#theorem([Non so se è un teorema])[
  Sia $C$ un codice correttore di tipo $(n,k)$ e sia $d$ la minima distanza di Hamming che esiste tra le parole di $C$.

  Allora $C$ rileva $ d-1 $ errori e ne corregge $ t = floor(frac(d-1,2)) . $
]

Possiamo vedere queste due quantità come due bolle su un asse cartesiano: su di esso poniamo le due parole di codice $x_0,x_1$ e le due bolle definite dalle due quantità precedenti. Non ho voglia di disegnare, mi dispiace tanto.

Non posso andare oltre $x_0$ (_partendo dall'altra parola_) perché $x_0$ è una parola di codice.

== Rilevazione e correzione errori

La distanza di Hamming è necessaria nella definizione del numero di errori che possono essere rilevati e corretti da un codice.

Un codice $P$ *rileva* $z$ errori se $ forall x in P quad forall x' in M_n slash P arrow.long.double 0 < hamming(x\,x') lt.eq z . $

Un codice $P$ *corregge* $t$ errori se $ forall x,y in P bar.v x eq.not y quad and quad forall x' in M_n slash P arrow.long.double hamming(x\,x') lt.eq t and hamming(x'\,y) > t . $

#theorem()[
  Condizione necessaria e sufficiente affinché il codice $P$ rilevi $z$ errori è che $ hamming(P) gt.eq z + 1 . $
]

#theorem()[
  Condizione necessaria e sufficiente affinché il codice $P$ corregga $t$ errori è che $ hamming(P) gt.eq 2t + 1 . $
]

In questi due teoremi, $hamming(P)$ indica la *distanza di Hamming minima* tra due parole del codice.

Come facciamo a sapere il valore $hamming(P)$?

Non so come, ma il valore $peso(P)$, che indica il minimo numero di $1$ presenti nelle parole di codice, è in realtà uguale a $hamming(P)$, quindi si gode.
