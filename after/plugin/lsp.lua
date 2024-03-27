local lsp_zero = require('lsp-zero')

-- When lsp_zero attaches, set keymaps
lsp_zero.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

  -- Unsure what these do
  --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
        "i",
        "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, {
      "i",
      "s"
    })
  }),
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" },
  },
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'gopls',
    'rust_analyzer',
    'pyright',
    'lua_ls',
  },
  handlers = {
    lsp_zero.default_setup,
    gopls = function ()
      require('lspconfig').gopls.setup({
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            gofumpt = true,
          }
        }
      })
    end,
    lua_ls = function ()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            }
          }
        }
      })
    end
  },
})
