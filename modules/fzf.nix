{ lib, ... }:

{
	programs.fzf = {
		enable = true;

		# TODO: Insert other useful features, etc.

		defaultCommand = "rg --files --hidden --glob=!.git/";
	};
}
