{
  description = "My Nix home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    # https://github.com/NotAShelf/nvf
    # Neovim configuration framework for Nix
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Stating *.follows = 'nixpkgs'; indicates that
      # the home-manager input is DEPENDENT on nixpkgs. I.e, an import DAG creation.
    };

    # macOS system layer. Release branch pinned to match nixpkgs/home-manager
    # (25.11). follows = nixpkgs keeps the whole tree on one nixpkgs.
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository — provides rycee.firefox-addons for declarative browser extensions.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      nvf,
      nur,
      ...
    }:
    let
      lib = nixpkgs.lib;
    in
    {
      # ── NixOS hosts ──────────────────────────────────────────────────
      # ramiel integrates home-manager into the system, so a single
      # `nixos-rebuild switch --flake .#ramiel` builds system + home. The
      # portable home core (profiles/home/*) is reused verbatim via
      # ./hosts/ramiel/home.nix. Home is managed only here — there is no
      # standalone homeConfiguration, so ~/.nix-profile is never owned by a
      # second activation path (which is what broke the login shell before).
      nixosConfigurations.ramiel = lib.nixosSystem {
        modules = [
          ./hosts/ramiel/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            # NUR overlay on the *system* pkgs so the integrated HM (which
            # uses useGlobalPkgs) can resolve rycee.firefox-addons.floccus.
            nixpkgs.overlays = [ nur.overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                isDarwin = false;
              };
              sharedModules = [ nvf.homeManagerModules.default ];
              users.kasada.imports = [ ./hosts/ramiel/home.nix ];
            };
          }
        ];
      };

      # ── macOS hosts ──────────────────────────────────────────────────
      # israfel integrates home-manager into nix-darwin, so a single
      # `darwin-rebuild switch --flake .#israfel` builds system + home —
      # the same two-tier integration as ramiel, and the system layer
      # (Homebrew, shells) now lives here instead of a separate repo.
      darwinConfigurations."israfel" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/israfel/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [ nur.overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                isDarwin = true;
              };
              sharedModules = [ nvf.homeManagerModules.default ];
              users.kasada.imports = [ ./hosts/israfel/home.nix ];
            };
          }
        ];
      };
    };
}
