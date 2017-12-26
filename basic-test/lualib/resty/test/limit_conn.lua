--限制链接数
--jufeng



local limit_conn = require "resty.limit.conn"

-- limit_conn.new("my_limit_conn_store",200,100,0.5)
-- "my_limit_conn_store" :lua_shared_dict
-- 200 限制的并发数量
-- 100 大于200 并发的时候，桶的容量是 100,此时再来request 就会被拒绝
-- 0.5 we assume a default request time of 0.5 sec, which can be dynamically adjusted by the leaving() call in log_by_lua below.

local lim,err = limit_conn.new("my_limit_conn_store",200,100,0.5)

if not lim then
    ngx.log(ngx.ERR,"failed to instantiate a resty.limit.conn object:,",err)
end

--用client ip 作为key
local key = ngx.var.binary_remote_addr
local delay,err = lim:incoming(key,true) -- 提交到shared_dict 共享内存内
--如果没有没延迟，说没有进入桶内，也就没有延迟处理的资格了
if not delay then
    if err == "rejectd" then
        return ngx.exit(503)
    end
    ngx.log(ngx.ERR,"failed limit req: ",err)
    return ngx.exit(500)
end

if delay >0 then
    --todo: delay doing
    ngx.sleep(delay);--等待delay之后在进如下一个阶段

end

