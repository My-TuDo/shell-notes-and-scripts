#!/bin/bash

OS=$(uname -s)  # uname -s 获取内核名称

case $OS in
    FreeBSD) echo "This is FreeBSD." ;;
    Darwin) echo "This is Darwin." ;;
    AIX) echo "This is AIX." ;;
    Minix) echo "This is Minix." ;;
    Linux) echo "This is Linux." ;;
    *) echo "Failed to identify this OS." ;;
esac