import Foundation

namespace LO.Meta.Kite

namespace Arith

open Lean Qq

structure Vertex (F : Q(Type)) where
  name : String
  Entailment : Q(Type)
  thy : Q($Entailment)

instance : ToString (Vertex F) where
  toString v := s!"{v.name}"

inductive EdgeType where
  | weaker
  | strict
deriving ToExpr, DecidableEq

def EdgeType.prefer : EdgeType → EdgeType → EdgeType
  | .strict, .strict => .strict
  | _, _ => .weaker

instance : Inhabited EdgeType := ⟨.weaker⟩
instance : ToString EdgeType where
  toString
    | .weaker => "weaker"
    | .strict => "strict"

def EdgeType.search {F : Q(Type)} (s t : Vertex F) : MetaM (Option EdgeType) := do
  let ⟨_, S, 𝓢⟩ := s
  let ⟨_, T, 𝓣⟩ := t
  let _ssys : Q(Entailment.{0,0,0} $F $S) ← Qq.synthInstanceQ q(Entailment.{0,0,0} $F $S)
  let _tsys : Q(Entailment.{0,0,0} $F $T) ← Qq.synthInstanceQ q(Entailment.{0,0,0} $F $T)
  let w ← Meta.synthInstance? q(Entailment.WeakerThan $𝓢 $𝓣)
  let s ← Meta.synthInstance? q(Entailment.StrictlyWeakerThan $𝓢 $𝓣)
  match w, s with
  |   .none,   .none => return .none
  | .some _,   .none => return .some <| .weaker
  |       _, .some _ => return .some <| .strict

end Arith

end LO.Meta.Kite
