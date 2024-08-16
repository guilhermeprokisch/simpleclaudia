local utils = require("simpleclaudia.utils")
local hlg, hsl = utils.hlg, utils.hsl

local M = {}

-- Function to create the color palettes
local function create_colors()
	local c = {
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
			red = hsl("#B1856C"):saturate(0), -- Darker red for contrast
			green = hsl("#8C9484"):saturate(20), -- Darker green for contrast
			yellow = hsl("#D67654"):saturate(20), -- Darker yellow for contrast
			blue = hsl("#556A7B"):saturate(50), -- Darker blue for contrast
			purple = hsl("#7E788E"):saturate(15), -- Darker purple for contrast
			cyan = hsl("#6d675d"):saturate(20), -- Darker cyan for contrast
		},
	}

	-- Define additional keys based on existing ones
	c.light.bg_alt = c.light.bg:desaturate(30)
	c.light.fg_alt = c.light.fg:lighter(2)
	return c
end

-- Initialize the colors
local colors = create_colors()

-- Function to set up your colorscheme
local function setup_colors()
	local theme = vim.o.background == "dark" and colors.dark or colors.light

	-- hl("NormalFloat"):as("Normal"):darker(10, "bg") -- FIX: Modifiers no working

	-- Basic editor colors
	hlg("Normal"):bg(theme.bg):fg(theme.fg)
	hlg("NormalFloat"):as("Normal")
	hlg("Comment"):fg(theme.green):italic()
	hlg("Cursor"):fg(theme.bg):bg(theme.fg)
	hlg("CursorLine"):bg(theme.bg_alt)
	hlg("CursorColumn"):as("CursorLine")

	-- Syntax highlighting
	hlg("Constant"):fg(theme.cyan)
	hlg("String"):fg(theme.green)
	hlg("Character"):as("String")
	hlg("Number"):fg(theme.purple)
	hlg("Boolean"):as("Number")
	hlg("Float"):as("Number")

	hlg("Identifier"):fg(theme.blue)
	hlg("Function"):fg(theme.yellow)

	hlg("Statement"):fg(theme.purple):bold()
	hlg("Conditional"):as("Statement")
	hlg("Repeat"):as("Statement")
	hlg("Label"):as("Statement")
	hlg("Operator"):fg(theme.cyan)
	hlg("Keyword"):as("Statement")
	hlg("Exception"):as("Statement")

	hlg("PreProc"):fg(theme.cyan)
	hlg("Include"):as("PreProc")
	hlg("Define"):as("PreProc")
	hlg("Macro"):as("PreProc")
	hlg("PreCondit"):as("PreProc")

	hlg("Type"):fg(theme.yellow)
	hlg("StorageClass"):as("Type")
	hlg("Structure"):as("Type")
	hlg("Typedef"):as("Type")

	hlg("Special"):fg(theme.red)
	hlg("SpecialChar"):as("Special")
	hlg("Tag"):as("Special")
	hlg("Delimiter"):as("Special")
	hlg("SpecialComment"):as("Special")
	hlg("Debug"):as("Special")

	hlg("Underlined"):underline()
	hlg("Ignore"):fg(theme.fg_alt)
	hlg("Error"):fg(theme.red):bold()
	hlg("Todo"):fg(theme.purple):bold()

	-- Editor UI
	hlg("StatusLine"):fg(theme.fg):bg(theme.bg_alt)
	hlg("StatusLineNC"):fg(theme.fg_alt):bg(theme.bg)
	hlg("TabLine"):as("StatusLineNC")
	hlg("TabLineFill"):as("StatusLine")
	hlg("TabLineSel"):fg(theme.bg):bg(theme.purple)

	hlg("Search"):fg(theme.bg):bg(theme.yellow)
	hlg("IncSearch"):as("Search")

	hlg("Pmenu"):fg(theme.fg):bg(theme.bg_alt)
	hlg("PmenuSel"):fg(theme.bg):bg(theme.purple)
	hlg("PmenuSbar"):bg(theme.bg_alt)
	hlg("PmenuThumb"):bg(theme.fg)

	hlg("Folded"):fg(theme.fg_alt):bg(theme.bg_alt)
	hlg("FoldColumn"):as("Folded")

	hlg("SignColumn"):fg(theme.fg):bg(theme.bg)
	hlg("LineNr"):fg(theme.fg_alt)
	hlg("CursorLineNr"):fg(theme.yellow):bold()

	hlg("MatchParen"):fg(theme.yellow):bold():underline()

	hlg("NonText"):fg(theme.fg_alt)
	hlg("SpecialKey"):as("NonText")

	hlg("Visual"):bg(theme.bg_alt)
	hlg("VisualNOS"):as("Visual")

	hlg("Directory"):fg(theme.blue)
	hlg("Title"):fg(theme.purple):bold()

	-- Diagnostic
	hlg("ErrorMsg"):fg(theme.red):bold()
	hlg("WarningMsg"):fg(theme.yellow):bold()
	hlg("MoreMsg"):fg(theme.blue):bold()
	hlg("Question"):fg(theme.purple):bold()

	-- Diff
	hlg("DiffAdd"):fg(theme.green):bold()
	hlg("DiffChange"):fg(theme.yellow):bold()
	hlg("DiffDelete"):fg(theme.red):bold()
	hlg("DiffText"):fg(theme.fg):bold()

	-- Git
	hlg("GitSignsAdd"):fg(theme.green)
	hlg("GitSignsChange"):fg(theme.yellow)
	hlg("GitSignsDelete"):fg(theme.red)
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
