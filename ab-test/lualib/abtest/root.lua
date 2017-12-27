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

-- all args from get request_method
--首先要获得lid
local url_args =  ngx.req.get_uri_args();
local lid = url_args["lid"]
if not lid then
    log(ERR,"lid is ," ,nil)
    ngx.exit(400) --request args err
end

--根据lid get config
local config = strategyConfig[lid]
local key = config["key"]  -- 分流key
local strategy_name = config["strategy_name"] -- 策略
local strategy_content = config["strategy_content"]
local default_experiment = config["default_experiment"] -- default
local upstream = config["upstream"] -- default
url_args["upstream_backend"] = upstream

local check = strategy.check_default_experiment(strategy_name,strategy_content)
if not check then
    strategy.forward_experiment(default_experiment,url_args)
end

local key_value = url_args[key]

if not key_value then
    strategy.forward_experiment(default_experiment,url_args)
end

if strategy_name == "tail" then
    local tail_value = ngx.re.sub(key_value,-2) --sub last one
    if tail_value then
        local exp = strategy_content[tail_value]
        if not exp then
            strategy.forward_experiment(default_experiment,url_args)
        else
            strategy.forward_experiment(exp,url_args)
        end
    else
        strategy.forward_experiment(default_experiment,url_args)
    end

elseif strategy_name == "range"  then

elseif strategy_name == "white"  then

elseif strategy_name == "random"  then

else
    --todo: default_experiment
end
