{ lib, pkgs, ... }: let
	username = "kasada";
in {
	home = {
		packages = with pkgs; [
			cowsay
			lolcat
			bat
			delta
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

		stateVersion = "23.11";
	};
}
