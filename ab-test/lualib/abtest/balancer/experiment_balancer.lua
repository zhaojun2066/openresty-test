--experiment balancer

local ngx = ngx
local log = ngx.log
local ERR = ERR
local tonumber = tonumber
local substring = string.sub
local ipairs = ipairs
local util = require("abtest.util")
local forward_experiment = util.forward_experiment
local _M = {}

---tail
-- strategy_content 策略数据
--- key_value: traffic key
--- default_experiment
--- url_args
function _M.tail(strategy_content,key_value,default_experiment,url_args)
    local tail_value = substring(key_value,-2) --sub last one
    if tail_value then
        local exp = strategy_content[tail_value]
        if not exp then
            return forward_experiment(default_experiment,url_args)
        else
            return forward_experiment(exp,url_args)
        end
    else
        return forward_experiment(default_experiment,url_args)
    end
end

---range
-- strategy_content 策略数据
--- key_value: traffic key
--- default_experiment
--- url_args
function _M.range(strategy_content,key_value,default_experiment,url_args)
    local key_number = tonumber(key_value)
    -- not number type
    if not key_number then
        return  forward_experiment(default_experiment,url_args)
    end
    local status = false
    for _,v in ipairs(strategy_content) do
        local data = v["data"]
        local experiment = v["experiment"]
        local min = data["min"]
        local max = data["max"]
        if key_number>= min and key_number<= max then
            status = true
            return  forward_experiment(experiment,url_args)
        end
    end
    -- not match anyone
    if  not status then
        return  forward_experiment(default_experiment,url_args)
    end
end


---white
-- strategy_content 策略数据
--- key_value: traffic key
--- default_experiment
--- url_args
function _M.white(strategy_content,key_value,default_experiment,url_args)
    local exp = strategy_content[key_value]
    if not exp then
        log(ERR,"debug_exp->",exp)
        return  forward_experiment(default_experiment,url_args)

    else
        log(ERR,"debug_url->",exp["url"])
        return forward_experiment(exp,url_args)
    end
end

return _M