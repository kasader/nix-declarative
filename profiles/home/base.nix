{ config, pkgs, ... }:
{
  # The base profile: everything that belongs on *every* machine. It pulls in the
  # full module registry (so all `custom.*` options exist) and switches on the
  # universal set. Per-host extras are enabled in the host files instead.
  imports = [ ../../modules/home ];

  programs.home-manager.enable = true;

  custom = {
    tmux.enable = true;
    fzf.enable = true;
    vim.enable = true;
    ghostty.enable = true;
    yazi.enable = true;
    git.enable = true;
    ghq.enable = true;
    fonts.enable = true;
    shell.enable = true;
    syncthing.enable = true;
    languages = {
      go.enable = true;
      rust.enable = true;
      python3.enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      hugo
      cowsay
      lolcat

      grep
      ripgrep

      # typing tests
      ttyper
      typioca
      gtypist

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
      direnv
      tree
      wget
      tldr
      curl
      keepassxc
      yubikey-manager
      ffmpeg

      # Migrated off Homebrew (`brew leaves`). Stable, cross-platform CLI tools
      # that nix packages cleanly. Build toolchains (cmake/meson/llvm/golangci-lint
      # /mage/doxygen) deliberately stay out of the global env and belong in each
      # project's dev-shell instead.
      gh
      coreutils
      ncdu
      nmap
      socat
      inetutils # provides telnet
      aria2
      shfmt
      stylua
      universal-ctags
      graphviz
      bashInteractive
      mpv # CLI player; the `iina` cask is the GUI front-end over the same engine
      watch

      # toys, matching the cowsay/lolcat/figlet/sl set above
      asciiquarium
      cmatrix
      boxes

      # TODO: Add Soulseek server-client (at some point...)
      # https://github.com/slskd/slskd/

      # TODO: Good OCR for when you need to do JPNs something?
      # tesseract
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

    sessionVariables = {
      EDITOR = "nvim";
      MANWIDTH = "100";
      LESSOPEN = "|- ${config.home.homeDirectory}/.bin/less_wrap.sh %s";
      DIARKIS_PATH = "${config.home.homeDirectory}/diarkis";
    };

    # Per-language install dirs (Go GOBIN, cargo CARGO_INSTALL_ROOT) target
    # ~/.local/bin, so no language-specific bin dirs are needed here.
    sessionPath = [
      "$HOME/.local/bin"
    ];

    # This value determines the Home Manager release that
    # this configuration is compatible with. It helps to
    # avoid breakage when a new Home Manage release
    # introduces backwards incompatible changes.
    stateVersion = "25.11";
  };

  # TODO: Move this to its own standalone module (if it is needed).
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
