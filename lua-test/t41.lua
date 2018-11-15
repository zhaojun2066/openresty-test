--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
--赋值操作
local a = "hello" .. "world"
local t = {}
t.a = 10

--- 给多个变量赋值
local s,e = 10,"2.42121"

---遇到赋值语句Lua会先计算右边所有的值然后再执行赋值操作，所以我们可以这样进行交换变量的值：
local x ,y = 1,2
x,y = y,x  --- 交换变量x,y的值
local d,f,g = 0 --- 只会给d 为0 ，其他都是nil，要对多个变量赋值，必须依次对每个变量赋值




