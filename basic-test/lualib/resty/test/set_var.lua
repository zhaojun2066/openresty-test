--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/9
-- Time: 15:32
-- To change this template use File | Settings | File Templates.
--set by lua test


local i = 10
local x = 11
return i+x

--- return 返回 set_by_lua_file 的num 变量
--- conf example
--[[

location /lua_set_1 {
    default_type "text/html";
    set_by_lua_file $num set_var.lua;
    echo $num;
}

 ]]

