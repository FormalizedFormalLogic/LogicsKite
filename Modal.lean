import ModalLogicKite

open Lean Qq
open LO.Modal
open LO.Meta
open LO.Meta.Modal.Kite

def Main.dot : Vizualize.Dot Vertex EdgeType where
  settings :=
    r"graph[
      rankdir = BT;
    ]

    node [
      shape=plaintext
      margin=0.05
      width=0
      height=0
    ];

    edge [
      style = solid
      arrowhead = none
    ];

    {rank = same; Triv; Ver;}
    "
  vertices := [
    ⟨"GL", q(Logic.GL)⟩,
    ⟨"Grz", q(Logic.Grz)⟩,
    ⟨"K", q(Logic.K)⟩,
    ⟨"K4", q(Logic.K4)⟩,
    ⟨"K45", q(Logic.K45)⟩,
    ⟨"K5", q(Logic.K5)⟩,
    ⟨"KB", q(Logic.KB)⟩,
    ⟨"KB4", q(Logic.KB4)⟩,
    ⟨"KB5", q(Logic.KB5)⟩,
    ⟨"KD", q(Logic.KD)⟩,
    ⟨"KD4", q(Logic.KD4)⟩,
    ⟨"KD45", q(Logic.KD45)⟩,
    ⟨"KD5", q(Logic.KD5)⟩,
    ⟨"KDB", q(Logic.KDB)⟩,
    ⟨"KT", q(Logic.KT)⟩,
    ⟨"KTB", q(Logic.KTB)⟩,
    ⟨"S4", q(Logic.S4)⟩,
    ⟨"S4Dot2", q(Logic.S4Dot2)⟩,
    ⟨"S4Dot3", q(Logic.S4Dot3)⟩,
    ⟨"S5", q(Logic.S5)⟩,
    ⟨"Triv", q(Logic.Triv)⟩,
    ⟨"Ver", q(Logic.Ver)⟩,
  ]
  edge := EdgeType.search
  vs v := v.name
  es e :=
    match e with
    | .weaker => "[style = dashed]"
    | .strict => "[]"

#eval Main.dot.toString

open Lean
open Lean.Meta

unsafe
def main : IO Unit := do
  searchPathRef.set compile_time_search_path%
  withImportModules #[Import.mk `ModalLogicKite false] {} 0 fun env => do
    let ⟨s, _, _⟩ ← Main.dot.toString.toIO { fileName := "<compiler>", fileMap := default } { env := env }
    IO.FS.writeFile ("modal.dot") s
