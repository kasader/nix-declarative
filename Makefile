## Running `make` with no target prints this help.
.DEFAULT_GOAL := help

# The flake lives in this repo on every machine — there is no need to copy it to
# /etc/nixos. Targets reference it as `$(FLAKE)#<attr>`, so either run make from
# the repo root or override: `make ramiel FLAKE=/home/kasada/.config/nix-declarative`.
FLAKE ?= .

.PHONY: help \
        israfel ramiel ramiel-home \
        israfel-build ramiel-build ramiel-test \
        check fmt update update-input \
        generations gc clean optimise vim-plugins

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# ── Switch: build + activate ─────────────────────────────────────────
israfel: ## macOS home: activate .#kasada@israfel (home-manager, no sudo)
	home-manager switch --flake $(FLAKE)#kasada@israfel

ramiel: ## NixOS ramiel: activate system + home in one shot (nixos-rebuild)
	sudo nixos-rebuild switch --flake $(FLAKE)#ramiel

ramiel-home: ## TRANSITIONAL: ramiel home only via standalone HM — drop once `ramiel` is trusted
	home-manager switch --flake $(FLAKE)#kasada@ramiel

# ── Build / test: no permanent activation ────────────────────────────
israfel-build: ## Build israfel home into ./result without activating
	home-manager build --flake $(FLAKE)#kasada@israfel

ramiel-build: ## Build ramiel system into ./result without activating
	nixos-rebuild build --flake $(FLAKE)#ramiel

ramiel-test: ## Activate ramiel now but DON'T make it the boot default (reverts on reboot)
	sudo nixos-rebuild test --flake $(FLAKE)#ramiel

# ── Maintenance ──────────────────────────────────────────────────────
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
