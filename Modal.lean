import LogicsKite

open Lean Qq
open LO.Modal
open LO.Meta
open LO.Meta.Kite.Modal

def Main.kite : Kite Vertex EdgeType where
  vertices := [
    ⟨q(Logic.Empty)⟩,
    ⟨q(Logic.GL)⟩,
    ⟨q(Logic.Grz)⟩,
    ⟨q(Logic.K)⟩,
    ⟨q(Logic.K4)⟩,
    ⟨q(Logic.K45)⟩,
    ⟨q(Logic.K4Point2)⟩,
    ⟨q(Logic.K4Point3)⟩,
    ⟨q(Logic.K5)⟩,
    ⟨q(Logic.KB)⟩,
    ⟨q(Logic.KB4)⟩,
    ⟨q(Logic.KB5)⟩,
    ⟨q(Logic.KD)⟩,
    ⟨q(Logic.KD4)⟩,
    ⟨q(Logic.KD45)⟩,
    ⟨q(Logic.KD5)⟩,
    ⟨q(Logic.KDB)⟩,
    ⟨q(Logic.KH)⟩,
    ⟨q(Logic.KT)⟩,
    ⟨q(Logic.KTB)⟩,
    ⟨q(Logic.KTc)⟩,
    ⟨q(Logic.S4)⟩,
    ⟨q(Logic.S4Point2)⟩,
    ⟨q(Logic.S4Point3)⟩,
    ⟨q(Logic.S5)⟩,
    ⟨q(Logic.Triv)⟩,
    ⟨q(Logic.Univ)⟩,
    ⟨q(Logic.Ver)⟩,
  ]
  search := EdgeType.search
  vs v := s!"{v.thy}"
  es e :=
    match e with
    | .weaker => "weaker"
    | .strict => "strict"
  prefer := EdgeType.prefer

open Lean
open Lean.Meta

unsafe
def main : IO Unit := do
  searchPathRef.set compile_time_search_path%
  withImportModules #[Import.mk `LogicsKite false] {} 0 fun env => do
    let ⟨s, _, _⟩ ← Main.kite.toStringM.toIO { fileName := "<compiler>", fileMap := default } { env := env }
    IO.FS.writeFile ("Modal.json") s
