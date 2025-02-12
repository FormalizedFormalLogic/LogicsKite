import Foundation.Logic.Entailment
import Foundation.Modal.Logic.WellKnown
import Foundation.FirstOrder.Arith.Theory

namespace LO.Meta

namespace Kite

open Lean Qq

structure Vertex (F : Q(Type)) where
  name : String
  Entailment : Q(Type)
  thy : Q($Entailment)

inductive EdgeType where
  | weaker
  | strict
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
  | .some _,   .none => return .some .weaker
  |       _, .some _ => return .some .strict

section test

open FirstOrder

def eq : Vertex q(SyntacticFormula ℒₒᵣ) := ⟨"EQ", q(Theory ℒₒᵣ), q(𝐄𝐐)⟩

def r₀ : Vertex q(SyntacticFormula ℒₒᵣ) := ⟨"R₀", q(Theory ℒₒᵣ), q(𝐑₀)⟩

#eval EdgeType.search r₀ eq

#eval EdgeType.search eq eq

#eval EdgeType.search eq r₀

end test

end Kite

end LO.Meta
