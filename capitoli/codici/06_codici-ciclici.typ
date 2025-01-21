// Setup

#import "../alias.typ": *

#import "@local/typst-theorems:1.0.0": *
#show: thmrules.with(qed-symbol: $square.filled$)


// Capitolo

= Codici ciclici

Un *codice ciclico* è un codice lineare che è dotato dell'operazione di *shift ciclico verso destra*.

Un codice lineare $P$ si dice ciclico se $ forall x = (x_1, dots, x_n) quad x' = x gt.double 1 = (x_n, x_1, dots, x_(n-1)) in P . $

Molto comodo lo shift verso destra perché nei campi di Galois questa operazione si tramuta in una semplice moltiplicazione per $x$ con una operazione di modulo per il polinomio irriducibile.

Definiamo il *grado* del polinomio $p(x)$ il numero $ grado(p(x)) = max(i bar.v p[i] = 1) . $

#theorem()[
  Sia $P$ un codice ciclico di ordine $n$ e sia $a(x) in P$. Vale $ forall p(x) in P bar.v grado(p(x) a(x)) < n arrow.long.double p(x) a(x) in P . $
]

Vediamo come è fatta la *matrice generatrice* $G$ di un codice ciclico.

#set math.mat(delim: "[")

#theorem()[
  Sia $P$ un codice ciclico di tipo $(n,k)$, allora:
  + $P$ contiene sempre almeno una parola $g(x)$ di grado $n-k$ tale che tutte le parole del codice $P$ sono multiple di $g(x)$; la parola $g(x)$ è il nostro *polinomio generatore* e ricopre il ruolo di $a(x)$ nel teorema precedente;
  + trovata la parola $g(x)$, la *matrice generatrice* $G$ è tale che $ G_(k times n) = mat(g(x); x dot g(x); x^2 dot g(x); dots; x^(k-1) dot g(x)) , $ ovvero ogni riga (_tranne la prima_) viene ottenuta dalla precedente tramite uno shift ciclico.
]

#theorem()[
  Sia $g(x)$ il polinomio generatore di un codice ciclico $P$ di tipo $(n,k)$, allora $g(x)$ è divisore proprio di $x^n - 1$.
]

Il polinomio generatore $g(x)$ *non è unico*: questo ci permette di definire un altro teorema.

#theorem()[
  Ogni divisore proprio di grado $ r in {1, n-k} $ genera un codice ciclico diverso di tipo $(n, n-r)$.
]

Il *polinomio di parità* di un codice ciclico $P$ di ordine $n$, generato da $g(x)$, che chiamiamo $pi(x)$, è il polinomio quoziente $ pi(x) = frac(x^n - 1, g(x)) . $

Vediamo infine come è definita la *matrice di parità* $H$ di un codice $P$.

#theorem()[
  Sia $P$ un codice ciclico di tipo $(n,k)$ e sia $pi(x)$ il polinomio di parità $ pi(x) = pi_0 + pi_1 x + dots + underbracket(pi_k, = 1) x^k . $

  Allora la *matrice di parità* $H$ è tale che $ H_((n-k) times n) = mat(x^(n-k-1) dot pi'(x) bar.v 0 dots 0; x^(n-k-2) dot pi'(x) bar.v 0 dots 0; dots; x dot pi'(x) bar.v 0 dots 0; pi'(x) bar.v 0 dots 0) , $ con $ pi'(x) = underbracket(pi_k, = 1) + pi_(k-1) x + dots + pi_0 x^k $ polinomio ottenuto invertendo i coefficienti.
]

Questi codici sono estremamente potenti, ma hanno un piccolo svantaggio: una volta definito il tipo del codice abbiamo definito di conseguenza anche tutto il resto, perché abbiamo già $peso(P)$, che corrisponde alla distanza $hamming(P)$, e quindi sappiamo già quanti errori possiamo rilevare e quanti ne possiamo correggere.

I *codici BCH* fanno il contrario: decidono quanti errori vogliono correggere e costruiscono di conseguenza il codice.
