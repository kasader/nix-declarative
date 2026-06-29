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
  options.custom.fonts.enable = lib.mkEnableOption "desktop fonts (coding faces)";

  config = lib.mkIf cfg.enable {
    # On Linux fontconfig discovers the packages below; on Darwin home-manager
    # rsyncs them into ~/Library/Fonts/HomeManager (a symlink there isn't picked
    # up by macOS), so the same package list covers both platforms.
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      iosevka
      source-code-pro
      nerd-fonts.jetbrains-mono
    ];
  };
}
