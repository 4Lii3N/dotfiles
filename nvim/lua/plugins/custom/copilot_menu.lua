local chat = require("CopilotChat")
local utils = require("CopilotChat.utils")
local menu = require("menu")
local colors = require("colors")

local M = {}

--- Picks an action from a categorized menu and executes it.
---@param pick_actions CopilotChat.integrations.actions? A table containing actions to pick from.
function M.pick(pick_actions)
	if not pick_actions or not pick_actions.actions or vim.tbl_isempty(pick_actions.actions) then
		print("No actions to pick from")
		return
	end

	utils.return_to_normal_mode()

	-- Define action categories with corresponding markers and icons
	local categories = {
		{ marker = "/COPILOT_REVIEW", name = "REVIEW", icon = "" },
		{ marker = "/COPILOT_EXPLAIN", name = "EXPLAIN", icon = "" },
		{ marker = "/COPILOT_GENERATE", name = "GENERATE", icon = "󰘦" },
		{ marker = "/CUSTOM", name = "CUSTOM", icon = "󰘦" },
		{ marker = "#git", name = "git", icon = "" },
	}

	-- Initialize category storage
	local categorized_actions = {}
	for _, category in ipairs(categories) do
		categorized_actions[category.name] = {}
	end

	--- Categorizes an action into the appropriate category
	---@param action_name string The name of the action
	---@param action table The action containing a prompt
	local function categorize_action(action_name, action)
		-- Create a helper function to build the command function
		local function create_command(prompt)
			return function()
				chat.ask(prompt .. '> ', {
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
						border = "none",
					},
				})
			end
		end

		-- Try to match the action with a category
		for _, category in ipairs(categories) do
			if action.prompt:find(category.marker, 1, true) then
				-- Build the action entry
				local entry = {
					name = action_name,
					cmd = create_command(action.prompt),
					rtxt = category.icon,
				}

				-- Add to the appropriate category
				table.insert(categorized_actions[category.name], entry)
				return
			end
		end
	end

	-- Categorize available actions
	for action_name, action in pairs(pick_actions.actions) do
		categorize_action(action_name, action)
	end

	-- Gather non-empty categories in order
	local ordered_categories = {}
	for _, category in ipairs(categories) do
		if #categorized_actions[category.name] > 0 then
			table.insert(ordered_categories, category.name)
		end
	end

	vim.api.nvim_set_hl(0, "MenuTitle", { fg = colors.red })
	-- Define the menu items for the Copilot menu
	local menu_items = {
		{
			name = " Copilot",
			title = true,
			hl = "MenuTitle"
		}
	}

	-- Build menu items with separators
	for i, category_name in ipairs(ordered_categories) do
		vim.list_extend(menu_items, categorized_actions[category_name])
		if i < #ordered_categories then
			table.insert(menu_items, { name = "separator" })
		end
	end

	-- Open selection menu
	menu.open(menu_items, { window = { border = "none", mouse = true } })
end

return M
