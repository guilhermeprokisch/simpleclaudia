local utils = require("simpleclaudia.utils")
local hl, hsl = utils.hl, utils.hsl

local M = {}

-- Define your color palettes
local colors = {
	dark = {
		bg = hsl(220, 13, 1), -- Dark background
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
		bg = hsl(220, 14, 90), -- Light background
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
	hl("NormalFloat"):from("Normal")
	hl("Comment"):fg(theme.green):italic()
	hl("Cursor"):fg(theme.bg):bg(theme.fg)
	hl("CursorLine"):bg(theme.bg_alt)
	hl("CursorColumn"):from("CursorLine")

	-- Syntax highlighting
	hl("Constant"):fg(theme.cyan)
	hl("String"):fg(theme.green)
	hl("Character"):from("String")
	hl("Number"):fg(theme.purple)
	hl("Boolean"):from("Number")
	hl("Float"):from("Number")

	hl("Identifier"):fg(theme.blue)
	hl("Function"):fg(theme.yellow)

	hl("Statement"):fg(theme.purple):bold()
	hl("Conditional"):from("Statement")
	hl("Repeat"):from("Statement")
	hl("Label"):from("Statement")
	hl("Operator"):fg(theme.cyan)
	hl("Keyword"):from("Statement")
	hl("Exception"):from("Statement")

	hl("PreProc"):fg(theme.cyan)
	hl("Include"):from("PreProc")
	hl("Define"):from("PreProc")
	hl("Macro"):from("PreProc")
	hl("PreCondit"):from("PreProc")

	hl("Type"):fg(theme.yellow)
	hl("StorageClass"):from("Type")
	hl("Structure"):from("Type")
	hl("Typedef"):from("Type")

	hl("Special"):fg(theme.red)
	hl("SpecialChar"):from("Special")
	hl("Tag"):from("Special")
	hl("Delimiter"):from("Special")
	hl("SpecialComment"):from("Special")
	hl("Debug"):from("Special")

	hl("Underlined"):underline()
	hl("Ignore"):fg(theme.fg_alt)
	hl("Error"):fg(theme.red):bold()
	hl("Todo"):fg(theme.purple):bold()

	-- Editor UI
	hl("StatusLine"):fg(theme.fg):bg(theme.bg_alt)
	hl("StatusLineNC"):fg(theme.fg_alt):bg(theme.bg)
	hl("TabLine"):from("StatusLineNC")
	hl("TabLineFill"):from("StatusLine")
	hl("TabLineSel"):fg(theme.bg):bg(theme.purple)

	hl("Search"):fg(theme.bg):bg(theme.yellow)
	hl("IncSearch"):from("Search")

	hl("Pmenu"):fg(theme.fg):bg(theme.bg_alt)
	hl("PmenuSel"):fg(theme.bg):bg(theme.purple)
	hl("PmenuSbar"):bg(theme.bg_alt)
	hl("PmenuThumb"):bg(theme.fg)

	hl("Folded"):fg(theme.fg_alt):bg(theme.bg_alt)
	hl("FoldColumn"):from("Folded")

	hl("SignColumn"):fg(theme.fg):bg(theme.bg)
	hl("LineNr"):fg(theme.fg_alt)
	hl("CursorLineNr"):fg(theme.yellow):bold()

	hl("MatchParen"):fg(theme.yellow):bold():underline()

	hl("NonText"):fg(theme.fg_alt)
	hl("SpecialKey"):from("NonText")

	hl("Visual"):bg(theme.bg_alt)
	hl("VisualNOS"):from("Visual")

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
