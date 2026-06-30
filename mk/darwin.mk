# macOS (nix-darwin) host targets. Included by the root Makefile.
.PHONY: israfel israfel-build israfel-bootstrap

israfel: ## macOS israfel: activate system + home in one shot (darwin-rebuild, needs sudo)
	sudo darwin-rebuild switch --flake $(FLAKE)#israfel

israfel-build: ## Build israfel system + home without activating
	darwin-rebuild build --flake $(FLAKE)#israfel

# One-time, per-machine, imperative bootstrap. macOS can't express these
# declaratively: Homebrew 6+ gates third-party-tap casks behind a local trust
# store, and the primary user's login shell is owned by macOS (not nix-darwin).
# Pinning the shell to /run/current-system/sw/bin/fish — which tracks the live
# system generation and so survives rebuilds and GC — is what stops the login
# shell from ever vanishing again. Idempotent; safe to re-run.
israfel-bootstrap: ## One-time macOS setup: trust brew taps + pin a stable fish login shell
	brew trust --tap nikitabobko/tap goreleaser/tap isen-ng/dotnet-sdk-versions
	@test -x /run/current-system/sw/bin/fish || { echo "Run 'make israfel' first, then re-run this."; exit 1; }
	grep -qxF /run/current-system/sw/bin/fish /etc/shells || echo /run/current-system/sw/bin/fish | sudo tee -a /etc/shells
	chsh -s /run/current-system/sw/bin/fish
