# flake.module.nix — project-specific flake-parts customizations.
# Unmanaged by seihou: never regenerated or overwritten. See
# flake.module.nix.example for the available options.
{ inputs, ... }:
{
  perSystem = { ... }: {
    # Multi-package repo: the root has no .cabal file, so build the core
    # package from its subdirectory.
    haskellProject.packageSource = "${inputs.self}/relay-pagination";
  };
}
