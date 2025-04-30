return {
	"carldaws/miser.nvim",
	config = function()
		require("miser").setup({
			tools = { "lua-language-server", "ruby-lsp", "rubocop", "typescript-language-server", "prettier", "gopls" }
		})
	end
}
