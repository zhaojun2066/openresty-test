--
-- Created by IntelliJ IDEA.
-- User: jufeng
-- Date: 17-12-27
-- Time: 上午10:38
-- To change this template use File | Settings | File Templates.
-- 分流中心root，流量到此进行分流操作,找find experiment and upstream
--
local ngx = ngx
local log = ngx.log
local ERR = ERR


local json = require("cjson.safe")
local limit_upstream_conn = require("abtest.limit.limit_upstream_conn")
local limit_all_conn = require("abtest.limit.limit_all_conn")
local util = require("abtest.util")
local check_default_experiment = util.check_default_experiment
local forward_experiment = util.forward_experiment
local ipairs = ipairs
local tonumber = tonmber
local substring = string.sub


-- all args from get request_method
--首先要获得lid
local url_args =  ngx.req.get_uri_args()
local lid = url_args["lid"]
log(ERR,"debug_lid->",lid)
if not lid then
    log(ERR,"lid is ," ,nil)
    return ngx.exit(400) --request args err
end
local shared_config_cache = ngx.shared.my_cache_config
local strategy_value = shared_config_cache:get("strategy_config")
log(ERR,"debug_strategy_config->",strategy_value)
if not strategy_value then
    log(ERR,"debug_strategy_config->",strategy_value)
    return ngx.exit(500)
end



--根据lid get config
local strategy_config = json.decode(strategy_value)
local config = strategy_config[lid]
if not config then
    log(ERR,"lid is not found," ,nil)
    return ngx.exit(400) --request args err
end
local key = config["key"]  -- 分流key
local strategy_name = config["strategy_name"] -- 策略
local strategy_content = config["strategy_content"]
local default_experiment = config["default_experiment"] -- default
local upstream = config["upstream"] -- default
url_args["upstream_backend"] = upstream


--limit traffic for all request
---limit_all_conn.incoming("total_traffic");

--limit upstream traffic for lid's request
limit_upstream_conn.incoming(upstream,lid);

log(ERR,"debug_strategy_name->",strategy_name)
log(ERR,"debug_strategy_content->",json.encode(strategy_content))
local check = check_default_experiment(strategy_name,strategy_content)
if not check then
    log(ERR,"debug_check->",check)
    return forward_experiment(default_experiment,url_args)
end

local key_value = url_args[key]
log(ERR,"debug_key_value->",key_value)
log(ERR,"debug_default_url->",default_experiment["url"])
if not key_value then
    return forward_experiment(default_experiment,url_args)
end

if strategy_name == "tail" then
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
elseif strategy_name == "range"  then
    local key_number = tonumber(key_value)
    -- not number type
    if not key_number then
        return  forward_experiment(default_experiment,url_args)
    end
    local status = false
    for k,v in ipairs(strategy_content) do
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
elseif strategy_name == "white"  then
    local exp = strategy_content[key_value]
    if not exp then
        log(ERR,"debug_exp->",exp)
        return  forward_experiment(default_experiment,url_args)

    else
        log(ERR,"debug_url->",exp["url"])
        return forward_experiment(exp,url_args)

    end
elseif strategy_name == "random"  then
else
    return forward_experiment(default_experiment,url_args)
end
