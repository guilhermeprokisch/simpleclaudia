local utils = require("simpleclaudia.utils")
local hl, hsl = utils.hl, utils.hsl

local M = {}

-- Define your color palettes
local colors = {
	dark = {
		bg = hsl("#6D675D"), -- Dark background
		bg_alt = hsl(220, 13, 22), -- Slightly lighter background
		fg = hsl(220, 14, 71), -- Light foreground
		fg_alt = hsl(220, 14, 60), -- Slightly darker foreground
		red = hsl(355, 65, 65), -- Soft red
		green = hsl(95, 55, 55), -- Muted green
		yellow = hsl(40, 70, 68), -- Warm yellow
		blue = hsl(207, 82, 66), -- Bright blue
		purple = hsl(286, 60, 67), -- Soft purple
		cyan = hsl(187, 47, 55), -- Muted cyan
	},
	light = {
		bg = hsl("#f3f1e9"), -- Light background
		bg_alt = hsl(220, 14, 85), -- Slightly darker background
		fg = hsl(220, 13, 25), -- Dark foreground
		fg_alt = hsl(220, 13, 35), -- Slightly lighter foreground
		red = hsl(355, 65, 50), -- Darker red for contrast
		green = hsl(95, 55, 40), -- Darker green for contrast
		yellow = hsl(40, 70, 50), -- Darker yellow for contrast
		blue = hsl(207, 82, 50), -- Darker blue for contrast
		purple = hsl(286, 60, 50), -- Darker purple for contrast
		cyan = hsl(187, 47, 40), -- Darker cyan for contrast
	},
}

-- Function to set up your colorscheme
local function setup_colors()
	local theme = vim.o.background == "dark" and colors.dark or colors.light

	-- Basic editor colors
	hl("Normal"):fg(theme.fg):bg(theme.bg)
	-- hl("Comment"):fg(colors.green:darker(10)):italic()
	-- hl("Constant"):fg(colors.cyan)
	-- hl("String"):fg(colors.yellow:saturate(10))
	-- hl("Identifier"):fg(colors.blue)
	-- hl("Function"):fg(colors.purple)
	-- hl("Statement"):fg(colors.purple:lighter(10)):bold()
	-- hl("PreProc"):fg(colors.cyan:rotate(15))
	-- hl("Type"):fg(colors.yellow)
	-- hl("Special"):fg(colors.red)
end

-- Function to load the colorscheme
function M.load()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "simpleclaudia"

	setup_colors()
end

-- Function to toggle between light and dark themes
function M.toggle_theme()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
	M.load()
end

-- Function to enter development mode
function M.dev_mode()
	print("Entering SimpleClaudia development mode...")
	local success, dev = pcall(require, "simpleclaudia.dev")
	if success then
		dev.start()
	else
		print("Error loading simpleclaudia.dev: " .. tostring(dev))
	end
end

return M
