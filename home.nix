{ lib, pkgs, ... }: let
	username = "kasada";
in {
	programs.home-manager.enable = true;
	home = {
		packages = with pkgs; [
			cowsay
			lolcat
			bat
			delta
			htop
			fortune
			jq
			nixfmt
      go # just for testing (for now)
		];

		file = {
			"hello.txt" = {
				text = ''
					#!/usr/bin/env bash

					echo "Hello, ${username}!"
					echo '*slaps roof* This script can fit so many lines in it'
				'';
				executable = true;
			};
		};

		inherit username;
		homeDirectory = "/home/${username}";

		# This value determines the Home Manager release that
		# this configuration is compatible with. It helps to
		# avoid breakage when a new Home Manage release
		# introduces backwards incompatible changes.
		stateVersion = "23.11";
	};
}
