{ config, lib, pkgs, ... }:
let
  cfg = config.custom.vim;
in
{
  options.custom.vim.enable = lib.mkEnableOption "vim editor";

  config = lib.mkIf cfg.enable {
    programs.vim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        vim-airline
        vim-go
        vim-nix
      ];

      extraConfig = ''
        set autoindent
        set ts=2 sw=2
        set expandtab
        set relativenumber

        set nocompatible

        " Syntax highlighting on by default:
        syntax on
      '';
    };
  };
}
