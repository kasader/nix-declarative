{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.fonts;
in
{
  # System-level fonts (distinct from the home-level custom.fonts coding faces).
  # These back the graphical session — Noto for broad coverage, plus the glyph
  # fonts a status bar like waybar renders icons from.
  options.custom.fonts.enable = lib.mkEnableOption "system fonts (Noto, Nerd Font symbols, Font Awesome)";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      nerd-fonts.symbols-only # glyphs for waybar / status bars
      font-awesome_4 # waybar icons
    ];
  };
}
