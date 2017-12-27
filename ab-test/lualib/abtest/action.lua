--真real action to upstream location
-- set real upstream
ngx.log(ngx.ERR,"debugin action")
local args = ngx.req.get_uri_args()

local upstream_backend = args["upstream_backend"]
ngx.log(ngx.ERR,"debugin upstream_backend-> ",upstream_backend)
--ngx.var.upstream_backend =  upstream_backend
-- set $upstream_backend '';


return upstream_backend
-- set_by_lua_file $upstream_backend /action.lua;