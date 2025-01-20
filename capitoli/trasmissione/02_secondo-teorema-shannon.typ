// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Secondo teorema di Shannon

Il canale che abbiamo ora non ci va molto bene: come nella parte di codifica, definiremo una sorta di estensione del canale per poter poi _"spalmare"_ l'errore quando l'estensione diventa molto grande.

Definiamo quindi l'*estensione* $n$-esima del canale come la tupla $ C_n = canale(X^n, Y^n, p(y^n bar.v x^n)) $ tale che $ p(y^n bar.v x^n) = product_(i=1)^n p(y_i bar.v x_i) $ per indipendenza.

Un *codice canale* per il canale $C_n$ è di tipo $(M,n)$ se:
- $M$ è il massimo numero di messaggi che voglio codificare/spedire sul canale, ovvero è l'insieme di messaggi ${1, dots, M}$;
- $n$ è il numero di accessi che facciamo al canale;
- $x^n$ è la funzione di codifica tale che $x^n : {1, dots, M} arrow.long X^n$;
- $g$ è la funzione di decodifica tale che $y^n : YY^n arrow.long {1, dots, M}$.

Manca ancora qualcosa, ma per sapere cosa vediamo cosa stiamo facendo ora: $ M arrow.long^(x^n) X^n arrow.long^"send" ("canale con rumore") arrow.long^("send") Y^n . $

Siamo in $Y^n$, abbiamo a disposizione la funzione $g$ di decodifica, che però potrebbe fare errori: questo è dato dal fatto che siamo passati in un canale con rumore. Dobbiamo quindi applicare $g$ e indovinare il risultato di questa decodifica.

Completiamo il nostro codice canale con:
- $lambda_i$, definita come $P(g(y^n) eq.not i bar.v XX^n = x^n (i))$, ovvero la probabilità che la funzione $g$ decodifichi $y^n$ in un valore diverso da $i$, che è il nostro messaggio di partenza che è stato codificato da $x^n$;
- $lambda^((n))$, definita come $max_(i = 1, dots, n) lambda_i$, ovvero la massima probabilità di errore; quantità comoda come upper bound alle probabilità di errore;
- $p_e^((n))$, definita come $1/n sum_(i=1)^n lambda_i$; quantità comoda invece per gestire delle probabilità medie.

Vale ovviamente $p_e^((n)) lt.eq lambda^((n))$.

Definiamo il *tasso di trasmissione* di un codice di tipo $(M,n)$ come la quantità $ R = (log_2(M)) / n . $

Nel nostro caso specifico, codificando in binario e usando $n$ accessi al canale, il numero di messaggi disponibili è $2^n$, ma allora $ R = (log_2(2^n)) / n = 1 . $ Questo caso è quello _utopico_, ovvero quando il canale è senza rumore. Se quest'ultimo è presente il tasso di trasmissione è ovviamente minore.

Nella realtà viene usato il *tasso di trasmissione raggiungibile*. Un tasso di trasmissione $R$ è *raggiungibile* se esiste una sequenza di codici canale di tipo $(2^(n R), n) bar.v n = 1, 2, dots$ tale che $ lim_(n arrow infinity) lambda^((n)) = 0 . $

Avendo $R < 1$ il valore di $M$ del codice canale viene minore del caso utopico. Possiamo vedere $R$ come la quantità che ci indica quanto sfoltire il $2^n$ teorico per non avere errori. Ovviamente, prenderemo la parte intera della quantità $2^(n R)$ perché dobbiamo codificare un numero intero di messaggi.

Vediamo due proprietà, una statistica e uno viscontea, che ci dicono la stessa cosa.

#theorem([Legge dei grandi numeri])[
  Per ogni sequenza $XX_1, dots, XX_n$ di variabili casuali i.i.d con valore atteso $mu$ finito, allora $ forall epsilon > 0 quad lim_(n arrow infinity) P(abs(1/n sum_(i=1)^n XX_i - mu) > epsilon) = 0 . $
]

Questa legge afferma che, usando la media campionaria come stimatore per il valore atteso delle variabili casuali $XX_i$, la probabilità di commettere un errore maggiore $epsilon$ è nulla se consideriamo un buon numero di variabili casuali.

Una proprietà analoga è quella di *equipartizione asintotica*.

