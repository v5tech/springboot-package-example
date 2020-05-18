#!/usr/bin/env bash

activeProfile=local
if [ -n "$1" ]; then
  activeProfile=$1
fi
echo "activeProfile:$activeProfile"
mvn clean package -P$activeProfile -Dmaven.test.skip=true