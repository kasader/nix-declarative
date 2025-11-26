{ lib, ... }: let
	something = "";
in {
	programs.tmux = {
		enable = true; 

		# Enables mouse support
		mouse = true; 

		keyMode = 'vi';
	};
}
