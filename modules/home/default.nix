{ config, lib, ... }:
{
  # Live working-tree checkout of this flake. The single source of truth for
  # "where does this repo live" — consumed by out-of-store symlinks (nvim) and
  # the `mknix` wrapper's NIX_FLAKE. Computed per-host from homeDirectory so it
  # stays correct on darwin (/Users) and NixOS (/home). Moving the repo is one
  # edit here (plus FLAKE in the Makefile, which can't read Nix).
  options.custom.flakeDir = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/src/github.com/kasader/nix-declarative";
    description = "Live checkout location of this flake, for out-of-store symlinks.";
  };

  # Module registry. Importing a module here only *declares* its
  # `custom.<name>.enable` option — everything defaults to off. Deciding what to
  # turn on is a separate concern owned by profiles and hosts:
  #   - profiles/base.nix  enables the universal set (every machine)
  #   - hosts/<name>       enable per-host extras (k8s, containers, browsers, …)
  #
  # So "is this module available?" and "is this module on?" are answered in
  # different places — nothing is active merely by being imported.
  imports = [
    ./editors
    ./languages
    ./terminal
    ./shell
    ./fonts
    ./vcs
    ./k8s
    ./containers
    ./browsers
    ./cloud
    ./security
    ./media
    ./fun
    ./files
    ./services
  ];
}
