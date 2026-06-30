{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.wayland;
in
{
  # Compositor-agnostic Wayland tooling — useful under any Wayland session, not
  # tied to Hyprland. wev in particular is the go-to for debugging input/keysyms.
  options.custom.desktop.wayland.enable =
    lib.mkEnableOption "Wayland session tooling (clipboard, event debugging)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard # wl-copy / wl-paste
      cliphist # clipboard history
      wev # Wayland event viewer — inspect input events / keysyms
    ];

    # Hint Electron/Chromium apps to render through native Wayland, not XWayland.
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
