{ config, lib, ... }:
let
  cfg = config.custom.tmux;
in
{
  options.custom.tmux.enable = lib.mkEnableOption "tmux terminal multiplexer";

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;

      # Enables mouse support
      mouse = true;

      keyMode = "vi";
    };
  };
}
