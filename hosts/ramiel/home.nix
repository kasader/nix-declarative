{ ... }: {
  imports = [ ../../modules/shared.nix ];
  
  home.username = "kasada";
  home.homeDirectory = "/home/kasada";

  # Browsers — pluggable, toggle per host.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;

  # TODO: Add relevant packages/modules
}