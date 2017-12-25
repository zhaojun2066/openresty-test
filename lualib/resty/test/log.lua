--
--ngx.STDERR     -- 标准输出
--ngx.EMERG      -- 紧急报错
--ngx.ALERT      -- 报警
--ngx.CRIT       -- 严重，系统故障，触发运维告警系统
--ngx.ERR        -- 错误，业务不可恢复性错误
--ngx.WARN       -- 告警，业务中可忽略错误
--ngx.NOTICE     -- 提醒，业务比较重要信息
--ngx.INFO       -- 信息，业务琐碎日志信息，包含不同情况判断等
--ngx.DEBUG      -- 调试
--对于应用开发，一般使用 ngx.INFO 到 ngx.CRIT 就够了。生产中错误日志开启到 error 级别就够了。
-- -- 如何正确使用这些级别呢？可能不同的人、不同的公司可能有不同见解。


local num = 55
local str = "string"
local obj
ngx.log(ngx.ERR, "num:", num)
ngx.log(ngx.INFO, " string:", str)
print([[i am print]])
ngx.log(ngx.ERR, " object:", obj)

