{ ... }: {
  imports = [ ../../modules/shared.nix ];

  home.username = "kasada";
  home.homeDirectory = "/home/kasada";

  # Pluggable modules — toggle per host.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;
  custom.k8s.enable = false;
  custom.containers.enable = false;

  # TODO: Add relevant packages/modules
}
