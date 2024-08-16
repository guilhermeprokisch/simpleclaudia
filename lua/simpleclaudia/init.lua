local utils = require("simpleclaudia.utils")
local hlg, hsl = utils.hlg, utils.hsl

local M = {}

-- Function to create the color palettes
local function create_colors()
	local c = {
		dark = {
			bg = hsl("#F2F0EA"):rotate(180), -- Dark background
			bg_alt = hsl(220, 13, 22), -- Slightly lighter background
			fg = hsl(220, 14, 71), -- Light foreground
			fg_alt = hsl(220, 14, 60), -- Slightly darker foreground
			red = hsl(355, 65, 65), -- Soft red
			green = hsl("#6D675D"), -- Muted green
			yellow = hsl(40, 70, 68), -- Warm yellow
			blue = hsl(207, 82, 66), -- Bright blue
			purple = hsl(286, 60, 67), -- Soft purple
			cyan = hsl(187, 47, 55), -- Muted cyan
			c1 = hsl("#737165"),
		},
		light = {
			bg = hsl("#F2F0EA"),
			fg = hsl("#7B6C51"),
			red = hsl("#8D4144"),
			green = hsl("#8CA375"),
			yellow = hsl("#CC7C5E"),
			blue = hsl("#3F7DD7"),
			purple = hsl("#41386E"),
			cyan = hsl("#6d675d"),
			c1 = hsl("#737165"),
			c2 = hsl("#A9A69C"),
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
	-- hlg("Comment"):fg(theme.green:mix(theme.bg):desaturate(10):darker(10)):italic()
	hlg("Comment"):fg(theme.c1:lighter(20)):italic()
	hlg("Cursor"):fg(theme.bg):bg(theme.fg)
	hlg("CursorLine"):bg(theme.bg_alt)
	hlg("CursorColumn"):as("CursorLine")

	-- Syntax highlighting
	hlg("Constant"):fg(theme.cyan):italic()
	hlg("String"):fg(theme.green)
	hlg("Character"):as("String")
	hlg("Number"):fg(theme.purple):italic()
	hlg("Boolean"):as("Number")
	hlg("Float"):as("Number")

	hlg("Identifier"):fg(theme.blue)
	hlg("Function"):fg(theme.yellow)

	hlg("Statement"):fg(theme.blue):bold()
	hlg("Conditional"):as("Statement")
	hlg("Repeat"):as("Statement")
	hlg("Label"):as("Statement")
	hlg("Operator"):fg(theme.cyan)
	hlg("Keyword"):fg(theme.blue)
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

	hlg("Special"):fg(theme.green)
	hlg("SpecialChar"):as("Special")
	hlg("Tag"):as("Special")
	hlg("Delimiter"):as("Special")
	hlg("SpecialComment"):as("Special")
	hlg("Debug"):as("Special")

	hlg("Underlined"):undercurl()
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
	hlg("LineNr"):fg(theme.c2)
	hlg("CursorLineNr"):fg(theme.yellow):bold()

	hlg("MatchParen"):fg(theme.yellow):bold():underline()

	hlg("NonText"):fg(theme.fg_alt)
	hlg("SpecialKey"):as("NonText")

	hlg("Visual"):bg(theme.bg_alt)
	hlg("VisualNOS"):as("Visual")

	hlg("Directory"):fg(theme.blue)
	hlg("Title"):fg(theme.purple):bold()

	-- Diagnostic
	hlg("ErrorMsg"):fg(theme.red):italic()
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

	--TreeSitter

	-- Additional highlight groups
	hlg("NvimInternalError"):fg(theme.red):bold()
	hlg("NvimInvalidSpacing"):bg(theme.red:lighter(20))
	hlg("NvimInvalidIndent"):bg(theme.yellow:lighter(20))
	hlg("NvimInvalidTabStop"):bg(theme.purple:lighter(20))

	-- Spelling
	hlg("SpellBad"):fg(theme.red):underline()
	hlg("SpellCap"):fg(theme.yellow):underline()
	hlg("SpellRare"):fg(theme.purple):underline()
	hlg("SpellLocal"):fg(theme.cyan):underline()

	-- Treesitter
	hlg("@string"):fg(theme.green)
	hlg("@function"):fg(theme.yellow)
	hlg("@function.call"):fg(theme.yellow)
	hlg("@method"):fg(theme.blue)
	hlg("@constructor"):fg(theme.purple)
	hlg("@parameter"):fg(theme.cyan):italic()
	hlg("@type"):fg(theme.yellow)
	hlg("@property"):fg(theme.cyan)
	hlg("@variable"):fg(theme.fg):italic()

	-- Diagnostic
	hlg("DiagnosticError"):fg(theme.red:lighter(10)):italic()
	hlg("DiagnosticWarn"):fg(theme.yellow:saturate(10)):italic()
	hlg("DiagnosticInfo"):fg(theme.blue):italic()
	hlg("DiagnosticHint"):fg(theme.cyan):italic()
	hlg("DiagnosticUnderlineError"):undercurl():sp(theme.red)
	hlg("DiagnosticUnderlineWarn"):undercurl():sp(theme.yellow)
	hlg("DiagnosticUnderlineInfo"):undercurl():sp(theme.blue)
	hlg("DiagnosticUnderlineHint"):undercurl():sp(theme.cyan)

	-- Neovim LSP
	hlg("LspReferenceText"):bg(theme.bg_alt)
	hlg("LspReferenceRead"):bg(theme.bg_alt)
	hlg("LspReferenceWrite"):bg(theme.bg_alt)
	hlg("LspSignatureActiveParameter"):fg(theme.yellow):bold()

	-- Lualine
	hlg("LualineNormal"):fg(theme.fg):bg(theme.bg_alt)
	hlg("LualineInsert"):fg(theme.bg):bg(theme.green)
	hlg("LualineVisual"):fg(theme.bg):bg(theme.purple)
	hlg("LualineReplace"):fg(theme.bg):bg(theme.red)
	hlg("LualineCommand"):fg(theme.bg):bg(theme.yellow)

	-- Nvim-Tree
	hlg("NvimTreeNormal"):fg(theme.fg):bg(theme.bg)
	hlg("NvimTreeFolderName"):fg(theme.blue)
	hlg("NvimTreeFolderIcon"):fg(theme.yellow)
	hlg("NvimTreeOpenedFolderName"):fg(theme.blue):bold()
	hlg("NvimTreeEmptyFolderName"):fg(theme.fg_alt)
	hlg("NvimTreeIndentMarker"):fg(theme.fg_alt)
	hlg("NvimTreeSymlink"):fg(theme.cyan)
	hlg("NvimTreeStatuslineNc"):fg(theme.fg_alt):bg(theme.bg)

	-- Spelling with wavy underlines
	hlg("SpellBad"):undercurl():sp(theme.red)
	hlg("SpellCap"):undercurl():sp(theme.yellow)
	hlg("SpellRare"):undercurl():sp(theme.purple)
	hlg("SpellLocal"):undercurl():sp(theme.cyan)

	-- NvimInvalid* groups with wavy underlines
	hlg("NvimInvalidSpacing"):undercurl():sp(theme.red)
	hlg("NvimInvalidIndent"):undercurl():sp(theme.yellow)
	hlg("NvimInvalidTabStop"):undercurl():sp(theme.purple)
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
