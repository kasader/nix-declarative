{ ... }: {
  imports = [
    ../../profiles/base.nix
    ../../profiles/darwin.nix
  ];

  home.username = "kasada";
  home.homeDirectory = "/Users/kasada";

  # Per-host extras — the base profile already provides the universal set.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;
  custom.k8s.enable = true;
  custom.containers.enable = true;
}
