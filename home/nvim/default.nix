{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [
      ripgrep

      # LSP servers
      cmake-language-server
      gopls
      nil
      pyright
      clang-tools
      lua-language-server
      racket
      jdt-language-server

      # Formatters/tools
      nixfmt
    ];

    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      cmp-path
      cmp-buffer
      luasnip

      # UI / editing
      indentLine
      comment-nvim
      rainbow-delimiters-nvim

      {
        plugin = nvim-surround;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-surround.lua;
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/lualine.lua;
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/telescope.lua;
      }

      {
        plugin = harpoon;
        type = "lua";
        config = builtins.readFile ./plugins/harpoon.lua;
      }

      {
        plugin = kanagawa-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/kanagawa.lua;
      }

      {
        plugin = cyberdream-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/cyberdream.lua;
      }

      {
        plugin = catppuccin-nvim;
        type = "viml";
        config = "colorscheme catppuccin";
      }

      # Tree-sitter
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-c
          p.tree-sitter-cpp
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-go
          p.tree-sitter-racket
        ]);

        type = "lua";
        config = builtins.readFile ./plugins/treesitter.lua;
      }
    ];

    initLua = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./lsp.lua}
    '';
  };
}
