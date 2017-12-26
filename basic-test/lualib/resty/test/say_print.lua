--say,print 均为异步输出
--ngx.say 会对输出响应体多输出一个 \n

--其实就是要利用 ngx.print 的特性了，它的输入参数可以是单个或多个字符串参数，也可以是 table 对象。
-- OpenResty 里面的 print 语句是 INFO 级别。
local table = {
    "hello, ",
    {"world: ", true, " or ", false,
        {": ", nil}}
}
ngx.print(table)