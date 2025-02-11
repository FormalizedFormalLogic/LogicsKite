import Foundation.Modal.Logic.WellKnown


namespace LO.Modal.Logic

class WeakerThan (L₁ L₂ : Logic) where
  subset : L₁ ⊆ L₂

class StrictWeakerThan (L₁ L₂ : Logic) where
  ssubset : L₁ ⊂ L₂

instance : StrictWeakerThan Logic.GL Logic.Ver := ⟨GL_ssubset_Ver⟩
instance : StrictWeakerThan Logic.Grz Logic.Triv := ⟨Grz_ssubset_Triv⟩
instance : StrictWeakerThan Logic.K Logic.K4 := ⟨K_ssubset_K4⟩
instance : StrictWeakerThan Logic.K Logic.K5 := ⟨K_ssubset_K5⟩
instance : StrictWeakerThan Logic.K Logic.KB := ⟨K_ssubset_KB⟩
instance : StrictWeakerThan Logic.K Logic.KD := ⟨K_ssubset_KD⟩
instance : StrictWeakerThan Logic.K4 Logic.GL := ⟨K4_ssubset_GL⟩
instance : StrictWeakerThan Logic.K4 Logic.K45 := ⟨K4_ssubset_K45⟩
instance : StrictWeakerThan Logic.K4 Logic.K45 := ⟨K4_ssubset_K45⟩
instance : StrictWeakerThan Logic.K45 Logic.KB4 := ⟨K45_ssubset_KB4⟩
instance : StrictWeakerThan Logic.K45 Logic.KD45 := ⟨K45_ssubset_KD45⟩
instance : StrictWeakerThan Logic.K5 Logic.K45 := ⟨K5_ssubset_K45⟩
instance : StrictWeakerThan Logic.K5 Logic.KD5 := ⟨K5_ssubset_KD5⟩
instance : StrictWeakerThan Logic.KB Logic.KB4 := ⟨KB_ssubset_KB4⟩
instance : StrictWeakerThan Logic.KB Logic.KDB := ⟨KB_ssubset_KDB⟩
instance : StrictWeakerThan Logic.KB4 Logic.S5 := ⟨KB4_ssubset_S5⟩
instance : StrictWeakerThan Logic.KD Logic.KD4 := ⟨KD_ssubset_KD4⟩
instance : StrictWeakerThan Logic.KD Logic.KD5 := ⟨KD_ssubset_KD5⟩
instance : StrictWeakerThan Logic.KD Logic.KDB := ⟨KD_ssubset_KDB⟩
instance : StrictWeakerThan Logic.KD Logic.KT := ⟨KD_ssubset_KT⟩
instance : StrictWeakerThan Logic.KD4 Logic.KD45 := ⟨KD4_ssubset_KD45⟩
instance : StrictWeakerThan Logic.KD4 Logic.S4 := ⟨KD4_ssubset_S4⟩
instance : StrictWeakerThan Logic.KD45 Logic.S5 := ⟨KD45_ssubset_S5⟩
instance : StrictWeakerThan Logic.KD5 Logic.KD45 := ⟨KD5_ssubset_KD45⟩
instance : StrictWeakerThan Logic.KDB Logic.KTB := ⟨KDB_ssubset_KTB⟩
instance : StrictWeakerThan Logic.KT Logic.KTB := ⟨KT_ssubset_KTB⟩
instance : StrictWeakerThan Logic.KT Logic.S4 := ⟨KT_ssubset_S4⟩
instance : StrictWeakerThan Logic.KTB Logic.S5 := ⟨KTB_ssubset_S5⟩
instance : StrictWeakerThan Logic.S4 Logic.Grz := ⟨S4_ssubset_Grz⟩
instance : StrictWeakerThan Logic.S4 Logic.Grz := ⟨S4_ssubset_Grz⟩
instance : StrictWeakerThan Logic.S4 Logic.S4Dot2 := ⟨S4_ssubset_S4Dot2⟩
instance : StrictWeakerThan Logic.S4Dot2 Logic.S4Dot3 := ⟨S4Dot2_ssubset_S4Dot3⟩
instance : StrictWeakerThan Logic.S4Dot3 Logic.S5 := ⟨S4Dot3_ssubset_S5⟩
instance : StrictWeakerThan Logic.S5 Logic.Triv := ⟨S5_ssubset_Triv⟩

end LO.Modal.Logic



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
  let w ← Meta.synthInstance? q(Logic.WeakerThan $L₁ $L₂)
  let s ← Meta.synthInstance? q(Logic.StrictWeakerThan $L₁ $L₂)
  match w, s with
  |   .none,   .none => return .none
  | .some _,   .none => return .some .weaker
  |       _, .some _ => return .some .strict

end Kite

end LO.Meta.Modal
