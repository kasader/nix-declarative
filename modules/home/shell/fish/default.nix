{ config, lib, ... }:
{
  config = lib.mkIf config.custom.shell.enable {
    # Templates that `devinit` copies into a project to scaffold a Nix devShell
    # + direnv. Stored as real files (not heredocs) so flake's `${system}` and
    # the shell `$` survive without nix/fish escaping.
    xdg.configFile = {
      "dev-templates/flake.nix".source = ./templates/flake.nix;
      "dev-templates/envrc".source = ./templates/envrc;
    };

    # Absolute path to this flake, so the `mk` wrapper (and any rebuild abbr) can
    # drive the Makefile from any directory. Single source of truth: custom.flakeDir.
    home.sessionVariables.NIX_FLAKE = config.custom.flakeDir;

    programs.fish = {
      enable = true;

      # Runs ONLY when creating an interactive shell (not that that matters with fish, really).
      shellInit = ''
        set -U fish_greeting ""
        starship init fish | source
        pay-respects fish --alias | source
      '';

      # Runs for login shells — env/PATH setup that terminals (Alacritty, VSCode, …) inherit.
      loginShellInit = ''
        /opt/homebrew/bin/brew shellenv fish | source

        if test -f $HOME/.local/share/google-cloud-sdk/path.fish.inc
          source $HOME/.local/share/google-cloud-sdk/path.fish.inc
        end
      '';

      shellAliases = import ./aliases.nix;
      shellAbbrs = import ./abbrs.nix;
      functions = import ./functions.nix;
    };
  };
}
