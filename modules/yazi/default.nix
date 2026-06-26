{ config, lib, ... }:
let
  cfg = config.custom.yazi;
in
{
  options.custom.yazi.enable = lib.mkEnableOption "yazi file manager";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
