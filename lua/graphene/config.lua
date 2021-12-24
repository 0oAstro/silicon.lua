local options = {
	theme = "github-dark",
	format = "png",
	upscale = 2,
	font = "hack",
	lineNumber = true,
	outputFile = "graphene_code",
	border = {
		thickness = 10,
		radius = 0,
		color = "#ABB8C3",
	},
}

--- user: iterate given options over the default config and loads the colorscheme
--- get: returns the options
--- @param type string
--- @param opts table
return function(type, opts)
    if type == "get" then
        return options
    elseif type == "user" then
        options = vim.tbl_deep_extend("force", options, opts or {})
    end
end
