--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 15:56
-- To change this template use File | Settings | File Templates.
--
--- 函数可以返回多个值，比如string.find，其返回匹配串“开始和结束的下标”（如果不存在匹配串返回nil）。
local s,e = string.find("hello Lua users", "Lua")
print(s,e) --> 7 9

--- example 返回数组的最大值的index 和 最大值
local function maxnum(a)
    local mi = 1     -- maximum index
    local m = a[mi]  -- maximum value
    for i ,value in ipair(a) do
        if value > m then
            mi = i
            m = value
        end
    end
    return mi , m
end

local function a1()
    return 1
end

local z = maxnum({2,1,5})  --> z=3 ,多出的值会被舍去
local x,y =  maxnum({2,1,5}) --> x=3 y = 5 ,都会被赋值
local a,b,c = maxnum{2,1,5} --> a = 3 b = 5 c = nil
a,b,c = 10,maxnum({2,1,5})  --> a = 10 b = 3 c = 5
a,b,c = maxnum({2,1,5}),10  --> a = 3 b = 5 c = 10
a,b =  maxnum({2,1,5}),10  -->a=3 b=10


--- 可变函数 Lua将函数的参数放在一个叫arg的表中，除了参数以外，arg表中还有一个域n表示参数的个数
local printResult = ""
local function print(...)
    for i,v in ipairs(arg) do
        printResult = printResult .. tostring(v) .. "\t"
    end
    printResult = printResult .. "\n"
end

--- 还可以这样
local function g(a, b, ...) end
--- 只要第二个返回值
local _, x = string.find(s, p)
---有时候需要将函数的可变参数传递给另外的函数调用，可以使用前面我们说过的unpack(arg)返回arg表所有的可变参数
local function fwrite(fmt, ...)
    return io.write(string.format(fmt, unpack(arg)))
end
--- 命名参数 传递table 来实现
local function rename (arg)
    return os.rename(arg.old, arg.new)
end

--- 闭包
--- 包含在sortbygrade函数内部的sort中的匿名函数可以访问sortbygrade的参数grades，
--- 在匿名函数内部grades不是全局变量也不是局部变量，我们称作外部的局部变量（external local variable）或者upvalue
function sortbygrade (names, grades)
    table.sort(names, function (n1, n2)
        return grades[n1] > grades[n2]    -- compare the grades
    end)
end

---匿名函数使用upvalue i保存他的计数，当我们调用匿名函数的时候i已经超出了作用范围，因为创建i的函数newCounter已经返回了。
---然而Lua用闭包的思想正确处理了这种情况。简单的说，闭包是一个函数以及它的upvalues。如果我们再次调用newCounter，
---将创建一个新的局部变量i，因此我们得到了一个作用在新的变量i上的新闭包
function newCounter()
    local i = 0
    return function()     -- anonymous function
        i = i + 1
        return i
    end
end
c1 = newCounter() -- 已经返回给c1 ，但是还可以访问到i ，这就是闭包
c2 = newCounter()

print(c2())  --> 1
print(c1())  --> 3
print(c2())  --> 2

--- 另一个沙箱的例子，检查不信任的外部文件，给io.open 重新赋值，但是filename ，mode 还是可以访问的，闭包的功劳
do
    local oldOpen = io.open
    io.open = function (filename, mode)
        if access_OK(filename, mode) then
            return oldOpen(filename, mode)
        else
            return nil, "access denied"
        end
    end
end
