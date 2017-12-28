--动态get upstream server list

local json = require("cjson.safe")
local balancer = require("ngx.balancer")
local shared_config_cache = ngx.shared.my_cache_config

local uri_args = ngx.req.get_uri_args()
if not uri_args then
    ngx.log(ngx.ERR,"debug_uri_args-> is nil")
    ngx.exit(500)
end

local upstream_backend = uri_args["upstream_backend"]
if not upstream_backend then
    ngx.log(ngx.ERR,"debug_get_upstream_backend-> is nil")
    --todo a upstram server and show err message
    ngx.exit(500)
    return
end
ngx.log(ngx.ERR,"debug_upstream_backend-> ",upstream_backend)
local upstream_server_value = shared_config_cache:get("up_"..upstream_backend)
if not upstream_server_value then
    --todo a upstram server and show err message
    ngx.log(ngx.ERR,"debug_upstream_server_value->",upstream_server_value)
    return
end
ngx.log(ngx.ERR,"debug_upstream_server_value-> ",upstream_server_value)
local upstream_server = json.decode(upstream_server_value)
if upstream_server then
    local upstream_server_list = upstream_server.data
    local upstream_server_method = upstream_server.method
    if not  upstream_server_method or upstream_server_method =="rr" then
        local len = #upstream_server_list
        local pre = shared_config_cache:incr("index_"..upstream_backend,1,1)
        --local index = math.abs(pre)%len
        ngx.log(ngx.ERR,"debug_len-> ",len)
        ngx.log(ngx.ERR,"debug_pre-> ",pre)
        local index = math.abs(pre) % len
        ngx.log(ngx.ERR,"debug_index-> ",index)
        local server = upstream_server_list[index+1]
        -- todo：:
        local ip = server.ip
        local port = server.port
        ngx.log(ngx.ERR,"debug_ip-> ",ip)
        ngx.log(ngx.ERR,"debug_port-> ",port)
        balancer.set_current_peer(ip,port)
    end

end