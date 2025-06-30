return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "astro", "css", "html", "markdown", "lua", "javascript", "ruby", "zig" },
		highlight = { enable = true },
	},
}
