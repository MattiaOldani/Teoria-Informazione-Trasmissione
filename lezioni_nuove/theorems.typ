// Setup teoremi

#import "@preview/ctheorems:1.1.2": *

#let theorem = thmbox(
  "teorema",
  "Teorema",
  fill: rgb("#eeffee"),
).with(numbering: none)

#let corollary = thmbox(
  "corollario",
  "Corollario",
  base: "teorema",
  fill: rgb("#eeffee"),
).with(numbering: none)

#let lemma = thmbox(
  "lemma",
  "Lemma",
  fill: rgb("#eeffee"),
).with(numbering: none)

#let definition = thmbox(
  "definizione",
  "Definizione",
  fill: rgb("#d0ffff"),
).with(numbering: none)

#let example = thmbox(
  "esempio",
  "Esempio",
  fill: rgb("#fadadd"),
).with(numbering: none)

#let proof = thmproof(
  "dimostrazione",
  "Dimostrazione",
  fill: rgb("#eeffee"),
).with(numbering: none)
