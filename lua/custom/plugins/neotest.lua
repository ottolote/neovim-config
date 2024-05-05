-- lazy.nvim
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuration
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "pytest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					-- python = ".venv/bin/python",
					-- Returns if a given file path is a test file.
					-- NB: This function is called a lot so don't perform any heavy tasks within it.
					-- is_test_file = function(file_path)
					-- 	local Path = require("plenary.path")
					-- 	if not vim.endswith(file_path, ".py") then
					-- 		return false
					-- 	end
					-- 	local elems = vim.split(file_path, Path.path.sep)
					-- 	local file_name = elems[#elems]
					-- 	return vim.startswith(file_name, "test_") or vim.endswith(file_name, "_test.py")
					-- end,
				}),
			},
		})
		require("which-key").register({
			t = {
				name = "neotest", -- Title for the group of mappings
				a = { "<cmd>lua require('neotest').run.attach()<CR>", "Neo[T]est [A]ttach" },
				o = { "<cmd>lua require('neotest').output.open()<CR>", "Neo[T]est [O]utput" },
				r = { "<cmd>lua require('neotest').run.run()<CR>", "Neo[T]est [R]un" },
				s = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Neo[T]est [S]ummary" },
				f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Neo[T]est run [F]ile tests" },
				n = {
					"<cmd>lua require('neotest').run.run({strategy = 'nearest'})<CR>",
					"Neo[T]est run [N]earest test",
				},
			},
		}, { prefix = "<leader>" })
	end,
}
