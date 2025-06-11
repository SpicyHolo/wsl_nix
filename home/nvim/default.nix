{ pkgs, ... }:
{
  programs.neovim = 
    let toLuaFile = file: "${builtins.readFile file}";
    in
    {
      enable = true;
      vimAlias = true;
      extraPackages = with pkgs; [ ripgrep ];
      plugins = with pkgs.vimPlugins; [
        # LSP
        nvim-lspconfig
        nvim-cmp 
        cmp-nvim-lsp
        cmp_luasnip
        cmp-path
        cmp-buffer
        luasnip

        # Eyecandy
        indentLine
        comment-nvim
        rainbow-delimiters-nvim
        { plugin = nvim-surround;   type = "lua"; config = toLuaFile ./plugins/nvim-surround.lua; }
        { plugin = lualine-nvim;    type = "lua"; config = toLuaFile ./plugins/lualine.lua; }
        { plugin = telescope-nvim;  type = "lua"; config = toLuaFile ./plugins/telescope.lua; }
        { plugin = harpoon;         type = "lua"; config = toLuaFile ./plugins/harpoon.lua; }
        { plugin = kanagawa-nvim;   type = "lua"; config = toLuaFile ./plugins/kanagawa.lua; }
        { plugin = cyberdream-nvim; type = "lua"; config = toLuaFile ./plugins/cyberdream.lua; }
        { plugin = catppuccin-nvim;               config = "colorscheme catppuccin"; }
        { plugin = (nvim-treesitter.withPlugins (p: [
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
          ]));
          type = "lua";
          config = toLuaFile ./plugins/treesitter.lua;
        }
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./remap.lua}
        ${builtins.readFile ./lsp.lua}
      '';
    };
}
