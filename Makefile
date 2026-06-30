## Running `make` with no target prints this help.
.DEFAULT_GOAL := help

# The flake lives in this repo. Targets reference it as `$(FLAKE)#<attr>`, so they
# work from any directory — the `mk` fish wrapper runs `make -C $NIX_FLAKE …`.
# Override per invocation if the repo lives elsewhere: `make switch FLAKE=/path`.
FLAKE ?= $(HOME)/src/github.com/kasader/nix-declarative

# Per-system target groups, mirroring the modules/{home,darwin,nixos} split:
#   common — host-agnostic maintenance (check, fmt, gc, update, …)
#   darwin — macOS (nix-darwin) host targets
#   nixos  — NixOS host targets
include mk/common.mk
include mk/darwin.mk
include mk/nixos.mk

.PHONY: help switch build

help: ## Show this help
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# ── Host-aware activation ────────────────────────────────────────────
# One command that does the right thing on any host: picks darwin-rebuild vs
# nixos-rebuild by OS, and the flake attr from the lowercased short hostname
# (israfel, ramiel). If a host's name doesn't match its flake attr, use the
# explicit per-host target instead (`make help`).
switch: ## Build + activate THIS host (auto-detects OS + hostname)
	@host=$$(hostname -s | tr '[:upper:]' '[:lower:]'); \
	if [ "$$(uname)" = Darwin ]; then \
	  sudo darwin-rebuild switch --flake $(FLAKE)#$$host; \
	else \
	  sudo nixos-rebuild switch --flake $(FLAKE)#$$host; \
	fi

build: ## Build THIS host without activating (auto-detects OS + hostname)
	@host=$$(hostname -s | tr '[:upper:]' '[:lower:]'); \
	if [ "$$(uname)" = Darwin ]; then \
	  darwin-rebuild build --flake $(FLAKE)#$$host; \
	else \
	  nixos-rebuild build --flake $(FLAKE)#$$host; \
	fi
