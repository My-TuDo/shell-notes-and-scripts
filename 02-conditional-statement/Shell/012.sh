#!/bin/bash

echo -n "请输入一个字母或者一个单词："
read character
case $character in
    [[:lower:]] | [[:upper:]]) echo "用户输入了字母：$character" ;;
    [0-9]) echo "用户输入了数值：$character" ;;
    *) echo "用户的输入不符合要求" ;;
esac