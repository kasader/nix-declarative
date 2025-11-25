{ lib, pkgs, ... }
{
	home = {
		packages = with pkgs; [
			hello
		];

		username = "kasada";
		homeDirectory = "/home/kasada";

		stateVersion = "23.11";
	};
}
