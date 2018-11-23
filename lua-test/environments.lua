--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/23
-- Time: 15:32
-- To change this template use File | Settings | File Templates.
--Lua用一个名为environment普通的表来保存所有的全局变量
---为了简化操作，Lua将环境本身存储在一个全局变量_G中，（_G._G等于_G）。例如，下面代码打印在当前环境中所有的全局变量的名字
for n in pairs(_G) do print(n) end



