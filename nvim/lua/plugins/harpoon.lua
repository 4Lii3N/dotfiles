return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>zm", function() harpoon:list():add() end)
			vim.keymap.set("n", "<leader>zr", function() harpoon:list():remove() end)
			vim.keymap.set("n", "<Leader>zz", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<Leader>z1", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<Leader>z2", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<Leader>z3", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<Leader>z4", function() harpoon:list():select(4) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<Leader>zu", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<Leader>zi", function() harpoon:list():next() end)

			vim.keymap.set("n", "<Leader>tt",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list("term"))
				end)

			vim.keymap.set("n", "<Leader>ta",
				function()
					vim.cmd("term")
					harpoon:list("term"):append()
				end)

			vim.keymap.set("n", "<Leader>t1",
				function() harpoon:list("term"):select(1) end)

			vim.keymap.set("n", "<Leader>t2",
				function() harpoon:list("term"):select(2) end)
		end
	}
}
