{ lib, ... }: let
	something = "";
in {
	programs = {
		bash = {
			enable = true;

			shellAliases = {
				f = "fish";
				grep = "grep --color=auto";
				ls = "ls --color";
			};

			# bashrcExtra for all shells, initExtra for interactive shells only
			initExtra = ''
				# Sets vim-style editing in Bash.
				set -o vi

				# Applies vi mode to tools that use Readline (e.g. MySQL client or Python REPL).
				set editing-mode vi

				# Exports the default editor
				export EDITOR=vim
			'';
		};
	};
}
