--openresty 执行阶段
--@see /run_process
--[[
--
    set_by_lua*: 流程分支处理判断变量初始化
    rewrite_by_lua*: 转发、重定向、缓存等功能(例如特定请求代理到外网)
    access_by_lua*: IP 准入、接口权限等情况集中处理(例如配合 iptable 完成简单防火墙)
    content_by_lua*: 内容生成
    header_filter_by_lua*: 响应头部过滤处理(例如添加头部信息)
    body_filter_by_lua*: 响应体过滤处理(例如完成应答内容统一成大写)
    log_by_lua*: 会话完成后本地异步完成日志记录(日志可以记录在本地，还可以同步到其他机器)
-- ]]

