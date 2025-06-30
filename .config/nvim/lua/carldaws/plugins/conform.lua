return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			lua = { "stylua" },
			ruby = { "rubocop" },
			zig = { "zigfmt" }
		},
		format_after_save = {
			lsp_format = "fallback"
		}
	}
}
