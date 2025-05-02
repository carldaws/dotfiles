return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "lua", "ruby", "javascript", "go" },
		highlight = { enable = true }
	}
}
