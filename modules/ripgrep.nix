{ config, lib, ... }:
let
  cfg = config.custom.ripgrep;
in
{
  options.custom.ripgrep.enable = lib.mkEnableOption "ripgrep search tool";

  config = lib.mkIf cfg.enable {
    programs.ripgrep.enable = true;
  };
}
