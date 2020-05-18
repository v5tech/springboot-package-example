#!/bin/bash

# 获取脚本绝对路径
cd $(dirname "$0")
# 回上级目录
cd ..
# 设置工作目录
WORKDIR=$(pwd)
JAR_FILE_NAME=${project.build.finalName}.jar
JAR_FILE="$WORKDIR/$JAR_FILE_NAME"
LOG_FILE="$WORKDIR/logs/startup.log"
CONFIG_DIR="$WORKDIR/config/"
JAVA_OPTS=""
# 获取进程id
PID=$(jps | grep $JAR_FILE_NAME | awk '{print $1}')

start()
{
  if [ -z $PID ]; then
    if [ -z $JAR_FILE ]; then
     echo "ERROR: jar file not found"
    else
     nohup java $JAVA_OPTS -jar $JAR_FILE --spring.config.location=$CONFIG_DIR > $LOG_FILE 2>&1 &
     echo "Application $JAR_FILE_NAME starting..."
     tail -f $LOG_FILE
    fi
  else
    echo "Application $JAR_FILE_NAME running..."
  fi
}

stop()
{
  if [ -z $PID ]; then
    echo "Application $JAR_FILE_NAME not running..."
  else
    kill -9 $PID
  fi
}

restart()
{
  stop
  start
}

case "$1" in
  'start')
    start
    ;;
  'stop')
    stop
    ;;
  'restart')
    restart
    ;;
  *)
  echo "Usage: $0 {  start | stop | restart  }"
  exit 1
  ;;
esac

exit 0