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

		home-manager  = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs"; # Stating *.follows = 'nixpkgs'; indicates that
			# the home-manager input is DEPENDENT on nixpkgs. I.e, an import DAG creation.
		};
	};

	outputs = { nixpkgs, home-manager, nvf, ... }:
		let 
			lib = nixpkgs.lib;

			pkgsLinux = import nixpkgs {
				system = "x86_64-linux";
				config.allowUnfree = true;
      };

			pkgsDarwin = import nixpkgs {
				system = "aarch64-darwin";
				config.allowUnfree = true;
			};

		in {
			homeConfigurations = {
				"kasada@ramiel" = home-manager.lib.homeManagerConfiguration {
				  pkgs = pkgsLinux;
					# Platform flag passed via specialArgs so modules can branch `imports`
					# without reading `pkgs` (which would be an infinite recursion).
					extraSpecialArgs = { inherit (pkgsLinux.stdenv) isDarwin; };
					modules = [ ./hosts/ramiel/home.nix nvf.homeManagerModules.default ./nvf.nix ]; # <- this imports the home-manager module that provides the options
				};

				"kasada@israfel" = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgsDarwin;
					extraSpecialArgs = { inherit (pkgsDarwin.stdenv) isDarwin; };
					modules = [ ./hosts/israfel/home.nix nvf.homeManagerModules.default ./nvf.nix ];
				};
			};
		};
}
