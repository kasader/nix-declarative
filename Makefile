.PHONY: update
update:
	home-manager switch --flake .#kasada

.PHONY: clean
clean:
	nix-collect-garbage -d 
