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

// Appunti

= Lezione 14

== Campi di Galois

=== Introduzione

Solitamente lavoriamo su $1$ byte, quindi $8$ bit: con questo numero di bit a disposizione abbiamo $256$ numeri diversi, da $0$ a $255$. Abbiamo un problema: questi valori formano l'anello $ZZ_256$, che però non garantisce la presenza di un inverso per ogni elemento, visto che $256$ non è primo.

L'*inverso* di un numero $a$ è quel valore $b$ tale per cui $a dot b = equiv_256 1$.

Perché serve l'inverso? Serve perché la divisione, definita come $b \/ a = b dot a^(-1)$, necessita della presenza dell'inverso $a^(-1)$.

Lavorare su un anello è problematico, esiste almeno un elemento che non ha l'inverso.

Su un campo si dice *generatore* (o *radice primitiva*) un numero che, elevato a tutti gli elementi del campo diversi da $0$, mi genera gli elementi stessi.

Se è un generatore devo ottenere $1$ all'inizio (elevamento alla zero) e alla fine, come dice il *piccolo teorema di Fermat*.

#theorem(
  name: "Piccolo teorema di Fermat",
  numbering: none
)[
  Non ricordo la definizione, ma so che vale $ a^(p-1) equiv_p 1 . $
]

Ci possono essere più generatori all'interno di un campo: li possiamo mappare tra loro, e quando succede quando il campo è *isomorfo*.

=== Definizione

I *campi di Galois* ci permettono di avere un campo anche se il numero non è un numero primo. Formalmente, un campo di Galois è un campo $ "GF"(p^n), $ dove $p$ è un numero primo e $n$ un numero naturale. Nel nostro caso, usiamo il campo $ ZZ_256 = "GF"(2^8) . $

Gli elementi del campo di Galois sono i polinomi di grado $n-1$ con coefficienti in $ZZ_p$. Nel nostro caso, i polinomi hanno grado massimo $7$ e coefficienti in ${0,1}$.

Presi due polinomi $a(x),b(x) in "GF"(2^8)$ sicuramente la loro somma (intesa come somma binaria, o meglio, come XOR binario) sarà sempre un elemento del campo, ma questo invece non vale per la moltiplicazione: infatti, potremmo uscire dal grado massimo consentito dal campo. Per "rientrare" nel campo dobbiamo ridurli facendo il modulo con un polinomio $m(x)$ irriducibile: in poche parole, $ a(x) dot.op b(x) mod m(x) = r(x) . $ Di solito viene usato $m(x) = x^8 + x^4 + x^3 + x + 1$ (anche in AES), ma ce ne sono circa 30.

== Codici ciclici

=== Definizione

Abbiamo la seguente gerarchia: $ "BCH" subset "ciclici" subset "lineari" . $

I *codici ciclici* sono codici $(n,k)$ in cui il polinomio che rappresenta il messaggio è del tipo $ m(x) = m_0 x^0 + m_1 x^1 + dots + m_(k-1) x^(k-1) $ e il polinomio generatore è $ g(x) = g_0 x^0 + g_1 x^1 + dots + g_(k-1) x^(k-1) . $

I codici ciclici possono essere:
- *sistematici*: le posizioni dei bit di controllo e di informazione sono prestabiliti. La parola di codice $v(x)$ è rappresentata come $ v(x) = m(x) g(x) , $ con $m(x)$ messaggio da spedire;
- *non sistematici*: la posizione dei bit di controllo non è prefissata. La parole di codice $v(x)$ è rappresentata come $ v(x) = x^(n-k) m(x) + r(x) . $

=== Esempio

Dato il codice $(7,4)$ con $g(x) = 1 + x + x^3$ e $m(x) = 1 + x^2 + x^3$ trovare la parola di codice corrispondente.

Se il codice è _sistematico_ allora $ v(x) = m(x) g(x) = (1 + x^2 + x^3) (1 + x + x^3) = x^6 + x^5 + x^4 + x^3 + x^2 + x + 1 . $

Se il codice è _non sistematico_ allora $ v(x) = x^(n-k) m(x) + r(x) = x^3 (1 + x^2 + x^3) + r(x) = "conti non fatti" = x^6 + x^5 + x^3 + 1 . $

=== Matrice generatrice

Per trovare le parole di codice possiamo usare anche la *matrice generatrice*.

In ordine:
// Sistemare
+ scriviamo la matrice generatrice $ G = mat(x^(k-1) g(x); x^(k-2) g(x); dots.v dots.v dots.v; x^(k-k) g(x);) quad ; $
+ se vogliamo ottenere la parole nella forma sistematica applichiamo una combinazione lineare delle righe per ottenere $ G = [I] , $ con $I$ matrice identità;
+ trovo le parole di codice con $ [c] = [d] dot.op [G] , $ con $c$ parola di codice e $d$ messaggio. 

Definiamo il *polinomio di parità* come $ h(x) = frac(x^n+1, g(x)) . $

Per essere un polinomio generatore valido $g(x)$ deve dividere propriamente $x^n + 1$.
