return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "ruby", "javascript", "go" },
			highlight = { enable = true }
		})
	end
}
