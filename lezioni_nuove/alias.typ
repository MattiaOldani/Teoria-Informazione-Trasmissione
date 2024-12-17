// Alias

// Lezione 03

#let modello(insieme, probabilita) = $angle.l insieme, probabilita angle.r$

// Lezione 05

#let enrel(primo, secondo) = $DD(primo bar.double secondo)$

// Lezione 11

#let canale(sorgente, ricevente, probabilita) = $angle.l sorgente,ricevente,probabilita angle.r$

// Lezione 14

#let GF(n) = {
  let GFop = math.class(
    "unary",
    "GF",
  )
  $GFop(#n)$
}
