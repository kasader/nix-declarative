{ ... }:
{
  # Terminal emulators. Ghostty is the sole emulator; toggle-gated via
  # custom.ghostty.enable. Room here for additional emulators later.
  imports = [
    ./ghostty.nix
  ];
}
