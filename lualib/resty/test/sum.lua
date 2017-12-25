
--get param for get method
local args = ngx.req.get_uri_args()
ngx.say(tonumber(args.a)+tonumber(args.b))

