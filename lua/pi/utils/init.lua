local M = {}

function M.lazy_map(lhs, rhs, modes)
	if type(rhs) == "string" then
		rhs = M.cmd_string(rhs)
	end
	modes = M.str_to_tbl(modes) or { "n" }
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

function M.cmd_string(cmd_arg)
	return [[<cmd>]] .. cmd_arg .. [[<cr>]]
end

function M.str_to_tbl(v)
	if type(v) == "string" then
		v = { v }
	end
	return v
end

return M
