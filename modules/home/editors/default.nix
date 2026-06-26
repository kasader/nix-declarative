{ ... }:
{
  # Editors. vim is toggle-gated (custom.vim.enable); neovim is the primary editor
  # and is on by default. nvf is an alternative neovim setup, imported but currently
  # disabled upstream-regression — see nvf.nix. Only one neovim provider
  # (programs.neovim vs programs.nvf) should be active at a time.
  imports = [
    ./vim.nix
    ./nvim.nix
    ./nvf.nix
  ];
}
