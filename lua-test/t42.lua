--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/15
-- Time: 15:37
-- To change this template use File | Settings | File Templates.
--局部变量和全局变量，尽量使用局部变量 避免冲突，访问局不变速度是很快的

x = 10
local i = 1              -- local to the chunk
while i<=x do
    local x = i*2        -- local to the while body
    print(x)             --> 2, 4, 6, 8, ...
    i = i + 1
end
if i > 20 then
    local x              -- local to the "then" body
    x = 20
    print(x + 2)
else
    print(x)             --> 10  (the global one)
end
print(x)                 --> 10  (the global one)

