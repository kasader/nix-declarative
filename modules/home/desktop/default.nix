{ ... }:
{
  # Linux-only home desktop bits — WM/DE *dotfiles* (waybar, etc.). This is the
  # "Linux home" tier: home-manager config that only makes sense with a graphical
  # Linux session. It is deliberately NOT imported by the universal registry
  # (modules/home/default.nix), so it never reaches macOS. A Phase 3
  # profiles/home/desktop.nix will import this on the hosts that want it.
  imports = [
    # ./waybar   # ⚠️ waybar/default.nix is still half-converted (raw JSON, not
    #            #    valid Nix). Convert it before enabling or eval will fail.
  ];
}
