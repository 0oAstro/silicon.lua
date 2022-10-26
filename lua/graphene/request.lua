local options = require("graphene.config").opts
local curl = require("plenary.curl")

local starting, ending = vim.api.nvim_buf_get_mark(0, "<")[1] - 1, vim.api.nvim_buf_get_mark(0, ">")[1]

local textCode = table.concat(vim.api.nvim_buf_get_lines(0, starting, ending, false), "\n")

local postBody = {
	code = textCode:gsub("\t",string.rep(" ", vim.o.tabstop)),
	lang = vim.bo.filetype,
	theme = options.theme,
	format = options.format,
	upscale = options.upscale,
	font = options.font,
	lineNumber = options.lineNumber,
	border = {
		thickness = options.border.thickness,
		radius = options.border.radius,
		colour = options.border.color,
	},
}

if postBody.code ~= nil then
  curl.post("https://teknologi-umum-graphene.fly.dev/api",{
    body = vim.json.encode(postBody),
    headers = {
      content_type = "application/json",
    },
    output = string.format("%s.%s", options.outputFile, options.format)
  })
  vim.notify(string.format("Code ScreenShot saved to %s.%s", options.outputFile, options.format))
else
	vim.notify("Please select code in visual mode first.", vim.log.levels.WARN)
end
