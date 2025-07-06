return {
	"gbprod/nord.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("nord").setup({
			transparent = true,
		})
		vim.cmd.colorscheme("nord")
	end,
}
