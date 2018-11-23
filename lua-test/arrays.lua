--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/23
-- Time: 11:02
-- To change this template use File | Settings | File Templates.
--lua 数组index 是从1 开始，越界会返回nil
local a = {2,3,3,3,3,3,3 }

local b ={}
--- 初始化
for i=1,100 do
    b[i] = i
end

