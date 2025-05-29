local rails_test = {}
rails_test.results = {}
rails_test.ns = vim.api.nvim_create_namespace("rails_test_status")
rails_test.buf = nil
rails_test.win = nil

vim.keymap.set("v", "<leader>rt", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_line = math.min(vim.fn.line("v"), vim.fn.line("."))
	local end_line = math.max(vim.fn.line("v"), vim.fn.line("."))
	local test_command = string.format("bundle exec rails test %s:%d-%d", vim.fn.expand("%"), start_line, end_line)

	-- Clear existing results
	rails_test.results = {}
	vim.api.nvim_buf_clear_namespace(bufnr, rails_test.ns, 0, -1)

	local extmarks = {}
	for i = start_line, end_line do
		local line_content = vim.fn.getline(i)
		if line_content:match("%S") and not line_content:match("^%s*end%s*$") then
			local mark = vim.api.nvim_buf_set_extmark(bufnr, rails_test.ns, i - 1, 0, {
				virt_text = { { "Running...", "Function" } },
				virt_text_pos = "eol",
			})
			table.insert(extmarks, { line = i, id = mark })
		end
	end

	-- Run test command asynchronously
	local stdout_data = {}
	local stderr_data = {}

	vim.system(vim.fn.split(test_command), {
		stdout = function(_, data)
			if data then table.insert(stdout_data, data) end
		end,
		stderr = function(_, data)
			if data then table.insert(stderr_data, data) end
		end,
	}, function(obj)
		local output = table.concat(stdout_data, "") .. table.concat(stderr_data, "")
		local success = obj.code == 0
		local result_text = success and "✓ Passed" or "✗ Failed"
		local hl_group = success and "String" or "DiagnosticError"

		vim.schedule(function()
			for _, mark in ipairs(extmarks) do
				-- Save result for hover
				rails_test.results[mark.line] = {
					success = success,
					output = output,
				}
				-- Update virtual text
				vim.api.nvim_buf_set_extmark(bufnr, rails_test.ns, mark.line - 1, 0, {
					id = mark.id,
					virt_text = { { result_text, hl_group } },
					virt_text_pos = "eol",
				})
			end
		end)
	end)
end)

vim.keymap.set("n", "K", function()
	local line = vim.api.nvim_win_get_cursor(0)[1]

	local result = rails_test.results[line]
	if not result then return end

	-- Close existing hover window if still open
	if rails_test.buf and vim.api.nvim_buf_is_valid(rails_test.buf) then
		vim.api.nvim_buf_delete(rails_test.buf, { force = true })
	end
	if rails_test.win and vim.api.nvim_win_is_valid(rails_test.win) then
		vim.api.nvim_win_close(rails_test.win, true)
	end

	-- Create new floating buffer
	rails_test.buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(rails_test.buf, 0, -1, false, vim.split(result.output, "\n"))

	-- Calculate size
	local width = math.min(80, vim.o.columns - 4)
	local height = math.min(20, #vim.split(result.output, "\n"))

	rails_test.win = vim.api.nvim_open_win(rails_test.buf, false, {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		border = "single",
		style = "minimal",
	})
end)
-- Close hover on move
vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave", "InsertEnter" }, {
	callback = function()
		if rails_test.buf and vim.api.nvim_buf_is_valid(rails_test.buf) then
			vim.api.nvim_buf_delete(rails_test.buf, { force = true })
		end
		if rails_test.win and vim.api.nvim_win_is_valid(rails_test.win) then
			vim.api.nvim_win_close(rails_test.win, true)
		end
		rails_test.buf = nil
		rails_test.win = nil
	end,
})
