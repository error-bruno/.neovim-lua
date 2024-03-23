local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = math.floor(gwidth * 0.8)
local height = math.floor(gheight * 0.8)

local buf
local win
local open_todo_float = function()
  buf = vim.api.nvim_create_buf(false, true)

  win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = (gheight - height) / 2,
    col = (gwidth - width) / 2,
    style = 'minimal',
    border = 'shadow',
  })

  vim.fn.termopen('~/scripts/jira.sh; read', {
    cwd = vim.fn.getcwd(),
    on_exit = function()
      -- Close the floating window when the shell script exits
      vim.api.nvim_win_close(win, true)
      vim.api.nvim_buf_delete(buf, {force = true})
    end
  })

  -- In order to interact with the script, we need to enter insert mode
  vim.api.nvim_feedkeys('i', 'n', true)
end

vim.keymap.set('n', '<leader>jt', open_todo_float, {})
