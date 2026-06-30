{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.hyprland;
in
{
  # The Hyprland compositor and its paired status bar. The actual *dotfiles*
  # (hyprland.conf, waybar config) are a home-manager concern (modules/home/
  # desktop); this module only enables the system-level programs.
  options.custom.desktop.hyprland.enable = lib.mkEnableOption "Hyprland Wayland compositor + waybar";

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    # programs.waybar.enable installs waybar, so no separate package entry.
    programs.waybar.enable = true;

    # kitty is the terminal the stock Hyprland keybinds launch (Super+Q).
    environment.systemPackages = with pkgs; [ kitty ];

    # Keyboard layout for the graphical session (also read by XWayland/console).
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # TODO: application launcher (rofi / wofi / bemenu) — undecided; add here.
  };
}
