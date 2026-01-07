#!/bin/bash
# 参考：ranger_admin.sh
# 位置：datasophon-api/src/main/resources/meta/DDP-1.2.1/ATLAS/atlas_server.sh

usage="Usage: start.sh (start|stop|restart|status) "

startStop=$1

start(){
    echo "Starting Atlas Server..."
    # Atlas启动命令
    ${ATLAS_HOME}/bin/atlas_start.py
    if [ $? -eq 0 ]; then
        echo "Atlas Server start success"
    else
        echo "Atlas Server start failed"
        exit 1
    fi
}

stop(){
    echo "Stopping Atlas Server..."
    ${ATLAS_HOME}/bin/atlas_stop.py
    if [ $? -eq 0 ]; then
        echo "Atlas Server stop success"
    else
        echo "Atlas Server stop failed"
        exit 1
    fi
}

status(){
    echo "Checking Atlas Server status..."
    # 检查进程
    pid=$(ps -ef | grep -i 'org.apache.atlas.Atlas' | grep -v grep | awk '{print $2}')
    if [ -n "$pid" ]; then
        # 检查API端点（参考status_fe.sh的HTTP检查）
        response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:21000/api/atlas/admin/status)
        if [ "$response" = "200" ]; then
            echo "Atlas Server is running (PID: $pid)"
        else
            echo "Atlas Server process exists but API is not responding"
            exit 1
        fi
    else
        echo "Atlas Server is not running"
        exit 1
    fi
}

restart(){
    echo "Restarting Atlas Server..."
    stop
    sleep 5
    start
}

case $startStop in
    (start)
        start
        ;;
    (stop)
        stop
        ;;
    (status)
        status
        ;;
    (restart)
        restart
        ;;
    (*)
        echo $usage
        exit 1
        ;;
esac

echo "End $startStop Atlas Server"