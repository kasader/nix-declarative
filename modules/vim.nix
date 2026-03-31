{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-go
      vim-nix
    ];

    extraConfig = 
      ''
      set autoindent
      set ts=2 sw=2
      set expandtab
      set relativenumber

      set nocompatible

      " Syntax highlighting on by default:
      syntax on
      '';
  };
} 
