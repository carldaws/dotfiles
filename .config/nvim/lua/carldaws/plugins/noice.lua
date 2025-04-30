return {
	"folke/noice.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	config = function()
		require("noice").setup({
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true
			}
		})
	end
}
