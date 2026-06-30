{ ... }:
{
  # Graphical-session modules (NixOS). Each declares its own custom.desktop.<x>
  # toggle; profiles/nixos/desktop.nix turns them on for workstation hosts, so a
  # headless host that imports only profiles/nixos/base.nix gets none of this.
  #   wayland  — compositor-agnostic Wayland tooling (clipboard, debug)
  #   hyprland — the Hyprland compositor + status bar
  imports = [
    ./wayland.nix
    ./hyprland.nix
  ];
}
