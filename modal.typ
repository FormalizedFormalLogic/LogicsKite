#import "@preview/diagraph:0.3.1": *
#import "@preview/oxifmt:0.2.1": strfmt

#set page(width: auto, height: auto, margin: 24pt)

#let Logic(L) = $upright(bold(#L))$

#let arrows = json("./modal.json").map(((from, to, type)) => {
  if type == "strict" {
    return strfmt("\"{}\" -> \"{}\"", from, to)
  }
})

Kite of Modal Logics

#raw-render(
  raw(
    "
  digraph modal_logic_kite {
    rankdir = BT;

    node [
      shape=none
      margin=0.1
      width=0
      height=0
    ]

    edge [
      style = solid
      arrowhead = none
    ];

    {rank = same; \"LO.Modal.Logic.Triv\"; \"LO.Modal.Logic.Ver\";}
  "
      + arrows.join("\n")
      + "}",
  ),
  labels: (
    "LO.Modal.Logic.Empty": $emptyset$,
    "LO.Modal.Logic.GL": $Logic("GL")$,
    "LO.Modal.Logic.Grz": $Logic("Grz")$,
    "LO.Modal.Logic.K": $Logic("K")$,
    "LO.Modal.Logic.K4": $Logic("K4")$,
    "LO.Modal.Logic.K45": $Logic("K45")$,
    "LO.Modal.Logic.K5": $Logic("K5")$,
    "LO.Modal.Logic.KB": $Logic("KB")$,
    "LO.Modal.Logic.KB4": $Logic("KB4")$,
    "LO.Modal.Logic.KB5": $Logic("KB5")$,
    "LO.Modal.Logic.KD": $Logic("KD")$,
    "LO.Modal.Logic.KD4": $Logic("KD4")$,
    "LO.Modal.Logic.KD45": $Logic("KD45")$,
    "LO.Modal.Logic.KD5": $Logic("KD5")$,
    "LO.Modal.Logic.KDB": $Logic("KDB")$,
    "LO.Modal.Logic.KH": $Logic("KH")$,
    "LO.Modal.Logic.KT": $Logic("KT")$,
    "LO.Modal.Logic.KTB": $Logic("KTB")$,
    "LO.Modal.Logic.KTc": $Logic("KTc")$,
    "LO.Modal.Logic.S4Dot2": $Logic("S4.2")$,
    "LO.Modal.Logic.S4Dot3": $Logic("S4.3")$,
    "LO.Modal.Logic.GrzDot2": $Logic("Grz.2")$,
    "LO.Modal.Logic.GrzDot3": $Logic("Grz.3")$,
    "LO.Modal.Logic.GLDot2": $Logic("GL.2")$,
    "LO.Modal.Logic.GLDot3": $Logic("GL.3")$,
    "LO.Modal.Logic.S4": $Logic("S4")$,
    "LO.Modal.Logic.S5": $Logic("S5")$,
    "LO.Modal.Logic.Triv": $Logic("Triv")$,
    "LO.Modal.Logic.Univ": $bot$,
    "LO.Modal.Logic.Ver": $Logic("Ver")$,
  ),
  width: 240pt,
)
