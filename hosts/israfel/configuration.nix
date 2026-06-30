{ pkgs, ... }:
{
  # macOS system layer for israfel (nix-darwin). The user layer lives in
  # ./home.nix and is wired in via home-manager.darwinModules in flake.nix —
  # mirroring how hosts/ramiel integrates system + home on NixOS.

  environment.systemPackages = [ pkgs.vim ];

  nix.settings.experimental-features = "nix-command flakes";

  # Wires nix's environment (set-environment / nix-daemon.fish) into fish's
  # startup the same way /etc/zshenv does for zsh, so login fish shells get nix
  # on PATH.
  programs.fish.enable = true;

  # Register fish in /etc/shells so it's a valid login-shell target. The login
  # shell itself is pinned once, imperatively, to /run/current-system/sw/bin/fish
  # via `make israfel-bootstrap` — macOS owns the primary user account, so
  # nix-darwin won't chsh it declaratively. That stable path (vs the old
  # ~/.nix-profile/bin/fish, which a switch can empty) is what prevents the
  # "login shell vanished after rebuild" breakage.
  environment.shells = [ pkgs.fish ];

  # Export ZDOTDIR from /etc/zshenv so zsh finds its config under ~/.config/zsh
  # without a ~/.zshenv bootstrap stub. Pairs with programs.zsh.dotDir in home.
  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    export ZDOTDIR="$HOME/.config/zsh"
  '';

  # Declarative Homebrew. nix-darwin doesn't install brew itself — it drives the
  # existing install via a generated Brewfile on each rebuild. cleanup = "none"
  # is the gentle setting: it installs/keeps what's declared here and never
  # removes anything installed manually. Flip to "zap" once everything worth
  # keeping is declared, for full reproducibility.
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };

    # Taps required by the casks below; core casks (homebrew/cask) need none.
    taps = [
      "nikitabobko/tap" # aerospace
      "goreleaser/tap" # goreleaser
      "isen-ng/dotnet-sdk-versions" # dotnet-sdk6*
    ];

    casks = [
      # "aerospace"
      "betterdisplay"
      "dotnet-sdk"
      "dotnet-sdk6"
      "dotnet-sdk6-0-400"
      "ghostty"
      "goreleaser"
      "handbrake-app"
      "iina"
      "librewolf"
      "meld"
      "orbstack"
      "stats"
    ];

    brews = [ ]; # Phase 2: migrate `brew leaves` here incrementally.
    # masApps = { }; # Mac App Store apps by id, e.g. { "Things" = 904280696; }
  };

  # nix-darwin's home-manager integration (useUserPackages) installs into this
  # user's profile, so the user must be declared at the system layer.
  users.users.kasada = {
    name = "kasada";
    home = "/Users/kasada";
  };

  # System activation now runs as root; user-scoped options (Homebrew) apply to
  # this user instead. Required by nix-darwin 25.11 once homebrew.enable is set.
  system.primaryUser = "kasada";

  # Used for backwards compatibility; read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
