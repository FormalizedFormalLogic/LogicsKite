import LogicsKite

open Lean Qq
open LO.FirstOrder
open LO.Meta
open LO.Meta.Kite.FO

def Main.kite : Kite.Generator (Vertex q(SyntacticFormula ℒₒᵣ)) EdgeType where
  vertices := [
    ⟨"CobhamR0", q(Theory ℒₒᵣ), q(𝐑₀)⟩,
    ⟨"PAMinus", q(Theory ℒₒᵣ), q(𝐏𝐀⁻)⟩,
    ⟨"ISigma0", q(Theory ℒₒᵣ), q(𝐈𝚺₀)⟩,
    ⟨"ISigma1", q(Theory ℒₒᵣ), q(𝐈𝚺₁)⟩,
    ⟨"PA", q(Theory ℒₒᵣ), q(𝐏𝐀)⟩,
    ⟨"TA", q(Theory ℒₒᵣ), q(𝐓𝐀)⟩,
  ]
  search := EdgeType.search
  vs v := s!"{v.name}"
  es e :=
    match e with
    | .weaker _ => "weaker"
    | .strict _ => "strict"

open Lean
open Lean.Meta

unsafe
def main : IO Unit := do
  searchPathRef.set compile_time_search_path%
  withImportModules #[Import.mk `LogicsKite false] {} 0 fun env => do
    let ⟨s, _, _⟩ ← Main.kite.toString.toIO { fileName := "<compiler>", fileMap := default } { env := env }
    IO.FS.writeFile ("FO.json") s
