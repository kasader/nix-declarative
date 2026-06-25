{ pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim.diagnostics.enable = true;
      vim.diagnostics.config.virtual_lines = true;

      vim.viAlias = false;
      vim.vimAlias = true;

      vim.options = {
        autoindent = true;
        smartindent = true;
        shiftwidth = 4;
        signcolumn = "yes";
        tabstop = 4;
        expandtab = true;
        wrap = false;
      };

      vim.maps.command = { };

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

      # Automatically indents on newline between {}.
      vim.autopairs.nvim-autopairs.enable = true;

      vim.languages.enableLSP = true;
      vim.languages.enableTreesitter = true;

      vim.treesitter.indent.enable = false;

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
