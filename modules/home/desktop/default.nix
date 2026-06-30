{ ... }:
{
  # The *dotfiles* half of the desktop concern (home): WM/DE user config (waybar,
  # hyprland, etc.) — things only home-manager can own. The matching *session*
  # half (compositor/bar enablement) lives in modules/nixos/desktop, since only
  # the system can turn those on. Two scopes, one feature.
  #
  # Linux-only, so it's deliberately NOT in the universal registry
  # (modules/home/default.nix) and never reaches macOS. A future
  # profiles/home/desktop.nix will import this on the hosts that want it.
  imports = [
    # ./waybar   # ⚠️ waybar/default.nix is still half-converted (raw JSON, not
    #            #    valid Nix). Convert it before enabling or eval will fail.
  ];
}
