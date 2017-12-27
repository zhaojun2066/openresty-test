--
-- Created by IntelliJ IDEA.
-- User: jufeng
-- Date: 17-12-27
-- Time: 上午10:07
-- To change this template use File | Settings | File Templates.
--

-- 初始化策略配置
local strategy = require("abtest.strategy")
local log = ngx.log
local ERR = ngx.ERR

local status,err = strategy.init("/home/jufeng/mai/openresty-test/ab-test/conf/strategy.json")
if status then
    --全局work 共享分流策略配置
    strategyConfig =  strategy.get_config()
else
    log(ERR,"get strategy config err , ",err)
end
