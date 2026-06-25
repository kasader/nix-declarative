{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # ./orbstack.nix
  ];

  # Spotlight/Launchpad won't index symlinks into /nix/store, so the apps Home
  # Manager links under "Home Manager Apps" never show up in the launcher.
  # Re-create each as a real macOS alias, which does get indexed.
  home.activation.aliasHomeManagerApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    apps="${config.home.homeDirectory}/Applications/Home Manager Apps"
    out="${config.home.homeDirectory}/Applications"
    if [ -d "$apps" ]; then
      for app in "$apps"/*.app; do
        [ -e "$app" ] || continue
        name="$(basename "$app")"
        $DRY_RUN_CMD rm -rf "$out/$name"
        $DRY_RUN_CMD ${pkgs.mkalias}/bin/mkalias "$(readlink -f "$app")" "$out/$name"
      done
    fi
  '';
}
