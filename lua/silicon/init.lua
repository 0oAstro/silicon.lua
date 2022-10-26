local init = {}

init.setup = function(opts)
	require("silicon.config").setup(opts)
end

-- Generates image of selected
---@param show_buf boolean whether to show buffer
---@param show_clip boolean whether to show clipboard
init.visualise = function(show_buf, show_clip)
	require("silicon.request")(show_buf, show_clip)
end

return init
