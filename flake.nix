{
	description = "My Nix home-manager configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";

		home-manager  = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs"; # Stating *.follows = 'nixpkgs'; indicates that
			# the home-manager input is DEPENDENT on nixpkgs. I.e, an import DAG creation.
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }:
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
					modules = [ ./hosts/ramiel/home.nix ];
				};

				"kasada@israfel" = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgsDarwin;
					modules = [ ./hosts/israfel/home.nix ];
				};
			};
		};
}
