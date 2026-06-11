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

## 2. test 命令

`if`结构的判断条件，一般用`test`命令的有三种形式：
```bash
# 写法一：
test expression

# 写法二：
[ expression ]

# 写法三：
[[ expression ]]
```
上面三种写法是等价的，不同的是写法三支持正则判断。

上面的`expression`是一个表达式，式子为真，`test`命令执行成功（返回值为`0`）；表达式为伪，`test`命令执行失败（返回值为`1`）。需要注意的是，第二种和第三种写法的`[`和`]`与内部的表达式之间必须有空格。
```bash
test -f /etc/hosts
echo $?
# 输出为0

[ -f /etc/hosts ]
echo $?
# 输出为0
```
上面两种`test`写法等价，判断`/etc/hosts`文件是否存在。

实际上，`[`字符是`test`命令的一种简写形式，可以看作一个独立的命令，这也解释了为什么它后面要有空格。

下面三种`test`命令的形式，用在`if`结构中，判断一个文件是否存在。
```bash
# 写法一
if  test -e ./02-conditional-statement/notes.md; then
    echo "Found notes.md"
fi

# 写法二
if [ -e ./02-conditional-statement/notes.md ]; then
    echo "Found notes.md"
fi

# 写法三
if [[ -e ./02-conditional-statement/notes.md ]]; then
    echo "Found notes.md"
fi
```
[点击前往Shell文件](./Shell/003-test.sh)
