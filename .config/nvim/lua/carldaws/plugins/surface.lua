return {
	"carldaws/surface.nvim",
	opts = {
		default_position = "right",
		mappings = {
			{ keymap = "lg", command = "lazygit",                                             position = "center" },
			{ keymap = ".g", command = "GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit", position = "center" },
			{ keymap = "ld", command = "lazydocker" },
			{ keymap = "rc", command = "rails console" },
			{ keymap = "db", command = "psql -h localhost -U postgres" },
			{ keymap = "tt", command = os.getenv("SHELL") }
		}
	}
}
