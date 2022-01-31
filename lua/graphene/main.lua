local options = require("graphene.config")("get")

local starting, ending = vim.api.nvim_buf_get_mark(0, "<")[1] - 1, vim.api.nvim_buf_get_mark(0, ">")[1] - 1

local textCode = table.concat(vim.api.nvim_buf_get_lines(0, starting, ending, false), "\n")

local postBody = {
	code = textCode,
	lang = vim.bo.filetype,
	theme = options.theme,
	format = options.format,
	upscale = options.upscale,
	font = options.font,
	lineNumber = options.lineNumber,
	border = {
		thickness = options.thickness,
		radius = options.radius,
		colour = options.color,
	},
}

if ending > 0 then
  vim.api.nvim_exec(string.format([[silent !curl -X POST 'https://teknologi-umum-graphene.fly.dev/api' -H 'content-type: application/json' -d '%s' >> %s.%s]], vim.json.encode(postBody), options.outputFile, options.format), true)
else
  vim.notify("Please select code in visual mode first.", vim.log.levels.WARN)
end