#theorem([AEP])[
  Per ogni sequenza $XX_1, dots, XX_n$ di variabili casuali i.i.d con entropia $H(XX)$ finita, allora $ forall epsilon > 0 quad lim_(n arrow infinity) P(abs(1/n log_2(1 / (p(x_1) dot dots dot p(x_n))) - H(XX)) > epsilon) = 0 . $
]

La proprietà è analoga alla legge dei grandi numeri, solo che si basa sull'entropia. Inoltre, questa proprietà vale per ogni variabile casuale $XX$ sulla quale calcoliamo l'entropia $H(XX)$.

Diamo ora una definizione di *insieme tipico*. Vediamo prima una definizione informale.

Peschiamo $n$ oggetti creando una sequenza $(x_1, dots, x_n)$. Visto che le pescate sono i.i.d., la probabilità di pescare tale sequenza è il prodotto delle singole probabilità. Se questo prodotto è compreso tra due quantità che ora vedremo allora tale sequenza appartiene all'insieme tipico.

Vediamo ora la definizione formale. L'insieme tipico è l'insieme $ A_epsilon^((n)) = {(x_1, dots, x_n) in X^n bar.v 2^(-n (H(XX) + epsilon)) lt.eq product_(i=1)^n p(x_i) lt.eq 2^(-n (H(XX) - epsilon))} . $

Facciamo vedere che l'insieme tipico è, in realtà, l'insieme formato da tutte le sequenze che rispettano la proprietà di equipartizione asintotica. Infatti: $ 2^(n (H(XX) - epsilon)) lt.eq 1 / (product_(i=1)^n p(x_i)) lt.eq 2^(n (H(XX) + epsilon)) \ n (H(XX) - epsilon) lt.eq log_2(1 / (product_(i=1)^n p(x_i))) lt.eq n (H(XX) + epsilon) \ H(XX) - epsilon lt.eq 1/n log_2(1 / (product_(i=1)^n p(x_i))) lt.eq H(XX) + epsilon \ -epsilon lt.eq 1/n log_2(1 / (product_(i=1)^n p(x_i))) - H(XX) lt.eq epsilon \ abs(1/n log_2(1 / (product_(i=1)^n p(x_i))) - H(XX)) lt.eq epsilon $

Dentro AEP abbiamo in realtà $< epsilon$, ma questo non cambia niente. Infatti, possiamo scrivere l'insieme tipico come $ A_epsilon^((n)) = {(x_1, dots, x_n) in X^n bar.v abs(1/n log_2(1 / (product_(i=1)^n p(x_i))) - H(XX)) lt.eq epsilon} . $

Vista questa definizione, possiamo affermare che $ lim_(n arrow infinity) P(A_epsilon^((n))) = 1 $ o che $ lim_(n arrow infinity) P(overline(A)_epsilon^((n))) = 0 . $

Il significato operativo di quanto detto fin'ora è il seguente: asintoticamente le sequenze che stanno nell'insieme tipico hanno tutte la stessa probabilità (_visto che le estrazioni sono i.i.d._) ed è uguale al prodotto delle probabilità singole. Ma queste quantità sono limitate dai due bound a meno di $epsilon$, ma allora le probabilità sono tutte uguali a $2^(-n H(XX))$ a meno di $epsilon$. In poche parole: $ P(x_1, dots, x_n) = product_(i=1)^n p(x_i) = cases(0 & "se" (x_1, dots, x_n) in.not A_epsilon^((n)), 2^(-n H(XX)) quad & "altrimenti") . $

#theorem()[
  Siano $XX_1, dots, XX_n$ delle variabili casuali i.i.d. e sia $A_epsilon^((n))$ l'insieme tipico ad esse associato. Allora:
  + possiamo dare un upper bound al numero di elementi dell'insieme tipico, ovvero $ forall n in NN quad abs(A_epsilon^((n))) lt.eq 2^(n (H(XX) + epsilon)) ; $
  + possiamo dare un lower bound al numero di elementi dell'insieme tipico, ovvero $ exists n_0 in NN bar.v forall n > n_0 quad abs(A_epsilon^((n))) gt.eq (1 - epsilon) 2^(n (H(XX) - epsilon)) . $
]

