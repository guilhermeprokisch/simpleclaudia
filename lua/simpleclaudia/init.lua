local utils = require("simpleclaudia.utils")
local hl, hsl, background = utils.hlg, utils.hsl, utils.background

local M = {}

-- Function to create the color palettes
local function create_colors()
	local bg_code_light = "#eeede6"
	local bg_code_dark = "#393937"

	local c = {
		dark = {
			bg = hsl(bg_code_dark),
			fg = hsl("#CFCFCA"),
			red = hsl("#8D4144"),
			green = hsl("#8CA375"),
			yellow = hsl("#D7785D"),
			blue = hsl("#3F7DD7"),
			purple = hsl("#9888EE"),
			cyan = hsl("#CFCFCA"),
			c1 = hsl("#CFCFCA"),
			c2 = hsl("#A9A69C"),
		},
		light = {
			bg = hsl(bg_code_light),
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
	c.light.background = background(bg_code_light)
	c.dark.background = background(bg_code_dark)
	return c
end

-- Initialize the colors
local colors = create_colors()

-- Function to set up your colorscheme
local function setup_colors()
	local theme = vim.o.background == "dark" and colors.dark or colors.light

	-- Set the background color for opacity calculations
	utils.set_background(theme.background)

	-- Basic editor colors
	hl("Normal"):fg(theme.fg):bg(theme.bg)
	hl("NormalFloat"):fg(theme.fg):bg(theme.bg:darken(5))
	hl("CursorLine"):bg(theme.fg:opacity(0.1))
	hl("Comment"):fg(theme.fg:opacity(0.5)):italic()
	hl("CursorColumn"):as("CursorLine")
	hl("Visual"):as("CursorLine")

	-- Editor UI
	hl("StatusLine"):fg(theme.fg):bg(theme.bg:opacity(0.5)):bold()
	hl("StatusLineNC"):fg(theme.fg:opacity(0.5)):bg(theme.bg)
	hl("TabLine"):as("StatusLineNC")
	hl("TabLineFill"):as("StatusLine")
	hl("TabLineSel"):fg(theme.bg):bg(theme.purple)
	hl("Search"):fg(theme.bg):bg(theme.yellow)
	hl("IncSearch"):as("Search")
	hl("Pmenu"):fg(theme.fg):bg(theme.bg:opacity(0.5))
	hl("PmenuSel"):fg(theme.bg):bg(theme.purple)
	hl("PmenuSbar"):bg(theme.bg:opacity(0.5))
	hl("PmenuThumb"):bg(theme.fg)
	hl("Folded"):fg(theme.fg:opacity(0.5)):bg(theme.bg:opacity(0.5))
	hl("FoldColumn"):as("Folded")
	hl("SignColumn"):fg(theme.fg):bg(theme.bg)
	hl("LineNr"):fg(theme.c2:opacity(0.8))
	hl("CursorLineNr"):fg(theme.yellow):bold()
	hl("MatchParen"):fg(theme.yellow):bold():underline()
	hl("NonText"):fg(theme.fg:opacity(0.5))
	hl("SpecialKey"):as("NonText")
	hl("VisualNOS"):as("Visual")
	hl("Directory"):fg(theme.blue)
	hl("Title"):fg(theme.purple):bold()

	-- Diff
	hl("DiffAdd"):fg(theme.green):bold()
	hl("DiffChange"):fg(theme.yellow):bold()
	hl("DiffDelete"):fg(theme.red):bold()
	hl("DiffText"):fg(theme.fg):bold()

	-- Git
	hl("GitSignsAdd"):fg(theme.green)
	hl("GitSignsChange"):fg(theme.yellow)
	hl("GitSignsDelete"):fg(theme.red)

	-- Spelling
	hl("SpellBad"):fg(theme.red):underline()
	hl("SpellCap"):fg(theme.yellow):underline()
	hl("SpellRare"):fg(theme.purple):underline()
	hl("SpellLocal"):fg(theme.cyan):underline()

	-- Treesitter
	hl("@comment"):fg(theme.c1:opacity(0.7)):italic()
	hl("@string"):fg(theme.green)
	hl("@variable"):fg(theme.fg):italic()
	hl("@function"):fg(theme.yellow)
	hl("@function.builtin"):fg(theme.yellow):italic()
	hl("@function.call"):as("@function")
	hl("@function.macro"):fg(theme.orange)
	hl("@keyword"):fg(theme.blue):italic()
	hl("@keyword.function"):fg(theme.blue):italic()
	hl("@keyword.operator"):fg(theme.cyan)
	hl("@keyword.return"):fg(theme.blue):italic()
	hl("@conditional"):fg(theme.blue)
	hl("@repeat"):fg(theme.blue)
	hl("@label"):fg(theme.blue)
	hl("@operator"):fg(theme.cyan)
	hl("@exception"):fg(theme.red):italic()
	hl("@constant"):fg(theme.cyan):italic()
	hl("@constant.builtin"):fg(theme.cyan):italic()
	hl("@constant.macro"):fg(theme.orange)
	hl("@namespace"):fg(theme.blue):italic()
	hl("@symbol"):fg(theme.purple)
	hl("@annotation"):fg(theme.yellow)
	hl("@attribute"):fg(theme.cyan)
	hl("@type"):fg(theme.yellow)
	hl("@type.builtin"):fg(theme.blue:opacity(0.5)):italic()
	hl("@type.definition"):fg(theme.yellow):underline()
	hl("@type.qualifier"):fg(theme.blue):italic()
	hl("@storageclass"):fg(theme.blue):italic()
	hl("@structure"):fg(theme.purple)
	hl("@property"):fg(theme.cyan:opacity(0.8))
	hl("@field"):fg(theme.green)
	hl("@parameter"):fg(theme.yellow):italic()
	hl("@parameterreference"):fg(theme.yellow):underline()
	hl("@method"):fg(theme.yellow)
	hl("@method.call"):as("@method")
	hl("@constructor"):as("@function")
	hl("@number"):fg(theme.purple):italic()
	hl("@boolean"):fg(theme.purple):italic()
	hl("@float"):fg(theme.purple):italic()
	hl("@punctuation.delimiter"):fg(theme.cyan)
	hl("@punctuation.bracket"):fg(theme.fg:opacity(0.8))
	hl("@punctuation.special"):fg(theme.cyan)
	hl("@string.regex"):fg(theme.red)
	hl("@string.escape"):fg(theme.purple)
	hl("@tag"):fg(theme.blue)
	hl("@tag.attribute"):fg(theme.yellow)
	hl("@tag.delimiter"):fg(theme.cyan)
	hl("@text"):fg(theme.fg)
	hl("@text.strong"):bold()
	hl("@text.emphasis"):italic()
	hl("@text.underline"):underline()
	hl("@text.strike"):strikethrough()
	hl("@text.title"):fg(theme.purple):bold()
	hl("@text.literal"):fg(theme.green)
	hl("@text.uri"):fg(theme.cyan):underline()
	hl("@text.math"):fg(theme.yellow)
	hl("@text.reference"):fg(theme.blue):underline()
	hl("@text.todo"):fg(theme.purple):bold()
	hl("@text.note"):fg(theme.cyan):italic()
	hl("@text.warning"):fg(theme.yellow):italic()
	hl("@text.danger"):fg(theme.red):italic()

	-- Semantic tokens
	hl("@lsp.type.class"):as("@type")
	hl("@lsp.type.comment"):as("@comment")
	hl("@lsp.type.decorator"):as("@function")
	hl("@lsp.type.enum"):as("@type")
	hl("@lsp.type.enumMember"):as("@constant")
	hl("@lsp.type.function"):as("@function")
	hl("@lsp.type.interface"):as("@type")
	hl("@lsp.type.macro"):as("@function.macro")
	hl("@lsp.type.method"):as("@method")
	hl("@lsp.type.namespace"):as("@namespace")
	hl("@lsp.type.parameter"):as("@parameter")
	hl("@lsp.type.property"):as("@property")
	hl("@lsp.type.struct"):as("@structure")
	hl("@lsp.type.type"):as("@type")
	hl("@lsp.type.typeParameter"):as("@type.definition")
	hl("@lsp.type.variable"):as("@variable")

	-- Diagnostic
	hl("DiagnosticError"):fg(theme.red:opacity(0.8)):italic()
	hl("DiagnosticWarn"):fg(theme.yellow:opacity(0.8)):italic()
	hl("DiagnosticInfo"):fg(theme.blue:opacity(0.8)):italic()
	hl("DiagnosticHint"):fg(theme.cyan:opacity(0.8)):italic()
	hl("DiagnosticUnderlineError"):undercurl():sp(theme.red)
	hl("DiagnosticUnderlineWarn"):undercurl():sp(theme.yellow)
	hl("DiagnosticUnderlineInfo"):undercurl():sp(theme.blue)
	hl("DiagnosticUnderlineHint"):undercurl():sp(theme.cyan)

	-- Neovim LSP
	hl("LspReferenceText"):bg(theme.bg:opacity(0.5))
	hl("LspReferenceRead"):bg(theme.bg:opacity(0.5))
	hl("LspReferenceWrite"):bg(theme.bg:opacity(0.5))
	hl("LspSignatureActiveParameter"):fg(theme.yellow):bold()

	-- Lualine
	hl("LualineNormal"):fg(theme.fg):bg(theme.bg:opacity(0.5))
	hl("LualineInsert"):fg(theme.bg):bg(theme.green)
	hl("LualineVisual"):fg(theme.bg):bg(theme.purple)
	hl("LualineReplace"):fg(theme.bg):bg(theme.red)
	hl("LualineCommand"):fg(theme.bg):bg(theme.yellow)

	-- Indent Blankline
	hl("@ibl.indent.char.1"):fg(theme.c2:opacity(0.3))
	hl("@ibl.whitespace.char.1"):fg(theme.c1)
	hl("@ibl.scope.char.1"):fg(theme.c1)

	utils.apply_highlights()
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
