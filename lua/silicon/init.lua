local init = {}

init.setup = function(opts)
	require("silicon.config").setup(opts)
end

-- For backwards compatibility
-- Generates image of selected
---@param show_buf boolean whether to show buffer
---@param to_clip boolean whether to show clipboard
init.visualise = function(show_buf, to_clip)
	init.visualise_api({ show_buf = show_buf, to_clip = to_clip })
	vim.notify(
		string.format(
			[[
Calling require("silicon").visualise(%s, %s) is deprecated and will be removed soon
Try using require("silicon").visualise_api({show_buf = %s, to_clip = %s})
  ]],
			show_buf,
			to_clip,
			show_buf,
			to_clip
		),
		vim.log.levels.WARN
	)
end

-- Similar to visualise
--- Generates image of selected
---[[
-- show_buf boolean whether to show buffer
-- to_clip boolean whether to show clipboard
-- debug show debug info
---]]
---@param opts table containing the options
init.visualise_api = function(opts)
	require("silicon.request").exec(opts.show_buf or false, opts.to_clip or false, opts.debug or false)
end

return init
