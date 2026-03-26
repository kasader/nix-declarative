{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;

      vim.languages.go.enable = true;
      vim.languages.go.lsp.enable = true;

      vim.lsp = {
        enable = true;
      };
    };

  };
} 
