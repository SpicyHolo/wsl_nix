-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Get theme colors
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  end,
})

-- Config autocomplete (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),          -- Trigger completion manually
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection (with Enter)
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- Navigate to the next item
      else
        fallback() -- Use default <Tab> behavior
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- Navigate to the previous item
      else
        fallback() -- Use default <Shift-Tab> behavior
      end
    end, { 'i', 's' }),

    ['<C-e>'] = cmp.mapping.abort(),                -- Close the completion menu
    ['<C-j>'] = cmp.mapping.select_next_item(),     -- Navigate down in the completion menu
    ['<C-k>'] = cmp.mapping.select_prev_item(),     -- Navigate up in the completion menu
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completions
    { name = 'luasnip' },   -- Snippet completions
    { name = 'buffer' },    -- Buffer completions
    { name = 'path' },      -- Path completions
  }),

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For snippet support
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      -- Base source name labels
      local source_names = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      }

      -- Start with source labels
      vim_item.menu = source_names[entry.source.name] or ""
      return vim_item
    end,
  },

})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = true;
  underline = true;
  update_in_insert = false,
  severity_sort = true,
})


-- Add language servers supports


require('lspconfig').cmake.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').nil_ls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').clangd.setup({
  cmd = { "clangd", "--compile-commands-dir=build" },  -- If you have a compile_commands.json in a separate build folder
  root_dir = require'lspconfig'.util.root_pattern("CMakeLists.txt", ".git"),
  settings = {
    clangd = {
      includePath = { "./include", "./src" },  -- Add additional include directories here
      compilationDatabaseDirectory = "build",  -- Specify the build directory for the `compile_commands.json` file
    }
  }
})
require('lspconfig').lua_ls.setup{
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },

      diagnostics = {
        globals = { "vim" },
      },
    }
  }
}
require('lspconfig').racket_langserver.setup{
  cmd = { "racket", "-l", "racket-langserver" },
  filetypes = { "racket" },
  root_dir = require('lspconfig.util').root_pattern(".git", "."),
}


