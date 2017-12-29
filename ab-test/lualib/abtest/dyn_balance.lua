--动态get upstream server list

local json = require("cjson.safe")
local balancer = require("ngx.balancer")

local ngx = ngx
local log = ngx.log
local ERR = ERR
local abs = math.abs
local shared_config_cache = ngx.shared.my_cache_config

local uri_args = ngx.req.get_uri_args()
if not uri_args then
    log(ERR,"debug_uri_args-> is nil")
    return ngx.exit(500)
end

local upstream_backend = uri_args["upstream_backend"]
if not upstream_backend then
    log(ERR,"debug_get_upstream_backend-> is nil")
    return ngx.exit(500)
end
log(ERR,"debug_upstream_backend-> ",upstream_backend)
local upstream_server_value = shared_config_cache:get("up_"..upstream_backend)
if not upstream_server_value then
    log(ERR,"debug_upstream_server_value->",upstream_server_value)
    return ngx.exit(500)
end
log(ERR,"debug_upstream_server_value-> ",upstream_server_value)
local upstream_server = json.decode(upstream_server_value)
if upstream_server then
    local upstream_server_list = upstream_server.data
    local upstream_server_method = upstream_server.method
    if not  upstream_server_method or upstream_server_method =="rr" then
        local len = #upstream_server_list
        local pre = shared_config_cache:incr("index_"..upstream_backend,1,1)
        log(ERR,"debug_len-> ",len)
        log(ERR,"debug_pre-> ",pre)
        local index = abs(pre) % len
        log(ERR,"debug_index-> ",index)
        local server = upstream_server_list[index+1]
        local ip = server.ip
        local port = server.port
        log(ERR,"debug_ip-> ",ip)
        log(ERR,"debug_port-> ",port)
        balancer.set_current_peer(ip,port)
    end

end