Vediamo l'insieme tipico in un altra versione. Supponiamo di trasmettere un messaggio $x^n in X^n$ in un canale rumoroso, che quindi distorce l'informazione trasmessa. Questo messaggio verrà mappato nei messaggi che stanno nell'insieme tipico se riceviamo un messaggio che non è distante dalla parola effettiva. Se invece siamo distanti dalla parola effettiva, non andremo a finire nell'insieme tipico. In poche parole, ogni messaggio $x^n in X^n$ va a definire un insieme tipico nell'insieme $Y^n$. Tutti questi insiemi formano delle *bolle* dentro $Y^n$.

Ogni bolla ha una dipendenza da ciò che abbiamo spedito, ovvero dobbiamo considerare degli insiemi che sono grandi $ abs(A_epsilon^((n))) approx 2^(n H(YY bar.v XX)) . $

Vogliamo ovviamente che tutti questi insiemi siano disgiunti, così da poter decodificare senza sovrapposizioni di bolle di messaggi diverse. Prendiamo quindi una parte di questi messaggi, ovvero $ M = frac(2^(n H(YY)), 2^(n H(YY bar.v XX))) = 2^(n (H(YY) - H(YY bar.v XX))) = 2^(n I(XX,YY)) . $

*ASSURDO*! Possiamo quindi riscrivere il tasso di trasmissione $R$ come $ R = frac(log_2(M), n) = frac(log_2(2^(n I(XX,YY))), n) = frac(n I(XX,YY), n) = I(XX,YY) . $

Definiamo quindi la nuova versione come l'*insieme congiuntamente tipico*. Esso è l'insieme $ B_epsilon^((n)) = {(x^n, y^n) in X^n times Y^n bar.v abs(1/n log_2(frac(1, p(x_1,y_1) dot dots dot p(x_n, y_n))) - H(XX,YY)) < epsilon} . $

Questo insieme gode di due *proprietà*:
- come per l'insieme tipico classico, $ lim_(n arrow infinity) P(B_epsilon^((n))) = 1 ; $
- se:
  - $XX_n$ ha distribuzione $p(XX_n = x^n) = product_i p(x_i)$ con $p(x_i)$ marginale di $X$ e $XX_n$ sequenze tipiche di $X$;
  - $YY_n$ ha distribuzione $p(YY_n = y^n) = product_i p(y_i)$ con $p(y_i)$ marginale di $Y$ e $YY_n$ sequenze tipiche di $Y$;
  allora $ forall n gt.eq 1 quad P((XX_n, YY_n) in B_epsilon^((n))) lt.eq 2^(-n (I(XX,YY) - 3epsilon)) . $

In poche parole, l'insieme $B_epsilon^((n))$ contiene tutte le coppie di sequenze $(x^n, y^n)$ che rispettano tre condizioni:
- le sequenze di $XX_n$ sono tipiche rispetto all'entropia $H(XX)$;
- le sequenze di $YY_n$ sono tipiche rispetto all'entropia $H(YY)$;
- le coppie di sequenze $(x^n, y^n)$ sono tipiche rispetto all'entropia $H(XX,YY)$.

Stiamo rispettando sia le distribuzioni marginali sia quella congiunta.

Le due proprietà ci dicono che per $n$ grande quasi tutte le coppie osservabili di sequenze appartengono all'insieme $B_epsilon^((n))$. Inoltre, la probabilità di uscire da questo insieme è bassa e decresce esponenzialmente al crescere di $n$. Lavorando con l'insieme tipico abbiamo una rappresentazione affidabile e precisa del comportamento delle sequenze originali.

Possiamo vedere infine il secondo teorema di Shannon, madonna.

#theorem([Secondo teorema di Shannon])[
  Se $canale(X,Y,p(y bar.v x))$ è un canale con capacità $C$, allora $ forall R < C quad exists K_1, dots, K_n "di tipo" (2^(n R_n), n) bar.v lim_(n arrow infinity) R_n = R and lim_(n arrow infinity) lambda^((n)) (K_n) = 0 . $
]

In altre parole, è possibile scegliere un codice che si avvina al massimo della capacità del canale tramite $R$, ovvero avvicinando il codice al massimo valore che $R$ può assumere. Inoltre, così facendo, almeno teoricamente, si _“spalma”_ l’errore sull'informazione trasmessa (_che è però massima_), perciò all’aumentare di $n$ si riduce al minimo l’errore trasmesso. Ricordiamo anche che, all’aumentare di $n$, le _“sfere”_ dell’insieme tipico tendono a non toccarsi permettendo di
decodificare senza sovrapposizioni.
