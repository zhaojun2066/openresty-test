--get  get_uri_args
--post get_post_args
-- local request_method = ngx.var.request_method  "GET" or "POST"


local uri_args = ngx.req.get_uri_args()
for k,v in pairs(uri_args) do
    ngx.say("[GET] key : ",k," ,value : ",v)
end

--接受post 参数，需要解析body
ngx.req.read_body()
local post_args = ngx.req.get_post_args()
for k,v in pairs(post_args) do
    ngx.say("[POST] key : ",k," ,value : ",v)
end