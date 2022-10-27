local opts = require("silicon.config").opts
local Job = require("plenary.job")
local fmt = string.format

return function(show_buffer, copy_to_board, debug)
	local starting, ending = vim.api.nvim_buf_get_mark(0, "<")[1] - 1, vim.api.nvim_buf_get_mark(0, ">")[1]

	local textCode = table.concat(vim.api.nvim_buf_get_lines(0, starting, ending, false), "\n")

	if show_buffer then
		textCode = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	end

	if #textCode ~= 0 then
		local args = {
			"--font",
			opts.font,
			"--language",
			vim.bo.filetype,
			"--line-offset",
			opts.lineOffset,
			"--line-pad",
			opts.linePad,
			"--pad-horiz",
			opts.padHoriz,
			"--pad-vert",
			opts.padVert,
			"--shadow-blur-radius",
			opts.shadowBlurRadius,
			"--shadow-color",
			opts.shadowColor,
			"--shadow-offset-x",
			opts.shadowOffsetX,
			"--shadow-offset-y",
			opts.shadowOffsetY,
			"--theme",
			opts.theme,
		}
		if not opts.roundCorner then
			table.insert(args, "--no-round-corner")
		end
		if not opts.lineNumber then
			table.insert(args, "--no-line-number")
		end
		if not opts.windowControls then
			table.insert(args, "--no-window-controls")
		end
		if #opts.bgImage ~= 0 then
			table.insert(args, "--background-image")
			table.insert(args, opts.bgImage)
		else
			table.insert(args, "--background")
			table.insert(args, opts.bgColor)
		end
		if show_buffer then
			table.insert(args, "--highlight-lines")
			table.insert(args, fmt("%s-%s", starting + 1, ending))
		end
		if copy_to_board and vim.fn.executable("wl-copy") == 0 then
			table.insert(args, "--to-clipboard")
		elseif vim.fn.executable("wl-copy") == 1 and copy_to_board then
			-- Save output to /tmp then copy from there
			table.insert(args, "--output")
      opts.output = fmt(
		"/tmp/SILICON_%s-%s-%s_%s-%s.png",
		os.date("%Y"),
		os.date("%m"),
		os.date("%d"),
		os.date("%H"),
		os.date("%M")
	)
			table.insert(args, opts.output)
		else
			table.insert(args, "--output")
			table.insert(args, opts.output)
		end
		local job = Job:new({
			command = "silicon",
			args = args,
			on_exit = function(_, code, ...)
				if code == 0 then
					local msg = ""
					if copy_to_board then
						msg = "Snapped to clipboard"
						vim.defer_fn(function()
							if vim.fn.executable("wl-copy") == 1 then
								vim.api.nvim_exec(fmt("silent !cat %s | wl-copy", opts.output), false)
							end
						end, 0)
					else
						msg = string.format("Snap saved to %s", opts.output)
					end
					vim.defer_fn(function()
						vim.notify(msg, vim.log.levels.INFO, { plugin = "silicon.lua" })
					end, 0)
				else
					vim.defer_fn(function()
						vim.notify(
							"Some error occured while executing silicon",
							vim.log.levels.ERROR,
							{ plugin = "silicon.lua" }
						)
					end, 0)
				end
			end,
			on_stderr = function(_, data, ...)
				if debug then
					print(vim.inspect(data))
				end
			end,
			writer = textCode,
			cwd = vim.fn.getcwd(),
		})
		job:start()
	else
		vim.notify("Please select code snippet in visual mode first!", vim.log.levels.WARN)
	end
end
