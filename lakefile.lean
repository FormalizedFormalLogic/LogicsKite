import Lake
open Lake DSL

package «modalLogicKite» where
  -- Settings applied to both builds and interactive editing
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩ -- pretty-prints `fun a ↦ b`
  ]
  -- add any additional package configuration options here

require "FormalizedFormalLogic" / "foundation" @ git "master"

lean_lib «ModalLogicKite» where
  -- add library configuration options here

@[default_target]
lean_exe «modalLogicKite» where
  root := `Main
  -- add any library configuration options here
