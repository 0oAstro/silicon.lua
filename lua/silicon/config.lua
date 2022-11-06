local config = {}

config.opts = {
	theme = "auto",
	output = "SILICON_${year}-${month}-${date}_${time}.png",
	bgColor = vim.g.terminal_color_5,
	bgImage = "", -- path to image, must be png
	roundCorner = true,
	windowControls = true,
	lineNumber = true,
	font = "monospace",
	lineOffset = 1, -- no idea what this is
	linePad = 2, -- padding between lines
	padHoriz = 80, -- Horizontal padding
	padVert = 100, -- vertical padding
	shadowBlurRadius = 10,
	shadowColor = "#555555",
	shadowOffsetX = 8,
	shadowOffsetY = 8,
	gobble = false,
	debug = false,
}

--- @param opts table
config.setup = function(opts)
	config.opts = vim.tbl_deep_extend("force", config.opts, opts or {})
end

return config
