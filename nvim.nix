{ pkgs, ... }:

{
  # See (for more info on using xdg home for config defs):
  # https://haripm.com/2025/09/05/neovim-nixos-setup/
  #
  # xdg.configFile."nvim/init.lua" = {
  #   enable = true;
  #   source = ./dotfiles/nvim/init.lua;
  # };

  programs.neovim = {
    enable = true;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      telescope-nvim
      catppuccin-nvim
      conform-nvim
      nvim-autopairs
      comment-nvim
      lualine-nvim
      blink-cmp
      todo-comments-nvim
      trouble-nvim
      undotree
    ];

    extraPackages = with pkgs; [
      # formatters
      ruff
      stylua
      alejandra

      # language servers
      pyright
      lua-language-server
      nil
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
