## Set default command of make to help, so that running make will output help texts
.DEFAULT_GOAL := help

.PHONY: help ramiel israfel update-locks clean vim-plugins

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

ramiel: ## Builds and switches the configuration for .#kasada@ramiel
	home-manager switch --flake .#kasada@ramiel

israfel: ## Builds and switches the configuration for .#kasada@israfel
	home-manager switch --flake .#kasada@israfel

update-locks: ## Updates flake.lock file (fetches latest packages from nixpkgs)
	nix flake update

clean: ## Cleans up old generations to free up disk space
	nix-collect-garbage -d

vim-plugins: ## Lists vim plugins
	nix-env -f '<nixpkgs>' -qaP -A vimPlugins.
