return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({ float = { border = "rounded" }, virtual_text = true })
		local lspconfig = require("lspconfig")
		local servers = { "lua_ls", "ruby_lsp", "rubocop", "ts_ls", "gopls", "html", "clangd" }
		local on_attach = function(client, bufnr)
			local all_chars = {}
			for i = 32, 126 do
				table.insert(all_chars, string.char(i))
			end

			if client.server_capabilities.completionProvider then
				client.server_capabilities.completionProvider.triggerCharacters = all_chars
			end
			vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions,
				{ noremap = true, silent = true, buffer = bufnr })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
				{ noremap = true, silent = true, buffer = bufnr })
		end

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach
			})
		end

		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
						},
					},
				})
			end,
			settings = { Lua = {} },
		})
	end
}
