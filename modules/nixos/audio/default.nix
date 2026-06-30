{ config, lib, ... }:
let
  cfg = config.custom.audio.pipewire;
in
{
  options.custom.audio.pipewire.enable =
    lib.mkEnableOption "PipeWire audio (ALSA + PulseAudio compat, rtkit)";

  config = lib.mkIf cfg.enable {
    # rtkit lets PipeWire acquire realtime priority — optional but recommended.
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true; # uncomment for JACK applications
    };
  };
}
