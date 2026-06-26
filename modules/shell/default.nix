{ lib, ... }:
{
  # One toggle for the whole shell stack — bash, fish and starship are
  # co-installed rather than alternatives, so they share a single enable flag
  # that each child gates its config on.
  options.custom.shell.enable = lib.mkEnableOption "shell stack (bash, fish, starship)";

  imports = [
    ./bash/default.nix
    ./fish/default.nix
    ./starship/default.nix
  ];
}
