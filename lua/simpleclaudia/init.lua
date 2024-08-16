local utils = require("simpleclaudia.utils")
local hl, hsl = utils.hlg, utils.hsl

local M = {}

-- Function to create the color palettes
local function create_colors()
	local c = {
		dark = {
			bg = hsl("#393937"),
			bg_alt = hsl("#393937"):lighter(3),
			fg = hsl("#CFCFCA"),
			red = hsl("#8D4144"),
			green = hsl("#8CA375"),
			yellow = hsl("#D7785D"),
			blue = hsl("#3F7DD7"),
			purple = hsl("#9888EE"),
			cyan = hsl("#CFCFCA"),
			c1 = hsl("#CFCFCA"):darker(30),
			c2 = hsl("#A9A69C"):darker(10),
		},
		light = {
			bg = hsl("#eeede6"),
			bg_alt = hsl("#EBE8E1"),
			fg = hsl("#7B6C51"),
			red = hsl("#8D4144"),
			green = hsl("#8CA375"),
			yellow = hsl("#CC7C5E"),
			blue = hsl("#3F7DD7"),
			purple = hsl("#41386E"),
			cyan = hsl("#6d675d"),
			c1 = hsl("#737165"):lighter(20),
			c2 = hsl("#A9A69C"),
		},
	}

	-- Define additional keys based on existing ones
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
	hl("Normal"):bg(theme.bg):fg(theme.fg)
	hl("NormalFloat"):as("Normal")
	-- hlg("Comment"):fg(theme.green:mix(theme.bg):desaturate(10):darker(10)):italic()
	hl("Comment"):fg(theme.c1):italic()
	hl("Cursor"):fg(theme.bg):bg(theme.fg)
	hl("CursorLine"):bg(theme.bg_alt)
	hl("CursorColumn"):as("CursorLine")

	-- Syntax highlighting
	hl("Constant"):fg(theme.cyan):italic()
	hl("String"):fg(theme.green)
	hl("Character"):as("String")
	hl("Number"):fg(theme.purple):italic()
	hl("Boolean"):as("Number")
	hl("Float"):as("Number")

	hl("Identifier"):fg(theme.blue)
	hl("Function"):fg(theme.yellow)

	hl("Statement"):fg(theme.blue):bold()
	hl("Conditional"):as("Statement")
	hl("Repeat"):as("Statement")
	hl("Label"):as("Statement")
	hl("Operator"):fg(theme.cyan)
	hl("Keyword"):fg(theme.blue)
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

	hl("Special"):fg(theme.c2)
	hl("SpecialChar"):as("Special")
	hl("Tag"):as("Special")
	hl("Delimiter"):as("Special")
	hl("SpecialComment"):as("Special")
	hl("Debug"):as("Special")

	hl("Underlined"):undercurl()
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
	hl("LineNr"):fg(theme.c2)
	hl("CursorLineNr"):fg(theme.yellow):bold()

	hl("MatchParen"):fg(theme.yellow):bold():underline()

	hl("NonText"):fg(theme.fg_alt)
	hl("SpecialKey"):as("NonText")

	hl("Visual"):bg(theme.bg_alt)
	hl("VisualNOS"):as("Visual")

	hl("Directory"):fg(theme.blue)
	hl("Title"):fg(theme.purple):bold()

	-- Diagnostic
	hl("ErrorMsg"):fg(theme.red):italic()
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

	--TreeSitter

	-- Additional highlight groups
	hl("NvimInternalError"):fg(theme.red):bold()
	hl("NvimInvalidSpacing"):bg(theme.red:lighter(20))
	hl("NvimInvalidIndent"):bg(theme.yellow:lighter(20))
	hl("NvimInvalidTabStop"):bg(theme.purple:lighter(20))

	-- Spelling
	hl("SpellBad"):fg(theme.red):underline()
	hl("SpellCap"):fg(theme.yellow):underline()
	hl("SpellRare"):fg(theme.purple):underline()
	hl("SpellLocal"):fg(theme.cyan):underline()

	-- Treesitter
	hl("@string"):fg(theme.green)
	hl("@function"):fg(theme.yellow)
	hl("@function.call"):fg(theme.yellow)
	hl("@method"):fg(theme.blue)
	hl("@constructor"):fg(theme.purple)
	hl("@parameter"):fg(theme.cyan):italic()
	hl("@type"):fg(theme.yellow)
	hl("@property"):fg(theme.cyan)
	hl("@variable"):fg(theme.fg):italic()

	-- Diagnostic
	hl("DiagnosticError"):fg(theme.red:lighter(10)):italic()
	hl("DiagnosticWarn"):fg(theme.yellow:saturate(10)):italic()
	hl("DiagnosticInfo"):fg(theme.blue):italic()
	hl("DiagnosticHint"):fg(theme.cyan):italic()
	hl("DiagnosticUnderlineError"):undercurl():sp(theme.red)
	hl("DiagnosticUnderlineWarn"):undercurl():sp(theme.yellow)
	hl("DiagnosticUnderlineInfo"):undercurl():sp(theme.blue)
	hl("DiagnosticUnderlineHint"):undercurl():sp(theme.cyan)

	-- Neovim LSP
	hl("LspReferenceText"):bg(theme.bg_alt)
	hl("LspReferenceRead"):bg(theme.bg_alt)
	hl("LspReferenceWrite"):bg(theme.bg_alt)
	hl("LspSignatureActiveParameter"):fg(theme.yellow):bold()

	-- Lualine
	hl("LualineNormal"):fg(theme.fg):bg(theme.bg_alt)
	hl("LualineInsert"):fg(theme.bg):bg(theme.green)
	hl("LualineVisual"):fg(theme.bg):bg(theme.purple)
	hl("LualineReplace"):fg(theme.bg):bg(theme.red)
	hl("LualineCommand"):fg(theme.bg):bg(theme.yellow)

	-- Nvim-Tree
	-- hl("NvimTreeNormal"):fg(theme.fg):bg(theme.bg)
	-- hl("NvimTreeFolderName"):fg(theme.blue)
	-- hl("NvimTreeFolderIcon"):fg(theme.yellow)
	-- hl("NvimTreeOpenedFolderName"):fg(theme.blue):bold()
	-- hl("NvimTreeEmptyFolderName"):fg(theme.fg_alt)
	-- hl("NvimTreeIndentMarker"):fg(theme.blue)
	-- hl("NvimTreeSymlink"):fg(theme.cyan)
	-- hl("NvimTreeStatuslineNc"):fg(theme.fg_alt):bg(theme.bg)

	-- Spelling with wavy underlines
	-- hl("SpellBad"):undercurl():sp(theme.red)
	-- hl("SpellCap"):undercurl():sp(theme.yellow)
	-- hl("SpellRare"):undercurl():sp(theme.purple)
	-- hl("SpellLocal"):undercurl():sp(theme.cyan)

	-- NvimInvalid* groups with wavy underlines
	-- hl("NvimInvalidSpacing"):undercurl():sp(theme.red)
	-- hl("NvimInvalidIndent"):undercurl():sp(theme.yellow)
	-- hl("NvimInvalidTabStop"):undercurl():sp(theme.purple)

	hl("@ibl.indent.char.1"):fg(theme.c1:darker(20))
	hl("@ibl.whitespace.char.1"):fg(theme.c1)
	hl("@ibl.scope.char.1"):fg(theme.c1)
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
