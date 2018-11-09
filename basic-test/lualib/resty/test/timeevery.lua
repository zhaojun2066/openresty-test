--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/9
-- Time: 15:26
-- To change this template use File | Settings | File Templates.
--


local delay = 5 -- in seconds

local handler

handler = function(premature)
    --- premature nginx 退出true
    if premature then
        return
    end
    --- todo some thing
    --os.execute("sleep " .. 5000)
    --log(ERR, "handler test")
end

--- 全局只有一个work 这样
if 0 == ngx.worker.id() then
    --- 注意和ngx.timer.at 的区别，at 是需要重复调用的
    local ok, err = ngx.timer.every(delay, handler)
    if not ok then
        log(ERR, "failed to create timer: ", err)
        return
    end
end
