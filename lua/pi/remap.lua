vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--vim.keymap.set("n", "<leader>r", ":source ~/.vimrc<CR>")
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader><space>", vim.cmd.nohlsearch)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
    require("CopilotChat").ask(args.args, { selection = require("CopilotChat.select").visual })
end, { nargs = "*", range = true })

vim.keymap.set("n", "<leader>av", ":CopilotChat<cr>")
vim.keymap.set("n", "<leader>cc", function ()
  local input = vim.fn.input("Quick Chat: ")

  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end)
--vim.keymap.set("x", "<leader>av", ":CopilotChatVisual<cr>")
vim.keymap.set("n", "<leader>ae", "<cmd>CopilotChatExplain<cr>")
vim.keymap.set("n", "<leader>at", "<cmd>CopilotChatTests<cr>")
-- The following commands don't seem to work
vim.keymap.set("n", "<leader>ar", "<cmd>CopilotChatReview<cr>")
vim.keymap.set("n", "<leader>aR", "<cmd>CopilotChatRefactor<cr>")
