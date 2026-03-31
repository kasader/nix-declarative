{ pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;

      vim.options = {
        autoindent = true;
        smartindent = true;
        cindent = true;
        shiftwidth = 2;
        signcolumn = "yes";
        tabstop = 2;
        expandtab = true;
        wrap = false; 
      };

      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";

      vim.statusline.lualine.enable = true;

      vim.languages.nix.enable = true;
      vim.languages.go = {
        enable = true;
        format.enable = true;
        treesitter.enable = true;
      };

      vim.languages.enableLSP = true;
      vim.languages.enableTreesitter = true;

      # vim.languages.go.lsp.enable = true;

      vim.lsp = {
        enable = true;
      };

      vim.autocmds = [
        {
          event = [ "BufWritePre" ];
          pattern = [ "*.go" ];
          command = "lua vim.lsp.buf.format()";
        }
      ]; 
    };

  };
} 
