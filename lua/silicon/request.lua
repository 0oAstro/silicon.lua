local opts = require("silicon.config").opts
local Job = require("plenary.job")
local fmt = string.format

return function(show_buffer, copy_to_board)
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
			table.insert(args, fmt("%s-%s", starting, ending))
		end
		if copy_to_board then
			table.insert(args, "--to-clipboard")
		else
			table.insert(args, "--output")
			table.insert(args, opts.output)
		end
		local job = Job:new({
			command = "silicon",
			args = args,
			on_exit = function(_, exit_code, signal)
				print(tostring(exit_code), tostring(signal))
			end,
			on_stderr = function(error, data, ...)
				print(vim.inspect(data))
			end,
			writer = textCode,
			cwd = vim.fn.getcwd(),
		})
		job:start()
		print(vim.inspect(fmt("%s %s", "silicon", table.concat(args, " "))))
	else
		vim.notify("Please select code in visual mode first.", vim.log.levels.WARN)
	end
end
