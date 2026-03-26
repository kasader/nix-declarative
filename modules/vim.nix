{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      vim-go
      vim-nix
    ];

    extraConfig = 
      ''
      set autoindent
      set ts=2 sw=2
      set expandtab
      set relativenumber
      '';
  };
} 
