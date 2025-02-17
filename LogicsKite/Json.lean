import Foundation.Vorspiel.Vorspiel
import Lean.Data.Json

open Lean Meta

namespace LO.Meta.Vizualize

structure Kite (V : Type*) (E : Type) where
  vertices : List V
  search : V → V → MetaM (Option E)
  vs : V → String
  es : E → String

protected def Kite.toJson (d : Kite V E) : MetaM Json := do
  let l : List Json ← (d.vertices.product d.vertices).filterMapM fun ⟨a, b⟩ ↦ do
    let o ← d.search a b
    match o with
    | .some e =>
      return Json.mkObj [
        ("from", Json.str (d.vs a)),
        ("to", Json.str (d.vs b)),
        ("type", Json.str (d.es e))
      ]
    | .none =>
      return none
  return Json.arr l.toArray

protected def Kite.toString (d : Kite V E) : MetaM String := do
  let j ← d.toJson
  return j.pretty

end LO.Meta.Vizualize
