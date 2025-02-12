import Foundation.Vorspiel.Vorspiel

open Lean Meta

namespace LO.Meta.Vizualize

structure Dot (V : Type*) (E : Type) where
  settings : String
  vertices : List V
  edge : V → V → MetaM (Option E)
  vs : V → String
  es : E → Array String

protected def Dot.toString (d : Dot V E) : MetaM String := do
  let l : List String ← (d.vertices.product d.vertices).mapM fun ⟨a, b⟩ ↦ do
    let o ← d.edge a b
    match o with
    | .some e => return s!"{d.vs a} -> {d.vs b} [{(d.es e).foldl (fun ih x ↦ s!"{x}, {ih}") ""}];\n"
    |   .none => return ""
  return s!"digraph \{\n{d.settings}\n{String.join l}\n}"

end LO.Meta.Vizualize
