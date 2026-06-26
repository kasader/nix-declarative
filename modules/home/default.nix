{ ... }:
{
  # Module registry. Importing a module here only *declares* its
  # `custom.<name>.enable` option — everything defaults to off. Deciding what to
  # turn on is a separate concern owned by profiles and hosts:
  #   - profiles/base.nix  enables the universal set (every machine)
  #   - hosts/<name>       enable per-host extras (k8s, containers, browsers, …)
  #
  # So "is this module available?" and "is this module on?" are answered in
  # different places — nothing is active merely by being imported.
  imports = [
    ./tmux
    ./fzf.nix
    ./editors
    ./yazi
    ./git
    ./shell
    ./syncthing.nix
    ./k8s
    ./containers
    ./browsers
  ];
}
