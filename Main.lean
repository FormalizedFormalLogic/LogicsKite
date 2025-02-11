import ModalLogicKite
import Mathlib.Lean.CoreM
namespace Main

open Lean Qq LO FirstOrder Meta Kite

def eq : Vertex q(SyntacticFormula ℒₒᵣ) := ⟨"EQ", q(Theory ℒₒᵣ), q(𝐄𝐐)⟩

def r₀ : Vertex q(SyntacticFormula ℒₒᵣ) := ⟨"R₀", q(Theory ℒₒᵣ), q(𝐑₀)⟩

def paminus : Vertex q(SyntacticFormula ℒₒᵣ) := ⟨"PA⁻", q(Theory ℒₒᵣ), q(𝐏𝐀⁻)⟩

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
  vertices := [eq, r₀, paminus]
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
