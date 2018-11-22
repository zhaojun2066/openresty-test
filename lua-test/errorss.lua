--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/22
-- Time: 15:18
-- To change this template use File | Settings | File Templates.
--错误处理

---- error 用于抛出异常信息
local n
if not n then
    error("n is nill")
end

--- assert 若执行函数没有问题，assert不会做任何事情，如果异常，assert 会以第二个参数作为异常信息抛出，
--- 第二个参数是可选的
assert(tonumber("2"),"invalida number")

--- error assert 抛出错误信息后，就不会继续往下执行了

---pcall (f, arg1, ...)
--- pcall 用于捕获抛出的异常信息和错误信息，惹没有问题，pcall 返回true以及被执行函数的返回值，否则返回false和错误信息
local function test()
    error("hahahha")
    return "tre"
end
--- 返回 nil , hahahah
local satus,error = pcall(test)
print(satus) -- false
print(error) -- hahahah

local c,d = pcall(function()
    return "success"
end)
print(c) -- true
print(d) -- success



