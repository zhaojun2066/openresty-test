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
local ERR = ngx.ERR


local strategy = require("abtest.strategy")
local json = require("cjson.safe")

-- all args from get request_method
--首先要获得lid
local url_args =  ngx.req.get_uri_args();
local lid = url_args["lid"]
ngx.log(ngx.ERR,"debug_lid->",lid)
if not lid then
    log(ERR,"lid is ," ,nil)
    ngx.exit(400) --request args err
end
local shared_config_cache = ngx.shared.my_cache_config
local strategy_value = shared_config_cache:get("strategy_config")
ngx.log(ngx.ERR,"debug_strategy_config->",strategy_value)
if not strategy_value then
    ngx.log(ngx.ERR,"debug_strategy_config->",strategy_value)
    ngx.exit(500)
    return
end
--根据lid get config
local strategy_config = json.decode(strategy_value)
local config = strategy_config[lid]
if not config then
    log(ERR,"lid is not found," ,nil)
    ngx.exit(400) --request args err
end
local key = config["key"]  -- 分流key
local strategy_name = config["strategy_name"] -- 策略
local strategy_content = config["strategy_content"]
local default_experiment = config["default_experiment"] -- default
local upstream = config["upstream"] -- default
url_args["upstream_backend"] = upstream
ngx.log(ngx.ERR,"debug_strategy_name->",strategy_name)
ngx.log(ngx.ERR,"debug_strategy_content->",json.encode(strategy_content))
local check = strategy.check_default_experiment(strategy_name,strategy_content)
if not check then
    ngx.log(ngx.ERR,"debug_check->",check)
    strategy.forward_experiment(default_experiment,url_args)
    return
end

local key_value = url_args[key]
ngx.log(ngx.ERR,"debug_key_value->",key_value)
ngx.log(ngx.ERR,"debug_default_url->",default_experiment["url"])
if not key_value then
    strategy.forward_experiment(default_experiment,url_args)
    return
end

if strategy_name == "tail" then
    local tail_value = string.sub(key_value,-2) --sub last one
    if tail_value then
        local exp = strategy_content[tail_value]
        if not exp then
            strategy.forward_experiment(default_experiment,url_args)
            return
        else
            strategy.forward_experiment(exp,url_args)
            return
        end
    else
        strategy.forward_experiment(default_experiment,url_args)
        return
    end

elseif strategy_name == "range"  then
    local key_number = tonumber(key_value)
    -- not number type
    if not key_number then
        strategy.forward_experiment(default_experiment,url_args)
        return
    end
    local status = false
    for k,v in ipairs(strategy_content) do
        local data = v["data"]
        local experiment = v["experiment"]
        local min = data["min"]
        local max = data["max"]
        if key_number>= min and key_number<= max then
            status = true
            strategy.forward_experiment(experiment,url_args)
            return
        end
    end
    -- not match anyone
    if  not status then
        strategy.forward_experiment(default_experiment,url_args)
        return
    end



elseif strategy_name == "white"  then
    local exp = strategy_content[key_value]
    if not exp then
        ngx.log(ngx.ERR,"debug_exp->",exp)
        strategy.forward_experiment(default_experiment,url_args)
        return
    else
        ngx.log(ngx.ERR,"debug_url->",exp["url"])
        strategy.forward_experiment(exp,url_args)
        return
    end
elseif strategy_name == "random"  then

else
    strategy.forward_experiment(default_experiment,url_args)
    return
end
