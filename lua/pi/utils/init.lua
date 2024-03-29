local M = {}

function M.cmd_string(cmd_arg)
	return [[<cmd>]] .. cmd_arg .. [[<cr>]]
end
local function str_to_tbl(v)
	if type(v) == "string" then
		v = { v }
	end
	return v
end

function M.cmd_map(lhs, rhs, modes, opts)
	modes = str_to_tbl(modes) or { "n" }
	opts = opts or { silent = true, noremap = true }
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, M.cmd_string(rhs), opts)
	end
end
function M.key_map(lhs, rhs, modes, opts)
	modes = str_to_tbl(modes) or { "n" }
	opts = opts or { silent = true, noremap = true }
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

function M.lazy_map(lhs, rhs, modes)
	if type(rhs) == "string" then
		rhs = M.cmd_string(rhs)
	end
	modes = str_to_tbl(modes) or { "n" }
	return {
		lhs,
		rhs,
		mode = modes,
	}
end

function M.create_cmd(command, f, opts)
	opts = opts or {}
	vim.api.nvim_create_user_command(command, f, opts)
end

return M
