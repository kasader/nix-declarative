# fish functions; imported by ./default.nix.
{
  # Run the nix-declarative Makefile from any directory: `mk fmt`, `mk gc`,
  # `mk israfel`, `mk switch`, ... NIX_FLAKE is set above.
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
}
