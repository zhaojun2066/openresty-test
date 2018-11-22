--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/22
-- Time: 9:51
-- To change this template use File | Settings | File Templates.
-- 迭代器的定义

--- 通过闭包来实现迭代器，闭包可以存储外部函数的局部变量
--- 创建一个list的迭代器
local function list_iter(list)
    local index = 0
    local length = table.getn(list) -- 获得list 长度
    return function()
        index = index+1
        if index<=length  then
            return list[index]
        end
    end
end
--- 上面是定义了一个迭代器，每次使用，闭包函数都会记录迭代到哪里了，记录了index的值情况
local t = {1,22,55}
local iter = list_iter(t)
while true do
    local ele = iter()  --- 每次调用都会调用闭包存储的index 下的值
    if ele == nil then
        break
    else
        println(ele)
    end
end
--- 作用到for
for ele in list_iter(t) do
    print(ele)
end

--- 无状态的迭代器 ipairs 的实现，遇到nil vlaue 就停止了，这也是和pairs的区别
--- 无状态的迭代器，状态其实是有外部的for 循环来记录的
local function iters(a,index)
    index = index +1
    local value = a[index]
    if value then
        return index ,value
    end
end

local function ipairss(a)
    return iters, a,0 -- 返回三个值，函数，数组，index，交由for处理，for 作为外部函数，每次就可以记录i，v 的值了
end
local a = {"one", "two", "three" }
--- for 接受迭代函数 iters，a,0 三个参数，然后a,0在传递给iters进行迭代，retuen 迭代器，返回的值给i,v进行复制
for i, v in ipairss(a) do
    print(i, v)
end

--- 我们应该尽量创建无状态的迭代器，因为这样可以让for循环来存储状态，来减少创建闭包的消耗，如果不能用无状态的迭代器，可以用闭包来代替






