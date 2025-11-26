{
	programs.fish = {
		enable = true;

		# Runs ONLY when creating an interactive shell (not that that matters with fish, really).
		shellInit = 
			''
				set -U fish_greeting ""
			'';

		shellAliases = {
			c = "clear"
			# TODO: add more shell aliases (borrow from older conifgs, at some point).
			# ...
		}

		shellAbbrs = {
			g = "git";
			gnm = "git commit -n -m";
			# TODO: add more abbreviations here. 
			# (See: https://github.com/donovanglover/nix-config/blob/master/home/fish.nix)
		}
	}
}
