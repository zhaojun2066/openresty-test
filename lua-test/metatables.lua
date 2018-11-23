--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/23
-- Time: 13:24
-- To change this template use File | Settings | File Templates.
--Lua中的每一个表都有其Metatable
--- 任何一个表都可以是其他一个表的metatable，一组相关的表可以共享一个metatable（描述他们共同的行为）。
--- 一个表也可以是自身的metatable（描述其私有行为）。
local t = {}
local t1 = {}
setmetatable(t, t1) --- 设置t的metatable 是 t1
assert(getmetatable(t) == t1)




---- 集合相加 ，去掉重读element
local Set = {}
Set.mt={}
function Set.new(t)
    local set = {}
    setmetatable(set,Set.mt)
    for i,v in ipairs(t) do
        set[v] = true
    end
    return set
end

function Set.union(a,b)
    local all = Set.new({})
    for k in ipairs(a) do
        all[k] = true
    end
    for k in ipairs(b) do
        all[k] = true
    end
    return all
end

function Set.tostring (set)
    local s = "{"
    local sep = ""
    for e in pairs(set) do
        s = s .. sep .. e
        sep = ", "
    end
    return s .. "}"
end
Set.mt.__add= Set.uinion
local s1 = Set.new{10, 20, 30, 50}
local s2 = Set.new{30, 1}
local s3 = s1 + s2
Set.print(s3)     --> {1, 10, 20, 30, 50}
--[[
Lua选择metamethod的原则：如果第一个参数存在带有__add域的metatable，Lua使用它作为metamethod，和第二个参数无关；
否则第二个参数存在带有__add域的metatable，Lua使用它作为metamethod 否则报错。]]


--- table __index, 找不到table的属性，回去matatable的 index 对应的function 内去找
local Window = {}
Window.prototype = {
    x = 1,
    y = 2,
    width = 30,
    high = 100
}
Window.mt = {
    __index = function(table,key)
        return Window.prototype[key]
    end
}
function Window.new(o)
    setmetatable(o,Window.mt)
    return o
end

local w = Window.new({x=2,y=10})
print(w.width) --> 30, 本身内没有，会去metatable 内对应的index 去找
--- __index 也可以是一个table Window.mt.__index = Window.prototype
--- 他发现window.prototype的值，它是一个表，所以Lua将访问这个表来获取缺少的值


--- 带有默认值的table
local Dog = {}
function Dog.new(dog)
    local default = {
        __index = {age = 10}
    }
    setmetatable(dog,default)
end
--- 不管是否存在的域都返回 特定的值
local D = {}
function D.new(o,defaultValue)
    local defaults = {
        __index = function()
            return defaultValue
        end
    }
    setmetatable(o,defaults)
end
---__newindex metamethod用来对表更新，__index则用来对表访问。当你给表的一个缺少的域赋值，解释器就会查找__newindex metamethod：
--- 像__index一样，如果metamethod是一个表，解释器对指定的那个表，而不是原始的表进行赋值操作

--- 监控表，创建一个代理表来监控
local  index  = {}
local mt = {
    __index = function(t,k)
        print("*access to element " .. tostring(k))
       return t[index][k]
    end,
    __newindex  = function(t,k,v)
        print("*update of element " .. tostring(k) .. " to "
                .. tostring(v))
        t[index][k] = v
    end
}

function track(t)
    local proxy = {}
    proxy[index] = t
    setmetatable(proxy,mt)
    return proxy
end
local tt = {1,3,333,22,422 }
local tt_proxy = track(tt)
tt_proxy[0] = 1
local ss  = tt_proxy[2]

--- 只读表
 local readonlyTable = function(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function(t,k,v)
            error("the table is readonly....")
        end
    }
    setmetatable(proxy,mt)
     return proxy
 end


