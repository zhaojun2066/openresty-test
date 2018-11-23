--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/22
-- Time: 17:58
-- To change this template use File | Settings | File Templates.
--协程

local co = coroutine.create(
    function()
        print("hi")
    end
)

print (co) --> thread: 0x8071d98
print(coroutine.status(co))     --> suspended  挂起
coroutine.resume(co)            --> hi，resume 运行
print(coroutine.status(co))     --> dead ，打印完 就是dead 了

---  让一个协同挂起
---使用函数yield可以使程序挂起，当我们激活被挂起的程序时，将从函数yield的位置继续执行程序，直到再次遇到yield或程序结束。
local coo = coroutine.create(function()
    for i =0,10 do
        print("coo",i)
        coroutine.yield() -- 挂起
    end
end)
coroutine.resume(coo)            --> coo   1
print(coroutine.status(coo))     --> suspended
--再次被激活协同
coroutine.resume(coo)     --> coo   2
coroutine.resume(coo)     --> coo   3
---...
coroutine.resume(coo)     --> coo   10
coroutine.resume(coo)     -- prints nothing ，
--上面最后一次调用时，协同体已结束，因此协同程序处于终止态。如果我们仍然希望激活它，resume将返回false和错误信息。

--- 传递参数
local cc = coroutine.create(function(a,b)
    print("cc",a,b)
end)
coroutine.resume(cc,10,20) -->cc 10 20

--- 数据由yield传给resume。true表明调用成功，true之后的部分，即是yield的参数。
local ccoo = coroutine.create(function(a,b)
    coroutine.yield(a+b,a-b);
end)
print(coroutine.resume(ccoo, 20, 10))    --> true  30  10


co = coroutine.create (function ()
    print("co", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)      --> co  4  5

---协同代码结束时的返回值，也会传给resume
co = coroutine.create(function ()
    return 6, 7
end)
print(coroutine.resume(co))     --> true  6  7

--- 管道和过滤器
--- 生产者和消费者的例子
local producer
local function receive()
    local status ,value = coroutine.resume(producer)
end
---- 消费者
local function consumer()
    while true do
        local msg = receive()
        print(msg)
    end
end
local function send(x)
    coroutine.yield(x) --- 挂起，不知道是否能消费，再次调用resume ，yied 会把参数传递给resume
end
----- 生产者协同
producer = coroutine.create(function()
    local i = 0;
    while true do
        local x = "hello->" +i
        send(x)
        i = i+1
    end
end)
--- 调用
producer()
consumer()






