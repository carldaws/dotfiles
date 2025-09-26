return {
	"carldaws/surface.nvim",
	opts = {
		default_position = "right",
		mappings = {
			{
				keymap = "<leader>lg",
				command = "lazygit",
				position = "center",
			},
			{
				keymap = "<leader>.g",
				command = "GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit",
				position = "center",
			},
			{ keymap = "<leader>ai", command = "claude" },
			{ keymap = "<leader>ld", command = "lazydocker" },
			{ keymap = "<leader>rc", command = "rails console" },
			{ keymap = "<leader>db", command = "psql -h localhost -U postgres" },
			{ keymap = "<leader>tt", command = os.getenv("SHELL") },
		},
	},
}
