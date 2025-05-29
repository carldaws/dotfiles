return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			ruby = { "rubocop" },
			javascript = { "prettier" },
			lua = { "lua-language-server" },
		},
		format_after_save = {
			lsp_format = "fallback"
		}
	}
}
