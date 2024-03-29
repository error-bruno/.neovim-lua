local u = require("pi/utils")
local m, k = u.cmd_map, u.key_map

m("<leader>w", "w")
m("<leader>q", "q")

k("<leader>pv", vim.cmd.Ex) -- Open file browser
k("<leader><space>", vim.cmd.nohlsearch) -- Clear search highlight
k("J", ":m '>+1<CR>gv=gv", "v") -- Move line down
k("K", ":m '<-2<CR>gv=gv", "v") -- Move line up

k("J", "mzJ`z") -- Join line, keep cursor position
k("<C-d>", "<C-d>zz") -- Scroll down, keep cursor position
k("<C-u>", "<C-u>zz") -- Scroll up, keep cursor position
k("n", "nzzzv") -- Move to next search result, keep cursor position
k("N", "Nzzzv") -- Move to previous search result, keep cursor position

k("p", '"_dP', "x") -- Paste without yanking
k("<leader>y", '"+y') -- Copy to system clipboard
k("<leader>y", '"+y', "v") -- Copy to system clipboard in visual mode
k("<leader>Y", '"+Y') -- Copy to system clipboard

-- Set keymaps for quick fix
k("<C-j>", "<cmd>cnext<CR>zz")
k("<C-k>", "<cmd>cprev<CR>zz")
k("<leader>j", "<cmd>lnext<CR>zz")
k("<leader>k", "<cmd>lprev<CR>zz")
