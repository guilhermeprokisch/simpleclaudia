local utils = require("simpleclaudia.utils")
local hl, hsl = utils.hl, utils.hsl

local M = {}

-- Function to create the color palettes
local function create_colors()
	local colors = {
		dark = {
			bg = hsl("#6D675E"), -- Dark background
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
			bg = hsl("#F3F1E9"), -- Light background
			fg = hsl("#A9A69C"), -- Dark foreground
			red = hsl("#B1856C"), -- Darker red for contrast
			green = hsl("#8C9484"), -- Darker green for contrast
			yellow = hsl("#D67654"), -- Darker yellow for contrast
			blue = hsl("#556A7B"), -- Darker blue for contrast
			purple = hsl("#7E788E"), -- Darker purple for contrast
			cyan = hsl("#6d675d"), -- Darker cyan for contrast
		},
	}

	-- Define additional keys based on existing ones
	colors.light.bg_alt = colors.light.bg:desaturate(30)
	colors.light.fg_alt = colors.light.fg:lighter(2)

	-- colors.light.contrast = colors.light.bg:darken_by(10) -- Example of creating a derived value

	return colors
end

-- Initialize the colors
local colors = create_colors()

-- Function to set up your colorscheme
local function setup_colors()
	local theme = vim.o.background == "dark" and colors.dark or colors.light

	-- hl("NormalFloat"):as("Normal"):darker(10, "bg") -- FIX: Modifiers no working

	-- Basic editor colors
	hl("Normal"):bg(theme.bg):fg(theme.fg)
	hl("NormalFloat"):as("Normal")
	hl("Comment"):fg(theme.green):italic()
	hl("Cursor"):fg(theme.bg):bg(theme.fg)
	hl("CursorLine"):bg(theme.bg_alt)
	hl("CursorColumn"):as("CursorLine")

	-- Syntax highlighting
	hl("Constant"):fg(theme.cyan)
	hl("String"):fg(theme.green)
	hl("Character"):as("String")
	hl("Number"):fg(theme.purple)
	hl("Boolean"):as("Number")
	hl("Float"):as("Number")

	hl("Identifier"):fg(theme.blue)
	hl("Function"):fg(theme.yellow)

	hl("Statement"):fg(theme.purple):bold()
	hl("Conditional"):as("Statement")
	hl("Repeat"):as("Statement")
	hl("Label"):as("Statement")
	hl("Operator"):fg(theme.cyan)
	hl("Keyword"):as("Statement")
	hl("Exception"):as("Statement")

	hl("PreProc"):fg(theme.cyan)
	hl("Include"):as("PreProc")
	hl("Define"):as("PreProc")
	hl("Macro"):as("PreProc")
	hl("PreCondit"):as("PreProc")

	hl("Type"):fg(theme.yellow)
	hl("StorageClass"):as("Type")
	hl("Structure"):as("Type")
	hl("Typedef"):as("Type")

	hl("Special"):fg(theme.red)
	hl("SpecialChar"):as("Special")
	hl("Tag"):as("Special")
	hl("Delimiter"):as("Special")
	hl("SpecialComment"):as("Special")
	hl("Debug"):as("Special")

	hl("Underlined"):underline()
	hl("Ignore"):fg(theme.fg_alt)
	hl("Error"):fg(theme.red):bold()
	hl("Todo"):fg(theme.purple):bold()

	-- Editor UI
	hl("StatusLine"):fg(theme.fg):bg(theme.bg_alt)
	hl("StatusLineNC"):fg(theme.fg_alt):bg(theme.bg)
	hl("TabLine"):as("StatusLineNC")
	hl("TabLineFill"):as("StatusLine")
	hl("TabLineSel"):fg(theme.bg):bg(theme.purple)

	hl("Search"):fg(theme.bg):bg(theme.yellow)
	hl("IncSearch"):as("Search")

	hl("Pmenu"):fg(theme.fg):bg(theme.bg_alt)
	hl("PmenuSel"):fg(theme.bg):bg(theme.purple)
	hl("PmenuSbar"):bg(theme.bg_alt)
	hl("PmenuThumb"):bg(theme.fg)

	hl("Folded"):fg(theme.fg_alt):bg(theme.bg_alt)
	hl("FoldColumn"):as("Folded")

	hl("SignColumn"):fg(theme.fg):bg(theme.bg)
	hl("LineNr"):fg(theme.fg_alt)
	hl("CursorLineNr"):fg(theme.yellow):bold()

	hl("MatchParen"):fg(theme.yellow):bold():underline()

	hl("NonText"):fg(theme.fg_alt)
	hl("SpecialKey"):as("NonText")

	hl("Visual"):bg(theme.bg_alt)
	hl("VisualNOS"):as("Visual")

	hl("Directory"):fg(theme.blue)
	hl("Title"):fg(theme.purple):bold()

	-- Diagnostic
	hl("ErrorMsg"):fg(theme.red):bold()
	hl("WarningMsg"):fg(theme.yellow):bold()
	hl("MoreMsg"):fg(theme.blue):bold()
	hl("Question"):fg(theme.purple):bold()

	-- Diff
	hl("DiffAdd"):fg(theme.green):bold()
	hl("DiffChange"):fg(theme.yellow):bold()
	hl("DiffDelete"):fg(theme.red):bold()
	hl("DiffText"):fg(theme.fg):bold()

	-- Git
	hl("GitSignsAdd"):fg(theme.green)
	hl("GitSignsChange"):fg(theme.yellow)
	hl("GitSignsDelete"):fg(theme.red)
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
