# fish functions; imported by ./default.nix.
{
  # Run the nix-declarative Makefile from any directory: `mknix fmt`, `mknix gc`,
  # `mknix israfel`, `mknix switch`, ... NIX_FLAKE is set above. Named `mknix`
  # (not `mk`) because `mk` is already a program on PATH.
  mknix = # fish
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
      # source name -> destination name (flake.nix stays; envrc -> .envrc;
      # env.example -> .env.example, the committed secret contract)
      for pair in flake.nix:flake.nix envrc:.envrc env.example:.env.example
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
      # The .env cache holds real secrets and must never be committed. -x pins
      # the whole-line match so it doesn't trip on the .env.example entry.
      if not test -e .gitignore; or not grep -qxF '.env' .gitignore
        echo '.env' >> .gitignore
        echo "devinit: added .env to .gitignore"
      end
      if test $made -eq 1; and type -q direnv
        direnv allow
      end
    '';
}
