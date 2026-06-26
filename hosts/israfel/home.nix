{ ... }: {
  imports = [ ../../modules/shared.nix ];
  
  home.username = "kasada";
  home.homeDirectory = "/Users/kasada";

  # Pluggable modules — toggle per host.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;
  custom.k8s.enable = true;
  custom.containers.enable = true;

  # TODO: Add relevant packages/modules
}