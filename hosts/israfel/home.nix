{ ... }: {
  imports = [ ../../modules/shared.nix ];
  
  home.username = "kasada";
  home.homeDirectory = "/Users/kasada";

  # Browsers — pluggable, toggle per host.
  custom.browsers.firefox.enable = true;
  # custom.browsers.librewolf.enable = true;

  # TODO: Add relevant packages/modules
}