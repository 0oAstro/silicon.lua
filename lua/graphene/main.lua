local options = require("graphene.config")("get")

local starting, ending = vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[2]
if starting == 1 then
	starting = 0
end

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
	
	print(textCode)
	vim.api.nvim_exec(string.format([[silent !curl -X POST 'https://teknologi-umum-graphene.fly.dev/api' -H 'content-type: application/json' -d '%s' --output %s.%s]], vim.json.encode(postBody), options.outputFile, options.format), true)
