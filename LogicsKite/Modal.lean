import Foundation

namespace LO.Meta.Modal

namespace Kite

open Lean Qq
open LO.Modal (Logic)

structure Vertex where
  name : String
  thy : Q(Logic)

inductive EdgeType where
  | weaker
  | strict
  deriving ToExpr

def EdgeType.search (s t : Vertex) : MetaM (Option EdgeType) := do
  let ⟨_, L₁⟩ := s
  let ⟨_, L₂⟩ := t
  let w ← Meta.synthInstance? q(Logic.Sublogic $L₁ $L₂)
  let s ← Meta.synthInstance? q(Logic.ProperSublogic $L₁ $L₂)
  match w, s with
  |   .none,   .none => return .none
  | .some _,   .none => return .some .weaker
  |       _, .some _ => return .some .strict

end Kite

end LO.Meta.Modal
