-- nginx内置变量
-- $args 	请求中的参数
-- $binary_remote_addr 	远程地址的二进制表示
-- $body_bytes_sent 	已发送的消息体字节数
-- $content_length 	HTTP请求信息里的"Content-Length"
-- $content_type 	请求信息里的"Content-Type"
-- $document_root 	针对当前请求的根路径设置值
-- $document_uri 	与-- $uri相同; 比如 /test2/test.php
-- $host 	请求信息中的"Host"，如果请求中没有Host行，则等于设置的服务器名
-- $hostname 	机器名使用 gethostname系统调用的值
-- $http_cookie 	cookie 信息
-- $http_referer 	引用地址
-- $http_user_agent 	客户端代理信息
-- $http_via 	最后一个访问服务器的Ip地址。
-- $http_x_forwarded_for 	相当于网络访问路径
-- $is_args 	如果请求行带有参数，返回“?”，否则返回空字符串
-- $limit_rate 	对连接速率的限制
-- $nginx_version 	当前运行的nginx版本号
-- $pid 	worker进程的PID
-- $query_string 	与-- $args相同
-- $realpath_root 	按root指令或alias指令算出的当前请求的绝对路径。其中的符号链接都会解析成真是文件路径
-- $remote_addr 	客户端IP地址
-- $remote_port 	客户端端口号
-- $remote_user 	客户端用户名，认证用
-- $request 	用户请求
-- $request_body 	这个变量（0.7.58+）包含请求的主要信息。在使用proxy_pass或fastcgi_pass指令的location中比较有意义
-- $request_body_file 	客户端请求主体信息的临时文件名
-- $request_completion 	如果请求成功，设为"OK"；如果请求未完成或者不是一系列请求中最后一部分则设为空
-- $request_filename 	当前请求的文件路径名，比如/opt/nginx/www/test.php
-- $request_method 	请求的方法，比如"GET"、"POST"等
-- $request_uri 	请求的URI，带参数
-- $scheme 	所用的协议，比如http或者是https
-- $server_addr 	服务器地址，如果没有用listen指明服务器地址，使用这个变量将发起一次系统调用以取得地址(造成资源浪费)
-- $server_name 	请求到达的服务器名
-- $server_port 	请求到达的服务器端口号
-- $server_protocol 	请求的协议版本，"HTTP/1.0"或"HTTP/1.1"
-- $uri 	请求的URI，可能和最初的值有不同，比如经过重定向之类的

--ngx.var.VARIABLE
--context: set_by_lua*, rewrite_by_lua*, access_by_lua*, content_by_lua*, header_filter_by_lua*, body_filter_by_lua*, log_by_lua*
--Read and write Nginx variable values.
--value = ngx.var.some_nginx_variable_name
--ngx.var.some_nginx_variable_name = value


--Note that only already defined nginx variables can be written to. For example:
--location /foo {
--    set $my_var ''; # this line is required to create $my_var at config time
--content_by_lua_block {
--    ngx.var.my_var = 123;
--}
--}


ngx.say("binary_remote_addr -> ",ngx.var.binary_remote_addr)
ngx.say("body_bytes_sent -> ",ngx.var.body_bytes_sent)
ngx.say("content_length -> ",ngx.var.content_length)
ngx.say("document_root -> ",ngx.var.ocument_root)
ngx.say("http_cookie -> ",ngx.var.http_cookie)
ngx.say("hostname -> ",ngx.var.hostname)
ngx.say("host  -> ",ngx.var.host )
ngx.say("http_referer  -> ",ngx.var.http_referer )
ngx.say("http_user_agent  -> ",ngx.var.http_user_agent )
ngx.say("limit_rate  -> ",ngx.var.limit_rate )
ngx.say("is_args  -> ",ngx.var.is_args )
ngx.say("http_x_forwarded_for  -> ",ngx.var.http_x_forwarded_for )
ngx.say("http_via  -> ",ngx.var.http_via )
ngx.say("nginx_version  -> ",ngx.var.nginx_version )
ngx.say("pid  -> ",ngx.var.pid )
ngx.say("query_string  -> ",ngx.var.query_string )
ngx.say("realpath_root  -> ",ngx.var.realpath_root )
ngx.say("request   -> ",ngx.var.request  )
ngx.say("remote_user   -> ",ngx.var.remote_user  )
ngx.say("remote_port   -> ",ngx.var.remote_port  )
ngx.say("remote_addr  -> ",ngx.var.remote_addr )
ngx.say("request_method   -> ",ngx.var.request_method  )
ngx.say("request_uri    -> ",ngx.var.request_uri)
ngx.say("scheme    -> ",ngx.var.scheme   )
ngx.say("server_addr     -> ",ngx.var.server_addr)
ngx.say("server_protocol      -> ",ngx.var.server_protocol )
ngx.say("uri      -> ",ngx.var.uri)
