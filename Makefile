.PHONY: update
update:
	home-manager switch --flake .#kasada

.PHONY: clean
clean:
	nix-collect-garbage -d 

.PHONY: vim-plugins
vim-plugins:
	nix-env -f '<nixpkgs>' -qaP -A vimPlugins.
