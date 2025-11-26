{ lib, ... }:

{
	programs.starship = {
		enable = true;

		enableFishIntegration = true;
		enableTransience = true;

		# TODO: Presets will be added in the next release of home-manager (I think).
		# presets = [ "nerd-font-symbols" ];

		settings = {
			add_newline = false;
		};
	};
}
