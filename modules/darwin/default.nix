{ ... }:
{
  # System-module registry (nix-darwin only). Mirrors modules/nixos: importing a
  # module here only *declares* its `custom.*` options — profiles and hosts decide
  # what's on. Nothing in here is ever evaluated on NixOS/Linux (no
  # darwinConfigurations there).
  imports = [
  ];
}
