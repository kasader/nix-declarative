{
	description = "My Nix home-manager configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-23.11";

		home-manager  = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs"; # Stating *.follows = 'nixpkgs'; indicates that
			# the home-manager input is DEPENDENT on nixpkgs. I.e, an import DAG creation.
		};
	};

	outputs = { nixpkgs, home-manager, ... }:
		let 
			lib = nixpkgs.lib;
			system = "aarch64-linux";
			pkgs = import nixpkgs { inherit system; };
		in {
			homeConfigurations = {
				kasada = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ 
						./home.nix 
						./bash/default.nix 
						./fish/default.nix
						./tmux/default.nix
						./starship/default.nix
						./yazi/default.nix
						./git/default.nix
					];
				};
			};
		};
}
