local M = {}

-- Function to convert hex to RGB
local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
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

-- Function to convert HSL to RGB
local function hsl_to_rgb(h, s, l)
	h, s, l = h / 360, s / 100, l / 100

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
		r, g, b = l, l, l -- achromatic
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue_to_rgb(p, q, h + 1 / 3)
		g = hue_to_rgb(p, q, h)
		b = hue_to_rgb(p, q, h - 1 / 3)
	end

	return r * 255, g * 255, b * 255
end

-- Base color object
local Color = {}
Color.__index = Color

function Color:new(h, s, l)
	return setmetatable({ h = h, s = s, l = l }, self)
end

function Color:toHex()
	local r, g, b = hsl_to_rgb(self.h, self.s, self.l)
	return string.format("#%02x%02x%02x", r, g, b)
end

-- HSL color object
local HSL = setmetatable({}, { __index = Color })
HSL.__index = HSL

function HSL:new(h, s, l)
	return setmetatable(Color:new(h, s, l), HSL)
end

function HSL:lighten(amount)
	return HSL:new(self.h, self.s, math.min(self.l + amount, 100))
end

function HSL:darken(amount)
	return HSL:new(self.h, self.s, math.max(self.l - amount, 0))
end

function HSL:saturate(amount)
	return HSL:new(self.h, math.min(self.s + amount, 100), self.l)
end

function HSL:desaturate(amount)
	return HSL:new(self.h, math.max(self.s - amount, 0), self.l)
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

-- Background color object
local Background = setmetatable({}, { __index = Color })
Background.__index = Background

function Background:new(h, s, l)
	return setmetatable(Color:new(h, s, l), Background)
end

-- Global background color
local background_color = nil

-- Function to set the background color
function M.set_background(bg)
	if getmetatable(bg) == Background then
		background_color = bg
	else
		error("Background must be a Background object")
	end
end

-- Function to get the background color
function M.get_background()
	if background_color then
		return background_color
	else
		error("Background color has not been set")
	end
end

-- Function to create an HSL color object
function M.hsl(h, s, l)
	if type(h) == "string" and h:sub(1, 1) == "#" then
		local r, g, b = hex_to_rgb(h)
		h, s, l = rgb_to_hsl(r, g, b)
	end
	return HSL:new(h, s, l)
end

-- Function to create a Background color object
function M.background(h, s, l)
	if type(h) == "string" and h:sub(1, 1) == "#" then
		local r, g, b = hex_to_rgb(h)
		h, s, l = rgb_to_hsl(r, g, b)
	end
	return Background:new(h, s, l)
end

-- Function to apply opacity
function HSL:opacity(alpha)
	if not background_color then
		error("Background color has not been set. Use set_background() first.")
	end
	if alpha < 0 or alpha > 1 then
		error("Alpha must be between 0 and 1")
	end

	local bg = background_color
	local r1, g1, b1 = hsl_to_rgb(self.h, self.s, self.l)
	local r2, g2, b2 = hsl_to_rgb(bg.h, bg.s, bg.l)

	local r = r1 * alpha + r2 * (1 - alpha)
	local g = g1 * alpha + g2 * (1 - alpha)
	local b = b1 * alpha + b2 * (1 - alpha)

	local h, s, l = rgb_to_hsl(r, g, b)
	return HSL:new(h, s, l)
end

return M
