
local limit_conn = require "resty.limit.conn"
local ngx = ngx
local log = ngx.log
local ERR = ngx.ERR
local tonumber = tonumber

local limit ,limit_err = limit_conn.new("my_limit_conn_store",1,1,0.05)
if not limit then
    log(ERR,"failed to instantiate a resty.limit.conn object: ", limit_err)
end
local _M = {
    _VERSION = '0.01'
}


function _M.incoming(key)
    --local key = ngx.var.binary_remote_addr
    local delay ,err =limit:incoming(key,true)
    if not delay then
        if err == "rejected" then
            return ngx.exit(503)
        end
        log(ERR,"failed to limit req: ", err)
        return ngx.exit(500)
    end

    --如果延迟，说名放入桶理了,是否提交到shared_dict 共享内存中
    if limit:is_committed() then
        local ctx = ngx.ctx
        ctx.limit_conn_key = key
        ctx.limit_conn_delay = delay
    end

    if delay>0.001 then
        log(ERR,"delaying conn, excess ", delay,
            "s per binary_remote_addr by limit_conn_store")
        ngx.sleep(delay)
    end
end

function _M.leaving() --完成从shared_dict 对应的key 减1
    local ctx = ngx.ctx
    local key = ctx.limit_conn_key
    if key then
        local latency = tonumber(ngx.var.request_time) - ctx.limit_conn_delay
        local conn,err = limit:leaving(key,latency)
        if not conn then
            log(ERR,
                "failed to record the connection leaving ",
                "request: ", err)
        end

    end
end


return  _M