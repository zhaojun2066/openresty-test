# openresty-test
    openresty test code


## 基础测试代码
      basic-test
      todo: ngx.req.set_uri、ngx.redirect("http://www.jd.com?jump=1", 302)

 ## AB TEST 实践
        ab-test

## 全局变量检查工具
    https://github.com/openresty/nginx-devel-utils/blob/master/lua-releng


## 支持JIT 的函数 （编译运行）
    http://wiki.luajit.org/NYI

## other
        kaitao: http://jinnianshilongnian.iteye.com/blog/2186448

        ngx.var ： nginx变量，如果要赋值如ngx.var.b = 2，此变量必须提前声明；另外对于nginx location中使用正则捕获的捕获组可以使用ngx.var[捕获组数字]获取；

        ngx.req.get_headers：获取请求头，默认只获取前100，如果想要获取所以可以调用ngx.req.get_headers(0)；获取带中划线的请求头时请使用如headers.user_agent这种方式；如果一个请求头有多个值，则返回的是table；

        ngx.req.get_uri_args：获取url请求参数，其用法和get_headers类似；

        ngx.req.get_post_args：获取post请求内容体，其用法和get_headers类似，但是必须提前调用ngx.req.read_body()来读取body体（也可以选择在nginx配置文件使用lua_need_request_body on;开启读取body体，但是官方不推荐）；

        ngx.req.raw_header：未解析的请求头字符串；

        ngx.req.get_body_data：为解析的请求body体内容字符串。

        ngx.header：输出响应头；

        ngx.print：输出响应内容体；

        ngx.say：通ngx.print，但是会最后输出一个换行符；

        ngx.exit：指定状态码退出。

        ngx.escape_uri/ngx.unescape_uri ： uri编码解码；

        ngx.encode_args/ngx.decode_args：参数编码解码；

        ngx.encode_base64/ngx.decode_base64：BASE64编码解码；

        ngx.re.match：nginx正则表达式匹配；

## init_worker_by_lua

        用于启动一些定时任务，比如心跳检查，定时拉取服务器配置等等；此处的任务是跟Worker进程数量有关系的，比如有2个Worker进程那么就会启动两个完全一样的定时任务。