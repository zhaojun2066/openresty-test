#!/usr/bin/env bash

BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`

OPENRESTY_INSTALL_PATH="/usr/local/openresty";

echo "检测nginx是否启动"
nginx_progress=`ps -ef|grep "nginx" |wc -l`

if [ $nginx_progress -gt 1 ]
then
    echo "nginx 已经启动,开始停止nginx"
    $OPENRESTY_INSTALL_PATH/nginx/sbin/nginx -s quit
    echo "nginx 已经停止"
else
    echo "nginx 没有启动,开始启动nginx"
fi

