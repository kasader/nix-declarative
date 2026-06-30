{ config, lib, ... }:
let
  cfg = config.custom.nvf;
in
{
  # Alternative Neovim provider to custom.nvim — mutually exclusive with it (see
  # editors/default.nix). Left off in the base profile because nvf >= 3a764365
  # regressed the legacy vim.maps.* options so that the keymaps module accesses
  # every (undefined) legacy mode and aborts eval. Flip on once upstream restores
  # defaults for vim.maps.*, and turn custom.nvim off in the same change.
  options.custom.nvf.enable = lib.mkEnableOption "nvf-managed Neovim (alternative to custom.nvim)";

  config = lib.mkIf cfg.enable {
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
  };
}
