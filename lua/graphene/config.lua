local config = {}

config.opts = {
	theme = string.format("github-%s", vim.o.background or "dark"),
	format = "png",
	upscale = 3,
	font = "fira code",
	lineNumber = true,
	outputFile = string.format("GRAPHENE_%s-%s-%s_%s-%s", os.date("%Y"), os.date("%m"), os.date("%d"), os.date("%H"), os.date("%M")),
	border = {
		thickness = 30,
		radius = 0,
		color = vim.g.terminal_color_4,
	},
}


--- @param opts table
config.setup = function(opts)
	config.opts = vim.tbl_deep_extend("force", config.opts, opts or {})
end

return config
