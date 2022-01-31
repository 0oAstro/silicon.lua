local init = {} 
init.setup = function (opts)
	require("graphene.config").setup("user", opts)
end

init.visualise = function ()
  require("graphene.main")
end

return init
