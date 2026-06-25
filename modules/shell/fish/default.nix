{ lib, ... }:
let
  xxx = "";
in
{
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

    shellAliases = {
      c = "clear";
      vim = "nvim";
      # TODO: add more shell aliases (borrow from older conifgs, at some point).
      # ...
    };

    shellAbbrs = {

      # git family
      g = "git";
      ga = "git add";
      gcm = "git commit -m";
      gcnm = "git commit -n -m";
      gd = "git diff";
      gds = "git diff --staged";
      gs = "git status";
      gp = "git push";
      gpf = "git push --force";

      lg = "lazygit";
      gcnv = "git commit --no-verify -m";

      # go family
      glci = "golangci-lint run ./...";

      # gcloud family
      gclist = "gcloud config configurations list";
      gcact = "gcloud config configuration activate";

      # k8s family
      k = "kubectl";
      kctx = "kubectx";
      kns = "kubens";

      e = "$EDITOR";
      c = "clear";

      ls = "ls --color";

      # TODO: add more abbreviations here.
      # (See: https://github.com/donovanglover/nix-config/blob/master/home/fish.nix)
    };

    functions = {
      y = # fish
        ''
          				set tmp (mktemp -t "yazi-cwd.XXXXXX")
          				yazi $argv --cwd-file="$tmp"
          				if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "cwd" != "$pwd" ]
          					builtin cd -- "$cwd"
          				end
          				rm -f -- "$tmp"
          				'';
    };
  };
}
