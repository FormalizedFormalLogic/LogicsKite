import ModalLogicKite
import Mathlib.Lean.CoreM
namespace Main

open Lean Qq LO FirstOrder Meta Kite

def dot : Vizualize.Dot (Vertex q(SyntacticFormula ℒₒᵣ)) EdgeType where
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
    ];"
  vertices := [
    ⟨"EQ", q(Theory ℒₒᵣ), q(𝐄𝐐)⟩,
    ⟨"R₀", q(Theory ℒₒᵣ), q(𝐑₀)⟩,
    ⟨"PA⁻", q(Theory ℒₒᵣ), q(𝐏𝐀⁻)⟩,
    ⟨"PA", q(Theory ℒₒᵣ), q(𝐏𝐀)⟩
  ]
  edge := EdgeType.search
  vs v := v.name
  es e :=
    match e with
    | .weaker => "[style = dashed]"
    | .strict => "[]"

#eval dot.toString

end Main

open Main
open Lean
open Lean.Meta

unsafe
def main : IO Unit := do
  searchPathRef.set compile_time_search_path%
  withImportModules #[Import.mk `ModalLogicKite false] {} 0 fun env => do
    let ⟨s, _, _⟩ ← dot.toString.toIO { fileName := "<compiler>", fileMap := default } { env := env }
    IO.FS.writeFile ("test.dot") s
