--
-- Created by IntelliJ IDEA.
-- User: jufeng
-- Date: 17-12-13
-- Time: 上午10:47
-- To change this template use File | Settings | File Templates.
--

local limit_req = require "resty.limit.req" -- 引用limit req 模块


--- new (share_dict,rate,burst)
--- share_dict ，open热resty cache
--- rate 限制请数 requests数/sec
--- burst 桶容量

local lim, err = limit_req.new("my_limit_req_store", 2, 2)

--- share_dict not found
if not lim then
    ngx.log(ngx.ERR,
        "failed to instantiate a resty.limit.req object: ", err)
    return ngx.exit(500)
end
--- 对ip限流,如果想限制second 可以用 os.time() 返回秒 作为key，这样就限制了本nginx 的速率
local key = ngx.var.binary_remote_addr
local delay, err = lim:incoming(key, true)
if not delay then --- 说明超出桶大小了
    if err == "rejected" then --- 如果被拒绝
        return ngx.exit(503)
    end
    ngx.log(ngx.ERR, "failed to limit req: ", err)
    return ngx.exit(500)
end


----- 如果delay >0，，，进入桶里了
if delay >= 0.001 then
    ngx.sleep(delay)
end