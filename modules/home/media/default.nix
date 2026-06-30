{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.media;
in
{
  # Media playback and processing CLIs.
  options.custom.media.enable = lib.mkEnableOption "media playback / processing (mpv, ffmpeg)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg
      mpv # CLI player; the `iina` cask is the GUI front-end over the same engine
    ];
  };
}
