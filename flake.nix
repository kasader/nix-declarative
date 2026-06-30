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

      # Host factory. Every host uses the same two-tier integration: one
      # `{nixos,darwin}-rebuild switch` builds system + home together, with the
      # portable home core (profiles/home/*) reused verbatim via the host's
      # home.nix. Home is managed only through this integration — there is no
      # standalone homeConfiguration, so ~/.nix-profile is never owned by a
      # second activation path (which is what broke the login shell before).
      #
      # `isDarwin` selects the system builder, the matching home-manager module,
      # and the platform flag handed to home modules via specialArgs (they branch
      # on it without reading `pkgs`, which would be infinite recursion). Each
      # host's configuration.nix owns its own nixpkgs.hostPlatform.
      mkHost =
        { isDarwin, hostDir }:
        let
          builder = if isDarwin then nix-darwin.lib.darwinSystem else lib.nixosSystem;
          hmModule =
            if isDarwin then
              home-manager.darwinModules.home-manager
            else
              home-manager.nixosModules.home-manager;
        in
        builder {
          modules = [
            (hostDir + "/configuration.nix")
            hmModule
            {
              nixpkgs.config.allowUnfree = true;
              # NUR overlay on the *system* pkgs so the integrated HM (which uses
              # useGlobalPkgs) can resolve rycee.firefox-addons.
              nixpkgs.overlays = [ nur.overlays.default ];

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit isDarwin; };
                sharedModules = [ nvf.homeManagerModules.default ];
                users.kasada.imports = [ (hostDir + "/home.nix") ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.ramiel = mkHost {
        isDarwin = false;
        hostDir = ./hosts/ramiel;
      };

      darwinConfigurations.israfel = mkHost {
        isDarwin = true;
        hostDir = ./hosts/israfel;
      };
    };
}
