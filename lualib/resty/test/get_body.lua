
local getBody = function()
    ngx.req.read_body()
    local body_data = ngx.req.get_body_data()
    ngx.say("hello,",body_data)
end

getBody()
--print hello ,nil

-- 打开读取body 开关 lua_need_request_body on,此方法不推荐

--  curl 127.0.0.1/body_test -d jack
-- hello jack