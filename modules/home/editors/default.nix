{ config, lib, ... }:
{
  # Editors, each toggle-gated like every other module: custom.vim, custom.nvim,
  # custom.nvf. The base profile turns custom.nvim on; vim and nvf default off.
  # nvim and nvf are two providers of the same `nvim` command, so enabling both
  # would have them fight over it — the assertion below forbids that.
  imports = [
    ./vim.nix
    ./nvim.nix
    ./nvf.nix
  ];

  config.assertions = [
    {
      assertion = !(config.custom.nvim.enable && config.custom.nvf.enable);
      message = "custom.nvim and custom.nvf are mutually exclusive Neovim providers; enable only one.";
    }
  ];
}
