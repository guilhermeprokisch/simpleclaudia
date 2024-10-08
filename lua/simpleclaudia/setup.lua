local M = {}

function M.load()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "simpleclaudia"

	local simpleclaudia = require("simpleclaudia")
	simpleclaudia.load()
end

function M.setup()
	-- Add a command to toggle between light and dark themes
	vim.api.nvim_create_user_command("SimpleClaudiaToggle", function()
		local simpleclaudia = require("simpleclaudia")
		if type(simpleclaudia.toggle_theme) == "function" then
			simpleclaudia.toggle_theme()
		else
			error("simpleclaudia.toggle_theme is not a function")
		end
	end, {})

	-- Add a command to enter development mode
	vim.api.nvim_create_user_command("SimpleClaudiaDev", function()
		local simpleclaudia = require("simpleclaudia")
		if type(simpleclaudia.dev_mode) == "function" then
			simpleclaudia.dev_mode()
		else
			error("simpleclaudia.dev_mode is not a function")
		end
	end, {})
end

return M
