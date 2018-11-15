--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 14:51
-- To change this template use File | Settings | File Templates.
--

--- false nil 都是false 其他都是 true
--- and or 的结果不是false 和true
--- a and b       -- 如果a为false，则返回a，否则返回b
--- a or  b        -- 如果a为true，则返回a，否则返回b
local a = (4 and 5) --- a =  5
local b = (4 or 5) --- a = 4
--- 很实用的技巧 判断赋值操作,如果x为true 返回x ，否则返回v 给x
local v = 10
local x
x = x or v
--- 实现三元运算  a ? b: v
--- lua 实现三元
local s = (a and b) or v

--- not 取反
local h = not nil  -- true




