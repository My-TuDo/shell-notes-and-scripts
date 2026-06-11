# 条件判断

## 1. if 结构

```bash
if commands;then
    commands
[elif commands;then
    commands...]
[else 
    commands...]
fi
```
例子：
```test
if test $USER = "foo";then
    echo "Hello foo."
else
    echo "You are not foo."
fi
```
[点击前往Shell文件](./Shell/001.sh)

`if` 关键字后面可以跟任意数量的命令。这时，所有命令都会执行，但是判断真伪的只看最后一个命令，即使前面的命令都失败了，只要最后一个命令返回`0`，就会执行`then`部分。
```bash
if false;true
then
    echo 'hello world.'
fi
```
[点击前往Shell文件](./Shell/002.sh)

`elif`可以存在多个，因为有其他语言基础，不多废话。
