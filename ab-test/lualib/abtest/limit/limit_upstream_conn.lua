
local limit_conn = require "resty.limit.conn"
local ngx = ngx
local log = ngx.log
local ERR = ngx.ERR
local tonumber = toumber
local pairs = pairs

local _M = {}

local limit_upstream={}

function _M.init(upstream_config_list)
    -- 初始化每个upstream limit param
    if upstream_config_list then
       for k,v in pairs(upstream_config_list) do
          local traffic = v.traffic
          if traffic then
              local rate = traffic.rate
              local burst = traffic.burst
              local limit,limit_err = limit_conn.new("my_limit_conn_store",rate,burst,0.05)
              if not limit then
                  log(ERR,"failed to instantiate a resty.limit.conn object: ", limit_err)
              end
              if limit then
                  limit_upstream[k] = limit
              end
          end
        end
    end
end
--[[
function _M.get_traffic_config(upstream_name)
    return limit_upstream[upstream_name]
end]]

function _M.incoming(upstream_name,key)
    local limit = limit_upstream[upstream_name]
    log(ERR,"debug_limit...upstream_name,",upstream_name)
    log(ERR,"debug_limit...key,",key)
    if limit then
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
            ctx.limit_upstream_name = upstream_name
        end

        if delay>0.001 then
            log(ERR,"delaying conn, excess ", delay,
                "s per binary_remote_addr by limit_conn_store")
            ngx.sleep(delay)
        end
    end

end

function _M.leaving() --完成从shared_dict 对应的key 减1
    local ctx = ngx.ctx
    local key = ctx.limit_conn_key
    if key then
        local upstream_name = ctx.limit_upstream_name
        local limit = limit_upstream[upstream_name]
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