
--以下是远程cookie 操作
local function get_all_cookie()
    return ngx.var.http_cookie
end

local function get_cookie(name)
    return ngx.var.cookie_..name
end

local function set_cookie(name,value,expires)
    ngx.headr["Set-Header"]={"'"..name.."="..value"; path=/; Expires="..ngx.cookie_time(expires)}
end


--利用 lua-resty-cookie

--https://github.com/cloudflare/lua-resty-cookie/edit/master/lib/resty/cookie.lua

local ck = require "resty.cookie"

local function cookies()
    local cookie, err = ck:new()
    if not cookie then
        ngx.log(ngx.ERR, err)
        return
    end

  --[[  local field, err = cookie:get("lang")
    if not field then
        ngx.log(ngx.ERR, err)
       -- return
    end
    if field then
        ngx.say("lang", " => ", field)
    end


    -- get all cookies
    local fields, err = cookie:get_all()
    if not fields then
        ngx.log(ngx.ERR, err)
       -- return
    end

    if fields then
        for k, v in pairs(fields) do
            ngx.say(k, " ====> ", v)
        end
    end]]



    -- set one cookie
    local ok, err = cookie:set({
        key = "lang11",
        value = "Bob",
        path = "/",
        domain = "www.jufeng.com",
        --secure = true,  https 才能使用，否则不会set 成功哦
        httponly = true,
        expires = "Wed, 09 Jun 2021 10:18:14 GMT", max_age = 50,
        samesite = "Strict", extension = "a4334aebaec"
    })
    if not ok then
        ngx.say("set err=> ", err)
        return
    end

    local field, err = cookie:get("lang11")
    if not field then
        ngx.say("get lang11  err =>  ", err)
        -- return
    end
    if field then
        ngx.say("lang11", " => ", field)
    end

    -- set another cookie, both cookies will appear in HTTP response
    --[[ local ok, err = cookie:set({
        key = "Age", value = "30",
    })
    if not ok then
        ngx.log(ngx.ERR, err)
        return
    end]]
end

cookies()