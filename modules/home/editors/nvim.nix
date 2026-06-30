{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.nvim;
in
{
  # Neovim, the "Nix owns the tools, Lua owns the config" way.
  #
  #   - Nix installs the binary plus every native dependency that is painful to
  #     get right by hand: LSP servers, formatters, the tree-sitter compiler,
  #     ripgrep, fd, a C compiler and node for plugins that shell out.
  #   - lazy.nvim (bootstrapped inside the Lua config) manages plugins at runtime,
  #     so trying a plugin never needs a home-manager rebuild and every upstream
  #     neovim guide applies verbatim.
  #   - The Lua config lives in this repo and is mounted as an *out-of-store*
  #     symlink (see xdg.configFile below), so edits under nvim/ take effect on
  #     the next restart with no rebuild, yet stay version-controlled.
  #
  # We deliberately leave programs.neovim.plugins / extraConfig empty: a non-empty
  # value makes home-manager generate its own init.lua, which would collide with
  # the symlinked config dir. Plugins and config are owned by Lua, not Nix.

  options.custom.nvim.enable = lib.mkEnableOption "Neovim (lazy.nvim-managed, out-of-store Lua config)";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;

      extraPackages = with pkgs; [
        # ── tools plugins shell out to ──
        ripgrep # telescope live-grep
        fd # telescope file finder
        tree-sitter # :TSUpdate grammar compilation
        gcc # treesitter / native plugin compilation
        gnumake # build step for fzf-native etc.

        # ── Go ──
        gopls
        delve
        gotools # goimports
        gofumpt

        # ── Nix ──
        nixd
        alejandra

        # ── C / C++ ──
        clang-tools # clangd + clang-format

        # ── Web / config languages ──
        yaml-language-server
        vscode-langservers-extracted # jsonls, html, cssls, eslint
        dockerfile-language-server
        bash-language-server
        marksman # markdown
        taplo # toml
        nodePackages.prettier
        shfmt

        # ── Lua (to hack on this very config) ──
        lua-language-server
        stylua
      ];
    };

    # Live-editable config: symlink the repo's nvim/ dir into ~/.config/nvim rather
    # than copying it to the read-only Nix store. lazy.nvim can then write its
    # lazy-lock.json back into the repo. Repo location is the single source of
    # truth custom.flakeDir (see modules/home/default.nix).
    xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.custom.flakeDir}/modules/home/editors/nvim";
  };
}
