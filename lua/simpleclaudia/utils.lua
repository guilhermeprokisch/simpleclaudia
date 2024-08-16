local M = {}
-- Function to convert hex to RGB
local function hex_to_rgb(hex)
	hex = hex:lower():gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

-- Function to convert RGB to HSL
local function rgb_to_hsl(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, l

	l = (max + min) / 2

	if max == min then
		h, s = 0, 0 -- achromatic
	else
		local d = max - min
		s = l > 0.5 and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / d + 2
		else
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return h * 360, s * 100, l * 100
end

-- HSL color object
local HSL = {}
HSL.__index = HSL

function HSL:new(h, s, l)
	return setmetatable({ h = h, s = s, l = l }, self)
end

function HSL:darker(amount)
	return HSL:new(self.h, self.s, math.max(0, self.l - amount))
end

function HSL:lighter(amount)
	return HSL:new(self.h, self.s, math.min(100, self.l + amount))
end

function HSL:saturate(amount)
	return HSL:new(self.h, math.min(100, self.s + amount), self.l)
end

function HSL:desaturate(amount)
	return HSL:new(self.h, math.max(0, self.s - amount), self.l)
end

function HSL:rotate(angle)
	return HSL:new((self.h + angle) % 360, self.s, self.l)
end

function HSL:mix(other, weight)
	weight = weight or 0.5
	local h = (self.h * (1 - weight) + other.h * weight) % 360
	local s = self.s * (1 - weight) + other.s * weight
	local l = self.l * (1 - weight) + other.l * weight
	return HSL:new(h, s, l)
end

function HSL:toHex()
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

	local h, s, l = self.h / 360, self.s / 100, self.l / 100
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

	return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- Function to create an HSL color object
function M.hsl(h, s, l)
	if type(h) == "string" and h:sub(1, 1) == "#" then
		-- If a hex code is provided, convert it to HSL
		local r, g, b = hex_to_rgb(h)
		h, s, l = rgb_to_hsl(r, g, b)
	end
	return HSL:new(h, s, l)
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

	-- Convert HSL colors to hex
	for attr, value in pairs(self.attrs) do
		if type(value) == "table" and value.toHex then
			self.attrs[attr] = value:toHex()
		end
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

function Highlight:as(base_group)
	self.attrs.base = base_group
	apply_highlight(self)
	return self
end

-- Function to create a new highlight definition
function M.hlg(group)
	return Highlight.new(group)
end

return M
