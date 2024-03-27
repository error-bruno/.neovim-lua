return {
	'f-person/git-blame.nvim',
	opts ={
		display_virtual_text = false
	},
	config = function(_, opts)
		require('gitblame').setup(opts)
	end
}
