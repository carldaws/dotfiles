vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.winborder = "rounded"
vim.opt.autoread = true

vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/carldaws/miser.nvim" },
	{ src = "https://github.com/gbprod/nord.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/carldaws/surface.nvim" },
})

local icons = require("mini.icons")
local lualine = require("lualine")
local miser = require("miser")
local nord = require("nord")
local oil = require("oil")
local pick = require("mini.pick")
local surface = require("surface")
local treesitter = require("nvim-treesitter")

icons.setup()

lualine.setup({
	options = {
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
})

miser.setup({
	task_runner = function(cmd)
		surface.open(cmd, "right")
	end,
	task_keymaps = { enabled = true, prefix = "<leader>" },
})

nord.setup({
	transparent = true,
	on_highlights = function(highlights, colors)
		highlights.FloatBorder = { fg = colors.aurora.purple }
		highlights.NormalFloat = { bg = "NONE" }
	end,
})
vim.cmd.colorscheme("nord")

oil.setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
})

pick.setup({
	source = {
		show = function(buf_id, items, query)
			return pick.default_show(buf_id, items, query, { show_icons = true })
		end,
	},
})

treesitter.setup()
treesitter.install({
	"ruby",
	"embedded_template",
	"go",
	"gomod",
	"typescript",
	"tsx",
	"javascript",
	"html",
	"css",
	"scss",
	"elixir",
	"heex",
	"lua",
	"markdown",
	"markdown_inline",
	"json",
	"yaml",
	"toml",
})

vim.treesitter.language.register("embedded_template", "eruby")
vim.treesitter.language.register("javascript", "javascriptreact")

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if vim.treesitter.language.get_lang(args.match) then
			pcall(vim.treesitter.start)
		end
	end,
})

surface.setup({})

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>f", function()
	pick.builtin.files({}, { source = { name = "Files" } })
end)
vim.keymap.set("n", "<leader>g", function()
	pick.builtin.grep_live({}, { source = { name = "Grep" } })
end)
vim.keymap.set("n", "<leader>*", function()
	pick.builtin.grep({ pattern = vim.fn.expand("<cword>") }, { source = { name = "Grep" } })
end)
vim.keymap.set("n", "<leader>b", function()
	pick.builtin.buffers({}, { source = { name = "Buffers" } })
end)
vim.keymap.set("n", "<leader>m", function()
	local files = vim.fn.systemlist("git ls-files --modified --others --exclude-standard")
	pick.start({ source = { name = "Modified", items = files } })
end, { desc = "Git modified files" })
vim.keymap.set("n", "<leader>?", function()
	local function on_list(what)
		local items = {}
		for _, item in ipairs(what.items) do
			table.insert(items, {
				text = item.filename,
				path = item.filename,
				lnum = item.lnum,
				col = item.col,
			})
		end
		pick.start({ source = { items = items } })
	end
	vim.lsp.buf.references(nil, { on_list = on_list })
end)
vim.keymap.set("n", "!", vim.diagnostic.open_float, { noremap = true })
