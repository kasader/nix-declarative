{ ... }:
{
  # The terminal environment: emulator + multiplexer, each toggle-gated
  # (custom.ghostty.enable, custom.tmux.enable). Room here for more later.
  imports = [
    ./ghostty.nix
    ./tmux.nix
  ];
}
