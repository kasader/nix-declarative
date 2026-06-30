{ ... }:
{
  # Workstation profile: a graphical Hyprland/Wayland session, audio, and the
  # fonts that back it. Imported by hosts that want a desktop (ramiel); a headless
  # host imports only profiles/nixos/base.nix and gets none of this. The custom.*
  # options below are declared by the modules/nixos registry (pulled in by base).
  custom = {
    desktop = {
      wayland.enable = true;
      hyprland.enable = true;
    };
    audio.pipewire.enable = true;
    fonts.enable = true;
  };
}
