local init = {}

init.setup = function(opts)
	require("silicon.config").setup(opts)
end

-- Generates image
init.visualise = function()
	require("silicon.request")
end

return init
