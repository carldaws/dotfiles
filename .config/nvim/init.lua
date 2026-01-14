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

vim.pack.add({
  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/carldaws/surface.nvim" },
})

local nord = require("nord")
nord.setup({
  transparent = true,
})
vim.cmd.colorscheme("nord")

local pick = require("mini.pick")
pick.setup({
  source = {
    show = function(buf_id, items, query)
      return pick.default_show(buf_id, items, query, { show_icons = true })
    end,
  }
})

local icons = require("mini.icons")
icons.setup()

local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
})

local lualine = require("lualine")
lualine.setup({
  options = {
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
})

local surface = require("surface")
surface.setup({
  default_position = "right",
  mappings = {
    { keymap = "<leader>tt", command = os.getenv("SHELL") },
    { keymap = "<leader>.g", command = "GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit", position = "center" },
    { keymap = "<leader>lg", command = "lazygit",                                             position = "center" },
    { keymap = "<leader>db", command = "psql -h localhost -U postgres" },
    { keymap = "<leader>rc", command = "rails console" },
    { keymap = "<leader>ai", command = "claude" },
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep<CR>")
vim.keymap.set("n", "<leader>*", "<cmd>Pick grep pattern='<cword>'<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>m", function()
  pick.start({ source = { items = vim.fn.systemlist("git ls-files --modified --others --exclude-standard") } })
end)
vim.keymap.set("n", "<leader>i", "<cmd>Inspect<CR>")
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>c", '"+y')
vim.keymap.set("v", "<leader>c", '"+y')
vim.keymap.set("n", "<leader>v", '"+p')
vim.keymap.set("v", "<leader>v", '"+p')
vim.keymap.set("n", "<leader>e", "<cmd>let @+ = expand('%')<CR>")
vim.keymap.set("n", "J", "<C-v>:move '>+1<CR>gv=gv<Esc>", { silent = true })
vim.keymap.set("n", "K", "<C-v>:move '<-2<CR>gv=gv<Esc>", { silent = true })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
vim.keymap.set("n", "<Tab><Left>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<Tab><Down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<Tab><Up>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<Tab><Right>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<leader>?", function()
  local function on_list(options)
    local items = {}
    for _, item in ipairs(options.items) do
      table.insert(items, {
        text = vim.fn.fnamemodify(item.filename, ":~:.") .. "|" .. item.lnum .. "|" .. item.col .. "|",
        path = item.filename,
        lnum = item.lnum,
        col = item.col
      })
    end
    pick.start({
      source = { items = items },
    })
  end
  vim.lsp.buf.definition({ on_list = on_list })
end, { noremap = true })

-- Build a cache and only do the installs in a new directory or whatever
-- local filetype_cache = {}

vim.lsp.config["luals"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
vim.lsp.enable("luals")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.system({ "mise", "use", "ruby" })
    vim.system({ "gem", "install", "ruby-lsp" })
    vim.system({ "bundle" })
  end
})

vim.lsp.config["ruby-lsp"] = {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby", "haml" },
  root_markers = { "Gemfile", ".git" },
}
vim.lsp.enable("ruby-lsp")

vim.lsp.config["rubocop"] = {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
}
vim.lsp.enable("rubocop")

local js_filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx"
}

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = js_filetypes,
--   callback = function(ev)
--     vim.system({ "mise", "use", "node" })
--     vim.system({ "npm", "i", "-g", "typescript" })
--     vim.system({ "npm", "i", "-g", "typescript-language-server" })
--     vim.system({ "npm", "i", "-g", "prettier" })
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = ev.buf,
--       callback = function(ev)
--         vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, vim.fn.systemlist({ "prettier", ev.file }))
--       end
--     })
--   end
-- })

vim.lsp.config["ts_ls"] = {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  root_markers = { ".git" },
}
vim.lsp.enable("ts_ls")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "astro",
--   callback = function(ev)
--     vim.system({ "mise", "use", "node" })
--     vim.system({ "npm", "i", "-g", "@astrojs/language-server" })
--     vim.system({ "npm", "i", "-g", "prettier" })
--     vim.system({ "npm", "i", "--save-dev", "prettier-plugin-astro" })
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = ev.buf,
--       callback = function(ev)
--         vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, vim.fn.systemlist({ "prettier", ev.file }))
--       end
--     })
--   end
-- })

vim.lsp.config["astro_ls"] = {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { ".git" },
  init_options = {
    typescript = {}
  }
}
vim.lsp.enable("astro_ls")

vim.lsp.config["gopls"] = {
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = { ".git" }
}
vim.lsp.enable("gopls")

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "haml",
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end
})
