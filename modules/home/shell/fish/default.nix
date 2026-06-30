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

      functions = {
        # Run the nix-declarative Makefile from any directory: `mk fmt`, `mk gc`,
        # `mk israfel`, `mk switch`, …. NIX_FLAKE is set above.
        mk = # fish
          ''
            make -C $NIX_FLAKE $argv
          '';

        y = # fish
          ''
            			set tmp (mktemp -t "yazi-cwd.XXXXXX")
            			yazi $argv --cwd-file="$tmp"
            			if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "cwd" != "$pwd" ]
            				builtin cd -- "$cwd"
            			end
            			rm -f -- "$tmp"
            			'';

        devinit = # fish
          ''
            set -l tdir $HOME/.config/dev-templates
            set -l made 0
            # source name -> destination name (flake.nix stays, envrc -> .envrc)
            for pair in flake.nix:flake.nix envrc:.envrc
              set -l src (string split -m1 ':' $pair)[1]
              set -l dst (string split -m1 ':' $pair)[2]
              if test -e $dst
                echo "devinit: $dst already exists, skipping"
              else
                cp $tdir/$src $dst
                chmod u+w $dst # nix store sources are read-only
                echo "devinit: created $dst"
                set made 1
              end
            end
            if test $made -eq 1; and type -q direnv
              direnv allow
            end
          '';
      };
    };
  };
}
