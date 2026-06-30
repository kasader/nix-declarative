{ ... }:
{
  # The *session* half of the desktop concern (NixOS): enabling the compositor,
  # bar, and Wayland tooling — things only the system can turn on. The matching
  # *dotfiles* half (waybar/hyprland config) lives in modules/home/desktop, since
  # only home-manager can own user config. Two scopes, one feature.
  #
  # Each module declares its own custom.desktop.<x> toggle; profiles/nixos/
  # desktop.nix turns them on for workstation hosts, so a headless host that
  # imports only profiles/nixos/base.nix gets none of this.
  #   wayland  — compositor-agnostic Wayland tooling (clipboard, debug)
  #   hyprland — the Hyprland compositor + status bar
  imports = [
    ./wayland.nix
    ./hyprland.nix
  ];
}
