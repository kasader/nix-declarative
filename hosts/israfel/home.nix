{ ... }: {
  imports = [
    ../../profiles/home/base.nix
    ../../profiles/home/darwin.nix
  ];

  home.username = "kasada";
  home.homeDirectory = "/Users/kasada";

  # Per-host extras — the base profile already provides the universal set.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;
  custom.k8s.enable = true;
  custom.containers.enable = true;
  custom.cloud.gcp.enable = true;
  # custom.cloud.aws.enable = true;
  # custom.cloud.oci.enable = true;
}
