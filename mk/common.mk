# Host-agnostic maintenance targets. Included by the root Makefile.
.PHONY: check fmt update update-input generations gc clean optimize vim-plugins

check: ## Evaluate every flake output without building (fast correctness gate)
	nix flake check --no-build

fmt: ## Format all .nix files with nixfmt
	find . -name '*.nix' -not -path './.git/*' -exec nixfmt {} +

update: ## Update all flake inputs (rewrites flake.lock)
	nix flake update

update-input: ## Update a single input: make update-input INPUT=nixpkgs
	nix flake update $(INPUT)

generations: ## List home-manager generations
	home-manager generations

gc: ## Delete user generations older than 14 days, then collect garbage
	nix-collect-garbage --delete-older-than 14d

clean: ## Aggressively delete ALL old generations (add sudo on NixOS for system gens)
	nix-collect-garbage -d

optimize: ## Deduplicate the Nix store with hard links
	nix store optimise

vim-plugins: ## List available vim plugins
	nix-env -f '<nixpkgs>' -qaP -A vimPlugins
