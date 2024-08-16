local M = {}

local hsl = require("simpleclaudia.hsl")

-- Table to store all highlight definitions
local highlight_definitions = {}

-- Highlight definition object
local Highlight = {}
Highlight.__index = Highlight

function Highlight.new(group)
	return setmetatable({ group = group, attrs = {} }, Highlight)
end

local function to_rgb_or_name(color)
	if type(color) == "string" then
		return color
	elseif type(color) == "table" and color.toHex then
		return color:toHex()
	else
		return nil
	end
end

local function create_method(name, value)
	Highlight[name] = function(self, col)
		self.attrs[name] = col or value
		return self
	end
end

-- Create methods for various attributes
create_method("fg")
create_method("bg")
create_method("sp")
create_method("bold", true)
create_method("italic", true)
create_method("underline", true)
create_method("undercurl", true)
create_method("strikethrough", true)

function Highlight:as(base_group)
	self.attrs.base = base_group
	return self
end

-- Function to create a new highlight definition
function M.hlg(group)
	local hl = Highlight.new(group)
	highlight_definitions[group] = hl
	return hl
end

-- Function to apply all collected highlight definitions
local function apply_highlights()
	for group, hl in pairs(highlight_definitions) do
		local final_attrs = {}

		-- Recursively resolve base groups
		local function resolve_base(attrs)
			if attrs.base then
				local base_hl = highlight_definitions[attrs.base]
				if base_hl then
					resolve_base(base_hl.attrs)
					for k, v in pairs(base_hl.attrs) do
						if k ~= "base" then
							final_attrs[k] = v
						end
					end
				end
			end
		end

		resolve_base(hl.attrs)

		-- Apply current attributes, overriding base attributes
		for k, v in pairs(hl.attrs) do
			if k ~= "base" then
				final_attrs[k] = v
			end
		end

		-- Convert colors to RGB or color names
		for attr, value in pairs(final_attrs) do
			if attr == "fg" or attr == "bg" or attr == "sp" then
				final_attrs[attr] = to_rgb_or_name(value)
			end
		end

		-- Set the highlight
		vim.api.nvim_set_hl(0, group, final_attrs)
	end
end

-- Export HSL functions
M.hsl = hsl.hsl
M.background = hsl.background
M.set_background = hsl.set_background

-- Function to finalize and apply all highlights
function M.apply_highlights()
	apply_highlights()
end

return M
