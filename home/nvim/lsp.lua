-- Reserve a space in the gutte-- Reserve space in the gutter.
vim.opt.signcolumn = "yes"

-- ============================================================================
-- nvim-cmp
-- ============================================================================

local cmp = require("cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, item)
      local source_names = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      }

      item.menu = source_names[entry.source.name] or ""

      return item
    end,
  },
})


-- ============================================================================
-- Diagnostics
-- ============================================================================

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },

  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


-- ============================================================================
-- LSP keybindings
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",

  callback = function(event)
    local opts = {
      buffer = event.buf,
      silent = true,
    }

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", builtin.lsp_references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

    vim.keymap.set(
      { "n", "x" },
      "<F3>",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      opts
    )

    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

    vim.keymap.set(
      "n",
      "<leader>d",
      vim.diagnostic.open_float,
      opts
    )
  end,
})


-- ============================================================================
-- LSP configuration
-- ============================================================================
--
-- Neovim 0.11+ uses:
--
--     vim.lsp.config("server", {...})
--     vim.lsp.enable("server")
--
-- instead of:
--
--     require("lspconfig").server.setup({...})
--
-- ============================================================================


-- CMake
vim.lsp.config("cmake", {
  capabilities = capabilities,
})

-- Go
vim.lsp.config("gopls", {
  capabilities = capabilities,

  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
    },
  },
})

-- Nix
vim.lsp.config("nil_ls", {
  capabilities = capabilities,
})

-- Python
vim.lsp.config("pyright", {
  capabilities = capabilities,
})

-- C / C++
vim.lsp.config("clangd", {
  capabilities = capabilities,

  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
  },
})

-- Lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },

      diagnostics = {
        globals = {
          "vim",
        },
      },

      workspace = {
        checkThirdParty = false,
      },

      telemetry = {
        enable = false,
      },
    },
  },
})

-- Racket
vim.lsp.config("racket_langserver", {
  capabilities = capabilities,

  cmd = {
    "racket",
    "-l",
    "racket-langserver",
  },

  filetypes = {
    "racket",
  },
})

-- Java
vim.lsp.config("jdtls", {
  capabilities = capabilities,
})


-- ============================================================================
-- Enable language servers
-- ============================================================================

vim.lsp.enable({
  "cmake",
  "gopls",
  "nil_ls",
  "pyright",
  "clangd",
  "lua_ls",
  "racket_langserver",
  "jdtls",
})
