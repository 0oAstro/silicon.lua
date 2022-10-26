local init = {}

init.setup = function(opts)
	require("graphene.config").setup(opts)
end

-- Generates image
init.visualise = function()
	require("graphene.request")
end

return init
