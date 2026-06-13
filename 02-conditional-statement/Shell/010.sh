#!/bin/bash

echo -n "输入一个1到3之间的数字（两端闭合）"
read character
case $character in
    1 ) echo 1 ;;
    2 ) echo 2 ;;
    3 ) echo 3 ;;
    * ) echo "输入不符合要求。" ;;
esac