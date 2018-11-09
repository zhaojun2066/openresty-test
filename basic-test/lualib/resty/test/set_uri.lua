
--第二个参数为false 内部uri重写，说明不会重新进行location 匹配
ngx.req.set_uri("/lua_rewrite_5", false);
ngx.req.set_uri("/lua_rewrite_6", false);
ngx.req.set_uri_args({a = 1, b = 2});


-- true 会进行location的重新匹配
--ngx.req.set_uri("/test", true); --rewrite ^ /lua_rewrite_4 last;



--[[
location /lua_rewrite {
    default_type "text/html";
    rewrite_by_lua_file set_uri.lua;
    echo "rewrite2 uri : $uri, a : $arg_a";  -- 如果第二个参数是true ，不会打印，false ，会进行打印内部跳转的uri和a 参数
}
 ]]


