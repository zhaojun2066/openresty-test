
local resp = ngx.location.capture(
    "/args_test",
    {
        method=ngx.HTTP_POST, --默认GET
        args=ngx.encode_args({a = 1 ,b = '2&'}), --get method
        body = ngx.encode_args({c = 3, d = '4&'})-- post method
    }
)

ngx.say(resp.body)