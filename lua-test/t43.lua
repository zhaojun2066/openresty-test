--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 15:39
-- To change this template use File | Settings | File Templates.
--控制语句
--[[
-- if conditions then
--    then-part
--end;
--
--if conditions then
--    then-part
--else
--    else-part
--end;
--
--if conditions then
--    then-part
--elseif conditions then
--    elseif-part
--..            --->多个elseif
--else
--    else-part
--end;
--
-- --]]

-- while
local x = 100
while x>10 do
    x = x - 1
end

-- for
--[[
 for var=exp1,exp2,step do
    loop-part
end
--]]
-- step 可以省略默认是1，f(x) 只会在循环前调用一次
for i=1,f(x) do
    print(i)
end



