return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			taplo = {
				args = { "format", "-o", "reorder_keys=true" }
			}
		},
		formatters_by_ft = {
			c = { "clang-format" },
			ruby = { "rubocop" },
			javascript = { "prettier" },
			lua = { "lua-language-server" },
			toml = { "taplo" }
		},
		format_after_save = {
			lsp_format = "fallback"
		}
	}
}
