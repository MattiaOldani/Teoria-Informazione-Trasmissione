// Setup


// Alias

#let modello(insieme, probabilita) = $angle.l insieme, probabilita angle.r$

#let enrel(primo, secondo) = $DD(primo bar.double secondo)$

#let canale(sorgente, ricevente, probabilita) = $angle.l sorgente,ricevente,probabilita angle.r$

#let GF(n) = {
  let GFop = math.class(
    "unary",
    "GF",
  )
  $GFop(#n)$
}

#let CR(x) = {
  let CRop = math.class(
    "unary",
    "CR",
  )
  $CRop(#x)$
}

#let coderate = $italic("CR")$

#let grado(p) = {
  let gradoop = math.class(
    "unary",
    "gr",
  )
  $gradoop[#p]$
}

#let peso(p) = {
  let gradoop = math.class(
    "unary",
    $omega$,
  )
  $gradoop(#p)$
}

#let hamming(p) = {
  let gradoop = math.class(
    "unary",
    "d",
  )
  $gradoop(#p)$
}
