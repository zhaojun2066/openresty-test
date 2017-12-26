--see /test_parallels
--see encode_args_test.lua
--需要注意的是，子请求只是模拟 HTTP 接口的形式，
--没有 额外的 HTTP/TCP 流量，也 没有 IPC (进程间通信) 调用。所有工作在内部高效地在 C 语言级别完成。
--子请求与 HTTP 301/302 重定向指令 (通过 ngx.redirect) 完全不同，也与内部重定向 ((通过 ngx.exec) 完全不同。

--res = ngx.location.capture(uri)
local uri = "/xxxx"
res = ngx.location.capture(uri)
--res一个包含四个元素的 Lua 表 (res.status, res.header, res.body, 和 res.truncated)。
--res.status (状态) 保存子请求的响应状态码。
--res.header (头) 用一个标准 Lua 表储子请求响应的所有头信息。如果是“多值”响应头，这些值将使用 Lua (数组) 表顺序存储
----Set-Cookie: a=3
----Set-Cookie: foo=bar
----Set-Cookie: baz=blah
--则 res.header["Set-Cookie"] 将存储 Lua 表 {"a=3", "foo=bar", "baz=blah"}。

--res.body (体) 保存子请求的响应体数据，它可能被截断。用户需要检测 res.truncated (截断) 布尔值标记来判断
-- res.body 是否包含截断的数据。这种数据截断的原因只可能是因为子请求发生了不可恢复的错误，例如远端在发送响应体时过早中断了连接，或子请求在接收远端响应体时超时。

--通过设置 proxy_pass_request_headers 为 off ，在子请求 location 中忽略原始请求头。