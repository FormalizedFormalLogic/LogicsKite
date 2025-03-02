import Foundation

namespace LO.Meta.Kite

namespace Arith

open Lean Qq

structure Vertex (F : Q(Type)) where
  name : String
  Entailment : Q(Type)
  thy : Q($Entailment)

inductive EdgeType where
  | weaker (s : String)
  | strict (s : String)
  deriving ToExpr

def EdgeType.search {F : Q(Type)} (s t : Vertex F) : MetaM (Option EdgeType) := do
  let ⟨_, S, 𝓢⟩ := s
  let ⟨_, T, 𝓣⟩ := t
  let _ssys : Q(Entailment.{0,0,0} $F $S) ← Qq.synthInstanceQ q(Entailment.{0,0,0} $F $S)
  let _tsys : Q(Entailment.{0,0,0} $F $T) ← Qq.synthInstanceQ q(Entailment.{0,0,0} $F $T)
  let w ← Meta.synthInstance? q(Entailment.WeakerThan $𝓢 $𝓣)
  let s ← Meta.synthInstance? q(Entailment.StrictlyWeakerThan $𝓢 $𝓣)
  match w, s with
  |   .none,   .none => return .none
  | .some e,   .none => return .some <| .weaker <| toString e
  |       _, .some e => return .some <| .strict <| toString e

end Arith

end LO.Meta.Kite
