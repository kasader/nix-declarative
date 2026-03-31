{ lib, ... }: let
	xxx = "";
in {
	programs.fish = {
		enable = true;

		# Runs ONLY when creating an interactive shell (not that that matters with fish, really).
		shellInit = 
			''
				set -U fish_greeting ""
				starship init fish | source
				pay-respects fish --alias | source
			'';

		shellAliases = {
			c = "clear";
			# TODO: add more shell aliases (borrow from older conifgs, at some point).
			# ...
		};

		shellAbbrs = {
			g = "git";
                        ga = "git add";
			gc = "git commit -m";
			gcn = "git commit -n -m";
			gd = "git diff";
			gds = "git diff --staged";
			gs = "git status";
			
			# TODO: add more abbreviations here. 
			# (See: https://github.com/donovanglover/nix-config/blob/master/home/fish.nix)
		};

		functions = {
			y = # fish
				''
				set tmp (mktemp -t "yazi-cwd.XXXXXX")
				yazi $argv --cwd-file="$tmp"
				if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "cwd" != "$pwd" ]
					builtin cd -- "$cwd"
				end
				rm -f -- "$tmp"
				'';
		};
	};
}
