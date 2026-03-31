{ pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;

      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";

      vim.statusline.lualine.enable = true;

      vim.languages.nix.enable = true;
      vim.languages.go.enable = true;

      vim.languages.enableLSP = true;
      vim.languages.enableTreesitter = true;

      # vim.languages.go.lsp.enable = true;

      vim.lsp = {
        enable = true;
      };
    };

  };
} 
