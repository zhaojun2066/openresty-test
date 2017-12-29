--
-- Created by IntelliJ IDEA.
-- User: jufeng
-- Date: 17-12-27
-- Time: 上午10:07
-- To change this template use File | Settings | File Templates.
--

-- 初始化策略配置
local log = ngx.log
local ERR = ngx.ERR
local json = require("cjson.safe")
local strategy = require("abtest.conf.strategy")
local dyn_upstream = require("abtest.conf.upstream")
local limit_conn = require("abtest.limit_upstream_conn")
local strategy_file = "/home/jufeng/mai/openresty-test/ab-test/conf/strategy.json"
local upstream_file = "/home/jufeng/mai/openresty-test/ab-test/conf/upstream.json"

local shared_config_cache = ngx.shared.my_cache_config
local status,err = strategy.init(strategy_file)
if status then
    --全局work 共享分流策略配置
    local strategy_config =  strategy.get_config()
    if strategy_config then
        shared_config_cache:set("strategy_config",json.encode(strategy_config),0);
    end
else
    log(ERR,"get strategy config err , ",err)
end

local init_status,err = dyn_upstream.init(upstream_file)
if init_status then
    local upstream_config =  dyn_upstream.get_config()
    if upstream_config then
        for k,v in pairs(upstream_config) do
            shared_config_cache:set("up_"..k,json.encode(v),0);
        end
        -- init limit traffic for upstream
        limit_conn.init(upstream_config)
    end
else
    log(ERR,"get upstream config err , ",err)
end
