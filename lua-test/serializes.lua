--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/23
-- Time: 11:42
-- To change this template use File | Settings | File Templates.
--正确的序列化

-- 序列化字符串，或者引用字符串不安全的方式
--if type(o) == "string" then
--    io.write("[[", o, "]]")
--- 如果o 是： ]]..os.execute('rm *')..[[ ，想想多可怕
--- 为了以安全的方式引用任意的字符串，string标准库提供了
--- 格式化函数专门提供"%q"选项。它可以使用双引号表示字符串并且可以正确的处理包含引号和换行等特殊字符的字符串

function serialize (o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    else
          ----......
    end
end

--- 序列化table,table 套table 都是可以的
local type = type
local io = io
local error = error
local serializes
serializes = function(o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q",o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
            io.write(" ",k," = ")
            serializes(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serializes type ".. type(o))
    end
end

