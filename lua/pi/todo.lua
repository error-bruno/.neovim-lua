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
  vim.cmd.edit '~/notes/todo.md'

  vim.opt.number = true
  vim.opt.relativenumber = true
  -- move cursor to line 3 on open
  vim.api.nvim_win_set_cursor(win, {3, 6})

  -- check if line 3 is '- [ ]' and if not, set it to '- [ ]'
  local line = vim.api.nvim_buf_get_lines(buf, 0, 3, false)
  -- clear whitespice at the end of line 3
  local line3 = vim.fn.substitute(line[3], '\\s*$', '', '')
  if line3 ~= '- [ ]' then
    vim.api.nvim_put({'- [ ] '}, 'l', false, true)
    vim.api.nvim_win_set_cursor(win, {3, 6})
  end

  vim.keymap.set('n', '<leader>q', function()
    vim.cmd('w')
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, {force = true})
  end, {buffer = buf})
end

vim.keymap.set('n', '<leader>td', open_todo_float, {})
