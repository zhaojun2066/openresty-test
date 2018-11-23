--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/23
-- Time: 16:31
-- To change this template use File | Settings | File Templates.
--面向对象的设计

local Dog = {}
function Dog:new (o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
    return o
end
Dog:say(){

}

return Dog

