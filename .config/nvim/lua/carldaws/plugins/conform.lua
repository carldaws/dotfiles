return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				ruby = { "rubocop" },
				javascript = { "prettier" },
				lua = { "lua-language-server" }
			},
			format_after_save = {
				lsp_format = "fallback"
			}
		})
	end
}
