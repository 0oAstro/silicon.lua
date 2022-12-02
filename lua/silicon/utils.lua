local config_opts = require("silicon.config").opts
local fmt = string.format
local Job = require("plenary.job")

local utils = {}

utils._os_capture = function(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

utils.config_dir = string.match(utils._os_capture("silicon --config-file"), "^(.*[\\\\/])")
utils.syntaxes_path = utils.config_dir .. "/syntaxes"
utils.themes_path = utils.config_dir .. "/themes"

utils._installed_colorschemes = function()
	return vim.fn.readdir(utils.themes_path)
end

--- Check if a file or directory exists in this path
---@param file string path of file or directory
utils._exists = function(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Reload silicon themes/synax cache
---[[
-- async boolean whether to wait for silicon command completion
---]]
---@param opts table containing the options
utils.reload_silicon_cache = function(opts)
	local reloader = Job:new({
		command = "silicon",
		args = { "--build-cache" },
		cwd = utils.config_dir,
		on_stderr = function(_, data, ...)
			if config_opts.debug then
				print(vim.inspect(data))
			end
		end,
	})

	if opts.async then
		reloader:start()
	else
		reloader:sync()
	end
end

--- Build silicon theme file from current colorscheme
utils.build_tmTheme = function()
	local tmTheme = require("silicon.build_tmTheme")()
	local file = fmt("%s/%s.tmTheme", utils.themes_path, config_opts.theme)
	os.execute(fmt("touch %s", file))
	local theme = io.open(file, "w+")
	theme:write(tmTheme)
	theme:close()
end

utils._replace_placeholders = function(str)
	return str:gsub("${time}", fmt("%s:%s", os.date("%H"), os.date("%M")))
		:gsub("${year}", os.date("%Y"))
		:gsub("${month}", os.date("%m"))
		:gsub("${date}", os.date("%d"))
end

return utils
