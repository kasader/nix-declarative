{ lib ... }: let
	something = "";
in {
	programs = {
		bash = {
			enable = true;

			shellAliases = {
				f = "fish"
				grep = "grep --color=auto"
				ls = "ls --color"
			}
		}
	}
}
