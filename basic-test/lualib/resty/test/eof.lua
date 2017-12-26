-- eof 它可以即时关闭连接，把数据返回给终端，后面de操作还会运行
-- 但是后面的擦做必须是非阻塞的，因为这个work 还是被占用的


local response, user_stat = logic_func.get_response(request)
ngx.say(response)
ngx.eof()

if user_stat then
    local ret = db_redis.update_user_data(user_stat)
end