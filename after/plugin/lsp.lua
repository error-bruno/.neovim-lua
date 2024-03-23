local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })
end)

local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-i>'] = cmp.mapping.select_prev_item(),
    ['<C-k>'] = cmp.mapping.select_next_item(),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  })
})

-- here you can setup the language servers 
-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
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
