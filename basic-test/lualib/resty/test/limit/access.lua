local limit_conn = require "resty.test.limit.conn_util"

--如果是内部不做限制
if ngx.req.is_internal() then
    return
end

limit_conn.incoming()