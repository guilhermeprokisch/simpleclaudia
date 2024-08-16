local M = {}

-- Function to create an HSL color object
function M.hsl(h, s, l)
	return { type = "hsl", h = h, s = s, l = l }
end

-- Function to convert HSL to RGB
local function hsl_to_rgb(h, s, l)
	h = h / 360
	s = s / 100
	l = l / 100

	local function hue_to_rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end

	local r, g, b
	if s == 0 then
		r, g, b = l, l, l
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue_to_rgb(p, q, h + 1 / 3)
		g = hue_to_rgb(p, q, h)
		b = hue_to_rgb(p, q, h - 1 / 3)
	end

	return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end

-- Function to convert RGB to hex
local function rgb_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

-- Function to process a color value
local function process_color(color)
	if type(color) == "table" and color.type == "hsl" then
		local r, g, b = hsl_to_rgb(color.h, color.s, color.l)
		return rgb_to_hex(r, g, b)
	end
	return color
end

-- Highlight definition object
local Highlight = {}
Highlight.__index = Highlight

function Highlight.new(group)
	return setmetatable({ group = group, attrs = {} }, Highlight)
end

local function apply_highlight(self)
	-- Process base style
	if self.attrs.base then
		local base_attrs = vim.api.nvim_get_hl(0, { name = self.attrs.base })
		for k, v in pairs(self.attrs) do
			base_attrs[k] = v
		end
		self.attrs = base_attrs
	end

	-- Process colors
	if self.attrs.fg then
		self.attrs.fg = process_color(self.attrs.fg)
	end
	if self.attrs.bg then
		self.attrs.bg = process_color(self.attrs.bg)
	end
	if self.attrs.sp then
		self.attrs.sp = process_color(self.attrs.sp)
	end

	-- Remove the base key
	self.attrs.base = nil

	-- Set the highlight
	vim.api.nvim_set_hl(0, self.group, self.attrs)
end

local function create_method(name, value)
	Highlight[name] = function(self, col)
		self.attrs[name] = col or value
		apply_highlight(self)
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

function Highlight:from(base_group)
	self.attrs.base = base_group
	apply_highlight(self)
	return self
end

-- Function to create a new highlight definition
function M.hl(group)
	return Highlight.new(group)
end

return M
