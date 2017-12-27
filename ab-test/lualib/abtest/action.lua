--真real action to upstream location
-- set real upstream
local args = ngx.req.get_uri_args
ngx.var.upstream_backend = args["upstream_backend"]