-- openresty 定时任务
-- ngx.timer.at
-- 在事件循环中，Nginx 会找出到期的 timer，并在一个独立的协程中执行对应的 Lua 回调函数。
-- 它是和每个nginx work 绑定的额
-- 但是 ngx.timer.at 自身的运行，与当前的请求并没有关系的。

local delay = 5
local handler
handler = function(premature)
    if premature then
        return
    end
    --do something here


    local ok ,err = ngx.timer.at(delay,handler)
    if not ok then
        ngx.log(ngx.ERR,"failed to create the timer: ",err)
        return
    end
end

local ok ,err = ngx.timer.at(delay,handler)
if not ok then
    ngx.log(ngx.ERR,"failed to create the timer: ",err)
    return
end

