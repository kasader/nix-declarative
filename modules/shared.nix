{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
{
  programs.home-manager.enable = true;

  imports = [
    # ./librewolf.nix
    ./firefox.nix
    ./fzf.nix
    ./ripgrep.nix
    ./vim.nix
    ./starship/default.nix
    ./tmux/default.nix
    ./yazi/default.nix
    ./fish/default.nix
    ./git/default.nix
    ./bash/default.nix
    ./k8s/default.nix
    ./containers/default.nix
  ]
  ++ lib.optionals isDarwin [ ./darwin ];

  home = {
    packages = with pkgs; [
      hugo
      cowsay
      lolcat
      fastfetch # TODO: Add an alias for neofetch (as it is now deprecated)
      bat
      pay-respects
      lazygit
      delta
      htop
      fortune
      figlet # funny text guy
      sl # steam engine
      jq
      nixfmt
      go # just for testing (for now)
      direnv
    ];

    file = {
      "hello.txt" = {
        text = ''
          					#!/usr/bin/env bash

          					echo "Hello, ${config.home.username}, @ ${config.home.homeDirectory}!"
          					echo '*slaps roof* This script can fit so many lines in it'
          				'';
        executable = true;
      };
    };

    # This value determines the Home Manager release that
    # this configuration is compatible with. It helps to
    # avoid breakage when a new Home Manage release
    # introduces backwards incompatible changes.
    stateVersion = "25.11";
  };

  # TODO: Move this to its own standalone file (if it is needed).
  programs.direnv = {
    enable = true;
    # FIXME: It seems like if you have 'enable = true;' then you don't need to configure your
    # options per shell.
    # enableFishIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

}
